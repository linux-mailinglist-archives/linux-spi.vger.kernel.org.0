Return-Path: <linux-spi+bounces-12037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2DCD19F7
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2251B3117FE9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEEB2D77FA;
	Fri, 19 Dec 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gj+1Z6hF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7352341678;
	Fri, 19 Dec 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172209; cv=none; b=sCa/BuCGh1tTZTKCyEDfMnSrz0HgVsBMLmpYqvyKvKB1IkGs50/Pa+GVZ01r+Po/Ls02jmf9zN26+Rqp3BssLsW/NxjsWAoT1021MnBv7zic1gJrQvNKaTLZe5FgACveLGEG+gFdg8T9DT21tCaAT+iWEXCNqN2BKqryQ0zPuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172209; c=relaxed/simple;
	bh=Xg6XHj6KozlX4NrGzKx/YCl8Yj2IOOPWG22yyPcuZ80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfcvxE5aCbhx1bXdBaoTQLolwFn9cyQEsKFMCqzz71CTMLOSNejwkMYqUSsxeAgRlonMTGcuxc2/CfNtME3Fikn5BClxCMoGWXHBhg/CXZfJ9fd/HgjPgMutZTfNnmKCWn32VpnKcykU7aFbAYneSm/bnZfWmwyfv+nTV4NV0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gj+1Z6hF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7D5461A22FA;
	Fri, 19 Dec 2025 19:23:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D4166071D;
	Fri, 19 Dec 2025 19:23:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 461F510AA981E;
	Fri, 19 Dec 2025 20:23:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172201; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PT1SPgDsRcvNYZ5/SapnZsLtcwfzwA7IG18t6F0iYJk=;
	b=Gj+1Z6hFqsWd4w22uR6ASCST6fEewFiYRrbbGGa97OMKH8pS3pwQM4HYaLFiWVGPZxcC+h
	myYkDo7dJAnFzASv0oc9PLXa2dqp4MpOReQHy3fLoTBWF+eyiIYYAN5JBoehCgMn84ExC6
	8+ycMuT1OnI1Dx8Hb+O/Dn+NNPp6twkg/AfnVsL9bocC6j9YuSCK1iMdYSB6AqWG6Bhqzd
	dt7k+Ot+pqwm4ANkwVT7BlO535ZQL6jB+Zu/b70gSprkslPDXBDdvuLjDp4syAb3XoWXnZ
	0RAlNDGQxu/LSTZs35pxOC+OSJb6JSLXNjGJce2MmG8kdg0awFIJxQJa49tHHA==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:10 +0100
Subject: [PATCH 08/13] spi: cadence-qspi: Try hard to disable the clocks
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-8-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In the remove path, we should try hard to perform all steps as we simply
cannot fail.

The "no runtime PM" quirk must only alter the state of the RPM core, but
the clocks should still be disabled if that is possible. Move the
disable call outside of the RPM quirk.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ff0ddd2c0d41..f282a06ba383 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2044,6 +2044,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	int ret = 0;
 
 	ddata = of_device_get_match_data(dev);
 
@@ -2063,8 +2064,10 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		if (pm_runtime_get_sync(&pdev->dev) >= 0)
-			clk_disable(cqspi->clk);
+		ret = pm_runtime_get_sync(&pdev->dev);
+
+	if (ret >= 0)
+		clk_disable(cqspi->clk);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);

-- 
2.51.1


