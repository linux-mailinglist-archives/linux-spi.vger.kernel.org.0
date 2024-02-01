Return-Path: <linux-spi+bounces-949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2178455AF
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C49281027
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FED5B1E7;
	Thu,  1 Feb 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gmhcq0fJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AD5684
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784303; cv=none; b=cbgsP8h5bCWfrbsw8H6+75s938xLkhWDHh0JUHEpxXjBbr/BSrzYupZIQngOY14nK70BahEI/0+grj50Br/yrCcTULFYt+rBycbmA2QZJ9HLUcYJS/qWXSNw7y6DhGYarilWghlAkew58+97NHKbIvWf7OcxyuGX659cVIJUdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784303; c=relaxed/simple;
	bh=kZjaPp8BXuct9xmw4djMb0CPkzw8Ow6dj0iqeWa3Fes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AfulpkFK0i5BUj8+88KqAizwJjQei59d0MNwK5gx7kA4b9hjnTsFf56G8vJZVYyEvLHQ4mydcawOZS4UWSJod5LnVLjvrEY4TUduTsO/AN3ZVHcfoBJtCFgkLSXdfF+MMBWvdt/0UR1gWwgdrFtx+jdlTGxrXk/J/20mtFlM8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gmhcq0fJ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4114hwuq013972;
	Thu, 1 Feb 2024 04:44:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=N
	nVtpt+kCskcLW0TE0UgA4uemFo9YDgxeiS4jUWyRRU=; b=gmhcq0fJlbyrg7m11
	ZtFMwUGPKw21mbOa7xMOGDP4OZhP+6DM4jufQLiTeTCeZFWLSPxZdODfBNrgMZq2
	IXF0Xe25Y8p5O+EGD0CxOqXhGnds655QV9PdSr4S5/HlOx8xTPsxa180W7QpScRm
	qinB2HJwNJdRXfVeCvGzNZMhtHmRFrhNoUDJLTAPgjwnbpaqLVAYfL+QnysFSoHs
	C1qeGjYwvqj2slFpCW9YMT9X6Qf4PskAgGFshaq+09Bwj/lRKIxb+Az2V2Utm5aZ
	DAH5Vv77lD0byS13wYQEqfi2uu7xcRXXhYhHNPos9CB5JWFoB3aUf6bGZkqbmPKB
	eA/IA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nwx99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 04:44:44 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 10:44:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 1 Feb 2024 10:44:43 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1CBD0820241;
	Thu,  1 Feb 2024 10:44:43 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: cs42l43: Clean up of firmware node
Date: Thu, 1 Feb 2024 10:44:43 +0000
Message-ID: <20240201104443.363786-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: taA_Jvmlm5um2kUhdpPB4Mq27fAvUfTE
X-Proofpoint-GUID: taA_Jvmlm5um2kUhdpPB4Mq27fAvUfTE
X-Proofpoint-Spam-Reason: safe

As we get a child node in the of case, we should also clean up the
references to this, add code for this.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index b24190526ce9..1765d752e341 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -218,6 +218,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spi_controller_set_devdata(priv->ctlr, priv);
+	platform_set_drvdata(pdev, priv);
 
 	priv->dev = &pdev->dev;
 	priv->regmap = cs42l43->regmap;
@@ -228,12 +229,6 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
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
@@ -257,14 +252,34 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
 
+	if (is_of_node(fwnode))
+		fwnode = fwnode_get_named_child_node(fwnode, "spi");
+
+	device_set_node(&priv->ctlr->dev, fwnode);
+
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
 		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
+		goto of_node_err;
 	}
 
+	return 0;
+
+of_node_err:
+	if (is_of_node(fwnode))
+		fwnode_handle_put(fwnode);
+
 	return ret;
 }
 
+static void cs42l43_spi_remove(struct platform_device *pdev)
+{
+	struct cs42l43_spi *priv = dev_get_drvdata(&pdev->dev);
+
+	if (is_of_node(priv->ctlr->dev.fwnode))
+		fwnode_handle_put(priv->ctlr->dev.fwnode);
+}
+
 static const struct platform_device_id cs42l43_spi_id_table[] = {
 	{ "cs42l43-spi", },
 	{}
@@ -276,6 +291,7 @@ static struct platform_driver cs42l43_spi_driver = {
 		.name	= "cs42l43-spi",
 	},
 	.probe		= cs42l43_spi_probe,
+	.remove_new	= cs42l43_spi_remove,
 	.id_table	= cs42l43_spi_id_table,
 };
 module_platform_driver(cs42l43_spi_driver);
-- 
2.30.2


