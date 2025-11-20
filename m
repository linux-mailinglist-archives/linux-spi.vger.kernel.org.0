Return-Path: <linux-spi+bounces-11407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA95C74433
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86713353A06
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFE33A708;
	Thu, 20 Nov 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0uYfHLY4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C933C1A5
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645072; cv=none; b=tX4LjOcV0z2Hu9c0xhtaldusfKO3YrgmdRf0dRsgGNYjbxZN7pLTQVM2GnPCqDCAqZB7PzoMluCrn1pp8SZGnzAF45EjrutjKefr0LX8S2VKV/Z5IlHPoe9m11KxsnrraYq3sZBAQ0J1spwx8HmT9TifoaICKTdw5VxQnfas/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645072; c=relaxed/simple;
	bh=aZ73W3YHGMU6xBUkukDk+WxhhQlc8F45xSk2D12rMD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NET6yVhQnE6Pm+0jT55HHEw88KysZBJ7c1L02XRwMQFWFBZw8cYlV+1ZNu7UUBD7w2RAJMvSfp6uD/XCRVxRwy2GIaj706xgwKr2/jVWa0bYkBqYXjMSp9dTYrRgpyJXxl657DnFHEIjh/JsO/u3aU/OHSDShmihlVxMCTUexY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0uYfHLY4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6697345e9.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645064; x=1764249864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8PxX49w5EzD4UFdp7KS/r9tDFhJ08WKJg91+BqmaAY=;
        b=0uYfHLY43FJDmE/SOb/HZKj+RXb0Uku8tf2XRiML3LAsoRZve1/nwwB4lzq1q8f0/j
         08JmnjD/ebPJocbIWHiDVstkScr1agn5jJv2JqKWDSx7Yu9Bv0knLY4AtQVClppR5IZ3
         CzveYHyAtsSUzVfCWzUfdObS4dhDIO46GCa1OAoCt32FkAoic+g3WYWo3PNsIWEmb2tb
         BJ78HhazpTEU9VqflHg9uugbwMLKVn5lY+hnjgqPd0z23vrbHywxJTknva98MVxfdNLU
         ioNj285srjUB7HOPeX2/XYAu+o9pukJOPGB4YSSiFqiyCwaVwQ9g9VmjXe8PGalwlw9j
         JroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645064; x=1764249864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8PxX49w5EzD4UFdp7KS/r9tDFhJ08WKJg91+BqmaAY=;
        b=omIiIlPy0m2O830/Pqobc+KcXa7GiDDLNO+Zw9SN/sY8CNZk2owrboTorVxiv5gb2R
         96t0D8BKW3Jj9r3xqaw+YTf8MQhdqfkqM2S5Im2u5JEWJD+yK/zUz8lWwxUpy3ZZF6SR
         nQBRq5sE1n8aLQFmjrwSk0MTkHJcn+yrt3UfgzQEZxS/N3wyWtK1X2SSa5VRvtItaWY3
         g+wnuliD0Dsd37FAktSHkCGx5qudFZ4SrHwPA5om0HM7ppPrJZEaMxUBMIuYgUsf0fK8
         O1ZgD7DXzPWGwKcygv+OZMyTC8B13T6KiT0GNe63tHXjWMD4y+Gu5WmRZovKNdS7Tgfo
         pSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVcKJ5rxktLeudGzzhkV2sOtDTGatQ8SQrrmJ5MnIGJ9XFOZQWmhjVPHiQ5GgFBzBKW5RajH8MSTYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9ATRK27WShoi5Ocr7/tyIEma2JCgNzGXxtubs/yvcf6q60TC
	eC0Q0upEW/MSZEz16SsneaJ0yrOCAtRUpRDHfopt4yeNlIIUhwqaY+AiMXUOIN0kHWg=
X-Gm-Gg: ASbGncu94KvhdIaURGIF4oIDbwMGxYC88TBvzmTfUHYUOkICeMAtUE590YCCbIAcbdO
	eXTXr+FVAjZHXDI+VmYvszAttapZZz1f02slJ2lYBIfTNeruT+CywmwtWrrEUNGSqKhmeno/UOM
	+vrnPllVKEol810SeXwWr5y0Cr8kQ3X9///4p/qupfV2wdro9xINfj7mNZ6vtXjuC820LzsTfv8
	mOGleAEj131itW8HzkzrM8MlaYBEAgZ0D3ijZxFOo8Moelj3cj3fJ4vb1X7EBrzKbZkZlkrEbja
	ACUq+5QontWDGmG9GxsAtVptKoZL8JSDNWX3ynCXa8ECAKvL3sZninmkIAZeNsX+HR1Y7t0U49e
	u9pXfzg4DThd5xF/Oc8YkFBTsmbQJzanMjJT9/PZ0+r8oWKV4TNP+RS76ja/LPTF1XEIHdzaQHV
	nShOk=
