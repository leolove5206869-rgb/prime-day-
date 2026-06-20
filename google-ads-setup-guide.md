# Google Ads 实操指南 — 跟着做

> 先读 `google-ads-launch-plan.md` 了解全貌，这篇是实操步骤

---

## Step 1: 创建 Google Ads 账号（10 分钟）

### 你需要准备
- 一个 Gmail 账号（建议用网站运营邮箱，如 `xxx@gmail.com`）
- 一张 Visa/Mastercard 信用卡
- 网站：`https://homekitchenpicks.com`

### 步骤

1. 打开 [ads.google.com](https://ads.google.com)，点「Start Now」
2. 登录你的 Gmail
3. Google 会问你的广告目标 → 选 **「Get website traffic or sales」**
4. 输入网址：`https://homekitchenpicks.com`
5. 选时区：`(GMT+8:00) China` — 重要，设完不能改
6. 选货币：`USD`
7. 设置结算：输入信用卡信息
8. 完成创建

> ⚠️ 创建过程中 Google 会让你创建第一个广告系列。**先不要启动**，点「Skip」或不要提交结算。我们先配好转化追踪再开始。

### 创建完成后找我

把你的 Google Ads **Customer ID** 给我，格式像这样：`123-456-7890`

我会用它指导你在 GTM 里配转化追踪。

---

## Step 2: 创建 Google Ads Conversion Tracking（跟着操作）

创建好账号后，在 Google Ads 后台：

1. 点右上角工具图标（🔧）→ **「Conversions」**
2. 点蓝色 **「+ New conversion action」**
3. 选 **「Website」**
4. 输入：
   - **Category**: `Other`
   - **Action name**: `Affiliate Click`
   - **Value**: `Use different values for each conversion` → 填入 `5`（每次点击预估收益）
   - **Count**: `Every`（不是 One）
   - **Click-through conversion window**: `30 days`
   - **Attribution model**: `Last click`
5. 点 **「Create and continue」**

### 拿到 Conversion ID

创建好后，Google 会给你一段代码。找到这两样给我：

- **Conversion ID**: 格式 `AW-123456789`
- **Conversion Label**: 跟在后面的标签

我帮你在 GTM 里配好。

---

## Step 3: GTM 转化追踪配置（我来操作）

### 在 GTM 创建 Conversion Linker 标签

1. 打开 [tagmanager.google.com](https://tagmanager.google.com) → 选择 GTM-PLN4Q6PZ
2. 新建标签：
   - **Tag type**: `Google Ads Conversion Tracking`
   - **Conversion ID**: 你给我的 ID
   - **Conversion Label**: 你给我的 Label
   - **Trigger**: 创建新触发器
3. 触发器设置：
   - **Trigger type**: `Click - Just Links`
   - **Wait for Tags**: ✅ 勾上
   - **Max wait time**: `2000` ms
   - **Enable this trigger when**: `Page URL` matches regex `.*`
   - **Fire this trigger when**: `Click URL` contains `amazon.com/dp/`
4. 保存并命名为 `GA4 - Affiliate Link Click`
5. Test → Preview → Submit

### 验证方法

发布后，自己在网站上点一个 Amazon 链接，然后去 Google Ads → Conversions → 看有没有记录到测试转化。

---

## Step 4: 创建第一个广告系列

转化追踪配好并验证通过后，按以下配置创建：

### 广告系列 1：厨房用具 Search

```
Campaign name:    HKP - Search - Cookware & Tools
Campaign type:    Search
Networks:         Search Network only (uncheck Display Network)
Locations:        United States
Languages:        English
Bidding:          Manual CPC (先手动控制，有数据再切)
Budget:           $10/day (约 $300/月)
Start date:       Today
```

### 广告系列 2：小家电 Search

```
Campaign name:    HKP - Search - Kitchen Appliances
Campaign type:    Search
Networks:         Search Network only
Locations:        United States
Languages:        English
Bidding:          Manual CPC
Budget:           $10/day (约 $300/月)
Start date:       Today
```

![campaign-structure](https://via.placeholder.com/1x1 "参见 google-ads-launch-plan.md 的广告组结构")

---

## Step 5: 否定关键词（必做！不花钱的关键词止损）

在每个广告系列添加：

| 否定词 | 原因 |
|---|---|
| free | 不买，白嫖流量 |
| DIY | 自己动手做，不是购买 |
| used | 二手，不是新品 |
| how to | 教怎么用，不是买什么 |
| repair | 修，不是买新的 |
| recipe | 食谱，不转化 |
| rental | 租赁 |

---

## 启动后前 3 周的纪律

| 时间 | 做什么 | 不做什么 |
|---|---|---|
| 第 1-3 天 | 等审核通过，观察展示次数 | ❌ 改出价 / 改文案 |
| 第 4-7 天 | 每天检查一遍，仅记录 | ❌ 暂停任何关键词 |
| 第 2 周 | 批量加新 Exact Match 关键词 | ❌ 大量调整预算 |
| 第 3 周 | 砍掉 CTR < 1% 或 Cost > $2 无转化的词 | ⚠️ 一次不超过 20% 预算 |

---

## 需要帮忙的时候

现在你可以先创建 Google Ads 账号，然后把 Customer ID 或 Conversion ID 给我，我来：

1. ✅ 在 GTM 配置好转化追踪标签
2. ✅ 生成具体的关键词列表（Keyword Planner 数据）
3. ✅ 帮你写好响应式搜索广告文案
4. ✅ 确认启动前所有设置
