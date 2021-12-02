Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7464667D3
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359435AbhLBQ2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Dec 2021 11:28:35 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27000 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1359356AbhLBQ2c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Dec 2021 11:28:32 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B21RQLk001056;
        Thu, 2 Dec 2021 10:25:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=WthyCW/E5S+GPAodK+ozsdsnUdmSep4hXzD10jB54ME=;
 b=KBA6ysJQpj+S9wTj1bSqnwCo1mxvDwJ3UDEJSGIlQDvNtKVulPSotJWybwTOQXhLiyBC
 EYRYCRb0mxM9AoA6Gp1byDKFMBmUzqzW1s3yVWGgeT6DjNKJhyOnbg1iI0ClL6gyWrBk
 HICgELJb79WhOSl6LOo9PyyY5PvsmFb9PFwo/EEPbjIsDzCa3VDy+OEZSpX5azV6HMPU
 BG8+9JnKpwRSuMiV2YGEYv4om/xqswDx/01Xx03iF8pMeVPBj4t8UXNoCUVPOD37YdgO
 3X3AQJ1sLiQ/d409hogucTTTAWgC6NaC95W9n9fTMTuQEja3svuXnlNL5R/yf5ntZEwm MQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cp6c89wp5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 10:25:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 16:24:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 16:24:57 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.136])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 80CBCB13;
        Thu,  2 Dec 2021 16:24:57 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 3/3] platform/x86: Support Spi in i2c-multi-instantiate driver
Date:   Thu, 2 Dec 2021 16:24:21 +0000
Message-ID: <20211202162421.7628-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
References: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Im-yIjRMkcAOJ9LGW5Kk4OUHPY3I6YPx
X-Proofpoint-GUID: Im-yIjRMkcAOJ9LGW5Kk4OUHPY3I6YPx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for spi bus in i2c-multi-instantiate driver
and rename it for a multiple purpose driver name
By adding spi support into this driver enables devices
to use the same _HID string for i2c and spi uses and
minimize the support for two drivers doing the same thing
for different busses

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 MAINTAINERS                                  |   4 +-
 drivers/acpi/scan.c                          |  19 +-
 drivers/platform/x86/Kconfig                 |  14 +-
 drivers/platform/x86/Makefile                |   2 +-
 drivers/platform/x86/bus-multi-instantiate.c | 432 +++++++++++++++++++
 drivers/platform/x86/i2c-multi-instantiate.c | 174 --------
 6 files changed, 452 insertions(+), 193 deletions(-)
 create mode 100644 drivers/platform/x86/bus-multi-instantiate.c
 delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b1e79f8e3d8..f75600d917bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -387,11 +387,11 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
-ACPI I2C MULTI INSTANTIATE DRIVER
+ACPI BUS MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/i2c-multi-instantiate.c
+F:	drivers/platform/x86/bus-multi-instantiate.c
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5991dddbc9ce..2f7da1a08112 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1696,14 +1696,15 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
 	/*
-	 * These devices have multiple I2cSerialBus resources and an i2c-client
-	 * must be instantiated for each, each with its own i2c_device_id.
-	 * Normally we only instantiate an i2c-client for the first resource,
-	 * using the ACPI HID as id. These special cases are handled by the
-	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
-	 * which i2c_device_id to use for each resource.
+	 * These devices have multiple I2cSerialBus/SpiSerialBusV2 resources
+	 * and an (i2c/spi)-client must be instantiated for each, each with
+	 * its own i2c_device_id/spi_device_id.
+	 * Normally we only instantiate an (i2c/spi)-client for the first
+	 * resource, using the ACPI HID as id. These special cases are handled
+	 * by the drivers/platform/x86/bus-multi-instantiate.c driver, which
+	 * knows which i2c_device_id or spi_device_id to use for each resource.
 	 */
