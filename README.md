# Next.js Hexagonal Architecture CLI

A CLI tool to create a fully configured Next.js project with TypeScript, MUI, Prisma, and a clean **Hexagonal Architecture**.

## Features

* Next.js with TypeScript and ESLint preconfigured
* MUI and MUI Icons installed
* Prisma installed and initialized
* Custom Hexagonal Architecture folder structure
* Cleans up default files and structure from `create-next-app`
* Preconfigured `page.tsx` and `layout.tsx`

![Hexagonal Architecture](public/hexagonal_architecture.png)

## Prerequisites

This tool is intended for **Linux** users.

You need to have the following installed:

* Node.js and npm
* `expect` package:

```bash
sudo apt-get install expect
```

## Installation

Clone the repository or download the script file. Then:

1. Move the script to a directory in your PATH (e.g., `~/.local/bin`):

```bash
mv new-nextjs-project.sh ~/.local/bin/new-nextjs-project
chmod +x ~/.local/bin/new-nextjs-project
```

2. Make sure `~/.local/bin` is in your `$PATH` (check with `echo $PATH`).

## Usage

Simply run:

```bash
new-nextjs-project <project-name>
```

Example:

```bash
new-nextjs-project my-awesome-app
```

This will generate a complete project with the following structure:

```
/my-awesome-app
│
├── app/
│   ├── api/            # Primary adapters: Next.js API routes
│   └── ui/             # Primary adapters: Pages and routing-specific UI components
│
├── components/         # Reusable UI components (MUI, buttons, forms, etc.)
│
├── core/
│   ├── domain/         # Domain entities, value objects
│   ├── use-cases/      # Application use cases
│   ├── services/       # Pure domain services
│   └── ports/          # Interfaces for external adapters (e.g., repositories)
│
├── infrastructure/
│   ├── orm/
│   │   └── prisma/
│   │       └── schema.prisma
│   ├── repositories/   # Concrete implementations of ports for persistence
│   ├── services/       # Implementations of external services (API, notifications, etc.)
│   └── config/         # Technical configuration (DB, API clients, etc.)
│
├── shared/             # Shared types, utilities, constants
│
├── public/             # Static files (cleaned)
│
├── styles/             # Global styles (includes globals.css)
│
└── tests/              # Unit and integration tests
```

## Notes

* The `public/` folder is cleaned of all default Next.js icons and files.
* The default `app/page.tsx` and `app/layout.tsx` are replaced with custom minimal versions using MUI and project metadata.
* Prisma schema is placed directly in `infrastructure/orm/prisma/schema.prisma`.
