#!/bin/bash
# ======================================================
# Local deploy script — production deployment via Git
# ======================================================
# 🚫 DO NOT run this for production from your local machine.
#    Production deploys are handled by GitHub Actions CI.
#
# ✅ Use this ONLY for:
#   - Preview deploys: vercel
#   - Local dev: hugo server
#
# 🔐 Isolation rule:
#   Your local browser should NEVER visit homekitchenpicks.com
#   for testing. Always use vercel preview URLs or localhost.
# ======================================================

set -euo pipefail

echo "=============================================="
echo "  🔒 生产部署已被 GitHub Actions CI 接管"
echo "=============================================="
echo ""
echo "  你的本地环境已与生产域名隔离。"
echo ""
echo "  本地开发:   hugo server"
echo "  预览部署:   vercel"
echo "  生产部署:   git push → GitHub Actions"
echo ""
echo "  推送到 main 分支将自动构建并部署。"
echo "=============================================="

read -p "推送到 GitHub 以触发生产部署？(y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  git push origin main
  echo "✅ 已推送。在 https://github.com/leolove5206869-rgb/prime-day-/actions 查看进度。"
fi
