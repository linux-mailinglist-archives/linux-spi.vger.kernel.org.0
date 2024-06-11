Return-Path: <linux-spi+bounces-3371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78B903D43
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BBD1C24146
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43217D8B1;
	Tue, 11 Jun 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B0Jd/mCw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B817D8A0;
	Tue, 11 Jun 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112364; cv=none; b=HcpmPT2+clRtx01/WNVJWX+CO4V2o1fzZ6OyvrF0tZn6Z2vSy5S3yTSr6xT6ocwu4WtXXL31yMZJUk9UVFgQLaiDHnQKo11AhnQeckywyioyCLNfKjd11JJusbdLYdzQYZQmvbOlURlS8a94TuEJfv5NOhqIuzcGS7IDoVtAsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112364; c=relaxed/simple;
	bh=LMY+etQsozLuXx9o40Dtn0k1umd+GpgYM37h1yNZL3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=put453OSc2R85/XcFJlfG9lLPsX4SDJXh/JxwSLf4EPh3dHQF8MVuo0hWe5PmXW2QqDWzLt3xb1QTmUsYdmq0bWbY9GBYQR9YjBlRP8K9UOAfO07EfyfGXN1zqqIokV5gMtkMpB444cZOQxcHbxITA2+wXj2LcK9I33Kl3TPZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=B0Jd/mCw; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B4c4Ku010402;
	Tue, 11 Jun 2024 08:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=DuurR0jE2iRLqiYyaQ5KjwGN5hMIK7uHSdNWCwP6haw=; b=
	B0Jd/mCwO4rGADGvFtWhqqB5mAK0T0LI786BA+KqbE59Cqwqgg52PZrIZsiwqQy2
	WhXecr5Xsfot8Ybm9pDqVULO2CF96pko4ToZv9v+/HgP1IcN9B1bxGtma6XG3EvG
	Ztr7vW4yYijHi0r89ON/QDsWQ/x4ylwmFRHeS8tTChhfQ0e6Xw8BasuRljAy2C4+
	b5NWoxPFzI+Bgj+eSx2v4pwyldbUmWJaYBP6x/LC5vkmfwt7mh64cNuPt31RmeEp
	4U/W3bYPnB2BqiE7gq0f13CCMC/FALuZmRoDqBTTn0ssMi34ThkRQKjVdBNlEGPQ
	N3G3McmoE1M1wOxmmmnzVA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhtuvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:25:58 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 14:25:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 11 Jun 2024 14:25:56 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B9312820249;
	Tue, 11 Jun 2024 13:25:56 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/3] spi: cs42l43: Add speaker id support to the bridge configuration
Date: Tue, 11 Jun 2024 14:25:55 +0100
Message-ID: <20240611132556.1557075-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L_K7qD8R29fjxR3D-OoIjBIErxXYBm2b
X-Proofpoint-ORIG-GUID: L_K7qD8R29fjxR3D-OoIjBIErxXYBm2b
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

OEMs can connect a number of types of speakers to the sidecar cs35l56
amplifiers and a different speaker requires a different firmware
configuration.

When the cs42l43 ACPI includes a property indicating a particular type
of speaker has been installed this should be passed to the cs35l56
driver instances as a device property.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 74 ++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 0a4475ae931b..5b8ed65f8094 100644
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
@@ -44,28 +45,10 @@ static const unsigned int cs42l43_clock_divs[] = {
 	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
 };
 
-static const struct software_node ampl = {
-	.name			= "cs35l56-left",
-};
-
-static const struct software_node ampr = {
-	.name			= "cs35l56-right",
-};
-
-static struct spi_board_info ampl_info = {
+static struct spi_board_info amp_info_template = {
 	.modalias		= "cs35l56",
 	.max_speed_hz		= 11 * HZ_PER_MHZ,
-	.chip_select		= 0,
 	.mode			= SPI_MODE_0,
-	.swnode			= &ampl,
-};
-
-static struct spi_board_info ampr_info = {
-	.modalias		= "cs35l56",
-	.max_speed_hz		= 11 * HZ_PER_MHZ,
-	.chip_select		= 1,
-	.mode			= SPI_MODE_0,
-	.swnode			= &ampr,
 };
 
 static const struct software_node cs42l43_gpiochip_swnode = {
@@ -273,6 +256,39 @@ static struct fwnode_handle *cs42l43_find_xu_node(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static struct spi_board_info *cs42l43_create_bridge_amp(struct cs42l43_spi *priv,
+							const char * const name,
+							int cs, int spkid)
+{
+	struct property_entry *props = NULL;
+	struct software_node *swnode;
+	struct spi_board_info *info;
+
+	if (spkid >= 0) {
+		props = devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
+		if (!props)
+			return NULL;
+
+		*props = PROPERTY_ENTRY_U32("cirrus,speaker-id", spkid);
+	}
+
+	swnode = devm_kmalloc(priv->dev, sizeof(*swnode), GFP_KERNEL);
+	if (!swnode)
+		return NULL;
+
+	*swnode = SOFTWARE_NODE(name, props, NULL);
+
+	info = devm_kmemdup(priv->dev, &amp_info_template,
+			    sizeof(amp_info_template), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	info->chip_select = cs;
+	info->swnode = swnode;
+
+	return info;
+}
+
 static void cs42l43_release_of_node(void *data)
 {
 	fwnode_handle_put(data);
@@ -367,11 +383,27 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 				     "Failed to register SPI controller\n");
 
 	if (nsidecars) {
-		if (!spi_new_device(priv->ctlr, &ampl_info))
+		struct spi_board_info *ampl_info;
+		struct spi_board_info *ampr_info;
+		int spkid = -EINVAL;
+
+		fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
+
+		dev_dbg(priv->dev, "Found speaker ID %d\n", spkid);
+
+		ampl_info = cs42l43_create_bridge_amp(priv, "cs35l56-left", 0, spkid);
+		if (!ampl_info)
+			return -ENOMEM;
+
+		ampr_info = cs42l43_create_bridge_amp(priv, "cs35l56-right", 1, spkid);
+		if (!ampr_info)
+			return -ENOMEM;
+
+		if (!spi_new_device(priv->ctlr, ampl_info))
 			return dev_err_probe(priv->dev, -ENODEV,
 					     "Failed to create left amp slave\n");
 
-		if (!spi_new_device(priv->ctlr, &ampr_info))
+		if (!spi_new_device(priv->ctlr, ampr_info))
 			return dev_err_probe(priv->dev, -ENODEV,
 					     "Failed to create right amp slave\n");
 	}
-- 
2.39.2