-	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+	static const struct acpi_device_id bus_multi_instantiate_ids[] = {
 		{"BSG1160", },
 		{"BSG2150", },
 		{"INT33FE", },
@@ -1721,8 +1722,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
-	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
-	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
+	/* Instantiate a pdev for the bus-multi-instantiate drv to bind to */
+	if (!acpi_match_device_ids(device, bus_multi_instantiate_ids))
 		return false;
 
 	INIT_LIST_HEAD(&resource_list);
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 97e87628eb35..5a413b123c01 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -958,16 +958,16 @@ config TOPSTAR_LAPTOP
 
 	  If you have a Topstar laptop, say Y or M here.
 
-config I2C_MULTI_INSTANTIATE
-	tristate "I2C multi instantiate pseudo device driver"
-	depends on I2C && ACPI
+config BUS_MULTI_INSTANTIATE
+	tristate "Bus multi instantiate pseudo device driver"
+	depends on I2C && SPI && ACPI
 	help
-	  Some ACPI-based systems list multiple i2c-devices in a single ACPI
-	  firmware-node. This driver will instantiate separate i2c-clients
-	  for each device in the firmware-node.
+	  Some ACPI-based systems list multiple i2c/spi devices in a
+	  single ACPI firmware-node. This driver will instantiate separate
+	  i2c-clients or spi-devices for each device in the firmware-node.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called i2c-multi-instantiate.
+	  will be called bus-multi-instantiate.
 
 config MLX_PLATFORM
 	tristate "Mellanox Technologies platform support"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 219478061683..639a50af0bec 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -108,7 +108,7 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 
 # Platform drivers
 obj-$(CONFIG_FW_ATTR_CLASS)		+= firmware_attributes_class.o
-obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_BUS_MULTI_INSTANTIATE)	+= bus-multi-instantiate.o
 obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
