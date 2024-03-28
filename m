Return-Path: <linux-spi+bounces-2079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9A890108
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A9297F10
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5B1DDF6;
	Thu, 28 Mar 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I4EH8uzJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F458172E;
	Thu, 28 Mar 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634497; cv=none; b=rh6CuMs7SIWhUHWp6iFEM7i8uQVGOIAZ6zjUwVDIBIHWwiThIDkivYdfgwFmOpK0frnuhBwc3DKr3ijzJdAY8DwzCd/HMBoy3O3y0tfJU3TLD3I/m1teoo8YfBYSfxxqYKnIaV4WGWLNu0qI5J+QTLQyMT+plZV05G+ndNOB5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634497; c=relaxed/simple;
	bh=ysAQBAFonNmNNQF1B+RQnJcwPvpzCptDD+KsQe6N+kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOCBGEKxdblFG0zGofJbsHQO1w7w8g42Tm0FWk9JX9iTlvZUbJW6KXRoYED+95U5eLTR5dabebFzN1RlYrphDiMq60XYcWPgBepqOG21+jzOI4NQalu3+HcSUK3weQfxXY5htY7ImKC3t5/SUWTgoicSY50Kwk3lJRWVXcxsz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=I4EH8uzJ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SD0EVJ012589;
	Thu, 28 Mar 2024 09:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=epdem1A+e/KXxjSnC36U+LUuyPBOSguFBRzyiDj8bdE=; b=
	I4EH8uzJW1JQuzSJUjXqeQ6XJLH9s5XpZntNNcgad7FT12aPwWoaVCWiSks7/8VX
	5BxdzaKCqN37ocTo/C1lZzesbFCJEhKQsJBnrynQt367dZx8FktlQeGt9TCITGi/
	c3E51L9rLPYcyG+9oyDUfhAbYth/dEI/821fJ/AZ8G5oG1F97ZAS4rZrwytOGvFf
	qIjblu6igYaXdwYcnV2seRetO+lDh/NehVAfHC6m5Ht430nQWnyRqtTn0/KavcZ/
	iBUFyRX+rt4wxXKx+VzR3qau+Z8It/tSfgZ/Eogkq730L3k8n5Gio381AuZP1Vkv
	l418Go8jvt00Ij014xhgoQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k2tjk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:01:22 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Mar
 2024 14:01:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 28 Mar 2024 14:01:19 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 63769820258;
	Thu, 28 Mar 2024 14:01:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Date: Thu, 28 Mar 2024 14:01:19 +0000
Message-ID: <20240328140119.1784350-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
References: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PjI5vtIadEsWQpuav7YvYPI8CX0PGAjj
X-Proofpoint-ORIG-GUID: PjI5vtIadEsWQpuav7YvYPI8CX0PGAjj
X-Proofpoint-Spam-Reason: safe

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

On some cs42l43 systems a couple of cs35l56 amplifiers are attached
to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
by a SDCA class driver and these two amplifiers are controlled by
firmware running on the cs42l43. However, under Linux the decision
was made to interact with the cs42l43 directly, affording the user
greater control over the audio system. However, this has resulted
in an issue where these two bridged cs35l56 amplifiers are not
populated in ACPI and must be added manually.

Check for the presence of the "01fa-cirrus-sidecar-instances" property
in the SDCA extension unit's ACPI properties to confirm the presence
of these two amplifiers and if they exist add them manually onto the
SPI bus.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Add some missing statics

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 152 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index aabef9fc84bdf..c7ee9d49d9ef4 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -5,6 +5,8 @@
 // Copyright (C) 2022-2023 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
+#include <dt-bindings/gpio/gpio.h>
+#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
@@ -39,6 +41,59 @@ static const unsigned int cs42l43_clock_divs[] = {
 	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
 };
 
