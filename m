Return-Path: <linux-spi+bounces-2248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3314A89DA04
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B653E1F22F1D
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044512F592;
	Tue,  9 Apr 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hkJdqFqA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609112F584;
	Tue,  9 Apr 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668906; cv=none; b=iTRWrTT6vQQJmGo5P6/znTWG4b/m5k3WStDXltZWZ8dOAZCCNRTrHBBebjtpg7m6Z7oPnsLbOiKYjGIvjIukyK2J5R0Xrv8MOnv9bDKsS+uQRPWazPRj0AvQ6Ly+9VwR71giTRNADBD208O5ML+HtB4FB3wRzWYh43eL9Vr03eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668906; c=relaxed/simple;
	bh=4mrEEGOLjj3zIVrlveb7wHZWigiUKdrnRjzDL9kY7vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZnrGLgfEZmphMQ4tlsgDU/HDhGfCJBuqWNJQnZntUl3jxi2gb6TvLelTtYtbsh4qunf0d0V4ud2JvlvNDJJcnjpBMV713T4pj397z7cKU5oP2aXr2roOl8cWstpXrv4f0j1Y9B+35NQ/0mgHsh0zLstayY/+u/qBJksCdBq7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hkJdqFqA; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43961qnf028753;
	Tue, 9 Apr 2024 08:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=1N277M4pHdYjbxAfgUtovFF3TmUPHYaLtIN3mgtzgS4=; b=
	hkJdqFqARylgiUeOKUh2jO72IT7WlF5O4Ya+WfNxz5iYrWJO8+tGDu+ojengimqU
	4dTLwq4vVOfEZLUm7PW4E+p0tw+azTP9yBTUBpM0e5mQBMPz8ACa4i3ObuG1E5V9
	FbP8mN+m2YPu0FligGi3TlaIrZ0hjA2S8Nmv7R/OgWTk2CTGQqMFbUi9a4HFhFM8
	gnCSt/nmXCqSuMcvgumG2LHe3ytjimPpRKIDQGLCsfwtpYLqiUxIW1P2cMH/4lxw
	ihFus2MdUBN+N+wDteli2C/ymM7ck/oZ2NjH+fZKIIcLURJBfL52pNCQ2prc2hde
	wjAb5sxvVOvo8ndTd6d/hA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjjvq5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:21:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 14:21:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Apr 2024 14:21:26 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 39723820272;
	Tue,  9 Apr 2024 13:21:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Date: Tue, 9 Apr 2024 14:21:26 +0100
Message-ID: <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zptHVDhrfzjv0RZapnshF0eKJC5eGHGs
X-Proofpoint-GUID: zptHVDhrfzjv0RZapnshF0eKJC5eGHGs
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

Changes since v3:
 - Correct some header includes
 - Use HZ_PER_MHZ
 - Use some swnode helper macros
 - Use acpi_get_local_address
 - Correct some handle puts
 - Add some dev_err_probes

Thanks,
Charles

 drivers/spi/Kconfig       |   1 +
 drivers/spi/spi-cs42l43.c | 139 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6e4b5f7e8adc..ffc4bd7a67e6 100644
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
index aabef9fc84bd..a4208c2dfc76 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -5,10 +5,13 @@
 // Copyright (C) 2022-2023 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
+#include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio/machine.h>
 #include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
 #include <linux/mod_devicetable.h>
@@ -16,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
@@ -39,6 +43,44 @@ static const unsigned int cs42l43_clock_divs[] = {
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
@@ -203,6 +245,47 @@ static size_t cs42l43_spi_max_length(struct spi_device *spi)
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
+		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
+
+		if (!adev)
+			continue;
+
+		ret = acpi_get_local_address(adev->handle, &function);
+		if (ret || function != func_smart_amp) {
+			fwnode_handle_put(child_fwnode);
+			continue;
+		}
+
+		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
+				"mipi-sdca-function-expansion-subproperties");
+		if (!ext_fwnode) {
+			fwnode_handle_put(child_fwnode);
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(ext_fwnode,
+					       "01fa-cirrus-sidecar-instances",
+					       &val);
+
+		fwnode_handle_put(ext_fwnode);
+		fwnode_handle_put(child_fwnode);
+
+		if (!ret)
+			return !!val;
+	}
+
+	return false;
+}
+
 static void cs42l43_release_of_node(void *data)
 {
 	fwnode_handle_put(data);
@@ -213,6 +296,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_spi *priv;
 	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
+	bool has_sidecar = cs42l43_has_sidecar(fwnode);
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -266,16 +350,64 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
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
@@ -288,9 +420,12 @@ static struct platform_driver cs42l43_spi_driver = {
 	},
 	.probe		= cs42l43_spi_probe,
 	.id_table	= cs42l43_spi_id_table,
+	.remove		= cs42l43_spi_remove,
 };
 module_platform_driver(cs42l43_spi_driver);
 
+MODULE_IMPORT_NS(GPIO_SWNODE);
+
 MODULE_DESCRIPTION("CS42L43 SPI Driver");
 MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
 MODULE_AUTHOR("Maciej Strozek <mstrozek@opensource.cirrus.com>");
-- 
2.39.2


