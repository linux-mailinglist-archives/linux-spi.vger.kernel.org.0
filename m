Return-Path: <linux-spi+bounces-976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC554845E9D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 18:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3BAB330A8
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC465E31;
	Thu,  1 Feb 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EARrFqcE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326265E24
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808875; cv=none; b=oDoo2nobswip8fG2n5MJQb/Yc3L7sn0VX+1rKqMzu1jjpYS1EesEZZmTD2MztOATxA/rLZv6w3G16ZF1OafXVynkpFSS977Rw1RmqsH7vLk+t3Q/3FVaOycHnbqwB2svhMcuNvTNq5ZbCJp4XceOdHHMCGWX2u/NYS6L3eqfwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808875; c=relaxed/simple;
	bh=Xk0/D3g0htFg5ExcrfgmLGl8+Y80ioAfVSKHkUdjaD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WdolDv4oofSXdLbJpD7MHUJwLZFtTgbJHShSRE1crPbiUKotNH4YoLGfG+BaGMa8/baxtfn21l2mdkceF4cwSD7asqGyQFGxc9zjbCMUQQtaBw5tGxI++/hYaBKN3nP9NzTQjdxgW/Rxf8ZPHkCg0awtOKiJbGE4wpCZT+BMCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EARrFqcE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411BLKZL023809;
	Thu, 1 Feb 2024 11:26:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=H
	I1W4OCzjVmZk7rGrNSqkQveipPZbajWqClH8h45vnQ=; b=EARrFqcEJxuZPAxhs
	ZZDoZBPBFvUtzZoz4DeGIz/QCCZ0RVFOHkJWvcSEWsj5yZomU0OwFWLvHq/eOitD
	LzBXN9ppBMYwbpenXKUpK2k7PAijpoW4n0jfGgsXS4sTn9PvtiWW78Sez7hD7nDG
	TMgmYhFJ+jY4ifDQGECvzfsZG7CsuAgvvvFaUscYSjX3HRZA3jzBjyIx2f7qsCKo
	MenBQ8Ja9THof2KxsCpJMBX3eKXJq51pJWj025dc4odsriiBnpBCAm8w25WAHCd5
	mc0f5Up7HkNaMMGyuaOO3HqwD/EBwv4q4HLqFDvKARnOFxIHzQVtvp0nwr0moL60
	s+APQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043xfvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:26:51 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 17:26:49 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 1 Feb 2024 17:26:49 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 90016820242;
	Thu,  1 Feb 2024 17:26:49 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2] spi: cs42l43: Clean up of firmware node
Date: Thu, 1 Feb 2024 17:26:49 +0000
Message-ID: <20240201172649.794161-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AAGaVmxDrPVoREiQNx1ZHlSvk-gpOGkd
X-Proofpoint-GUID: AAGaVmxDrPVoREiQNx1ZHlSvk-gpOGkd
X-Proofpoint-Spam-Reason: safe

As we get a child node in the OF case, we should also clean up the
reference, add code to do so.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Switch to using devm_add_action to clean up the of_node

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index b24190526ce9..adf6ec4833a5 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -202,6 +202,11 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
+static void cs42l43_release_of_node(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static int cs42l43_spi_probe(struct platform_device *pdev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
@@ -228,12 +233,6 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	priv->ctlr->transfer_one = cs42l43_transfer_one;
 	priv->ctlr->set_cs = cs42l43_set_cs;
 	priv->ctlr->max_transfer_size = cs42l43_spi_max_length;
-
-	if (is_of_node(fwnode))
-		fwnode = fwnode_get_named_child_node(fwnode, "spi");
-
-	device_set_node(&priv->ctlr->dev, fwnode);
-
 	priv->ctlr->mode_bits = SPI_3WIRE | SPI_MODE_X_MASK;
 	priv->ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	priv->ctlr->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
@@ -257,6 +256,13 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
 
+	if (is_of_node(fwnode)) {
+		fwnode = fwnode_get_named_child_node(fwnode, "spi");
+		devm_add_action(priv->dev, cs42l43_release_of_node, fwnode);
+	}
+
+	device_set_node(&priv->ctlr->dev, fwnode);
+
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
 		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
-- 
2.30.2


