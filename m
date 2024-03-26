Return-Path: <linux-spi+bounces-2011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869C88C4CE
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 15:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C391F663D5
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233BB7F7E6;
	Tue, 26 Mar 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SWJQLccA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DB7EF05;
	Tue, 26 Mar 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462291; cv=none; b=MbN99nOdt615jLR8aQpwSiAzwwwO1QFDqnipRb/OOLdhx0n/l/0bVxGEd9yfGw38ukm8RH/JXb+raDnuET0frifvU4QlePDXrIHJlZ1WemtCJZPkB+wQrr2jc1+kRGfkNklxMYTA8iyvDLmJMyVMEbY26V09VUJO1HFf4plyp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462291; c=relaxed/simple;
	bh=+eDTwCLFN+6oHzjEUNWk7F4lsHMeamQDyDZXLiBW+fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOMyGnVlfz9e5zzlPzqRrZLhY52Qt7ZNlt8ldQwIDVWZtckEmU3PDRft+2a/K9C7dnaD+iQsSFLTJZGMf4FlkQgjc4TUjrhakmGt15chCyHxURCJt1CrK6HL77yScRIg6gyf+ZwETXxlE1OI3uL4RP2GI0K59L9TO9q0+nsfw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SWJQLccA; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q79uUA026416;
	Tue, 26 Mar 2024 09:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Ovuw+SaOftuSi5DbYOc7/XJi0fkbkH92Lk+LQ0sGnSY=; b=
	SWJQLccAEMGNn2Jk0wVUSnJaugYlXzZzk4d8ZG3N55iSfyt5FYnloYPRztuL0c8I
	iNRWB+0+i5vaEoz9APWgmuFl+X/E9y9m4vIB/TbzwWvmOWUrf78tl8NXSK58ka58
	V/UbwvYMB7epH8RAEazVH0Ir5MLhgIaOc6xD2c9+HgFKDIafkLFfdvN9cRRWzRKA
	A7Ym2Z1QNYTurhchr6DKomUvcH96+SsHuwjdKJupzG+OAF5+gVt4KKk6p0VD12Gz
	/3enrOKsPslx4Nct58Ygd18a2Z65W1zVPoWDQZD1KsYnqrM2fahDaYH3HqZw4uJE
	wj7rd+W4plRDMAgjO4exrQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x1ugm5b9y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:11:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Mar
 2024 14:11:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Tue, 26 Mar 2024 14:11:08 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9764B820258;
	Tue, 26 Mar 2024 14:11:08 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Date: Tue, 26 Mar 2024 14:11:08 +0000
Message-ID: <20240326141108.1079993-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5VCBO9wa67MyW6DHCC1YDjLgbo3eBJ1z
X-Proofpoint-GUID: 5VCBO9wa67MyW6DHCC1YDjLgbo3eBJ1z
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
 drivers/spi/spi-cs42l43.c | 152 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index aabef9fc84bd..3620d4059034 100644
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
 
+const struct software_node ampl = {
+	.name			= "cs35l56-left",
+};
+
+const struct software_node ampr = {
+	.name			= "cs35l56-right",
+};
+
+struct spi_board_info ampl_info = {
+	.modalias		= "cs35l56",
+	.max_speed_hz		= 2000000,
+	.chip_select		= 0,
+	.mode			= SPI_MODE_0,
+	.swnode			= &ampl,
+	.use_fwnode_name	= true,
+};
+
+struct spi_board_info ampr_info = {
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


