# HomeKitchenPicks 广告上线路线图

## TL;DR

> **核心目标**: 从 $0 流量起步，通过分阶段广告网络升级，实现网站变现
>
> **交付物**:
> - AdSense 申请 → 技术部署 → Cookie Consent → 上线运行
> - 流量里程碑驱动的网络升级路径 (AdSense → Ezoic → Mediavine → Raptive)
> - 每次升级的技术迁移步骤
>
> **估算工作量**: 短期（AdSense 技术部署 2-3 天）→ 长期（流量增长持续数月）
> **并行执行**: 技术部署与内容/SEO 可并行
> **关键路径**: AdSense 申请获批 → 广告代码部署 → Cookie Consent → 上线

---

## 广告网络晋级路径

```
流量 (sessions/月)    网络                    RPM 预估    年收入预估*       申请条件
──────────────────────────────────────────────────────────────────────────────
0 → 500+              Google AdSense           $5-15       $0-500          内容质量过关即可申请
│
5K → 10K+            Ezoic / Monumetric       $10-20      $500-2,400      10K+ sessions/月
│
50K+                 Mediavine               $25-45      $15,000-27,000   50K+ sessions/月 (US为主)
│
100K+                Raptive (AdThrive)       $30-50      $36,000-60,000   100K+ sessions/月
```

*\* 估算基于行业平均 RPM，实际取决于流量质量、季节、品类等因素*

### 选择 AdSense 起步的理由

| 对比项 | AdSense | Ezoic | Mediavine |
|--------|---------|-------|-----------|
| 流量门槛 | 无（内容够即可） | ~10K/月 | 50K/月 |
| 申请难度 | 低 | 中 | 高 |
| RPM | $5-15 | $10-20 | $25-45 |
| 对 UX 影响 | 低（可控制） | 中（AI 放置） | 中高 |
| 迁移灵活度 | 高（随时可替换） | 中 | 低（需换域名 DNS） |

**结论**: 新站从 AdSense 起步最合理。等流量达标再升级。

---

## 执行策略

### 并行执行 Waves

```
Wave 1（立即启动 — 技术准备，可并行）：
├── 1. AdSense 申请准备 + 提交（用户手动操作）
├── 2. Cookie Consent 部署
├── 3. ads.txt 配置并部署
├── 4. GTM 配置广告容器
└── 5. 内容持续优化 + SEO 增长（独立进行）

Wave 2（AdSense 获批后 — 上线投放）：
├── 6. 创建广告单元 + 接入现有容器
├── 7. 启用 AdSense Auto Ads
├── 8. 上线监控 + RPM 基线记录
└── 9. 性能验证（CLS/LCP 不受影响）

Wave 3（流量到阈值后 — 网络升级循环）：
├── 10. 10K → 申请 Ezoic/Monumetric
├── 11. 迁移广告代码
├── 12. 50K → 申请 Mediavine
├── 13. 迁移到 Mediavine
└── 14. 100K → 申请 Raptive
```

---

## TODOs

### Wave 1 — 技术准备（现在可并行做）

- [ ] 1. 提交 Google AdSense 申请

  **做什么**:
  - 访问 https://adsense.google.com 用 Google 账号注册
  - 提交网站 URL: https://homekitchenpicks.com
  - 填写网站信息（内容类型: 产品评测/博客）
  - 等审核结果（通常 1-2 周，可能拒后重提）

  **注意**:
  - 确保网站有足够内容（100+ 篇 ✅）
  - 必须有 Privacy Policy（已含广告声明 ✅）
  - 必须有 About / Contact 页面
  - 必须有良好 UX（已有 ✅）
  - **审核通过后，后台 → Account → Publisher ID，复制 `pub-XXXXXXXXXXXXXXXXXX`**

  **我这边可做**:
  - 创建 About 页面（如还没有）
  - 确认 Contact 页面存在

  **Commit**: YES（创建 About/Contact 时）
  - `chore: add about and contact pages for adsense compliance`

