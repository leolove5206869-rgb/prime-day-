# Google Ads 启动计划 — homekitchenpicks.com

> 日期：2026-06-13
> 预算：$500–1000/月
> 目标：关键词搜索流量 → 评测阅读 → Amazon 联盟转化

---

## 1. 账号注册（你来操作）

### 步骤
1. 打开 [ads.google.com](https://ads.google.com)，用你的 Gmail 注册
2. 创建第一个广告系列前，先做**转化追踪设置**（见第 3 节）
3. 结算设置：国内信用卡，设 $300 每日预算上限（$500-1000 月预算 × 30天 = ~$17-33/天，留余量）
4. **不要启动广告系列**—等全部配置好再上线

---

## 2. 广告系列架构

### Phase 1（第 1-3 周）— 2 个 Search 广告系列

| 广告系列名称 | 主题 | 预算 | 匹配类型 |
|---|---|---|---|
| HKP - Search - 厨房用具 | Cookware / 工具类 | $300/月 | Phrase + Exact |
| HKP - Search - 小家电 | Appliances / 电器类 | $300/月 | Phrase + Exact |

> 区别不了具体受众群的词放在 Broad 匹配单独测试

### 广告组结构（以「厨房用具」系列为例）

| 广告组 | 对应 keywords | 对应着陆页 |
|---|---|---|
| 砍刀/厨刀 | chef's knife, kitchen knife | best-chef-knife-under-100/ |
| 砧板 | cutting board, wood vs plastic | best-cutting-board/ |
| 蒜蓉器 | garlic press | best-garlic-press/ |
| 厨房剪刀 | kitchen shears | best-kitchen-shears/ |
| 削皮器 | vegetable peeler | best-vegetable-peeler/ |
| 量杯 | measuring cups | best-measuring-cups/ |

---

## 3. 关键词策略

### 关键词类型（优先级递减）

| 类型 | 举例 | 意图 | 优先级 |
|---|---|---|---|
| Best + 品类 + 年份 | best air fryer 2026 | 最高（主动比价） | ⭐⭐⭐ |
| 品类 + review | garlic press review | 高（决策前） | ⭐⭐⭐ |
| 品类 + vs + 品类 | toaster vs air fryer | 高（对比选型） | ⭐⭐⭐ |
| 品牌 + review | KitchenAid Artisan review | 高（具体型号） | ⭐⭐ |
| 品类 + buyer's guide | blender buyer's guide | 中（早期调研） | ⭐⭐ |
| cheap/affordable + 品类 | affordable espresso machine | 中（价格敏感） | ⭐⭐ |
| best + 品牌 + 品类 | best KitchenAid stand mixer | 中 | ⭐⭐ |

### 初始关键词列表（按广告组）

**Air Fryer 广告组**
- `best air fryer 2026` — Exact — $2.50 CPC 估
- `best air fryer to buy` — Phrase — $2.20
- `air fryer review` — Phrase — $2.00
- `best air fryer for family` — Phrase — $2.80

**Coffee 广告组（单品 / 滴滤 / 意式）**
- `best drip coffee maker 2026` — Exact — $3.00
- `best espresso machine under 500` — Exact — $4.50
- `best pour over coffee maker` — Phrase — $2.80
- `Moccamaster vs Bonavita` — Exact — $2.50

**Food Processor 广告组**
- `best food processor 2026` — Exact — $3.20
- `food processor for dough` — Exact — $2.80

**Knife 广告组**
- `best chef's knife under 100` — Exact — $2.50
- `best kitchen knife set 2026` — Phrase — $3.00

**Comparison 广告组（核心差异化）**
- `manual vs electric can opener` — Exact — $1.80
- `wood vs plastic cutting board` — Exact — $1.50
- `KitchenAid Artisan vs Pro 600` — Exact — $2.20
- `immersion blender vs countertop blender` — Exact — $1.80

> CPC 估算基于厨房工具品类平均值；实际以 Google Keyword Planner 为准

---

## 4. 转化追踪设置（GTM）

这是 affiliate 站 Google Ads 最关键的一步。因为在 Amazon 上完成购买，只能以 **出站 affiliate 链接点击**作为代理转化。

### 原理
```
用户搜索 → 看评测 → 点 Amazon 链接 → GTM 触发转化事件 → Google Ads 记录一次转化
```

### GTM 配置步骤

等你的 Google Ads 账号创建好之后得到 **Conversion ID**，我再帮你做以下配置：

1. 在 GTM 创建一个 **Google Ads Conversion Tracking** 标签
2. 触发器：点击 Amazon 链接（`a[href*="amazon.com/dp/"]`）
3. 用一个 1-2 秒的延迟确保链接正常跳转

### 需要的代码（准备好后我在 GTM 帮你部署）

```javascript
// GTM Custom HTML tag / 转化追踪
// 在 affiliate 链接点击时触发
function() {
  var clickLink = {{Click URL}};
  if (clickLink && clickLink.indexOf('amazon.com/dp/') > -1) {
    // 触发 Google Ads 转化
    gtag('event', 'conversion', {
      'send_to': 'AW-CONVERSION_ID/CONVERSION_LABEL',
      'value': 5.0,  // 每次转化的平均预估收益
      'currency': 'USD'
    });
  }
}
```

> ⚠️ 需要你创建账号后告诉我 Conversion ID 和 Label

---

## 5. 广告文案模板

### 响应式搜索广告（RSA）

每个广告组需要 15 个标题 + 4 条描述。

**标题模板（针对 best/review 词）**
```
Best {Product} 2026
{Product} — Read Our Review
{Product} Buyer's Guide
We Tested 8 {Product}s — See Results
Top {Product} Picks for 2026
Which {Product} Is Best?
Don't Buy Until You Read This
Honest {Product} Reviews
Find Your Perfect {Product}
```

**描述模板**
```
We tested 8 top-rated {product}s for 45+ days. Read our detailed comparisons, pros & cons, and find the best {product} for your kitchen in 2026.
```
```
Not sure which {product} to buy? Our hands-on testing covers everything from performance to durability. See which models passed and which failed.
```

---

## 6. 预算分配

### 初始 $750/月（取中间值）

| 项目 | 占比 | 金额 |
|---|---|---|
| 厨房用具 Search | 40% | $300 |
| 小家电 Search | 40% | $300 |
| 测试 & 优化 | 20% | $150 |

### 分配逻辑
- 第 1-2 周：两个系列对半跑，收集数据
- 第 3 周起：砍掉 CTR < 1% 或 Conv. Cost > $15 的关键词
- 第 4 周起：把预算集中到 ROAS 最高的广告组

---

## 7. 着陆页优化提醒

Google Ads 使用 **Landing Page Experience** 作为 Quality Score 因素。做对以下：

- ✅ 页面加载快（Vercel + WebP 图片 → 确认）
- ✅ 移动端适配（Ananke 主题 → 需要确认）
- ✅ 内容与关键词匹配（review 页面对应产品关键词 → 基本满足）
- ❌ 可能会有问题：部分页面可能缺少明确 CTA 按钮
- ❌ 隐私政策 / 关于 / 联系页面 → 检查是否存在

### 建议补充

每个评测页底部加一个 CTA 区域：

```html
<div class="ads-cta">
  <p>⚡ 我们测试了所有产品，找到了最好的。</p>
  <a href="https://www.amazon.com/dp/{BEST_ASIN}?tag=homekitchenpic-20"
     class="cta-button"
     rel="nofollow sponsored"
     onclick="gtag_report_conversion()">
    See Today's Best Price on Amazon →
  </a>
</div>
```

---

## 8. 启动检查清单

- [ ] 创建 Google Ads 账号
- [ ] 设置结算方式
- [ ] 告诉我 Conversion ID / Label
- [ ] 我在 GTM 配置转化追踪标签
- [ ] 用 Google Keyword Planner 验证 CPC 估算
- [ ] 创建 2 个 Search 广告系列
- [ ] 写响应式广告（每个广告组 15 标题 + 4 描述）
- [ ] 添加否定关键词（free, DIY, used, how to）
- [ ] 设每日预算并启动
- [ ] 第 7 天检查数据并初步优化

---

## 9. 预期节奏

| 时间 | 预期 |
|---|---|
| 第 1-3 天 | 广告审核通过，开始展示 |
| 第 4-7 天 | 数据积累期（不要改任何设置） |
| 第 2 周 | 收集到转化数据，开始优化 |
| 第 3 周 | 砍掉低效词，加预算到高效组 |
| 第 4 周 | 可以增加 Demand Gen 或 Retargeting |

你的**第一步**：创建 Google Ads 账号，然后把 Conversion ID 给我。

要我现在继续，还是有什么问题想先确认？
