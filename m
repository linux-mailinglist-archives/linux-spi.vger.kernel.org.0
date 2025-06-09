Return-Path: <linux-spi+bounces-8418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F7AD28AA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 23:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01693AFCF9
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F31DB54C;
	Mon,  9 Jun 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGPZAMdQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205419EEC2;
	Mon,  9 Jun 2025 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504124; cv=none; b=CsKZ/zb8bhmCgREmhMTf6kUf7GG7XdUzKkGqIXDQX108DcHZnFHa5DlAsFMdrMjUGXW/42C1WZITEVzJ8I5z7SLmvSxNNWPhuv+AZI03M6BYIOMmoeyYElMoH2zrRs97Rg660sl/Uj3ctDOQK1V0BL+jg8MX+Sqc9EZUHBVNNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504124; c=relaxed/simple;
	bh=4hFPVX1a3Njgj3J/CkbuhSBDyw/fQl9H1TWiharQ0iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IaFZNCSq6mYVnSXky3kbix5d3bIpWwwu1HRd5wUIY0klOOnxVQIKwYvcFldxe4s15K6YZadPXk3N+d84h19gLOgHaj5FC7r4nSgGkSZJmi/17w1smlWEr//XwLsvX3hQNRl43KrKt0eDZ7DhHuC8rTCEHCzjKZew9AlaSV9Plvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGPZAMdQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cea01b9cso16695645e9.0;
        Mon, 09 Jun 2025 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749504120; x=1750108920; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gdOKP+Nxfmhacg4X+8FKqM5iRQ19VcTJllRh7MyQ40=;
        b=GGPZAMdQ3ha0QyIlRAQgL84kimO6IKdnoKZBaJdTdDfKL9O0s3dgF5ExIOYoJkd1GR
         0yluOlAai8woo8GYs/sigS7vh2cQAcNAW1TbSTp1mtW+v8ooVMM6gh6iakuTwuXIzbip
         ZFbstjKCURYvQtCqMZk3MMcNGK4VioWnvtK0goe5NWOni4USFzPKvuDqQZqtjez7yH6T
         5DNvlSrGdDA815po6XstFCxnHpldf+cLghwFaCW3xO2Zl1ksBf+2sQolLPCvsR9fHE4n
         xz2scvJFNOMKzyHh+Jt3BZy86y2H8i4AKUrlvjubv2T6ewI85fs4MF/pjaSnYWidXFHE
         I3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749504120; x=1750108920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gdOKP+Nxfmhacg4X+8FKqM5iRQ19VcTJllRh7MyQ40=;
        b=aeklOMuDkDUJyp0C8Cz32xrqBOxvaiHqv5v7bKTiwJdMHnNRwfNfoOBMEfabH6cjTd
         blaY16/AgyCMuyWaOJ2ufUeyt3p5Zs95K3eplodZCk++Ro2r90fpr374op1ZOY/vOEbE
         bYEJbYj15JDaGt9RBQDt58GiRkz3p6P7SWnGu46ZkBCrYUSWsFvaCzS0X3cZp4gWJENq
         Mm/vUU6pwHfYkmI+ndHvZDuCW+E2kWCaTxTGr2J2Ng0j17rDPLPdLqdgGILXU3OEYjuR
         +QvEb6pvYbWDx6dPaNAsQ604WilzujQV7Xv52WzGKJSyXHbyJ1KYWbKpdD1u6sk5Hfo7
         5uGA==
X-Forwarded-Encrypted: i=1; AJvYcCWqPjyLpLaceHzoyMaBU21kLR+T6vNvqz4dsXaFz9jeXkVoVIlcd7CYQAUacNGQ8YeZfWXUAifiVIYYTDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkFcvPJOpScj+hm4KD2dBejGGFRbB20L5Olvs/3k93eNqwmT9
	9t9JLmuJYvEFn+p2Wzvf1NRfiD4oCJoVIkh8jlPhPO03TUtWGbqoNzHrNgubwA==
X-Gm-Gg: ASbGncv+EuM64rLfwKYIWmGsS7ZBBFxxjnKdztsPzfnR55GALxW0RssFsq8Qe0oQ72q
	QPg77k5M+CnhK1rhei2JYyXBjZsVpi3UfFXbtbrFRVSmfEWOYGAPS0w2PKC0yyTKgDzxXaf3bkI
	As2phn6/zOdhJCmAUQ0jBr4M5J8nqV9WycP8Jcyfcbg6HoXI/8begZTr/EM1TiroUpgem1Y/9M2
	sehxQ3qsZRLW9gZNhADuoZ6JIFpm9DK/iolX/5NywINa8cupbqv9ldqd3MI1IPcIaObFWVPQ6uA
	Bvylas2QREgZ3gkPpPYsfsK4ckgv7IFkxK72bUIzz0YOqc+5YBxKDmrvk/UIkjM=
