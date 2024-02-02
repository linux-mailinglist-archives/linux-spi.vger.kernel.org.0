Return-Path: <linux-spi+bounces-983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0587846E10
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DCC1C22482
	for <lists+linux-spi@lfdr.de>; Fri,  2 Feb 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534F7C0A2;
	Fri,  2 Feb 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XXjBs4XD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565B136659
	for <linux-spi@vger.kernel.org>; Fri,  2 Feb 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870079; cv=none; b=ocSKDp1zFS8mgZpiIDO2p3DgjjZdvw7SCXTm6hDLnKR3dc8K8jfrJZ14We2aW7lqggSurF2is93QalLkXVDyOSphMP7ODXVOCsW6FJdaAS11QglQsr1Kne9ZyAdD5gIWRBC88WBr4Hmq9E+NBK4xi4eRMGfVV2j5tdv77pgRC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870079; c=relaxed/simple;
	bh=SBwHNMKX/f0R5Nv/qc9DdEWrHV6ByPeMPfU/SLoek5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WS+psKXUUHin4Kd0sBNf+kVfbTld6RigZbUOU8YocJQGUPn33nopnfg+m8PPtHQbG+3XqPa/0sE7uuvZlEaJfeDwd+JIdp9fHIhxipxFLTYYJhVD2Is5F6dbxQEqMVUtiHlaA86bplVSwRUkupQQBFYwRzrKRZxxduT2Xj7SeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XXjBs4XD; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126fOjd019475;
	Fri, 2 Feb 2024 04:34:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=j
	h5GhYm6ldFfXCmcd+s3luoeaGWLzaBtAfD98fIaV60=; b=XXjBs4XDPFxONImfS
	zIrApKiwEuMkD9Rd1kmKNml11psq6CsMu2qwWYgxEOaB0YF0ocEiaLOihl2pEIZu
	wqPoz6pVQ5TNb5orbnHZJNmGIkp4FiIUEnjRNr4EVEvlrWcAAyFJheEuIHWaICkv
	5G3e20FqTqCjrPJ31vzUFIPGyhRALM5aDN6aUXyfj87N253HvPcYjfw/V9DPQP/S
	R1xDez5ooRJpALe2EEVdVvH5ZjJFzZV7xHtz74RyV40N8pCuy31nrNg9LeK9w/Ap
	zrl7Lf+Wlfg63N1meXZX9bkacpROVSsVh1BVVHzK7UBv0naXfrQdb2VRVPFjcJDY
	ODlgQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3w0pwx0csa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 04:34:32 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 10:34:30 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 2 Feb 2024 10:34:30 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 995BA820241;
	Fri,  2 Feb 2024 10:34:30 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3] spi: cs42l43: Clean up of firmware node
Date: Fri, 2 Feb 2024 10:34:30 +0000
Message-ID: <20240202103430.951598-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hPix1aRf2x38zDGqnt9hSV0P0DkgOp56
X-Proofpoint-ORIG-GUID: hPix1aRf2x38zDGqnt9hSV0P0DkgOp56
X-Proofpoint-Spam-Reason: safe

As we get a child node in the OF case, we should also clean up the
reference, add code to do so.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Added error check for devm_add_action

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index b24190526ce9..d45d9e2e1611 100644
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
@@ -257,6 +256,17 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
 	regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
 
+	if (is_of_node(fwnode)) {
+		fwnode = fwnode_get_named_child_node(fwnode, "spi");
+		ret = devm_add_action(priv->dev, cs42l43_release_of_node, fwnode);
+		if (ret) {
+			fwnode_handle_put(fwnode);
+			return ret;
+		}
+	}
+
+	device_set_node(&priv->ctlr->dev, fwnode);
+
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
 		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
-- 
2.30.2


