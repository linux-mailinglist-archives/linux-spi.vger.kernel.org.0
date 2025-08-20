Return-Path: <linux-spi+bounces-9568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A96B2E498
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23625E8235
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404725A347;
	Wed, 20 Aug 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioZTnQdy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535019F464;
	Wed, 20 Aug 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713023; cv=none; b=LnwpP+B33tDIgJFHqTWF/ARAzEqCPMpMZqWN0pHF87O6GejdqAZf0RpeMp/6dwdAwVMvRwiKaEAq/q7hDUMNA7778+dXWk/NrdtoCBAvH4bz6HgQqkMtDYhYIYYf69MF9FfJ2r7pSfRStpvfg/6YEnz5fOJtiURCZKgVR5hthCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713023; c=relaxed/simple;
	bh=7QHvqbNyD3T8XWXuo9VVc7Qe5eq8zUqzOagpa4SYsvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3M4QmRuAIDzc5/aq5Z3ABAcEyqjR5aL5PZjpkNfBWdT4RBLJN7aGexIoh2KwjuafyP8XonCzS1bpLzBBsOFWCDEYWLvpWMsp0ev6NA4UsjxyHRzFTsZ51H5kcuAGIFDJFnAXkYyv3nMVt08JXifv1tGnNjxZTmZrtWYxKBGWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioZTnQdy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so1066195e9.0;
        Wed, 20 Aug 2025 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713020; x=1756317820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpJLLzSWB1hSMWi95RrMucYY40dFasoMvr1QtUcD398=;
        b=ioZTnQdytYrWnSwex2LrIsJNb+/uQq04DBmAWubpWEPniqN8Xzj+ddCi30fjxtHTm6
         rR+ERXpFKu+2nEWLmh+GTAhXSnvpZQJj3aICAAAdGdvbbtfrDZ1F+iRoqsPAngjLX0ex
         DB24p24L7vrZGSdr/r5OmLIv9351xrQ1kX8FmuvfuMhnU9FBQI9eL3ijGFwrokSnNPqX
         3uUB7AHlnciS2B9sPJm2OXkvWke07FTzIg3TbJrOg/T+heni3m8Zb3FflEk03ah3QcnW
         mZvZrhPo4mhAgyr8Lcd81oNAn8beESXzlJECa+myNj5FwCLl9L2MwbZkpf165IcXyWpr
         Ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713020; x=1756317820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpJLLzSWB1hSMWi95RrMucYY40dFasoMvr1QtUcD398=;
        b=r4A0c99Kjd9CNT3zIk/Y0u5pRvL7v0YONAZnBh05bKY/ZCAUNkWWJbGD+8OKHVRMC7
         rNvJlRlxRmalleT0x9ToKBH6vBLnuM7h1BSHgOrvehsHGKb+5y48iKRZUqshjzrzMGNy
         bYsKCV7ouYU/W0OyzPLWVj6EoR8IBlqr/pid8vZD84dmW53Bu28T2PK2LoTJTYbYA+Az
         2wUVo9fevsuLvgs3bD74TN/Kuhq6p3hIOyTiQjXBFK/GPaX6GCY9pM+4GxfG+kQxMgZT
         0x8hCYAb8mk7s/zDBZgBQqkbOHSXCAJS5LkzEGdDrVEr+KZ0uSXE9OMS7noA6y5c6+Ym
         z0uw==
X-Forwarded-Encrypted: i=1; AJvYcCUNR8WNuX79SSOKxk+SZs62DcRX42J/f28v2ErHhJH2NnEZeBvM2eVw5cQlPR5o+M5F63O2dl2FkiGe0k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMq2ydKpfPGp17gWmWQyhM5kqmE+WFc6kVmQ1JJwXAFKlGednn
	UtZ8q5rySWb59szyVbQuKRk+VUNGggHY3brrBHpRjQzEgfCHkupMrGQYhODUaQ==
X-Gm-Gg: ASbGnctSOaGdbpZuzMRN2n20JmKiJLuA3ih1k1B9skE/viVTF11BlK8SA1Th3GgS7ri
	FhMr0mCRjY/xzgwpBUiwuSGP4WN+iYvgNXZfceVyML3GAercYnqUayokgHEcRyfnW3452dOzXx1
	iE4t6lCWxf393eZUJMcLysBL+KMWT70R2lz3w9993DOqCmz5STD9Su0VaKy1XvDVOMlhofk+6MX
	gF3oXM+INaxCUhh+lgmicjGrukN2Vu//XZGMLGx9xVq73gdcf53jsRR+bXruvmKfOBWk8L9OrUe
	YArY2yqEW7NyBETTijOavFf/g8OZ03sZ4qK1MPW3WFRH3SH6D0PZEMpa0Xsym8eJ+E9/mnWOSLz
	eo7ZpD9+0PlP6zb+SP+/zvw==
X-Google-Smtp-Source: AGHT+IFh/E9lnjKTs3kxRrLvlbGjy8oSnK4JJSucdbLknDdJAJH1cXdCJOfOTXv/BaL/tYZQxUpKaA==
X-Received: by 2002:a05:600c:1d0a:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-45b47a20422mr28734805e9.4.1755713019930;
        Wed, 20 Aug 2025 11:03:39 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4cd1ff39sm435695e9.0.2025.08.20.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:03:39 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP
Date: Wed, 20 Aug 2025 20:03:10 +0200
Message-ID: <20250820180310.9605-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_sleep_ptr() depends on CONFIG_PM_SLEEP while pm_ptr() depends on
CONFIG_PM.  Since ST SSC4 implements runtime PM it makes sense using
pm_ptr() here.

For the same reason replace PM macros that use CONFIG_PM.  Doing so
prevents from using __maybe_unused attribute of runtime PM functions.

Link: https://lore.kernel.org/lkml/CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com
Fixes: 6f8584a4826f ("spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()")

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/spi/spi-st-ssc4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 49ab4c515156..c07c61dc4938 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -378,7 +378,7 @@ static void spi_st_remove(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
+static int spi_st_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
@@ -391,7 +391,7 @@ static int __maybe_unused spi_st_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused spi_st_runtime_resume(struct device *dev)
+static int spi_st_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
@@ -428,8 +428,8 @@ static int __maybe_unused spi_st_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops spi_st_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
-	SET_RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
+	RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
 };
 
 static const struct of_device_id stm_spi_match[] = {
@@ -441,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
 static struct platform_driver spi_st_driver = {
 	.driver = {
 		.name = "spi-st",
-		.pm = pm_sleep_ptr(&spi_st_pm),
+		.pm = pm_ptr(&spi_st_pm),
 		.of_match_table = of_match_ptr(stm_spi_match),
 	},
 	.probe = spi_st_probe,
-- 
2.50.1