X-Google-Smtp-Source: AGHT+IE/2cX1nPf+w8uCeJiXWp8kn5eQF6w8I1IgQsMIxqQWcOXANvEMg488kaOtPpg6uFilgCO05w==
X-Received: by 2002:a05:600c:4686:b0:450:d3b9:4bac with SMTP id 5b1f17b1804b1-452014e9488mr98598825e9.28.1749504120302;
        Mon, 09 Jun 2025 14:22:00 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45213759fb2sm122214215e9.38.2025.06.09.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 14:22:00 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 09 Jun 2025 23:21:09 +0200
Subject: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
X-B4-Tracking: v=1; b=H4sIAERQR2gC/x3MQQqAIBBA0avErBNMTKirRITlWLNIRSsC8e5Jy
 7f4P0PCSJhgbDJEfCiRdxVd28B2aLcjI1MNgoueKz6wOxh94RLO5dRb9GxVBq2QUg1cQq1CREv
 vf5zmUj5QMyFfYQAAAA==
X-Change-ID: 20250609-update_pm_macro-b6def2446904
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=4hFPVX1a3Njgj3J/CkbuhSBDyw/fQl9H1TWiharQ0iI=;
 b=kA0DAAoB5yGKaNQSwrUByyZiAGhHUFqj8dJRYFzmY0ZW+fvyMY9Yi7zZ5P4NaBLUfxynWzzc3
 4kCMwQAAQoAHRYhBCCZe/YT5+9tX/26L+chimjUEsK1BQJoR1BaAAoJEOchimjUEsK19NcP/2dj
 r1wHyNk+LDWLAqNfnIGYI4TD3bdedaYFflFfZ8irmdke0UxSyh5cKAwifY/P9+dgw8r1BpwgGMs
 EjusV83G6rLLHL1LvTRwAIFAKWlcUgkY+CyUsAB8no11XD9Q/ho3Q8AQIuFGEdn2cLjp0R/QoJL
 3RTtpJh+17JNWPSZArbMqLl4ZdWVS+0ktCYommwxYDxNUi2W+kWIO9bdtw2uGhIgZ9nUUsSoE/6
 Z/Wo9CCe+EViQcXfclbWR5WRtlRkJoD37Jmy0rT5iKSS/pe8Cvnwj0qmVcftcrw7wsVNwkPrKR1
 jb/7OTUgUXIEu2E8tiMI3IKryGm9yXvaSutvRMAtKgphESdmrFREN28pv6Ow5Q0RgPwXnedj0nU
 18XrOkZIR5VQNQqspgeWGZ2LL6rLdzuIlT02yXFJIG8pjrgs6FfsRQYOxUIM84JioQFl6ZzAuTs
 ZVm9KRFwpzIhg26sNZZYi9ZZwlOnSyBZWEr819URUJibvlffk8ISmt0VSRJ1dgd7c2XAK5TPhSg
 dXYwbTuKhGh9ThJxa23mO4tqi0vwpmI96xSI5LZCV7K3zs3j00y3uvQMCILxkDn0oKxAPvbZs7j
 vv4gA0qcTdzHc1jGO7hzrxJxupNF55BssBWAt0mzBkJWH9AyMhQv/vm56MsEXHLo9Sp5m6A6pFG
 hDlD1
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/spi/spi-st-ssc4.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 4cff976ab16fbdf3708ab870176a04f2628b501b..49ab4c515156fbabe0761028a5cb4770b61ca508 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -378,8 +378,7 @@ static void spi_st_remove(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
-static int spi_st_runtime_suspend(struct device *dev)
+static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
@@ -392,7 +391,7 @@ static int spi_st_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int spi_st_runtime_resume(struct device *dev)
+static int __maybe_unused spi_st_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
@@ -403,10 +402,8 @@ static int spi_st_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int spi_st_suspend(struct device *dev)
+static int __maybe_unused spi_st_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -418,7 +415,7 @@ static int spi_st_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int spi_st_resume(struct device *dev)
+static int __maybe_unused spi_st_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
 
 	return pm_runtime_force_resume(dev);
 }
-#endif
 
 static const struct dev_pm_ops spi_st_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
@@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
 static struct platform_driver spi_st_driver = {
 	.driver = {
 		.name = "spi-st",
-		.pm = &spi_st_pm,
+		.pm = pm_sleep_ptr(&spi_st_pm),
 		.of_match_table = of_match_ptr(stm_spi_match),
 	},
 	.probe = spi_st_probe,

---
base-commit: 475c850a7fdd0915b856173186d5922899d65686
change-id: 20250609-update_pm_macro-b6def2446904

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