X-Google-Smtp-Source: AGHT+IEPrIuvvvNMQFwqIyjWYN4SQgSzWiJ7h+dcP18/s+37GPMsHprp+4ehD4s+zAvJdXC3SMQrZQ==
X-Received: by 2002:a05:600c:1549:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-477b8a8a611mr29954055e9.22.1763645063647;
        Thu, 20 Nov 2025 05:24:23 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:24:04 +0100
Subject: [PATCH v7 9/9] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-9-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7100;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LjGY9Q7mtS01FVXkHDotI+zXY3Fvxr3o/OlPgyLk0TI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZ14gj5DrBF7BjfQSYkrPkMGdchXL7C84cpA
 KldwESHuaaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WdQAKCRAFnS7L/zaE
 w0XKEACEAckJGFkSrLISJsfqUyT4xiT9YfJMF2gB9kxRNAxwghciygZ9f7VnTqHyPNatoNhoiw1
 E4FHBgWoklBQfqNMPdNoS4RdB8d1nFYv4pen1wZ3pA814x5/Zx4S9qC+L/xqiibxLN6MrfW8LMy
 6WHIQ1P5B4yUmpZI1A1DqFMv5upZ35nbbKyDLa8yRxjuROC+Nt75mYI9mxwWlSvvcoVqu1OGqG2
 mHUWjUrU8JzKMw+R7NXKm3gV1fyn7qJNrIMd1GspbBlPSv0hga5fC25ZZw5EMFWZ9WFeNyGSMlH
 Z6yG/tZJHsUxKs1SPAHy4F+92oJ3jPNEPJfImCDEEsMGVgxoo5IcV2wGvVw+6/puCLagj+zTNaT
 wpey8oRdiAZ8XXSFCGJmpj/8cETs0mtAyXTV1eoBduLE+pAyglmdcurRcPkY1acTFK9xVZp1G4m
 1gt3Ux14aD3BaTFEjUnWfzrtFw0cYwpZDQQvjo5McStw2E5JkAvvChn7PH36+sKqKf+bpjwliTY
 asDaM2+Jn6np80FewW2ZmGgfSSL5osa0R84Uhq3TsawQxqB29OMN1GHbVXuNmJO7S3EbAdBusjP
 fMIfEls4PbOZYNd+6564Cvf46pp2hZxWYXIAiJI0uKqg+516JCILSzGl5cTmKkdMju8ggW1FU6T
 z6r0OwGdtHBUKsA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO machine lookup is a nice mechanism for associating GPIOs with
consumers if we don't know what kind of device the GPIO provider is or
when it will become available. However in the case of the reset-gpio, we
are already holding a reference to the device and so can reference its
firmware node. Let's setup a software node that references the relevant
GPIO and attach it to the auxiliary device we're creating.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 127 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 53 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 1f5f8d85dc16142da3e3a9988f2737c83550cb2f..0135dd0ae20498396fdb5a682f913b6048cb5750 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -74,10 +75,12 @@ struct reset_control_array {
 /**
  * struct reset_gpio_lookup - lookup key for ad-hoc created reset-gpio devices
  * @of_args: phandle to the reset controller with all the args like GPIO number
+ * @swnode: Software node containing the reference to the GPIO provider
  * @list: list entry for the reset_gpio_lookup_list
  */
 struct reset_gpio_lookup {
 	struct of_phandle_args of_args;
+	struct fwnode_handle *swnode;
 	struct list_head list;
 };
 