new file mode 100644
index 000000000000..1b55380a2057
--- /dev/null
+++ b/drivers/platform/x86/bus-multi-instantiate.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bus multi-instantiate driver, pseudo driver to instantiate multiple
+ * i2c-clients or spi-devices from a single fwnode.
+ *
+ * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#define IRQ_RESOURCE_TYPE		GENMASK(1, 0)
+#define IRQ_RESOURCE_NONE		0
+#define IRQ_RESOURCE_GPIO		1
+#define IRQ_RESOURCE_APIC		2
+#define MAX_RESOURCE_SOURCE_CHAR	30
+
+struct inst_data {
+	const char *type;
+	unsigned int flags;
+	int irq_idx;
+};
+
+struct multi_inst_data {
+	int i2c_num;
+	int spi_num;
+	struct spi_device **spi_devs;
+	struct i2c_client **i2c_devs;
+};
+
+struct spi_acpi_data {
+	char resource_source[MAX_RESOURCE_SOURCE_CHAR];
+	struct acpi_resource_spi_serialbus sb;
+};
+
+struct spi_serialbus_acpi_data {
+	int count;
+	struct spi_acpi_data acpi_data[];
+};
+
+static int spi_count(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_spi_serialbus *sb;
+	int *count = data;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	sb = &ares->data.spi_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
+		return 1;
+
+	*count = *count + 1;
+	return 1;
+}
+
+static int spi_count_resources(struct acpi_device *adev)
+{
+	LIST_HEAD(r);
+	int count = 0;
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &r, spi_count, &count);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&r);
+	return count;
+}
+
+static int spi_save_res(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_spi_serialbus *sb;
+	struct spi_serialbus_acpi_data *resources = data;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
+
+	sb = &ares->data.spi_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
+		return 1;
+
+	memcpy(&resources->acpi_data[resources->count].sb, sb, sizeof(*sb));
+	strscpy(resources->acpi_data[resources->count].resource_source,
+		sb->resource_source.string_ptr,
+		sizeof(resources->acpi_data[resources->count].resource_source));
+	resources->count++;
+
+	return 1;
+}
+
+static struct spi_serialbus_acpi_data *spi_get_resources(struct device *dev,
+							 struct acpi_device *adev, int count)
+{
+	struct spi_serialbus_acpi_data *resources;
+	LIST_HEAD(r);
+	int ret;
+
+	resources = kmalloc(struct_size(resources, acpi_data, count), GFP_KERNEL);
+	if (!resources)
+		return NULL;
+
+	ret = acpi_dev_get_resources(adev, &r, spi_save_res, resources);
+	if (ret < 0)
+		goto error;
+
+	acpi_dev_free_resource_list(&r);
+
+	return resources;
+
+error:
+	kfree(resources);
+	return NULL;
+}
+
+static struct spi_controller *find_spi_controller(char *path)
+{
+	struct spi_controller *ctlr;
+	acpi_handle parent_handle;
+	acpi_status status;
+	int i;
+
+	status = acpi_get_handle(NULL, path, &parent_handle);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	/* There will be not more than 10 spi controller for a device */
+	for (i = 0 ; i < 10 ; i++) {
+		ctlr = spi_busnum_to_master(i);
+		if (ctlr && ACPI_HANDLE(ctlr->dev.parent) == parent_handle)
+			return ctlr;
+	}
+
+	return NULL;
+}
+
+static int spi_multi_inst_probe(struct platform_device *pdev, struct acpi_device *adev,
+				const struct inst_data *inst_data, int count)
+{
+	struct spi_serialbus_acpi_data *acpi_data;
+	struct device *dev = &pdev->dev;
+	struct multi_inst_data *multi;
+	struct spi_controller *ctlr;
+	struct spi_device *spi_dev;
+	char name[50];
+	int i, ret;
+
+	multi = devm_kzalloc(dev, sizeof(*multi), GFP_KERNEL);
+	if (!multi)
+		return -ENOMEM;
+
+	multi->spi_devs = devm_kcalloc(dev, count, sizeof(*multi->spi_devs), GFP_KERNEL);
+	if (!multi->spi_devs)
+		return -ENOMEM;
+
+	acpi_data = spi_get_resources(dev, adev, count);
+	if (!acpi_data)
+		return -ENOMEM;
+
+	for (i = 0; i < count && inst_data[i].type; i++) {
+		ctlr = find_spi_controller(acpi_data->acpi_data[i].resource_source);
+		if (!ctlr) {
+			ret = -EPROBE_DEFER;
+			goto probe_error;
+		}
+
+		spi_dev = spi_alloc_device(ctlr);
+		if (!spi_dev) {
+			dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
+				dev_name(&adev->dev));
+			ret = -ENOMEM;
+			goto probe_error;
+		}
+
+		strscpy(spi_dev->modalias, inst_data[i].type, sizeof(spi_dev->modalias));
+
+		if (ctlr->fw_translate_cs) {
+			int cs = ctlr->fw_translate_cs(ctlr,
+					acpi_data->acpi_data[i].sb.device_selection);
+			if (cs < 0) {
+				ret = cs;
+				goto probe_error;
+			}
+			spi_dev->chip_select = cs;
+		} else {
+			spi_dev->chip_select = acpi_data->acpi_data[i].sb.device_selection;
+		}
+
+		spi_dev->max_speed_hz = acpi_data->acpi_data[i].sb.connection_speed;
+		spi_dev->bits_per_word = acpi_data->acpi_data[i].sb.data_bit_length;
+
+		if (acpi_data->acpi_data[i].sb.clock_phase == ACPI_SPI_SECOND_PHASE)
+			spi_dev->mode |= SPI_CPHA;
+		if (acpi_data->acpi_data[i].sb.clock_polarity == ACPI_SPI_START_HIGH)
+			spi_dev->mode |= SPI_CPOL;
+		if (acpi_data->acpi_data[i].sb.device_polarity == ACPI_SPI_ACTIVE_HIGH)
+			spi_dev->mode |= SPI_CS_HIGH;
+
+		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		case IRQ_RESOURCE_GPIO:
+			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "Error requesting irq at index %d: %d\n",
+						inst_data[i].irq_idx, ret);
+				goto probe_error;
+			}
+			spi_dev->irq = ret;
+			break;
+		case IRQ_RESOURCE_APIC:
+			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
+					inst_data[i].irq_idx, ret);
+				goto probe_error;
+			}
+			spi_dev->irq = ret;
+			break;
+		default:
+			spi_dev->irq = 0;
+			break;
+		}
+
+		snprintf(name, sizeof(name), "%s.%u-%s-%s.%d", dev_name(&ctlr->dev),
+			 spi_dev->chip_select, dev_name(dev), inst_data[i].type, i);
+		spi_dev->dev.init_name = name;
+
+		if (spi_add_device(spi_dev)) {
+			dev_err(&ctlr->dev, "failed to add SPI device %s from ACPI\n",
+				dev_name(&adev->dev));
+			spi_dev_put(spi_dev);
+			goto probe_error;
+		}
+
+		multi->spi_devs[i] = spi_dev;
+		multi->spi_num++;
+	}
+
+	if (multi->spi_num < count) {
+		dev_err(dev, "Error finding driver, idx %d\n", i);
+		ret = -ENODEV;
+		goto probe_error;
+	}
+
+	dev_info(dev, "Instantiate %d devices.\n", multi->spi_num);
+	platform_set_drvdata(pdev, multi);
+	kfree(acpi_data);
+
+	return 0;
+
+probe_error:
+	while (--i >= 0)
+		spi_unregister_device(multi->spi_devs[i]);
+
+	kfree(acpi_data);
+	return ret;
+}
+
+static int i2c_multi_inst_probe(struct platform_device *pdev, struct acpi_device *adev,
+				const struct inst_data *inst_data, int count)
+{
+	struct i2c_board_info board_info = {};
+	struct device *dev = &pdev->dev;
+	struct multi_inst_data *multi;
+	char name[32];
+	int i, ret;
+
+	multi = devm_kzalloc(dev, sizeof(*multi), GFP_KERNEL);
+	if (!multi)
+		return -ENOMEM;
+
+	multi->i2c_devs = devm_kcalloc(dev, count, sizeof(*multi->i2c_devs), GFP_KERNEL);
+	if (!multi->i2c_devs)
+		return -ENOMEM;
+
+	for (i = 0; i < count && inst_data[i].type; i++) {
+		memset(&board_info, 0, sizeof(board_info));
+		strscpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
+		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_data[i].type, i);
+		board_info.dev_name = name;
+		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		case IRQ_RESOURCE_GPIO:
+			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "Error requesting irq at index %d: %d\n",
+						inst_data[i].irq_idx, ret);
+				goto error;
+			}
+			board_info.irq = ret;
+			break;
+		case IRQ_RESOURCE_APIC:
+			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
+					inst_data[i].irq_idx, ret);
+				goto error;
+			}
+			board_info.irq = ret;
+			break;
+		default:
+			board_info.irq = 0;
+			break;
+		}
+		multi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
+		if (IS_ERR(multi->i2c_devs[i])) {
+			ret = dev_err_probe(dev, PTR_ERR(multi->i2c_devs[i]),
+					    "Error creating i2c-client, idx %d\n", i);
+			goto error;
+		}
+		multi->i2c_num++;
+	}
+	if (multi->i2c_num < count) {
+		dev_err(dev, "Error finding driver, idx %d\n", i);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(dev, "Instantiate %d devices.\n", multi->i2c_num);
+	platform_set_drvdata(pdev, multi);
+
+	return 0;
+
+error:
+	while (--i >= 0)
+		i2c_unregister_device(multi->i2c_devs[i]);
+
+	return ret;
+}
+
+static int bus_multi_inst_probe(struct platform_device *pdev)
+{
+	const struct inst_data *inst_data;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	int count;
+
+	inst_data = device_get_match_data(dev);
+	if (!inst_data) {
+		dev_err(dev, "Error ACPI match data is missing\n");
+		return -ENODEV;
+	}
+
+	adev = ACPI_COMPANION(dev);
+
+	/* Count number of i2c clients to instantiate */
+	count = i2c_acpi_client_count(adev);
+	if (count > 0)
+		return i2c_multi_inst_probe(pdev, adev, inst_data, count);
+	else if (count < 0)
+		dev_warn(dev, "I2C multi instantiate error %d\n", count);
+
+	/* Count number of spi devices to instantiate */
+	count = spi_count_resources(adev);
+	if (count > 0)
+		return spi_multi_inst_probe(pdev, adev, inst_data, count);
+	else if (count < 0)
+		dev_warn(dev, "SPI multi instantiate error %d\n", count);
+
+	return -ENODEV;
+}
+
+static int bus_multi_inst_remove(struct platform_device *pdev)
+{
+	struct multi_inst_data *multi = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < multi->i2c_num; i++)
+		i2c_unregister_device(multi->i2c_devs[i]);
+
+	for (i = 0; i < multi->spi_num; i++)
+		spi_unregister_device(multi->spi_devs[i]);
+
+	return 0;
+}
+
+static const struct inst_data bsg1160_data[]  = {
+	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+	{ "bmc150_magn" },
+	{ "bmg160" },
+	{}
+};
+
+static const struct inst_data bsg2150_data[]  = {
+	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+	{ "bmc150_magn" },
+	/* The resources describe a 3th client, but it is not really there. */
+	{ "bsg2150_dummy_dev" },
+	{}
+};
+
+static const struct inst_data int3515_data[]  = {
+	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
+	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
+	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
+	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
+	{}
+};
+
+/*
+ * Note new device-ids must also be added to bus_multi_instantiate_ids in
+ * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
+ */
+static const struct acpi_device_id bus_multi_inst_acpi_ids[] = {
+	{ "BSG1160", (unsigned long)bsg1160_data },
+	{ "BSG2150", (unsigned long)bsg2150_data },
+	{ "INT3515", (unsigned long)int3515_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, bus_multi_inst_acpi_ids);
+
+static struct platform_driver bus_multi_inst_driver = {
+	.driver	= {
+		.name = "Bus multi instantiate pseudo device driver",
+		.acpi_match_table = bus_multi_inst_acpi_ids,
+	},
+	.probe = bus_multi_inst_probe,
+	.remove = bus_multi_inst_remove,
+};
+module_platform_driver(bus_multi_inst_driver);
+
+MODULE_DESCRIPTION("Bus multi instantiate pseudo device driver");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
deleted file mode 100644
index 4956a1df5b90..000000000000
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * I2C multi-instantiate driver, pseudo driver to instantiate multiple
- * i2c-clients from a single fwnode.
- *
- * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
- */
-
-#include <linux/acpi.h>
-#include <linux/bits.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-#include <linux/types.h>
-
-#define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
-#define IRQ_RESOURCE_NONE	0
-#define IRQ_RESOURCE_GPIO	1
-#define IRQ_RESOURCE_APIC	2
-
-struct i2c_inst_data {
-	const char *type;
-	unsigned int flags;
-	int irq_idx;
-};
-
-struct i2c_multi_inst_data {
-	int num_clients;
-	struct i2c_client *clients[];
-};
-
-static int i2c_multi_inst_probe(struct platform_device *pdev)
-{
-	struct i2c_multi_inst_data *multi;
-	const struct i2c_inst_data *inst_data;
-	struct i2c_board_info board_info = {};
-	struct device *dev = &pdev->dev;
-	struct acpi_device *adev;
-	char name[32];
-	int i, ret;
-
-	inst_data = device_get_match_data(dev);
-	if (!inst_data) {
-		dev_err(dev, "Error ACPI match data is missing\n");
-		return -ENODEV;
-	}
-
-	adev = ACPI_COMPANION(dev);
-
-	/* Count number of clients to instantiate */
-	ret = i2c_acpi_client_count(adev);
-	if (ret < 0)
-		return ret;
-
-	multi = devm_kmalloc(dev, struct_size(multi, clients, ret), GFP_KERNEL);
-	if (!multi)
-		return -ENOMEM;
-
-	multi->num_clients = ret;
-
-	for (i = 0; i < multi->num_clients && inst_data[i].type; i++) {
-		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
-		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
-			 inst_data[i].type, i);
-		board_info.dev_name = name;
-		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
-		case IRQ_RESOURCE_GPIO:
-			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
-			if (ret < 0) {
-				dev_err(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
-				goto error;
-			}
-			board_info.irq = ret;
-			break;
-		case IRQ_RESOURCE_APIC:
-			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
-			if (ret < 0) {
-				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].irq_idx, ret);
-				goto error;
-			}
-			board_info.irq = ret;
-			break;
-		default:
-			board_info.irq = 0;
-			break;
-		}
-		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (IS_ERR(multi->clients[i])) {
-			ret = dev_err_probe(dev, PTR_ERR(multi->clients[i]),
-					    "Error creating i2c-client, idx %d\n", i);
-			goto error;
-		}
-	}
-	if (i < multi->num_clients) {
-		dev_err(dev, "Error finding driver, idx %d\n", i);
-		ret = -ENODEV;
-		goto error;
-	}
-
-	platform_set_drvdata(pdev, multi);
-	return 0;
-
-error:
-	while (--i >= 0)
-		i2c_unregister_device(multi->clients[i]);
-
-	return ret;
-}
-
-static int i2c_multi_inst_remove(struct platform_device *pdev)
-{
-	struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < multi->num_clients; i++)
-		i2c_unregister_device(multi->clients[i]);
-
-	return 0;
-}
-
-static const struct i2c_inst_data bsg1160_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	{ "bmg160" },
-	{}
-};
-
-static const struct i2c_inst_data bsg2150_data[]  = {
-	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
-	{ "bmc150_magn" },
-	/* The resources describe a 3th client, but it is not really there. */
-	{ "bsg2150_dummy_dev" },
-	{}
-};
-
-static const struct i2c_inst_data int3515_data[]  = {
-	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
-	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
-	{}
-};
-
-/*
- * Note new device-ids must also be added to i2c_multi_instantiate_ids in
- * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
- */
-static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
-	{ "BSG1160", (unsigned long)bsg1160_data },
-	{ "BSG2150", (unsigned long)bsg2150_data },
-	{ "INT3515", (unsigned long)int3515_data },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
-
-static struct platform_driver i2c_multi_inst_driver = {
-	.driver	= {
-		.name = "I2C multi instantiate pseudo device driver",
-		.acpi_match_table = i2c_multi_inst_acpi_ids,
-	},
-	.probe = i2c_multi_inst_probe,
-	.remove = i2c_multi_inst_remove,
-};
-module_platform_driver(i2c_multi_inst_driver);
-
-MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_LICENSE("GPL");
-- 
2.25.1

