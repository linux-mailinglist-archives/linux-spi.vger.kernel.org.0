Return-Path: <linux-spi+bounces-2293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD38A0BDB
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707CC1F277A6
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7CF14389F;
	Thu, 11 Apr 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eqLG01s+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8414264F;
	Thu, 11 Apr 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826401; cv=none; b=G7zLduUl76LCi4+m5oRXVpKJ2+MGxIRf/IT7jaIchMWjGHkYCySCsuwn3Bus6YJoYaGSPd8LS58rk0ICRIrX4JrXV+Cx1e3K8R+t+77n+IX8Ze3RrSY4x0PKECWecRWMwt2Nd9/Qv2R7JbLnKowBGKvUpFQmFOsA3FLhm9q+ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826401; c=relaxed/simple;
	bh=fTcHpoY+wJed+LhLtyl7F4AT7+EI2kzKaCLD3rNROmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAtHtL8ZpIQDD4Cs5jt20FiGb8NDtNMMBhd/CtROkXXZoLNLcq30GSrAE36056j7feOIPAcgajzfGSVkbvJdJfb6ioCm3Qb7bcU0Boa5U+NadQpI4uZJMn1qJ03kIDSpC3BHqHBCTbZ551n352SVy4t4XYYHY5VXz4JWe45G6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eqLG01s+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naFJ004518;
	Thu, 11 Apr 2024 04:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Lsqqhjor6m8TXKDJJd6rShK4y5bntshWQZozEsXfdA8=; b=
	eqLG01s+txThPwCb/5vAN8SqS10WWFrwuNCsiGhPKjLl/eYeGSXlZ6gf7SBSvFhP
	P7PX+HowFD/70l0t2A8vG0wwzqVTf+Z+OmHikv+rwRIxfyjBUXXdwjzpAeCy5YqK
	33cLYRIlppo/lDWJrTXTzigSVP4mSlbxQQLvGnOXYJlTrOlTT/Z6bztwiGfT7j70
	U5hiB6oTq2tB4tv6HfZFF0a3JHKnu3nPCi9yFGURR5CPacFkgkjHEThHJuL/TOLK
	xfqMESdVAQz73pqQA/5CyL1EYyLJuDXWSOobV6O5dTcZC4AZchdwN9+B+qRCxtiP
	dKuzkscp1+R7qZdS0xiZlA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq0gy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 04:06:30 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 10:06:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 10:06:28 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8CC6A820258;
	Thu, 11 Apr 2024 09:06:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Date: Thu, 11 Apr 2024 10:06:28 +0100
Message-ID: <20240411090628.2436389-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W5RMmcoLzVBo1zK0DRpCCxJPGiw8zPYF
X-Proofpoint-GUID: W5RMmcoLzVBo1zK0DRpCCxJPGiw8zPYF
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

Changes since v4:
 - Drop some redundant fwnode_handle_puts
 - Remove stray blank line
 - Use ACPI_HANDLE_FWNODE

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
index aabef9fc84bd..29049f3f1f64 100644
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
+#include <linux/fwnode.h>
+#include <linux/gpio/machine.h>
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
+		if (!handle)
+			continue;
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
 	}
 
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


