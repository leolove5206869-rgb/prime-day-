#!/bin/bash
# ======================================================
# 生产部署已被 GitHub Actions CI 接管
# ======================================================
# 你的本地环境已与生产域名隔离。
#
# 本地开发:   hugo server
# 预览部署:   vercel
# 生产部署:   git push → GitHub Actions
#
# 推送到 main 分支将自动构建并部署。
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
echo "=============================================="

read -p "推送到 GitHub 以触发 CI 生产部署？(y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  git push origin main
  echo "✅ 已推送。在 https://github.com/leolove5206869-rgb/prime-day-/actions 查看进度"
fi
