Return-Path: <linux-spi+bounces-2345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C68A52BF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E837CB22186
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576F745C0;
	Mon, 15 Apr 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XWftdwC0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427174BF2;
	Mon, 15 Apr 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190184; cv=none; b=iBOv88rsHynhhN0n2P/az2nRLvXW4LGv/t/cfvOnNmbNOUdfTZnHOINndraNW6t3eknGbWPRZYJNeOoo4ks9rvDztpMsUlxskNoiIDAytvG9BpoFCzDwxXVMvdvi2XYjtq9QEyoDaxBa7KmL/xxTqHtz0+0OMXFAL1Gxeos9ua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190184; c=relaxed/simple;
	bh=VubkqVunCvyrqrFZjfuqzQZPSF83H4JjX2MW6+0iZco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQWEZWbxb4E20B6WT8hYFHSboXB0i7b1zNEsg7IxTjCjjp18ZeW0j1yFp1ZUXclGdo1AKP3mckrK8+zx2jFZmW4k7318ZhXeRuZM6SlCOwh/NIj7Le9Wb6WfOE7C9zHGUEErsGPm8TVUU7AT1ldjTqTnUusAxkM+keCB95w8Q4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XWftdwC0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5v4tA010751;
	Mon, 15 Apr 2024 09:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=COzlX8fkfaEwrquhuGOS6Dm/+unUK0HwsZD7pIT8gfw=; b=
	XWftdwC0VtPYam2ifYYONpodSUybRJ4gJSOSh/hTJ1HKlPwGg9vafzi/6aa37IGq
	H9s7ZCjhNIzvECAupzo43WomRBmPcRjaCSxuBhPndYzQZIHyoFAD7fVwOR9vQBig
	sjGTd0+5i5iLXQteWD2C2O6lgf3c1HBpZ8hquyi8/eSg2pvcb9cpmSTSDdfdmRah
	imXl3R0n6mG1dUptdMoXhBdFPMxZrc58HpX5hdsd4iVfkm4MBThcTHgUdXORM0zu
	hdhDgy6CeEm/AKaZnCbrRLaTddPbjvcLsoWe9d20HKqTcOQntThtu1oGGrtjGrzb
	f+KuA9vU9hjefGDzawRtIA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhsk4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 09:09:26 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 15:09:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 15 Apr 2024 15:09:25 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1DDDC820245;
	Mon, 15 Apr 2024 14:09:25 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v6 1/4] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Mon, 15 Apr 2024 15:09:22 +0100
Message-ID: <20240415140925.3518990-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: cX6SLbLLwZPJ3Hxyajib5zlh9H5IVyGd
X-Proofpoint-GUID: cX6SLbLLwZPJ3Hxyajib5zlh9H5IVyGd
X-Proofpoint-Spam-Reason: safe

SPI devices can specify a cs-gpios property to enumerate their
chip selects. Under device tree, a zero entry in this property can
be used to specify that a particular chip select is using the SPI
controllers native chip select, for example:

        cs-gpios = <&gpio1 0 0>, <0>;

Here, the second chip select is native. However, when using swnodes
there is currently no way to specify a native chip select. The
proposal here is to register a swnode_gpio_undefined software node,
that can be specified to allow the indication of a native chip
select. For example:

static const struct software_node_ref_args device_cs_refs[] = {
	{
		.node  = &device_gpiochip_swnode,
		.nargs = 2,
		.args  = { 0, GPIO_ACTIVE_LOW },
	},
	{
		.node  = &swnode_gpio_undefined,
		.nargs = 0,
	},
};

Register the swnode as the gpiolib is initialised and check in
swnode_get_gpio_device() if the returned node matches
swnode_gpio_undefined and return -ENOENT, which matches the
behaviour of the device tree system when it encounters a 0 phandle.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Series changes since v5:
 - Add back help for GPIO_SWNODE_UNDEFINED
 - Correct some typos
 - Only check for undefined swnode if the Kconfig is set
 - Add a pr_fmt
 - Move swnode_gpio_undefined to include/linux/gpio/property.h

Thanks,
Charles

 drivers/gpio/Kconfig          |  9 +++++++
 drivers/gpio/gpiolib-swnode.c | 44 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/property.h |  4 ++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b50d0b470849..00b5c007a2bb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -103,6 +103,15 @@ config GPIO_REGMAP
 	select REGMAP
 	tristate
 
+config GPIO_SWNODE_UNDEFINED
+	bool
+	help
+	  This adds a special place holder for software nodes to contain an
+	  undefined GPIO reference, this is primarily used by SPI to allow a
+	  list of GPIO chip selects to mark a certain chip select as being
+	  controlled the SPI device's internal chip select mechanism and not
+	  a GPIO.
+
 # put drivers in the right section, in alphabetical order
 
 # This symbol is selected by both I2C and SPI expanders
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a..cec1ab878af8 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -4,8 +4,13 @@
  *
  * Copyright 2022 Google LLC
  */
+
+#define pr_fmt(fmt) "gpiolib: swnode: " fmt
+
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/property.h>
@@ -17,6 +22,8 @@
 #include "gpiolib.h"
 #include "gpiolib-swnode.h"
 
+#define GPIOLIB_SWNODE_UNDEFINED_NAME "swnode-gpio-undefined"
+
 static void swnode_format_propname(const char *con_id, char *propname,
 				   size_t max_size)
 {
@@ -40,6 +47,14 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Check for a special node that identifies undefined GPIOs, this is
+	 * primarily used as a key for internal chip selects in SPI bindings.
+	 */
+	if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
+	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
+		return ERR_PTR(-ENOENT);
+
 	gdev = gpio_device_find_by_label(gdev_node->name);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
@@ -121,3 +136,32 @@ int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 
 	return count ?: -ENOENT;
 }
+
+#if IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED)
+/*
+ * A special node that identifies undefined GPIOs, this is primarily used as
+ * a key for internal chip selects in SPI bindings.
+ */
+const struct software_node swnode_gpio_undefined = {
+	.name = GPIOLIB_SWNODE_UNDEFINED_NAME,
+};
+EXPORT_SYMBOL_NS_GPL(swnode_gpio_undefined, GPIO_SWNODE);
+
+static int __init swnode_gpio_init(void)
+{
+	int ret;
+
+	ret = software_node_register(&swnode_gpio_undefined);
+	if (ret < 0)
+		pr_err("failed to register swnode: %d\n", ret);
+
+	return ret;
+}
+subsys_initcall(swnode_gpio_init);
+
+static void __exit swnode_gpio_cleanup(void)
+{
+	software_node_unregister(&swnode_gpio_undefined);
+}
+__exitcall(swnode_gpio_cleanup);
+#endif
diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 6c75c8bd44a0..832a60c2e0b9 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -5,7 +5,11 @@
 #include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
 #include <linux/property.h>
 
+struct software_node;
+
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
 	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
 
+extern const struct software_node swnode_gpio_undefined;
+
 #endif /* __LINUX_GPIO_PROPERTY_H */
-- 
2.39.2


