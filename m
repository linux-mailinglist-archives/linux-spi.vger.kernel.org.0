Return-Path: <linux-spi+bounces-2363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022F8A67D0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCDA281106
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0F1272A8;
	Tue, 16 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eOrmRLLO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218F8664D;
	Tue, 16 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262158; cv=none; b=HOlSqV2oHcegNQ1Plk4NbbioZT4LdgC7+amJNh3MVVxeEZKKZxX+QRWrFzSQlGb6qtcPoGIYTLU74iffQ4Vl7LaM2pyDoSU6wuwY6ZqVFlHyMo3rjcEHPkBil5XCMUj1rGgW5GrMd0kzTtLBssY7+Bq7AeHlGQfSrhF0yjmn7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262158; c=relaxed/simple;
	bh=CD+TPgp3DuSwnl1o5ltbLIy69Dm8QATdMg6VvFzXEmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWRqbUgh9ejPvLSI+wEwPMu64LubPnEoO3WM2K+oiWqUFyKdskkk046XgxGFToSqry+qQ9TSIgBaj+1dVsad4JCy3wMcy+wJusWcJIwWPvnkFImUX6VPs/5mKFYC2+FWJrEess+gPV3mgZrjk5SnPKh7IlI+2n9A3U+IgBDl2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eOrmRLLO; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G2gOLu020556;
	Tue, 16 Apr 2024 05:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=f4v1A86bSkUti3Z9+VZYS0Fzwqr9QU/1PhKinMp5JFM=; b=
	eOrmRLLOsVkDrEfdGg9Gi2hhT2LDFZgChysQ3jKXIotq2sc/pYnArejVJI5DwOps
	+69VKKX7du7omXT2edkGLxp7yd80zvmrfdp8AOfb6/3SHd2OYrYgml2lJoDFG8iv
	w8pRy+uDCXlwY/7scJnjJGoCCQt3bzZM1Gq3LS9CbX20PMl6x0flcFh9onXVzEQO
	0lj/hV4vTXJZS0kXEX1vnEsW4Wy2xwbqt6iSAuLfJ/lqSOyqqATopCdCEwQwTdMx
	jHDlaFzrxjMXz/t/dQIukOtASwA7ZGHoBxkodE0kT+uUhtDfD9ussMkQislBezHE
	Z7s9GrYofpDG7V99cCp3bA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyac9p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:09:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 11:09:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 16 Apr 2024 11:09:05 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D1B66820245;
	Tue, 16 Apr 2024 10:09:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v7 1/4] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Tue, 16 Apr 2024 11:09:01 +0100
Message-ID: <20240416100904.3738093-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JXtdat0xklKbLdCrcrh6-aQ96h7jrjNr
X-Proofpoint-ORIG-GUID: JXtdat0xklKbLdCrcrh6-aQ96h7jrjNr
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v6.

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


