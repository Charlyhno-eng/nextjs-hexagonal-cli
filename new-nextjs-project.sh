#!/usr/bin/env bash

APP_NAME=$1

if [ -z "$APP_NAME" ]; then
  echo "Usage: new-nextjs-project <project-name>"
  exit 1
fi

# Create Next.js app with predefined answers
expect <<EOF
spawn npx create-next-app@latest $APP_NAME --typescript --eslint --no-tailwind --no-src-dir --app
expect "Would you like to use Turbopack"
send "No\r"
expect "Would you like to customize the import alias"
send "No\r"
expect eof
EOF

echo "Next.js project '$APP_NAME' created successfully."
echo "Installing MUI, Emotion, Prisma and @prisma/client..."

cd "$APP_NAME" || exit 1

npm install @mui/material @emotion/react @emotion/styled
npm install @mui/icons-material

npm install prisma --save-dev
npm install @prisma/client

npx prisma init

echo "Moving schema.prisma to infrastructure/orm/prisma and cleaning up..."

mkdir -p infrastructure/orm/prisma
mv prisma/schema.prisma infrastructure/orm/prisma/
rm -rf prisma

echo "Creating hexagonal architecture folder structure..."

mkdir -p \
  app/api \
  app/ui \
  components \
  core/domain \
  core/use-cases \
  core/services \
  core/ports \
  infrastructure/repositories \
  infrastructure/services \
  infrastructure/config \
  shared \
  public \
  styles \
  tests

echo "Removing unnecessary files from app/..."

rm -f app/favicon.ico
rm -f app/page.module.css

echo "Moving app/globals.css to styles/..."

mv app/globals.css styles/globals.css

echo "Cleaning public/ folder..."

# Remove all files in public folder
find public/* -type f -exec rm -f {} +

echo "Project '$APP_NAME' initialization complete."

echo "Updating app/page.tsx..."

cat > app/page.tsx <<EOL
import { Typography } from "@mui/material";

export default function Home() {
  return (
    <Typography>Hello world!</Typography>
  );
}
EOL

echo "Updating app/layout.tsx..."

cat > app/layout.tsx <<EOL
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "@/styles/globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "$APP_NAME",
  description: "Description",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={\`\${geistSans.variable} \${geistMono.variable}\`}>
        {children}
      </body>
    </html>
  );
}
EOL

echo "Project '$APP_NAME' initialization complete with custom files and structure."
