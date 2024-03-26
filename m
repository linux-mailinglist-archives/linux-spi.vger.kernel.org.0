Return-Path: <linux-spi+bounces-2008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95888C4C7
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C832C1F66859
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6D80059;
	Tue, 26 Mar 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gio7s8YJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51E7868B;
	Tue, 26 Mar 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462289; cv=none; b=RRkdYlChrHPpMphjHULRJngXUMz5P/TPyNqjvUcioycFuK6Y91FT1V9dOaAigjh7qDVwf3HantmtXsOjRgg1CaRjaLFu3FvthBHExC0HuBnPQe/mGOnO40IXoNVk2RajTqMNMOCwFy1A/pYhAOvC0DWjeezDDQvT5189eECo5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462289; c=relaxed/simple;
	bh=PG0wAgADiIlosGIwLe7lmg3misXuUzIWoVdudTZr5u8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ2y9GzT/kt/nklDOOjqTNMb6wTAcRN2JgD+Sq4UzFEwyPg2r3+tRti7EvTkOlEDfbZM/+DXv9wRq6Pekjcif/KmkMuPkn+A02daVUwEYQUJ1/DqY2G0sR0D2Z3PX8iVrF3l1S8fUKMiCV208AlxxCoZGHA9zF3do7erRWoc954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gio7s8YJ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q5N4lC025675;
	Tue, 26 Mar 2024 09:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Oa9RMXyFQyvDRTYAufadJrjMNSL+muJ4voyz0aQjTVY=; b=
	gio7s8YJcscQgaj7nFV+v6oS9GvGvb4Z9R3gmPGMd6DpO+7dcIWHturpgpLdPRek
	cPI891L+6/lQlKH+S8ulE6RekReXz6XfsHamJqyNu2KT8HdipKlXwLFfBJfwfUOZ
	IRh6OGSiC1oYBmbByopCqMcEEcWrSQ8wsb/ZbNjLo92N4g/iTokWkBUdonWpq+aI
	qAocHD3TOiPruZDNHnJO+qI213nTZrsnv8LZ8j+2oVVeBVimV9OtGyabnAll4COE
	3yqeKV6E8SPVwXDFvYyk/OXRvc1PO7zBlPEXQRvIuNluAvDGOqcleWoi/wMnrU+z
	lCrlRLW3+lxSIZU/H6SeDw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfydawa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:11:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Mar
 2024 14:11:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Tue, 26 Mar 2024 14:11:08 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 92DCF82024D;
	Tue, 26 Mar 2024 14:11:08 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/3] gpio: swnode: Add ability to specify native chip selects for SPI
Date: Tue, 26 Mar 2024 14:11:06 +0000
Message-ID: <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: UbCSCGn9bifaR6cxmF6f9JpOzaLQvWCU
X-Proofpoint-GUID: UbCSCGn9bifaR6cxmF6f9JpOzaLQvWCU
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
 drivers/gpio/gpiolib-swnode.c | 8 ++++++++
 drivers/gpio/gpiolib.c        | 9 +++++++++
 include/linux/gpio/consumer.h | 4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a..801b5a660307 100644
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
index ce94e37bcbee..e3a7e2a3a323 100644
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