- [ ] 2. 部署 Cookie Consent 横幅

  **做什么**:
  - 选方案：推荐 **CookieYes** 免费版（一站式，GDPR 合规）
    - 免费版支持：横幅样式自定义、自动语言检测、手动/自动同意
    - 注册 cookieyes.com → 获取免费代码片段
  - 在 Hugo 中部署：
    - `layouts/partials/cookie-consent.html` — 新建，放 CookieYes 代码
    - 在 `layouts/_default/baseof.html` 中 `</body>` 前引用该 partial
  - 配置 CookieYes 控制台：
    - 扫描网站自动发现 cookies（GA4 等）
    - 开启"strictly necessary" + "analytics" 分类
    - 样式匹配现有主题颜色

  **为什么选 CookieYes**:
  - 免费版已够用（1 domain，50K 月 PV 以内免费）
  - 自动处理 GDPR + ePrivacy（即使 US 为主，全球访客也受保护）
  - 与 AdSense 合规要求完全匹配（AdSense 需要用户同意后才可投个性化广告）

  **验收标准**:
  - 首次访问时底部弹出 Cookie 横幅
  - 点击 Accept → 横幅消失，GA4 开始追踪
  - 点击 Reject → GA4 不追踪（CookieYes 自动处理）
  - 不影响 CLS（横幅 position: fixed 不会撑大内容）

  **提交**: 与任务 3 合并

- [ ] 3. 配置 ads.txt 并部署上线

  **做什么**:
  - AdSense 批准后，用真实 Publisher ID 替换 `static/ads.txt`：
    ```
    google.com, pub-XXXXXXXXXXXXXXXXXX, DIRECT, f08c47fec0942fa0
    ```
  - 部署到 Vercel
  - 验证：访问 `https://homekitchenpicks.com/ads.txt` → 返回正确内容
  - AdSense 后台验证 ads.txt（后台就有验证入口）

  **阻止条件**: 等待 AdSense 审批拿到 Publisher ID

  **提交**: 与任务 2 合并
  - `feat: add cookie consent and configure ads.txt`

### Wave 2 — AdSense 上线（获批后执行）

- [ ] 4. 创建 AdSense 广告单元并接入现有容器

  **做什么**:
  - AdSense 后台 → Ads → By ad unit → 创建展示广告
    - 建议创建 3 种尺寸（方便容器适配）:
      - 矩形 (300x250) — 文章内嵌
      - 横向 (728x90) — 列表页
      - 自适应 (Responsive) — 侧边栏
  - 获取每个单元的广告代码（`<script>` + `<ins>` 片段）
  - 在 GTM 中配置：
    - 新建 Tag → Google AdSense → 粘贴广告代码
    - 触发器设定为页面路径匹配对应的模板
  - 或者直接在模板中嵌入代码（更简单但不通过 GTM）：
    - 修改 `layouts/shortcodes/ad-unit.html`，直接从 shortcode 参数指定广告 slot ID
    - 通过 Hugo 的 `{{ .Site.Params.adsense_pub_id }}` 管理 ID

  **推荐方案**: 通过 GTM 管理（后续换网络只需改 GTM，不动模板）

  **当前容器映射**:
  | 容器 ID | 位置 | 推荐广告尺寸 |
  |---------|------|-------------|
  | review-in-content-1 | 评测文章第一篇后 | 300x250 或 Responsive |
  | review-in-content-2 | 评测文章第二篇后 | 300x250 或 Responsive |
  | review-sidebar | 评测侧边栏 | 300x250 |
  | list-in-content-after-3 | 列表页第3篇后 | 728x90 或 Responsive |
  | list-bottom | 列表页底部 | 728x90 |
  | single-bottom | 普通页面底部 | 728x90 或 Responsive |

  **验收标准**:
  - 页面加载后广告容器内渲染出广告内容
  - 广告被 AdSense 填充（非空白占位，非空白）
  - CLS 未显著增加（因为已有 min-height ✅）
  - 广告内容响应式适配

- [ ] 5. 启用 AdSense Auto Ads

  **做什么**:
  - AdSense 后台 → Ads → Auto ads → 启用
  - 选择"使用自动广告"（与手动单元互补）
  - 配置排除：不在导航、页脚、登录页等位置自动放置
  - 与手动广告单元的关系：Auto Ads 会自动避开已放置手动单元的位置

  **为什么要启用**:
  - 保守策略下也能最大化填充率
  - Auto Ads 会自动找到最佳位置
  - 和现有手动容器不冲突

- [ ] 6. 上线监控 + RPM 基线

  **做什么**:
  - AdSense 上线后第 1 周每天看后台数据
  - 记录基线：
    - 页面 RPM（$ / 1000 PV）
    - 填充率（fill rate）
    - 点击率（CTR）
  - 对比 GA4 流量数据交叉验证
  - 确认无异常：误点击、违规警告、流量异常

  **关键指标**:
  | 指标 | 健康范围 | 需关注 |
  |------|---------|-------|
  | Page RPM | $5-15 | < $3 |
  | Fill Rate | > 80% | < 50% |
  | CTR | 0.5-2% | < 0.1% 或 > 5% |
  | Invalid Traffic | < 0.5% | > 1%（可能被警告）|

