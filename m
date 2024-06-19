Return-Path: <linux-spi+bounces-3458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A28190EAB2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7174F1C21803
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04679950;
	Wed, 19 Jun 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VKvK12lU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B65140360;
	Wed, 19 Jun 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799431; cv=none; b=PpbPwGoXeaYAgyIuO8qeJ9b0CgJT8i5SOPVijZOZp49pVZY0ofrIJhC0Ze4HW4zvNaPeSwfY5qY33G51SMwbh2YmOi/GFNpaboF6MHSmGZiIp1wqrnXWtGNCPeBzYuM3QhOH8hWF3qzXmYbaLkAiTHYRAjwycuR/8L7I7k5OPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799431; c=relaxed/simple;
	bh=3Nfc9qTrzhoyruiWP0Sm39r61eJRz96SU2sZ+DEAy0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVEZnhwgTgzCW9+YoHUNVvKCm2LTrg8EETs4tvLhfOHj9UGG4I7yYPYPqk2hJyQhEyyUOJOPaAHLNTWj6mvMjv3Y4F0tkwRgrlt3sGfknVZgY5M2R0V69crnLonaZTfzLD9jony2UxG4A8TjQo6cpc5d3MAGtOIsmXwK8TaKqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VKvK12lU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J5ecEE006698;
	Wed, 19 Jun 2024 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=M+XNeP4vrTMboLr4R7ijBBTatNPgu6loYHa23IGjAgE=; b=
	VKvK12lUAz+C4IR6LIhBs9QHMqe0jdVOwMHsFj4+tI+imXOd+s4i2LE9JWBmMFHT
	ZDkemej5VFTWwYxyklmqcHCgg5z2aOgxmiJ+uyxDptMG8lnE8yGMBJ3g0EAyVa9k
	eVvB5zMhFEn+cLofd+SeW2NUJ7bVvH/OJckB26FySJcyrChH33lungzBNPB7ppI8
	jLbajxd672FhreH2H1fzCVhQrnk6vLkyAlu9RVSbsx2HUlSeA2pfix4y71ReQ298
	8IWJu7COBrLRktgtM56EL8EHnHvsGhvew+EuCK9ZXBtazKAG4NruKZaBk59rc6aA
	b1H2fCqhZ1PVfdod9jp18g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yujb10kgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 13:17:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 13:17:03 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3C83C82024D;
	Wed, 19 Jun 2024 12:17:03 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/2] spi: cs42l43: Add speaker id support to the bridge configuration
Date: Wed, 19 Jun 2024 13:17:03 +0100
Message-ID: <20240619121703.3411989-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NuaHAG3etiZu26oPqo63gHAjmc8vdl4v
X-Proofpoint-GUID: NuaHAG3etiZu26oPqo63gHAjmc8vdl4v
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

Changes since v1:
 - Just a rebase

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 73 ++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 7b6fc6158a3b..5b8ed65f8094 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -45,28 +45,10 @@ static const unsigned int cs42l43_clock_divs[] = {
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
@@ -274,6 +256,39 @@ static struct fwnode_handle *cs42l43_find_xu_node(struct fwnode_handle *fwnode)
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
@@ -368,11 +383,27 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
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