@@ -819,52 +822,45 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
-					 struct device_node *np,
-					 unsigned int gpio,
-					 unsigned int of_flags)
+static void reset_gpio_aux_device_release(struct device *dev)
 {
-	unsigned int lookup_flags;
-	const char *label_tmp;
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
-	/*
-	 * Later we map GPIO flags between OF and Linux, however not all
-	 * constants from include/dt-bindings/gpio/gpio.h and
-	 * include/linux/gpio/machine.h match each other.
-	 */
-	if (of_flags > GPIO_ACTIVE_LOW) {
-		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
-		       of_flags, gpio);
-		return -EINVAL;
+	kfree(adev);
+}
+
+static int reset_add_gpio_aux_device(struct device *parent,
+				     struct fwnode_handle *swnode,
+				     int id, void *pdata)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->id = id;
+	adev->name = "gpio";
+	adev->dev.parent = parent;
+	adev->dev.platform_data = pdata;
+	adev->dev.release = reset_gpio_aux_device_release;
+	device_set_node(&adev->dev, swnode);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ret;
 	}
 
-	label_tmp = gpio_device_get_label(gdev);
-	if (!label_tmp)
-		return -EINVAL;
+	ret = __auxiliary_device_add(adev, "reset");
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		kfree(adev);
+		return ret;
+	}
 
-	char *label __free(kfree) = kstrdup(label_tmp, GFP_KERNEL);
-	if (!label)
-		return -ENOMEM;
-
-	/* Size: one lookup entry plus sentinel */
-	struct gpiod_lookup_table *lookup __free(kfree) = kzalloc(struct_size(lookup, table, 2),
-								  GFP_KERNEL);
-	if (!lookup)
-		return -ENOMEM;
-
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
-	if (!lookup->dev_id)
-		return -ENOMEM;
-
-	lookup_flags = GPIO_PERSISTENT;
-	lookup_flags |= of_flags & GPIO_ACTIVE_LOW;
-	lookup->table[0] = GPIO_LOOKUP(no_free_ptr(label), gpio, "reset",
-				       lookup_flags);
-
-	/* Not freed on success, because it is persisent subsystem data. */
-	gpiod_add_lookup_table(no_free_ptr(lookup));
-
-	return 0;
+	return ret;
 }
 
 /*
@@ -872,8 +868,10 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
  */
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
+	struct property_entry properties[2] = { };
+	unsigned int offset, of_flags, lflags;
 	struct reset_gpio_lookup *rgpio_dev;
-	struct auxiliary_device *adev;
+	struct device *parent;
 	int id, ret;
 
 	/*
@@ -892,6 +890,23 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	offset = args->args[0];
+	of_flags = args->args[1];
+
+	/*
+	 * Later we map GPIO flags between OF and Linux, however not all
+	 * constants from include/dt-bindings/gpio/gpio.h and
+	 * include/linux/gpio/machine.h match each other.
+	 *
+	 * FIXME: Find a better way of translating OF flags to GPIO lookup
+	 * flags.
+	 */
+	if (of_flags > GPIO_ACTIVE_LOW) {
+		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
+		       of_flags, offset);
+		return -EINVAL;
+	}
+
 	struct gpio_device *gdev __free(gpio_device_put) =
 		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
 	if (!gdev)
@@ -906,6 +921,10 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+	parent = gpio_device_to_device(gdev);
+	properties[0] = PROPERTY_ENTRY_GPIO("reset-gpios", parent->fwnode, offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -917,11 +936,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
-					    args->args[1]);
-	if (ret < 0)
-		goto err_kfree;
-
 	rgpio_dev->of_args = *args;
 	/*
 	 * We keep the device_node reference, but of_args.np is put at the end
@@ -929,19 +943,26 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
-				       "gpio", &rgpio_dev->of_args, id);
-	ret = PTR_ERR_OR_ZERO(adev);
+
+	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
+	if (IS_ERR(rgpio_dev->swnode)) {
+		ret = PTR_ERR(rgpio_dev->swnode);
+		goto err_put_of_node;
+	}
+
+	ret = reset_add_gpio_aux_device(parent, rgpio_dev->swnode, id,
+					&rgpio_dev->of_args);
 	if (ret)
-		goto err_put;
+		goto err_del_swnode;
 
 	list_add(&rgpio_dev->list, &reset_gpio_lookup_list);
 
 	return 0;
 
-err_put:
+err_del_swnode:
+	fwnode_remove_software_node(rgpio_dev->swnode);
+err_put_of_node:
 	of_node_put(rgpio_dev->of_args.np);
-err_kfree:
 	kfree(rgpio_dev);
 err_ida_free:
 	ida_free(&reset_gpio_ida, id);

-- 
2.51.0


