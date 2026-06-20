# 联盟营销投放闭环执行计划

## Context

网站基建已完成（Hugo 站点、评测内容、联盟链接、GA4/GTM），但存在三个硬阻塞导致无法形成有效投放闭环：
1. Google Ads 转化追踪代码在 hugo.toml 中被注释掉，未实际生效
2. speakable schema CSS 选择器指向不存在的 class
3. 缺少 "How We Test" 页面（菜单引用但无内容）

用户需要一个清晰的闭环路径，从广告投放到佣金回收，每个环节可追踪、可判断。

---

## 闭环定义

```
Google Ads 花费 $ → 广告曝光 → 用户点击 → 落地页访问 → 用户点击联盟按钮 → 跳转 Amazon → 用户购买 → 你获得佣金
                                                                                                        ↓
                                                                                         佣金 > 广告花费 = 盈利
```

闭环中每一层都必须可测量，否则无法判断哪里断了。

---

## 任务清单

### Phase 1: 代码修复（Sisyphus 执行）

- [ ] 1.1 修复 speakable schema 选择器
  - 文件: `layouts/partials/schema.html` 第 109 行
  - 改: `".article-summary", "#quick-verdict"` → `".review-summary", ".review-summary-text"`
  - 验证: 在已部署的评测页查看源码，确认 speakable 指向正确 class

- [ ] 1.2 取消注释 Google Ads 追踪代码
  - 文件: `hugo.toml` 第 20-21 行
  - 改: 取消 `google_ads_id` 和 `google_ads_label` 的注释，填入真实 ID
  - 注意: 需要用户提供真实的 Google Ads Conversion ID 和 Label
  - 验证: 部署后在页面源码中确认 Google Ads tag 存在

- [ ] 1.3 创建 "How We Test" 页面
  - 文件: `content/how-we-test/_index.md`
  - 内容: 测试方法论、30 天测试周期、独立购买声明、联盟披露
  - 验证: 部署后访问 /how-we-test/ 页面正常渲染

- [ ] 1.4 更新 llms.txt，列出 top-20 评测页面
  - 文件: `static/llms.txt`
  - 改: 在 Key Pages 部分添加所有评测文章 URL
  - 验证: 访问 /llms.txt 确认内容完整

### Phase 2: 用户手动操作（浏览器中完成）

- [ ] 2.1 注册 Google Search Console
  - 操作: 访问 search.google.com/search-console → 添加资源 → 验证域名所有权
  - 提交 sitemap: https://homekitchenpicks.com/sitemap.xml
  - 验证: GSC 显示"已验证"且 sitemap 状态正常

- [ ] 2.2 修正 Google Ads 地理定位
  - 操作: Google Ads → 广告系列 → 设置 → 地区 → 选择目标国家（如 US）
  - 排除非目标地区
  - 验证: GA4 实时报告中的用户地区与目标一致

- [ ] 2.3 确认 Google Ads 语言设置
  - 操作: 广告系列 → 设置 → 语言 → 选择 "English"
  - 确认广告文案语言、关键词语言、页面语言一致
  - 验证: 搜索词报告中语言与设置匹配

- [ ] 2.4 设置最小有效预算
  - 操作: 广告系列 → 设置 → 预算 → 设置每日预算
  - 建议: 先设 $10-20/天，跑 7 天收集数据
  - 验证: 广告开始获得曝光和点击

- [ ] 2.5 验证转化追踪
  - 操作: 从广告或测试入口进入页面 → 点击联盟按钮 → 检查 GA4/GTM/Google Ads 后台
  - 确认三层事件: 页面访问、按钮点击、联盟跳转
  - 验证: Google Ads 后台能看到转化事件

### Phase 3: 第一轮数据验证（跑 7 天后）

- [ ] 3.1 建立投放记录表
  - 字段: 日期、产品、地区、预算、曝光、点击、CTR、CPC、页面访问、按钮点击、联盟点击、订单、佣金、备注
  - 每天固定看同一组指标

- [ ] 3.2 诊断链路检查
  - 广告没人点？→ 检查关键词/素材/出价
  - 点了没人进站？→ 检查落地页加载
  - 进站没人点按钮？→ 检查首屏/卖点/按钮位置
  - 点按钮没到联盟？→ 检查联盟链接/跳转
  - 到联盟没订单？→ 检查产品/价格/评论/购买意图

---

## 成功标准

Phase 1 完成后:
- speakable schema 指向正确的 CSS class
- Google Ads 追踪代码实际生效
- How We Test 页面可访问
- llms.txt 列出所有评测页面

Phase 2 完成后:
- GSC 已验证并提交 sitemap
- 广告展示地区与目标市场一致
- 转化事件能在 GA4/GTM/Google Ads 中看到
- 广告获得真实曝光和点击

Phase 3 完成后:
- 能判断广告 CTR 是否可接受
- 能判断页面按钮点击率是否可接受
- 能判断联盟后台是否有点击记录
- 能计算单品 CPC 和潜在 ROI

---

## 关键用户输入（阻塞项）

执行前需要用户提供:
1. Google Ads Conversion ID（格式: AW-XXXXXXXXX）
2. Google Ads Conversion Label
3. 目标投放国家（如 US、UK、CA）
4. 当前每日预算金额
5. 是否已有 Google Ads 曝光和点击数据
