Return-Path: <linux-spi+bounces-2295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8318A0BE0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331DAB25667
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51E1428EA;
	Thu, 11 Apr 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kC6NHnwX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660513DDC3;
	Thu, 11 Apr 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826403; cv=none; b=clYvZOrruT8e8Crx15iGKD6D3RwR/htmiA8T+QlBToowAfxuuYeIxHnsvv1DKEuLFufVVw1ceMPRagaGLafC2qAIcsl5RRn1iWHMUijiLdhlCCt42yvPqSa6712dVbtYKnbuyqcMstIqfSVihgXKgBu3UBCq8ErDmuBlyF4TPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826403; c=relaxed/simple;
	bh=K4KYvJJg2q7BV66oXG0PKdR3pdDJTSOZ+dp7rML2wWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbFR/XBVVFv76PdevrTwa42+a/MLKl0gzINXMQPGW5EOG9t2qAIK3gQEzxqTnYI3du87VGRXvhsk4A1d/mSXA5+6IiZBJSGNoYifTHfnewkLayCqLUforM2ednNURp6I3bIy7UX6twdA9bVYWwCY+cM+kSZrimsGn84oA0Uxc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kC6NHnwX; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naFH004518;
	Thu, 11 Apr 2024 04:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=lH8ULuZvzTGyU/8OcNSxtvMWKC0z5j487Fx7Of18YfQ=; b=
	kC6NHnwXb3HL2hEFDVBbudeRaaVgaQlUcOa3JEf0nPNdK22uEis8XKa0e1qU0mYH
	jc6rNOR5M7UJExtvFpRlP+RAoalY69jZe2fIrV2iSy4Tv1si9P75IITBgrkSJfue
	OQ9fgHws/dYZ/2LcweC06hEflEXMhVY2bNf6bMAYoqPEahJzebxM7eColNdA5WHG
	3gHJnodOLkSK/QClDqgr0EOyoTpS3V5rokAZtpLABxMKrLOKrjwQ6/6mJkRvJguz
	PxJxyC2x5LPekIcpipvXbR8HDDSaq0dOYvFSo5zaz/9EzIMYCi6Ku6Fg7enoGvw1
	7lCWazLKcH5JoUeQVp/2Ng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq0gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 04:06:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 10:06:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 10:06:28 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6F53C820245;
	Thu, 11 Apr 2024 09:06:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v5 1/4] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Thu, 11 Apr 2024 10:06:25 +0100
Message-ID: <20240411090628.2436389-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: DGBrbU4VeBsdBtgHDggi_qglvb9X9OlF
X-Proofpoint-GUID: DGBrbU4VeBsdBtgHDggi_qglvb9X9OlF
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

Register the swnode as the gpiolib is initialised and check in
swnode_get_gpio_device() if the returned node matches
swnode_gpio_undefined and return -ENOENT, which matches the
behaviour of the device tree system when it encounters a 0 phandle.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v4:
 - Make GPIO_SWNODE_UNDEFINED not user visible
 - Minor fixes to commit message
 - Add some missing headers

Thanks,
Charles


 drivers/gpio/Kconfig          |  3 +++
 drivers/gpio/gpiolib-swnode.c | 40 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b50d0b470849..c44a6b57aefa 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -103,6 +103,9 @@ config GPIO_REGMAP
 	select REGMAP
 	tristate
 
+config GPIO_SWNODE_UNDEFINED
+	bool
+
 # put drivers in the right section, in alphabetical order
 
 # This symbol is selected by both I2C and SPI expanders
diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a..add5f8962e8d 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -6,6 +6,8 @@
  */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/property.h>
@@ -17,6 +19,8 @@
 #include "gpiolib.h"
 #include "gpiolib-swnode.h"
 
+#define GPIOLIB_SWNODE_UNDEFINED_NAME "swnode-gpio-undefined"
+
 static void swnode_format_propname(const char *con_id, char *propname,
 				   size_t max_size)
 {
@@ -40,6 +44,13 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
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
@@ -121,3 +132,32 @@ int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 
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


