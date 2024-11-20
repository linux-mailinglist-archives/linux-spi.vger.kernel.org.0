Return-Path: <linux-spi+bounces-5756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2E9D31E1
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 02:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4712831AF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77D168DA;
	Wed, 20 Nov 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SIKkUbqd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m24109.xmail.ntesmail.com (mail-m24109.xmail.ntesmail.com [45.195.24.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC65EED8;
	Wed, 20 Nov 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065745; cv=none; b=OLGQ3PRguwGcoiVzdoKDbsZUwAzWs/iczyx2Ik7kO38LefRwJwCkXg4AQajy1YFL0nCWi2X+Dag0KLRiTE+EB1Znbn2YCJIXHTCMD1Oo+C/CG9xJxgufxhxTseMHNKfMTp3Xeq1gw3HYOFhsJAN2y1saH7L3fDLh5xk5QQI/n4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065745; c=relaxed/simple;
	bh=LG1K0LyvIOCuD7NM9eRmoBLOj06O57MRqo4woKUYWdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPrifK9CwVOxOtHesYy/6R0Tahs1J3sTdc5tVARwEPrshfbeDDQ66Z+SZVLeI0uPkkvxSIFPGDTtmpW5VuX88pa6cBmqP3ed5ziCruNeYMZ6u0vWdOdXyM2go0W690q2Sp/6N8kCoLWPP2LsisVGJA8NBR5t6oZSql1wXOExzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SIKkUbqd; arc=none smtp.client-ip=45.195.24.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33e51e23;
	Wed, 20 Nov 2024 09:22:10 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: rockchip-sfc: Support ACPI
Date: Wed, 20 Nov 2024 09:22:08 +0800
Message-Id: <20241120012208.1193034-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxDTFZKH0NCHUlIS05ISkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a934729a09809d9kunm33e51e23
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Tww6HDIeT0gqFTwySy8s
	IzwaFDpVSlVKTEhJS01OTEhKTUxLVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0lPNwY+
DKIM-Signature:a=rsa-sha256;
	b=SIKkUbqd1UD6wg4Ir2CWDFg9eY5xS3C5QaInroY38GsKPx2HWyGq315zqKv3nAQmmVjk2d1e3zp+Q9VdoXxGhV8/ep98jWVAFAvrqlG+yUSrCnSEhHEXiLMol95k181NauvT+QssWMHVPE4lnYVDtU77hD3vcS7XZZSX8es/stQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4roe1uOrMlMXfDLEUiS1htJOky9bJXMb1BjJs0uBvqY=;
	h=date:mime-version:subject:message-id:from;

Compatible with ACPI.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip-sfc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 69d0f2175568..138508d2c736 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -491,7 +491,7 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 	u32 len = op->data.nbytes;
 	int ret;
 
-	if (unlikely(mem->spi->max_speed_hz != sfc->frequency)) {
+	if (unlikely(mem->spi->max_speed_hz != sfc->frequency) && !has_acpi_companion(sfc->dev)) {
 		ret = clk_set_rate(sfc->clk, mem->spi->max_speed_hz);
 		if (ret)
 			return ret;
@@ -579,16 +579,24 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	if (IS_ERR(sfc->regbase))
 		return PTR_ERR(sfc->regbase);
 
-	sfc->clk = devm_clk_get(&pdev->dev, "clk_sfc");
+	if (!has_acpi_companion(&pdev->dev))
+		sfc->clk = devm_clk_get(&pdev->dev, "clk_sfc");
 	if (IS_ERR(sfc->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->clk),
 				     "Failed to get sfc interface clk\n");
 
-	sfc->hclk = devm_clk_get(&pdev->dev, "hclk_sfc");
+	if (!has_acpi_companion(&pdev->dev))
+		sfc->hclk = devm_clk_get(&pdev->dev, "hclk_sfc");
 	if (IS_ERR(sfc->hclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->hclk),
 				     "Failed to get sfc ahb clk\n");
 
+	if (has_acpi_companion(&pdev->dev)) {
+		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &sfc->frequency);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Failed to find clock-frequency\n");
+	}
+
 	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 
 	if (sfc->use_dma) {
-- 
2.34.1