+static const struct software_node ampl = {
+	.name			= "cs35l56-left",
+};
+
+static const struct software_node ampr = {
+	.name			= "cs35l56-right",
+};
+
+static struct spi_board_info ampl_info = {
+	.modalias		= "cs35l56",
+	.max_speed_hz		= 2000000,
+	.chip_select		= 0,
+	.mode			= SPI_MODE_0,
+	.swnode			= &ampl,
+	.use_fwnode_name	= true,
+};
+
+static struct spi_board_info ampr_info = {
+	.modalias		= "cs35l56",
+	.max_speed_hz		= 2000000,
+	.chip_select		= 1,
+	.mode			= SPI_MODE_0,
+	.swnode			= &ampr,
+	.use_fwnode_name	= true,
+};
+
+static const struct software_node cs42l43_gpiochip_swnode = {
+	.name			= "cs42l43-pinctrl",
+};
+
+static const struct software_node_ref_args cs42l43_cs_refs[] = {
+	{
+		.node		= &cs42l43_gpiochip_swnode,
+		.nargs		= 2,
+		.args		= { 0, GPIO_ACTIVE_LOW },
+	},
+	{
+		.node		= &swnode_gpio_undefined,
+		.nargs		= 0,
+	},
+};
+
+static const struct property_entry cs42l43_cs_props[] = {
+	{
+		.name		= "cs-gpios",
+		.length		= ARRAY_SIZE(cs42l43_cs_refs) *
+				  sizeof(struct software_node_ref_args),
+		.type		= DEV_PROP_REF,
+		.pointer	= cs42l43_cs_refs,
+	},
+	{}
+};
+
 static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
 {
 	const u8 *end = buf + len;
@@ -203,6 +258,51 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
+static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
+{
+	static const int func_smart_amp = 0x1;
+	struct fwnode_handle *child_fwnode, *ext_fwnode;
+	unsigned long long function;
+	unsigned int val;
+	int ret;
+
+	if (!is_acpi_node(fwnode))
+		return false;
+
+	fwnode_for_each_child_node(fwnode, child_fwnode) {
+		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
+
+		ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &function);
+		if (ACPI_FAILURE(ret))
+			continue;
+
+		if (function != func_smart_amp)
+			continue;
+
+		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
+				"mipi-sdca-function-expansion-subproperties");
+		if (!ext_fwnode)
+			continue;
+
+		ret = fwnode_property_read_u32(ext_fwnode,
+					       "01fa-cirrus-sidecar-instances",
+					       &val);
+		if (ret)
+			continue;
+
+		return !!val;
+	}
+
+	return false;
+}
+#else
+static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
+{
+	return false;
+}
+#endif
+
 static void cs42l43_release_of_node(void *data)
 {
 	fwnode_handle_put(data);
@@ -213,6 +313,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_spi *priv;
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
+	bool has_sidecar = cs42l43_has_sidecar(fwnode);
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -266,16 +367,64 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	device_set_node(&priv->ctlr->dev, fwnode);
+	if (has_sidecar) {
+		ret = software_node_register(&cs42l43_gpiochip_swnode);
+		if (ret) {
+			dev_err(priv->dev, "Failed to register gpio swnode: %d\n", ret);
+			return ret;
+		}
+
+		ret = device_create_managed_software_node(&priv->ctlr->dev, cs42l43_cs_props, NULL);
+		if (ret) {
+			dev_err(priv->dev, "Failed to add swnode: %d\n", ret);
+			goto err;
+		}
+
+	} else {
+		device_set_node(&priv->ctlr->dev, fwnode);
+	}
 
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
 		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
+		goto err;
 	}
 
+	if (has_sidecar) {
+		if (!spi_new_device(priv->ctlr, &ampl_info)) {
+			ret = -ENODEV;
+			dev_err(priv->dev, "Failed to create left amp slave\n");
+			goto err;
+		}
+
+		if (!spi_new_device(priv->ctlr, &ampr_info)) {
+			ret = -ENODEV;
+			dev_err(priv->dev, "Failed to create right amp slave\n");
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	if (has_sidecar)
+		software_node_unregister(&cs42l43_gpiochip_swnode);
+
 	return ret;
 }
 
+static int cs42l43_spi_remove(struct platform_device *pdev)
+{
+	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
+	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
+	bool has_sidecar = cs42l43_has_sidecar(fwnode);
+
+	if (has_sidecar)
+		software_node_unregister(&cs42l43_gpiochip_swnode);
+
+	return 0;
+};
+
 static const struct platform_device_id cs42l43_spi_id_table[] = {
 	{ "cs42l43-spi", },
 	{}
@@ -288,6 +437,7 @@ static struct platform_driver cs42l43_spi_driver = {
 	},
 	.probe		= cs42l43_spi_probe,
 	.id_table	= cs42l43_spi_id_table,
+	.remove		= cs42l43_spi_remove,
 };
 module_platform_driver(cs42l43_spi_driver);
 
-- 
2.39.2


