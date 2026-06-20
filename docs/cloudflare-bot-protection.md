# Cloudflare Bot Protection Setup

## Overview
This document provides instructions for enabling Cloudflare Bot Fight Mode to protect homekitchenpicks.com from invalid traffic (IVT).

## Prerequisites
- Cloudflare account with homekitchenpicks.com added as a site
- DNS pointing to Vercel (already configured)

## Steps to Enable Bot Fight Mode

### 1. Access Cloudflare Dashboard
1. Log in to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Select **homekitchenpicks.com** from your sites list

### 2. Enable Bot Fight Mode
1. Navigate to **Security** → **Bots**
2. Under **Bot Fight Mode**, toggle **Enable** to ON
3. Configure settings:
   - **Definitely automated**: Block (recommended)
   - **Likely automated**: Challenge (recommended)
   - **Verified bots**: Allow (for Google, Bing, etc.)

### 3. Configure Super Bot Fight Mode (Pro Plan or higher)
If you have Cloudflare Pro or higher:
1. Go to **Security** → **Bots**
2. Enable **Super Bot Fight Mode**
3. Configure:
   - **Definitely automated**: Block
   - **Likely automated**: Managed Challenge
   - **Static Resource Protection**: Enable
   - **JavaScript Detection**: Enable

### 4. Set Up WAF Rules (Optional)
For additional protection:
1. Go to **Security** → **WAF**
2. Create custom rules:
   - Block requests from known bad IPs
   - Challenge requests from high-risk countries
   - Rate limit login attempts

### 5. Enable Security Headers
1. Go to **Security** → **Settings**
2. Enable:
   - **Security Level**: Medium
   - **Browser Integrity Check**: On
   - **Challenge Passage**: 30 minutes

## Verification
After enabling Bot Fight Mode:
1. Visit https://homekitchenpicks.com
2. Check Cloudflare Analytics for bot traffic reduction
3. Monitor for legitimate traffic being blocked (false positives)

## Monitoring
- Check **Security** → **Analytics** weekly
- Review blocked traffic in **Firewall Events**
- Adjust rules if legitimate traffic is being blocked

## Notes
- Bot Fight Mode may increase challenge pages for some users
- Legitimate search engine crawlers (Googlebot, Bingbot) are usually allowed by default
- Monitor Core Web Vitals after enabling - challenges can affect INP
