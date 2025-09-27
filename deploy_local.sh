#!/usr/bin/env bash
# Helper script to follow the README deployment steps locally
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$PROJECT_ROOT"

echo "🎨 Deploying Gemini Picture Book Generator locally"

if ! command -v uv >/dev/null 2>&1; then
  echo "❌ uv is not installed. Please install uv (https://github.com/astral-sh/uv) and re-run this script."
  exit 1
fi

# Install dependencies using uv
if ! uv sync; then
  echo "⚠️  uv sync failed. Please ensure you have network connectivity and try again."
  exit 1
fi

# Ensure .env exists
if [ ! -f .env ]; then
  cp .env.template .env
  echo "ℹ️  Created .env from template. Please edit .env and add your GOOGLE_API_KEY before running the app."
else
  if grep -q "your_google_api_key_here" .env; then
    echo "⚠️  Update the GOOGLE_API_KEY value in .env with your actual API key from https://aistudio.google.com/app/apikey."
  fi
fi

echo "✅ Dependencies installed."
echo "🚀 To launch the web UI run: uv run gemini-picturebook"
echo "📟 To run the CLI generator run: uv run python -m gemini_picturebook_generator.enhanced_story_generator"