### Wave 3 — 流量驱动升级（重复使用）

- [ ] 7. 10K sessions → 升级到 Ezoic / Monumetric

  **触发条件**: GA4 连续 30 天月访问量稳定 > 10K sessions

  **做什么**:
  - 比较选择：
    - **Ezoic**: AI 广告放置、Big Data Analytics，门槛更低
    - **Monumetric**: 人工优化、1-on-1 支持，门槛 10K
  - 迁移步骤：
    - 注册新网络账号
    - 需要将域名 DNS 指向 Ezoic（或使用其其他接入方式）
    - 在 Ezoic 后台配置广告布局
    - 保留 AdSense 作为 Ezoic 的广告需求来源（Ezoic 可用 AdSense 填充）
    - 逐步关掉直接 AdSense 代码
  - **注意**: 迁移通常需要 DNS 切换，会有短暂（<1 小时）流量波动

- [ ] 8. 50K sessions → 申请 Mediavine

  **触发条件**: 连续 30 天月访问量 > 50K sessions（US 流量为主）

  **做什么**:
  - 访问 mediavine.com → Apply
  - 准备材料：流量数据截图（GA4），网站信息
  - 审核等待：通常 1-2 周
  - 批准后：Mediavine 提供广告代码
  - 迁移：移除 Ezoic DNS 指向 → 插入 Mediavine 代码
  - Mediavine 会自动管理广告布局（不再需要手动管理容器）

- [ ] 9. 100K sessions → 申请 Raptive

  **触发条件**: 100K+ sessions/月
  **过程类似 Mediavine，但 RPM 更高**

---

## Cookie Consent 方案对比

| 方案 | 免费额度 | 安装复杂度 | 自定义 | 推荐场景 |
|------|---------|-----------|--------|---------|
| **CookieYes** | 1 domain / 50K PV | 低（一行代码） | 好 | ✅ 推荐，新站首选 |
| Osano | 有限免费 | 低 | 中 | 免费额度较紧 |
| Finsweet Cookie Consent | Webflow 专用 | - | - | 不适用 |
| 自建 | 无限制 | 高 | 完全 | 不推荐（维护成本高） |

---

## 收入预估模型

```
场景 A — 保守（AdSense 起步）
  RPM: $8（保守估计）
  流量: 1K → 10K → 50K sessions/月
  年收入: ~$0 → $200 → $4,800

场景 B — 中等（流量增长正常 + 适时升级）
  流量 10K: AdSense $15 RPM → $1,800/年
  流量 50K: Mediavine $35 RPM → $21,000/年
  流量 100K: Raptive $45 RPM → $54,000/年

场景 C — 乐观（SEO 爆发式增长）
  24 个月达到 200K sessions/月
  RPM $40 → $96,000/年
```

---

## 时间线预估

```
Month 1-2:  AdSense 申请 + 部署上线 + 持续内容
Month 3-6:  流量从 0 爬坡到 1-5K（SEO 见效期）
Month 6-12: 流量 5K-10K（考虑 Ezoic）
Month 12-18: 流量 10K-50K（准备 Mediavine）
Month 18-24: 50K+（Mediavine 收入达到有意义水平）
```

---

## 关键风险

| 风险 | 概率 | 影响 | 应对 |
|------|------|------|------|
| AdSense 首次驳回 | 中 | 延迟 1-2 周 | 根据驳回理由修改后重提 |
| RPM 过低 | 中 | 收入不达预期 | 检查流量来源（非 US 流量 RPM 低），优化内容质量 |
| 流量增长缓慢 | 中高 | 上线网络后长期低收 | 重点投入 SEO + 内容策略 |
| Ezoic DNS 迁移导致流量下滑 | 中 | 短期波动 | 做足准备，选低峰时段切换 |
| Mediavine 拒批 | 低 | 保持当前网络继续 | 继续增长流量 3 个月后再申请 |
| Cookie 合规风险 | 低 | 法律罚款 | CookieYes 免费版已覆盖基础合规 |

---

## 成功标准

- [ ] AdSense 获批并上线部署
- [ ] 所有现有广告容器填充非空白广告
- [ ] 无 CLS 退化（与 Phase 3 优化后对比）
- [ ] Cookie Consent 正常工作
- [ ] RPM 基线建立，有数据驱动的优化依据
- [ ] 达到流量阈值时按路径升级

---

## 下一步具体行动

1. **你这边**: 去 adsense.google.com 提交申请（需要就做这一步）
2. **我这边**: 准备 Cookie Consent 部署 + 确认 About/Contact 页面
3. 审批下来后：配置 ads.txt + 广告单元 + 上线监控
