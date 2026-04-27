import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';

const _kFormspreeId = String.fromEnvironment('FORMSPREE_ID');

enum _FormStatus { idle, loading, success, error }

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  _FormStatus _status = _FormStatus.idle;
  String _errorMsg = '';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = context.l10n;

    setState(() {
      _status = _FormStatus.loading;
      _errorMsg = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/$_kFormspreeId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': _nameCtrl.text.trim(),
          'email': _emailCtrl.text.trim(),
          'message': _msgCtrl.text.trim(),
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() => _status = _FormStatus.success);
        _nameCtrl.clear();
        _emailCtrl.clear();
        _msgCtrl.clear();
      } else {
        final body = jsonDecode(response.body);
        setState(() {
          _status = _FormStatus.error;
          _errorMsg = body['error'] as String? ?? 'Erro ${response.statusCode}';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _FormStatus.error;
        _errorMsg = l10n.contactErrorNoConnection;
      });
    }
  }

  void _resetForm() => setState(() {
        _status = _FormStatus.idle;
        _errorMsg = '';
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      color: AppTheme.slate900.withValues(alpha: 0.5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────────
              const Text('<Contact>',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 14,
                      fontFamily: 'monospace')),
              const SizedBox(height: 16),
              Text(
                context.l10n.contactSectionTitle,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),
              Text(
                '// ${context.l10n.contactSectionSubtitle}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppTheme.slate400,
                    fontSize: 16,
                    fontFamily: 'monospace'),
              ),
              const SizedBox(height: 8),
              const Text('</Contact>',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 14,
                      fontFamily: 'monospace')),
              const SizedBox(height: 64),
              // ── Layout responsivo ────────────────────────────────────────────
              LayoutBuilder(builder: (_, constraints) {
                if (constraints.maxWidth > 1024) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 340, child: _buildContactInfo(context)),
                      const SizedBox(width: 32),
                      Expanded(child: _buildFormArea(context)),
                    ],
                  );
                }
                return Column(children: [
                  _buildContactInfo(context),
                  const SizedBox(height: 32),
                  _buildFormArea(context),
                ]);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ── Info cards ───────────────────────────────────────────────────────────────

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        _ContactCard(
            icon: Icons.email,
            label: 'email:',
            value: '"ianpedro1812@gmail.com"'),
        const SizedBox(height: 24),
        _ContactCard(
            icon: Icons.code,
            label: 'github:',
            value: '"github.com/Ianzinn"'),
        const SizedBox(height: 24),
        _ContactCard(
            icon: Icons.location_on,
            label: 'location:',
            value: '"${context.l10n.contactInfoLocation}"'),
      ],
    );
  }

  // ── Form area (idle / loading / success / error) ──────────────────────────

  Widget _buildFormArea(BuildContext context) {
    if (_status == _FormStatus.success) return _buildSuccess(context);
    return _buildForm(context);
  }

  // ── Success state ────────────────────────────────────────────────────────────

  Widget _buildSuccess(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.slate900,
        border: Border.all(color: AppTheme.green500.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.green500.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppTheme.green500.withValues(alpha: 0.4)),
            ),
            child: const Icon(Icons.check,
                color: AppTheme.green400, size: 36),
          ),
          const SizedBox(height: 24),
          Text(
            '// ${context.l10n.contactSuccessTitle}',
            style: const TextStyle(
                color: AppTheme.green400,
                fontSize: 18,
                fontFamily: 'monospace'),
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.contactSuccessBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppTheme.slate400,
                fontSize: 14,
                fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh, size: 16),
            label: Text(context.l10n.contactSuccessRetry,
                style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  // ── Form ────────────────────────────────────────────────────────────────────

  Widget _buildForm(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = _status == _FormStatus.loading;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.slate900,
        border:
            Border.all(color: AppTheme.green500.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'async function sendMessage() {',
              style: TextStyle(
                  color: AppTheme.green500,
                  fontSize: 14,
                  fontFamily: 'monospace'),
            ),
            const SizedBox(height: 24),
            _buildField(
              label: 'const name = ',
              controller: _nameCtrl,
              hint: l10n.contactFormNameHint,
              enabled: !isLoading,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.contactFormNameError : null,
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'const email = ',
              controller: _emailCtrl,
              hint: l10n.contactFormEmailHint,
              enabled: !isLoading,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return l10n.contactFormEmailError;
                if (!v.contains('@') || !v.contains('.')) {
                  return l10n.contactFormEmailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildField(
              label: 'const message = ',
              controller: _msgCtrl,
              hint: l10n.contactFormMessageHint,
              maxLines: 6,
              enabled: !isLoading,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.contactFormMessageError
                  : null,
            ),
            // Error banner
            if (_status == _FormStatus.error) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.red500.withValues(alpha: 0.1),
                  border: Border.all(
                      color: AppTheme.red500.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: AppTheme.red500, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMsg,
                        style: const TextStyle(
                            color: AppTheme.red500,
                            fontSize: 13,
                            fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _submit,
                icon: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send, size: 16),
                label: Text(
                  isLoading
                      ? l10n.contactFormSendingButton
                      : 'await sendMessage();',
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'monospace'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.green600,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppTheme.green600.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  side: BorderSide(
                      color: AppTheme.green500.withValues(alpha: 0.5)),
                  elevation: 8,
                  shadowColor:
                      AppTheme.green500.withValues(alpha: 0.2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('}',
                style: TextStyle(
                    color: AppTheme.green500,
                    fontSize: 14,
                    fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    final borderColor = AppTheme.green500.withValues(alpha: 0.3);
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(4),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppTheme.green400,
                fontSize: 14,
                fontFamily: 'monospace')),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          enabled: enabled,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'monospace'),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                color: AppTheme.slate600, fontFamily: 'monospace'),
            filled: true,
            fillColor: AppTheme.slate950,
            border: border,
            enabledBorder: border,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.green500.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.green500),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// ─── Contact info card ────────────────────────────────────────────────────────

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactCard(
      {required this.icon, required this.label, required this.value});
  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppTheme.slate900,
          border: Border.all(
            color: _hovered
                ? AppTheme.green500.withValues(alpha: 0.5)
                : AppTheme.green500.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: AppTheme.green500.withValues(alpha: 0.15),
                      blurRadius: 20)
                ]
              : [],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('{',
                style: TextStyle(
                    color: AppTheme.green500,
                    fontSize: 12,
                    fontFamily: 'monospace')),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.green500.withValues(alpha: 0.1),
                    border: Border.all(
                        color: AppTheme.green500.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(widget.icon,
                      color: AppTheme.green400, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.label,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'monospace')),
                      const SizedBox(height: 4),
                      Text(widget.value,
                          style: const TextStyle(
                              color: AppTheme.green400,
                              fontSize: 13,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('}',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 12,
                      fontFamily: 'monospace')),
            ),
          ],
        ),
      ),
    );
  }
}
