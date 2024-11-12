Return-Path: <linux-spi+bounces-5687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B69C5962
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CA1F227CF
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C899145B3F;
	Tue, 12 Nov 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cE7fWQ9K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610D8614E
	for <linux-spi@vger.kernel.org>; Tue, 12 Nov 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418954; cv=none; b=bSuZBoja3EkxY1bLtpiKbpCZfwL4OtCeiRzRR+V4cf6xV/cLhi7CWV5Ar8fR5SWgk37oPA71clv4q+SVnQRAzGzPyreG8C5xbbJV1ObMvAW5ikElKjiXn4eZchcOAonGyTDMBrH3/xNPEsx8yUFQ/kijOLbH6xz2F8V8LWLdyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418954; c=relaxed/simple;
	bh=N8FpRnzUZPbaHEban3irlAWuvmLWodujTP5VHleNsl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhoViH5e5fFJRt5o8MZqYWFqwWJFG+fG+DfOyNcgD+zcPwg7Hn0MaSN4yBK2RYOMzzRp7DHLFJz8f/v1sNcqo1hCvXJBbc72NfXMTLBteeazvFmR7KOl3fYbe8TF+kfWZrkNRDLa4MPBOb0ln7VfDIqUZY4SKW3Y1ygt+oOVFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cE7fWQ9K; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC6dhRb026352;
	Tue, 12 Nov 2024 07:14:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=AdNv6VJBkL+UQ4wf
	hxhyUfabaQRutH6h88XESTcL05c=; b=cE7fWQ9K8FU3wUxKdODMnOxGUp8xgMa5
	LiLln0Jkchs3t9OoqGr+QaTs7HHleKo9hwhGJKQONIgBg4KoqD3WlFCoT9zCIKfY
	x6HTnnJgOdH1mMzzumDfYyxQT8kVG60Ba0s+v95A0ZVMRo2hSrrWhtZo5lHm4L+y
	KNYvjEvWGP1JQZsdzIFd5/z9m4Lm4hmz0Hbu2Qk+W7z0HsnuT/GFlO+vw+MfS/Yr
	ZarzTgo/pdEQ7lODctn1J4emDcx80M8JFYIgq8SWFzY971hZb9iUMzDTVu0DT+lC
	IOi67OK+5lzpisUzNu/xS3eL8NmJzytPqlMex0dpAaz6NIreT4O2uQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 42t613b675-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:14:37 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 13:14:35 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 12 Nov 2024 13:14:35 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 016EA820241;
	Tue, 12 Nov 2024 13:14:35 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: cs42l43: Add GPIO speaker id support to the bridge configuration
Date: Tue, 12 Nov 2024 13:14:34 +0000
Message-ID: <20241112131434.678882-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3Q2WRqZyrHFIM7JSZrmpEP1KfpLsOLgS
X-Proofpoint-GUID: 3Q2WRqZyrHFIM7JSZrmpEP1KfpLsOLgS
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

OEMs can use the spk-id-gpios ACPI property to indicate the type of
speakers fitted to a device.

Attempt to read a spk-id value using the GPIO method when a usable
spk-id value is not obtained from the 01fa-spk-id-val ACPI property.

Obtaining the spk-id value has been moved earlier in the function to the
other sidecar block, so that an -EPROBE_DEFER from a GPIO driver is
handled more efficiently.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 46 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 5b8ed65f8094d..d0b55a26c31b9 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -12,6 +12,7 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <linux/mfd/cs42l43.h>
@@ -229,6 +230,33 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
+static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
+{
+	struct gpio_descs *descs;
+	u32 spkid;
+	int i, ret;
+
+	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
+	if (IS_ERR_OR_NULL(descs))
+		return PTR_ERR(descs);
+
+	spkid = 0;
+	for (i = 0; i < descs->ndescs; i++) {
+		ret = gpiod_get_value_cansleep(descs->desc[i]);
+		if (ret < 0)
+			goto err;
+
+		spkid |= (ret << i);
+	}
+
+	dev_dbg(priv->dev, "spk-id-gpios = %d\n", spkid);
+	*result = spkid;
+err:
+	gpiod_put_array(descs);
+
+	return ret;
+}
+
 static struct fwnode_handle *cs42l43_find_xu_node(struct fwnode_handle *fwnode)
 {
 	static const u32 func_smart_amp = 0x1;
@@ -306,6 +334,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
 	struct fwnode_handle *xu_fwnode __free(fwnode_handle) = cs42l43_find_xu_node(fwnode);
 	int nsidecars = 0;
+	int spkid = -EINVAL;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -360,6 +389,18 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 
 	if (nsidecars) {
+		ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
+		if (!ret) {
+			dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
+		} else if (ret != -EINVAL) {
+			return dev_err_probe(priv->dev, ret, "Failed to get spk-id-val\n");
+		} else {
+			ret = cs42l43_get_speaker_id_gpios(priv, &spkid);
+			if (ret < 0)
+				return dev_err_probe(priv->dev, ret,
+						     "Failed to get spk-id-gpios\n");
+		}
+
 		ret = software_node_register(&cs42l43_gpiochip_swnode);
 		if (ret)
 			return dev_err_probe(priv->dev, ret,
@@ -385,11 +426,6 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	if (nsidecars) {
 		struct spi_board_info *ampl_info;
 		struct spi_board_info *ampr_info;
-		int spkid = -EINVAL;
-
-		fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
-
-		dev_dbg(priv->dev, "Found speaker ID %d\n", spkid);
 
 		ampl_info = cs42l43_create_bridge_amp(priv, "cs35l56-left", 0, spkid);
 		if (!ampl_info)
-- 
2.39.5


