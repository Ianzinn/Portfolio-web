# Portfolio — Ian Pedro

Portfolio profissional desenvolvido em **Flutter Web**, com tema de terminal/código, Clean Architecture e suporte a múltiplos idiomas.

---

## Seções

| Seção | Descrição |
|---|---|
| Hero | Apresentação com animação Matrix Rain e links sociais |
| Skills | Grade de habilidades agrupadas por categoria |
| Projects | Cards de projetos com links para o GitHub |
| Experience | Linha do tempo da trajetória profissional |
| Contact | Formulário de contato integrado ao Formspree |

---

## Stack

- **Framework:** Flutter 3 / Dart SDK ^3.9.2
- **State Management:** flutter_bloc ^8.1.6
- **Dependency Injection:** get_it ^7.7.0
- **Functional Programming:** dartz ^0.10.1
- **HTTP:** http ^1.2.2
- **SVG:** flutter_svg ^2.0.9
- **i18n:** flutter_localizations + intl
- **Fontes:** google_fonts ^6.2.1

---

## Arquitetura

O projeto segue **Clean Architecture** organizada por feature modules:

```
lib/
├── core/
│   ├── error/
│   ├── extensions/
│   ├── theme/
│   ├── usecases/
│   └── widgets/
├── modules/
│   ├── contact/
│   ├── experience/
│   ├── footer/
│   ├── hero/
│   ├── home/
│   ├── projects/
│   └── skills/
├── gen_l10n/
├── app.dart
├── injection_container.dart
└── main.dart
```

Cada módulo segue a divisão:

```
módulo/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

---

## Internacionalização

O app suporta três idiomas, selecionáveis pela NavBar:

| Locale | Idioma |
|---|---|
| `pt` | Português (padrão) |
| `en` | English |
| `es` | Español |

Os arquivos de tradução ficam em `lib/gen_l10n/` e são gerados a partir de `l10n/`.

---

## Variáveis de Ambiente

Dados sensíveis **não ficam no código-fonte**. Use `--dart-define` ao buildar.

Copie o arquivo de exemplo e preencha com seus valores:

```bash
cp .env.example .env
```

**Variáveis disponíveis:**

| Variável | Descrição |
|---|---|
| `FORMSPREE_ID` | ID do formulário no [Formspree](https://formspree.io) |

> O arquivo `.env` está no `.gitignore` e **nunca deve ser commitado**.

---

## Como Rodar

### Pré-requisitos

- Flutter SDK `^3.9.2`
- Dart SDK `^3.9.2`

### Instalação

```bash
flutter pub get
```

### Desenvolvimento

```bash
flutter run -d chrome \
  --dart-define=FORMSPREE_ID=seu_id_aqui
```

### Build para produção

```bash
flutter build web \
  --dart-define=FORMSPREE_ID=seu_id_aqui
```

Ou lendo direto do `.env`:

```bash
flutter build web \
  --dart-define=FORMSPREE_ID=$(grep FORMSPREE_ID .env | cut -d= -f2)
```

---

## Projetos em Destaque

| Projeto | Tecnologias |
|---|---|
| Relógio Pomodoro | Flutter · Dart · Cross-platform |
| EcoMonitor API | C# · ASP.NET Core · .NET 10 · SQLite |
| Eleição Brasil API | C# · ASP.NET Core · .NET 10 · MVC |
| SpiderNet API | C# · .NET 10 · Swagger · REST API |

---

## Contato

- **Email:** ianpedro1812@gmail.com
- **GitHub:** [github.com/Ianzinn](https://github.com/Ianzinn)
- **LinkedIn:** [ian-pedro-barbosa-de-santana](https://www.linkedin.com/in/ian-pedro-barbosa-de-santana-8a81ab307)
