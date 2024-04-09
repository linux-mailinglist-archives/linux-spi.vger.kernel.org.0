Return-Path: <linux-spi+bounces-2249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C789DA07
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A061F22A3B
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087E12F5A3;
	Tue,  9 Apr 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TJCcMPcD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7912F593;
	Tue,  9 Apr 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668909; cv=none; b=Gw3JHvASLo/+VMkrMMHJBlA4IjJWB5xpBEXbrmz1i55p/CNNGsAsQQpG8aB5JjqREAE4Y1Za+ko/zM4C/0Jm7b87UbYotkXJTB+BwqoWm9ru0Q7ovC6TTQUlXPcdk/2v+xIvTr2dgKAhxiHb/vRCUaAvYjY3v3l9QMANbhdU3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668909; c=relaxed/simple;
	bh=z1yjpIfaGVLJp9praoV3jgXZ8H0g9Eci4QdrTqwYnQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSI7A8I5RChYLMYNyupxaMg0h6HtEzd08oI8HrdH2iyfT3mMpsNb24GeJHCQd+uZ9z25xjtj8bVW59NvRua4oQWM7s9G2yyv0FkYV1HyNZmdPEC3bB2kDMYPIztsnhRtgjgW4jG8QAYUbO+pXOqaBWvZ14hq70/Lv8VHUK/7xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TJCcMPcD; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4396p0c4026996;
	Tue, 9 Apr 2024 08:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Rhz5LZ7KP9UURKVEBTDrQBrstG3e0z6P4A5PG//dvRQ=; b=
	TJCcMPcDGaeaCRFCV6JhQc7CbcRuSUpzPWikVpNrAtvCSuLdniMpR5qvpmw+trzo
	armxRKh1IEivlvmxUTj8wHkmaj+5fSIXibj1Gw8o3I+Aj0w0DGOlLNTnQBuIx1Cv
	ya06F43MIpMsB2ISVt3Zqrw6os7TgKPGHdhBPMtTKrfKh4kuBqDrSE8JOJpfd0nO
	ikeQiS/RI2ofrQcPUmooOpYzyjSHC7ADRikXyKR0WzTN/4bQq0KXxT51IYW6LdgV
	+dLae2IB6Vu4KDdk13FZxoGzTc3dmqReMyyJCQpaHR5bXWl0h6FRnjSDeYGcexg+
	oib4wcUyJ1d8YjB8X5F5lQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxjh3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:21:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 14:21:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 9 Apr 2024 14:21:26 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 29D02820270;
	Tue,  9 Apr 2024 13:21:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 1/3] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Tue, 9 Apr 2024 14:21:24 +0100
Message-ID: <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: QvtJ8NF0eE1IwrvLEhOybZJA7PJcuoeq
X-Proofpoint-GUID: QvtJ8NF0eE1IwrvLEhOybZJA7PJcuoeq
X-Proofpoint-Spam-Reason: safe

SPI devices can specify a cs-gpios property to enumerate their
chip selects. Under device tree, a zero entry in this property can
be used to specify that a particular chip select is using the SPI
controllers native chip select, for example:

        cs-gpios = <&gpio1 0 0>, <0>;

Here the second chip select is native. However, when using swnodes
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

Register the swnode as the gpiolib is initialised and
check in swnode_get_gpio_device if the returned node matches
swnode_gpio_undefined and return -ENOENT, which matches the behaviour
of the device tree system when it encounters a 0 phandle.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v3:
 - Add Kconfig to make swnode conditionally built
 - Add define for swnode name
 - Add custom init and exit calls
 - Use export namespaces

Thanks,
Charles

 drivers/gpio/Kconfig          |  9 +++++++++
 drivers/gpio/gpiolib-swnode.c | 38 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |  4 ++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b50d0b470849..e9b977139674 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -103,6 +103,15 @@ config GPIO_REGMAP
 	select REGMAP
 	tristate
 
+config GPIO_SWNODE_UNDEFINED
+	bool "Undefined swnode GPIOs"
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
index fa52bdb1a29a..57722d829c61 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -17,6 +17,8 @@
 #include "gpiolib.h"
 #include "gpiolib-swnode.h"
 
+#define GPIOLIB_SWNODE_UNDEFINED_NAME "swnode-gpio-undefined"
+
 static void swnode_format_propname(const char *con_id, char *propname,
 				   size_t max_size)
 {
@@ -40,6 +42,13 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Check for special node that identifies undefined GPIOs, this is
+	 * primarily used as a key for internal chip selects in SPI bindings.
+	 */
+	if (!strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
+		return ERR_PTR(-ENOENT);
+
 	gdev = gpio_device_find_by_label(gdev_node->name);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
@@ -121,3 +130,32 @@ int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 
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
+		pr_err("gpiolib: failed to register swnode: %d\n", ret);
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
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..e685fac43398 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -12,6 +12,8 @@ struct fwnode_handle;
 struct gpio_array;
 struct gpio_desc;
 
+struct software_node;
+
 /**
  * struct gpio_descs - Struct containing an array of descriptors that can be
  *                     obtained using gpiod_get_array()
@@ -54,6 +56,8 @@ enum gpiod_flags {
 	GPIOD_OUT_HIGH_OPEN_DRAIN = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_OPEN_DRAIN,
 };
 
+extern const struct software_node swnode_gpio_undefined;
+
 #ifdef CONFIG_GPIOLIB
 
 /* Return the number of GPIOs associated with a device / function */
-- 
2.39.2


