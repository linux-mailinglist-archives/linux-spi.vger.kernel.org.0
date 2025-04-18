Return-Path: <linux-spi+bounces-7671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13938A93686
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBC23B1B21
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9727465F;
	Fri, 18 Apr 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VMdEVWS2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E5155C82;
	Fri, 18 Apr 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975690; cv=none; b=d2+uHaI18K72hpvX+cB+Yl6BlnQnIp6yRTAwKjDEAQ+RT4Axhl+Wc3y4z1YLa3AYoO7ZinJEepHUXrMnW3fAWDWauHYtLCIqoaavrCCFvRuuntA+57VhQw1GUsWw+bauz0o1D6wBfr2pe589yuVIUXGSHaF45XrusltmzZg/IRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975690; c=relaxed/simple;
	bh=Ri9lzbonzTQiqH/1Av5Jqz+SjGr0tK+npV2Sd+2GNeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfn9lXqu4/4xpyr0blzNkoKKE1c90umV/kWBatMEpCitOQN5IfkxlA1T1P2MVYR8UUaOjwfcv00Aoxd95Cay/vDvrrfLHuDx9d63yu8jXpIB+mxHPu1HIAXI7mI4lgHVaJzqaTMEFAwiAQzAR9ytgKkOlGL1fA91WzcqiLy+8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VMdEVWS2; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5jt3uIpWSETiN5jt6uVhXy; Fri, 18 Apr 2025 13:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744975684;
	bh=RhKKzOTavQSyVncFCb3AgWCcG0eXDV8j6b9vH+lBEeA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VMdEVWS2hqlZxDo0TKNCxl3joZjhxZ5dBS7jxMf3Ig2oLFcedqURf035X+Jw176ZQ
	 QcsWaiXrLT8X5xmmDrjRQYF2ImTuhZ+VMWlUGkk/Mwl7ck6Gv7cp8wiTan9TvMxRWk
	 ERm0gI5Vrr/96HQVBSu44t5mHNziyqFa4Jg5ddIW69TfzUTgddT8Ju8VD/okA5wfv6
	 4gZlT5pA6eIbzwrR0wG7RNeWSL9Uze7pujd56A3Mur39GyaOsqWIE99ykQ5N08Hfs3
	 Wv4hg3yq+TMbTHpEnLoIPgPWakRcLRKzS1ytgYg4Tr9o9LURl4djvDBVsZJICso9yW
	 4AhmuJ7XVYN7Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Apr 2025 13:28:04 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: stm32-ospi: Fix an error handling path in stm32_ospi_probe()
Date: Fri, 18 Apr 2025 13:27:53 +0200
Message-ID: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful stm32_ospi_dma_setup() call, some
dma_release_channel() calls are needed to release some resources, as
already done in the remove function.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/spi/spi-stm32-ospi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 668022098b1e..9ec9823409cc 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -960,6 +960,10 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 err_pm_enable:
 	pm_runtime_force_suspend(ospi->dev);
 	mutex_destroy(&ospi->lock);
+	if (ospi->dma_chtx)
+		dma_release_channel(ospi->dma_chtx);
+	if (ospi->dma_chrx)
+		dma_release_channel(ospi->dma_chrx);
 
 	return ret;
 }
-- 
2.49.0


