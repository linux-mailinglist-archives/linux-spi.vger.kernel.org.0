Return-Path: <linux-spi+bounces-2077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FE890106
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A188CB22C2D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2E57895;
	Thu, 28 Mar 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="K/LUO2/L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424E847C;
	Thu, 28 Mar 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634494; cv=none; b=gMd53HRQTZkl2rXdsXFUyf54hsPcfIzETMSUDEZW1tIZ+yuEPX/GFlrXoOP1Ww5GZnwxYAi1BvFVt+cI+oyijF06t+x2yGfCBsTwOB/RbIe4PlRDsBUok7pkJXv9GQU68qAh8NiMpAKEeG+Mq3eAz+7rQwDWVlZTKueQFBEoZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634494; c=relaxed/simple;
	bh=0E4sclIuWxxvRcboXZ9VBO3TzkiK9KWVot98fwVOPBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFksGHQ6CCrLJoOuOSlssYwaFyl5c6nIoFOIF7OHHokzr4I5ImG3S3sJPnTv1O2JXWioC5DJF4K2FQIaVd0h/E9cSguSHJX9hIYz/omcbeft1rSIq/LwhuZVcM1FnhxE7ejar/0N2RhKIuhpaHAhYdgN1OqjY8kSCxck7Y3nYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=K/LUO2/L; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SCxqrc012070;
	Thu, 28 Mar 2024 09:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=efdIDRMFkjfkwtxgpobaEbduuanmmZbHzPl6Zn/Y3js=; b=
	K/LUO2/LuK3/1W7HOhWd/dbsl9nbacfwv9LSAs6Wz4QvI+YLyD25njAcmj1uQuTL
	+nem5T1BqGWZy5aOHgLfmFQ0Frr8zBqZxkl2c3C/2S7zVvRRmNAN9LiwaW+GCMsk
	2A4yCjADMGM6iMfrmVeeBQ0pn440u0bH8TIYhe34Gv0x0qeYJc5osBTym2M85FQj
	BlmWzhzWEzOEiRvCA0DCrpIf/DL+0kaPGv+eA03gWy1luZaX/zBr9o91CvHy+tto
	WqIFypo29+N/TKvMnXjA5VWpCveLz8xrtw9zix2LgmupGVZjO6tPrDJC/GuKdduo
	EEUctLVAyOZCsNkKbTCdMQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x4et832uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:01:21 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Mar
 2024 14:01:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 28 Mar 2024 14:01:19 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 531D5820244;
	Thu, 28 Mar 2024 14:01:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/3] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Thu, 28 Mar 2024 14:01:17 +0000
Message-ID: <20240328140119.1784350-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: MMksPHF7iaiS_n_XyE8O9eYQgdxRCY0M
X-Proofpoint-ORIG-GUID: MMksPHF7iaiS_n_XyE8O9eYQgdxRCY0M
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

No changes since v1.

Thanks,
Charles

 drivers/gpio/gpiolib-swnode.c | 8 ++++++++
 drivers/gpio/gpiolib.c        | 9 +++++++++
 include/linux/gpio/consumer.h | 4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a3..801b5a660307f 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -17,6 +17,11 @@
 #include "gpiolib.h"
 #include "gpiolib-swnode.h"
 
+const struct software_node swnode_gpio_undefined = {
+	.name = "gpio-internal-undefined",
+};
+EXPORT_SYMBOL_GPL(swnode_gpio_undefined);
+
 static void swnode_format_propname(const char *con_id, char *propname,
 				   size_t max_size)
 {
@@ -40,6 +45,9 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
+	if (!strcmp(gdev_node->name, "gpio-internal-undefined"))
+		return ERR_PTR(-ENOENT);
+
 	gdev = gpio_device_find_by_label(gdev_node->name);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce94e37bcbee7..e3a7e2a3a323e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4892,8 +4892,17 @@ DEFINE_SEQ_ATTRIBUTE(gpiolib);
 
 static int __init gpiolib_debugfs_init(void)
 {
+	int ret;
+
+	ret = software_node_register(&swnode_gpio_undefined);
+	if (ret < 0) {
+		pr_err("gpiolib: failed to register swnode: %d\n", ret);
+		return ret;
+	}
+
 	/* /sys/kernel/debug/gpio */
 	debugfs_create_file("gpio", 0444, NULL, NULL, &gpiolib_fops);
+
 	return 0;
 }
 subsys_initcall(gpiolib_debugfs_init);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edbd..e685fac43398d 100644
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


