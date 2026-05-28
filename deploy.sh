#!/bin/bash

echo "🚀 开始构建 Hugo 站点..."
hugo --gc --minify

if [ $? -ne 0 ]; then
    echo "❌ Hugo 构建失败，请检查错误信息。"
    exit 1
fi

echo "✅ Hugo 构建完成！"
echo ""
echo "🌐 开始部署到 Netlify..."
netlify deploy --prod

if [ $? -ne 0 ]; then
    echo "❌ 部署失败，请检查 Netlify 配置。"
    exit 1
fi

echo ""
echo "🎉 部署成功！网站已更新。"
