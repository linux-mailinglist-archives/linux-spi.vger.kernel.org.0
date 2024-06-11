Return-Path: <linux-spi+bounces-3372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB33903D44
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F921F24CFE
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B717D8B8;
	Tue, 11 Jun 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lybl2cGR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876217C9F9;
	Tue, 11 Jun 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112364; cv=none; b=QVHjidh6Embrw5ftKtZDJ7M+02JvGaYmu1kDPMlb/BMTlwvl/ofykRYMrIK8kI73r7UoxvS3RJennaaEoRtMCY4Nj5rRzbYaUhHymvJRf+U68iUT6kP+uvRj631ETRfn7XOPzHkqU7ggQKVJqNtxReGE3H9bQ2NsJni8rTAZJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112364; c=relaxed/simple;
	bh=xsUIs1Kt5mpQP6+VuDxqZD5NRvHeR1YK4OYtm7Chvk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cr+X9QKjDZkjWHoDUY6BpdG1VGE4lEg51hTI384I68G3tKW/UZGqOr8KF2ogZKyAksVItRci95gYLbl1OQmbc0HXdZ6JUAgdntDVBJVwSXABfL1Lw+BCl9T0PmqvlNQ83cr9wzcSJWGCBcqcsD3J2jIH7ypCYp25rp5CHV48tME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lybl2cGR; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B4c4Kv010402;
	Tue, 11 Jun 2024 08:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=T4zM91sFnNYIgYO3
	pQDLwJ7ZrWumJOlcKaLpF6K+kHA=; b=lybl2cGR4J0+/ktWFPOcUvBGZynyg4jv
	qhetaj5NuYGCqzX4DxNKB5zPnJwkve5hwwQ1U+Fg3OPD0egfrlzRehz5NxgQEzh9
	M/HQf9Ec2OBt+1zC/wzAs3Vpqkh3lpJSwOjKYT4VCqjLvEgHa3aUQTX/cQ8YU2ja
	SRs/w6dvmUlPpQXkWYew1/oUooAW17LCr8L0YhgF+omPRVmXyz5wIIQw6RKCgeeX
	UqgYLiAN2jg30PnM7zRvF5Zf3sw2vU9bQi0PEv8zWx6hVkAVqXIoH68v2MIR45nO
	2cOo2wsx1ExG9MVTuoyYrGyEJ+Y4Sun3T7Ox0Ju97+UlqVV1I8B5Tg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhtuvb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:25:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 14:25:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 11 Jun 2024 14:25:56 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B4FB6820244;
	Tue, 11 Jun 2024 13:25:56 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/3] spi: cs42l43: Refactor accessing the SDCA extension properties
Date: Tue, 11 Jun 2024 14:25:54 +0100
Message-ID: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RlxZDK-G1HOQKD9cYSixedcmOG006PmH
X-Proofpoint-ORIG-GUID: RlxZDK-G1HOQKD9cYSixedcmOG006PmH
X-Proofpoint-Spam-Reason: safe

Refactor accessing the SDCA extension properties to make it easier to
access multiple properties to assist with future features. Return the
node itself and allow the caller to read the actual properties.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 8b618ef0f711..0a4475ae931b 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -246,11 +246,10 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
-static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
+static struct fwnode_handle *cs42l43_find_xu_node(struct fwnode_handle *fwnode)
 {
 	static const u32 func_smart_amp = 0x1;
 	struct fwnode_handle *child_fwnode, *ext_fwnode;
-	unsigned int val;
 	u32 function;
 	int ret;
 
@@ -266,21 +265,12 @@ static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
 		if (!ext_fwnode)
 			continue;
 
-		ret = fwnode_property_read_u32(ext_fwnode,
-					       "01fa-sidecar-instances",
-					       &val);
-
-		fwnode_handle_put(ext_fwnode);
-
-		if (ret)
-			continue;
-
 		fwnode_handle_put(child_fwnode);
 
-		return !!val;
+		return ext_fwnode;
 	}
 
-	return false;
+	return NULL;
 }
 
 static void cs42l43_release_of_node(void *data)
@@ -298,7 +288,8 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_spi *priv;
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
-	bool has_sidecar = cs42l43_has_sidecar(fwnode);
+	struct fwnode_handle *xu_fwnode __free(fwnode_handle) = cs42l43_find_xu_node(fwnode);
+	int nsidecars = 0;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -350,7 +341,9 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (has_sidecar) {
+	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
+
+	if (nsidecars) {
 		ret = software_node_register(&cs42l43_gpiochip_swnode);
 		if (ret)
 			return dev_err_probe(priv->dev, ret,
@@ -373,7 +366,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(priv->dev, ret,
 				     "Failed to register SPI controller\n");
 
-	if (has_sidecar) {
+	if (nsidecars) {
 		if (!spi_new_device(priv->ctlr, &ampl_info))
 			return dev_err_probe(priv->dev, -ENODEV,
 					     "Failed to create left amp slave\n");
-- 
2.39.2


