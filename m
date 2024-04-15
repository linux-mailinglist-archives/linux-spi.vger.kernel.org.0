Return-Path: <linux-spi+bounces-2343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B629B8A52B9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4121E1F23FBF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45774E37;
	Mon, 15 Apr 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hpPwFDIO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF07353F;
	Mon, 15 Apr 2024 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190177; cv=none; b=IP0IPxWn6thwdjmUZKbfIiNsc2QCuHpRBh8r1rZn5EG0ArdsDJ70KcW+z1GslAnbfy9nK/5Mq1Lm9K5O/rQTKNA2SbljhmTibmXvyRTfrVwvt8k+NRA/QA5JY8qIKFXaviezbQDxpEE+pOE6p0ZGKdDUoAbF2BW2cw3BXDYchpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190177; c=relaxed/simple;
	bh=7NB1bm23p4RwXEG6oxBBqEg3qxWytcPBM0x2mN0fIDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9830haYfyqHKV7xEVV2AJDQZ5X062UMYvoDI4cAcJG5yG2FKIX/dPTldOPArvmNmu+UJUu0jTV4+r4HpKNz1CpPaO8lPuwWnMrZqAWaqpgk2VSLIFAVwFBd8JiF0Uy2xIm6I+pOvlsvjs/rPKJCGBYlI1ChoaZU6HHrxrlEzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hpPwFDIO; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5UOmi015882;
	Mon, 15 Apr 2024 09:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=DJY1KZXHgteDpxXXPC4njqQ8+51Vn4q5z9pKGZ7zkrY=; b=
	hpPwFDIOjvms8FSqTMA7KkrvItgps2jRd1hv3mi1DRKLjN6USlqjckb8wZcvdYlM
	ygPyXu0fqQUGTea5KUHvY/uQWYrz+b9sXXXTjegBtUZX7dxrcSKnq2KmtWWVALg/
	8ceODgjr2LpI45rgGtZivzpQlCNeZAn7CfwxfcJN86kvrm2yPi/dz1+IpqzKP5BW
	qpVD4eXs90utJ1fVagr3RDlT77oOT3K5YQr4ZLVQC+JYmJPixW4kp6xPY82X+puR
	qjj8B8SA9NNejmB/ejL4U13icVMmcuhNzDZEvO7z0+o3+e4tKIYslljCCJ7W401N
	JCsb/05XHKg2G1DWx1/qbg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqey9hc7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 09:09:28 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 15:09:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 15 Apr 2024 15:09:25 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3CB30820258;
	Mon, 15 Apr 2024 14:09:25 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v6 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Date: Mon, 15 Apr 2024 15:09:25 +0100
Message-ID: <20240415140925.3518990-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g1ZwcAt2Ssybc9eRtq8NZabj-RbCMu5R
X-Proofpoint-ORIG-GUID: g1ZwcAt2Ssybc9eRtq8NZabj-RbCMu5R
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

Series changes since v5:
 - Remove NULL check on acpi_handle

Thanks,
Charles

 drivers/spi/Kconfig       |   1 +
 drivers/spi/spi-cs42l43.c | 135 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 554664efda86..17325e0b7bd5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -284,6 +284,7 @@ config SPI_COLDFIRE_QSPI
 config SPI_CS42L43
 	tristate "Cirrus Logic CS42L43 SPI controller"
 	depends on MFD_CS42L43 && PINCTRL_CS42L43
+	select GPIO_SWNODE_UNDEFINED
 	help
 	  This enables support for the SPI controller inside the Cirrus Logic
 	  CS42L43 audio codec.
diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index aabef9fc84bd..dbc60ddaca93 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -5,10 +5,14 @@
 // Copyright (C) 2022-2023 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
+#include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
 #include <linux/mod_devicetable.h>
@@ -16,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
@@ -39,6 +44,44 @@ static const unsigned int cs42l43_clock_divs[] = {
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
+	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.chip_select		= 0,
+	.mode			= SPI_MODE_0,
+	.swnode			= &ampl,
+};
+
+static struct spi_board_info ampr_info = {
+	.modalias		= "cs35l56",
+	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.chip_select		= 1,
+	.mode			= SPI_MODE_0,
+	.swnode			= &ampr,
+};
+
+static const struct software_node cs42l43_gpiochip_swnode = {
+	.name			= "cs42l43-pinctrl",
+};
+
+static const struct software_node_ref_args cs42l43_cs_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
+};
+
+static const struct property_entry cs42l43_cs_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY("cs-gpios", cs42l43_cs_refs),
+	{}
+};
+
 static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
 {
 	const u8 *end = buf + len;
@@ -203,6 +246,43 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
 	return CS42L43_SPI_MAX_LENGTH;
 }
 
+static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
+{
+	static const u32 func_smart_amp = 0x1;
+	struct fwnode_handle *child_fwnode, *ext_fwnode;
+	unsigned int val;
+	u32 function;
+	int ret;
+
+	fwnode_for_each_child_node(fwnode, child_fwnode) {
+		acpi_handle handle = ACPI_HANDLE_FWNODE(child_fwnode);
+
+		ret = acpi_get_local_address(handle, &function);
+		if (ret || function != func_smart_amp)
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
+
+		fwnode_handle_put(ext_fwnode);
+
+		if (ret)
+			continue;
+
+		fwnode_handle_put(child_fwnode);
+
+		return !!val;
+	}
+
+	return false;
+}
+
 static void cs42l43_release_of_node(void *data)
 {
 	fwnode_handle_put(data);
@@ -213,6 +293,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_spi *priv;
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
+	bool has_sidecar = cs42l43_has_sidecar(fwnode);
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -266,16 +347,64 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 		}
 	}
 
-	device_set_node(&priv->ctlr->dev, fwnode);
+	if (has_sidecar) {
+		ret = software_node_register(&cs42l43_gpiochip_swnode);
+		if (ret) {
+			return dev_err_probe(priv->dev, ret,
+					     "Failed to register gpio swnode\n");
+		}
+
+		ret = device_create_managed_software_node(&priv->ctlr->dev,
+							  cs42l43_cs_props, NULL);
+		if (ret) {
+			dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
+			goto err;
+		}
+	} else {
+		device_set_node(&priv->ctlr->dev, fwnode);
+	}
 
 	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
 	if (ret) {
-		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
+		dev_err_probe(priv->dev, ret, "Failed to register SPI controller\n");
+		goto err;
+	}
+
+	if (has_sidecar) {
+		if (!spi_new_device(priv->ctlr, &ampl_info)) {
+			ret = dev_err_probe(priv->dev, -ENODEV,
+					    "Failed to create left amp slave\n");
+			goto err;
+		}
+
+		if (!spi_new_device(priv->ctlr, &ampr_info)) {
+			ret = dev_err_probe(priv->dev, -ENODEV,
+					    "Failed to create right amp slave\n");
+			goto err;
+		}
 	}
 
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
@@ -288,9 +417,11 @@ static struct platform_driver cs42l43_spi_driver = {
 	},
 	.probe		= cs42l43_spi_probe,
 	.id_table	= cs42l43_spi_id_table,
+	.remove		= cs42l43_spi_remove,
 };
 module_platform_driver(cs42l43_spi_driver);
 
+MODULE_IMPORT_NS(GPIO_SWNODE);
 MODULE_DESCRIPTION("CS42L43 SPI Driver");
 MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
 MODULE_AUTHOR("Maciej Strozek <mstrozek@opensource.cirrus.com>");
-- 
2.39.2


