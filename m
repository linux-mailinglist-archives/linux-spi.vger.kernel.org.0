Return-Path: <linux-spi+bounces-3459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C604590EAB4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D55B25696
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC4142E67;
	Wed, 19 Jun 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nXxxizXV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2513EFEE;
	Wed, 19 Jun 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799432; cv=none; b=GYYQdqoY4uTGuoLsL8fftD6uyyYNBulr9+LGmXe10siCUf7dwDK562i9Fy5/asQSIXgYov37R0SOlzwa9lL6GRNeb4y/af24qmxlq/0/5NOinswtdqEMGer2NNtMOxIjNjHgEyXRBLHM2bhgXY9pXHXa5Zn1yKaYgWsxCnb4dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799432; c=relaxed/simple;
	bh=HP0dCcka6pca6BLKLABLAn653S9Ig96dEh2Ez+NhI80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdHvWb+fLKdj1N03Tjvf0fseex6tsvG2o8pfKV+J+DbxeDPQPbIZy7TUOS0aRkQL9THgnHkhLxhjkSzc6Zv1vxeRgWFp5WAA2sRGcK8b3dXgFGkr2n+Qh3bMpvZ4ISG0bzelQPlBDG+dbaXR+0MZQYEK1DCh7P+l47EnpTrn+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nXxxizXV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JC1CxA003623;
	Wed, 19 Jun 2024 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=yt0LxRAz/H7pZDYn
	7NF3OX6wgEwczumHLis/56dhObc=; b=nXxxizXVtUiQOqa85FlroOs9bbHZZsGl
	umvOMJ9kLYbvoUg+MZP7O97NQlCoVQoqgfKzbxcmQoUtAIKnToHH3cC/p5EkwpxE
	SSfk5D3fTfuniOW8y9xgXObgzxcg/mw8cN7VZhft5z1J648j9reVxBl7fIHFwvJ/
	OU0iB94QbJpxWmiKeGMzLyfoSSFOgcjMBS86LNxOOM1LekkozDhZqbCy3vHqNDT7
	/UBneGyz+IIVzWBFwc5v8UdlmnKNr1/cT72XwtxGiVN2ftqpZzum9GR/RNhtsuQk
	6WM6Tv/LwSwJqJzZHXOXwA19kNGJI6Yr797I2ykNkhV1zDAhP4OGqg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yujb10kgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:05 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 13:17:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 13:17:03 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2EBA5820248;
	Wed, 19 Jun 2024 12:17:03 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA extension properties
Date: Wed, 19 Jun 2024 13:17:02 +0100
Message-ID: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YTBlebnxgzbzBuj25OCSrJ-WR018wIK4
X-Proofpoint-GUID: YTBlebnxgzbzBuj25OCSrJ-WR018wIK4
X-Proofpoint-Spam-Reason: safe

Refactor accessing the SDCA extension properties to make it easier to
access multiple properties to assist with future features. Return the
node itself and allow the caller to read the actual properties.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Based off the SPI for-next branch no need for this to go through the
same tree as c38082bf223f ("ASoC: cs35l56: Attempt to read from
cirrus,speaker-id device property first").

Changes since v1:
 - Move header include to correct patch
 - Rebase

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 8b618ef0f711..7b6fc6158a3b 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -9,6 +9,7 @@
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/machine.h>
@@ -246,11 +247,10 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
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
 
@@ -266,21 +266,12 @@ static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
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
@@ -298,7 +289,8 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_spi *priv;
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
-	bool has_sidecar = cs42l43_has_sidecar(fwnode);
+	struct fwnode_handle *xu_fwnode __free(fwnode_handle) = cs42l43_find_xu_node(fwnode);
+	int nsidecars = 0;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -350,7 +342,9 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (has_sidecar) {
+	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
+
+	if (nsidecars) {
 		ret = software_node_register(&cs42l43_gpiochip_swnode);
 		if (ret)
 			return dev_err_probe(priv->dev, ret,
@@ -373,7 +367,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(priv->dev, ret,
 				     "Failed to register SPI controller\n");
 
-	if (has_sidecar) {
+	if (nsidecars) {
 		if (!spi_new_device(priv->ctlr, &ampl_info))
 			return dev_err_probe(priv->dev, -ENODEV,
 					     "Failed to create left amp slave\n");
-- 
2.39.2


