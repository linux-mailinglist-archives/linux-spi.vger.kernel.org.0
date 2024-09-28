Return-Path: <linux-spi+bounces-5014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837C988DC3
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE81C211CB
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3284E155730;
	Sat, 28 Sep 2024 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ebROR9Er"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF54381C7;
	Sat, 28 Sep 2024 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727496788; cv=none; b=Y2vJnXosVAEewACsGu7+FpAVmbvKu5t4IhV6PYnILunqyvqhnVUFU0q8hVs/ds6/2j2ijJQfZxBN299lLLzsv4N13l9Bxw5vI5tPhVifeVBVyOQYHnaE55HI6PHw3V6S9pk+S2AgGODDb3L42+EcBqnY5jZrM2o9XmggrwiqHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727496788; c=relaxed/simple;
	bh=nJq456f64c+e8kZN0NWzv3Ow9HI5KlTRIj9SThuwtKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oz1AKpSo1GSrQvMYB7hqERLdtyg7NX0KxaAG5yZ/m0heinM71H4yRAIURFPQHbSRoOxIF1J3p/hHihKVSdW7dIfD04sfeni+SxPQ90VilH4FbMxprmzZobFcj38mmdOjbNibdgCiG53ySlXGsUy9P3jl/9LsX374qhXeLcmK1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ebROR9Er; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727496778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpUUSCEgG6i2JX+Qd6833mlykOrIc+MfZyPBIOvg7Ao=;
	b=ebROR9ErceR5vLV6cjmxcAfhWeSaIi+Yaw6kiOKzhN2gRBUoNd0WAzLvX9dDvV7besTMnm
	CqC7FI16ocPrGYHG2aQpdXNcUDXhMv+LkTHNvryfbBIAQN5jj141TOKRtOKVYRS+1JpLcA
	h+klMWa3REEoMjBMGnHeNnpxERAAUtv+QNeOloEiCRrnv1x71Uv62isl02CdF9njwwNfKH
	40YVJYnOzIShI08RuypKroKj0RaRbYlzsZBmuGZJsffwKEFW+BYeXqg5kn0VKe3jbE4WGm
	IjvTyQTP46pTPIUoUSfIDhbhrvAaNNHMtqB/BosoynekID7D/vAaLTe5CVucng==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] spi: rockchip: Perform trivial code cleanups
Date: Sat, 28 Sep 2024 06:12:45 +0200
Message-Id: <1b55380a0b9f0e8fe1a09611636b30e232b95d08.1727496560.git.dsimic@manjaro.org>
In-Reply-To: <cover.1727496560.git.dsimic@manjaro.org>
References: <cover.1727496560.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Perform a few trivial code cleanups, to obey the reverse Christmas tree rule,
to avoid unnecessary line wrapping by using the 100-column width better, to
actually obey the 100-column width in one case, and to make the way a couple
of wrapped function arguments are indented a bit more readable.

No intended functional changes are introduced by these code cleanups.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/spi/spi-rockchip.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..81f2a966c124 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -742,34 +742,32 @@ static int rockchip_spi_setup(struct spi_device *spi)
 
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
-	int ret;
-	struct rockchip_spi *rs;
+	struct device_node *np = pdev->dev.of_node;
 	struct spi_controller *ctlr;
+	struct rockchip_spi *rs;
 	struct resource *mem;
-	struct device_node *np = pdev->dev.of_node;
 	u32 rsd_nsecs, num_cs;
 	bool target_mode;
+	int ret;
 
 	target_mode = of_property_read_bool(np, "spi-slave");
 
 	if (target_mode)
-		ctlr = spi_alloc_target(&pdev->dev,
-				sizeof(struct rockchip_spi));
+		ctlr = spi_alloc_target(&pdev->dev, sizeof(struct rockchip_spi));
 	else
-		ctlr = spi_alloc_host(&pdev->dev,
-				sizeof(struct rockchip_spi));
+		ctlr = spi_alloc_host(&pdev->dev, sizeof(struct rockchip_spi));
 
 	if (!ctlr)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ctlr);
 
 	rs = spi_controller_get_devdata(ctlr);
 
 	/* Get basic io resource and map it */
 	rs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(rs->regs)) {
-		ret =  PTR_ERR(rs->regs);
+		ret = PTR_ERR(rs->regs);
 		goto err_put_ctlr;
 	}
 
@@ -794,26 +792,25 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 
 	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
-			IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
+					IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
 	if (ret)
 		goto err_put_ctlr;
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
 				  &rsd_nsecs)) {
 		/* rx sample delay is expressed in parent clock cycles (max 3) */
-		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8),
-				1000000000 >> 8);
+		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8), 1000000000 >> 8);
 		if (!rsd) {
 			dev_warn(rs->dev, "%u Hz are too slow to express %u ns delay\n",
-					rs->freq, rsd_nsecs);
+				 rs->freq, rsd_nsecs);
 		} else if (rsd > CR0_RSD_MAX) {
 			rsd = CR0_RSD_MAX;
-			dev_warn(rs->dev, "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-					rs->freq, rsd_nsecs,
-					CR0_RSD_MAX * 1000000000U / rs->freq);
+			dev_warn(rs->dev,
+				 "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+				 rs->freq, rsd_nsecs, CR0_RSD_MAX * 1000000000U / rs->freq);
 		}
 		rs->rsd = rsd;
 	}

