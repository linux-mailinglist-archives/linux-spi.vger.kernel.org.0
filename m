Return-Path: <linux-spi+bounces-7112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7CA5F225
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EE23BD981
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61556266581;
	Thu, 13 Mar 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OB4jeFYg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BD26657C;
	Thu, 13 Mar 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864489; cv=none; b=iMnvxcEy0746Kbm/kQmSykMJYVEzIl15DsktTDFYN6EPqGUxkBr2LWfrDkRqD1Rv0ysOiarHV3ASDMgzCY9OEdt79g5G/mkZWf/8q+tEjU36AOsr4/SsYKwB9PQAlLkxk5ipriSy89oyj+oCiKPGeMUzdWDt9ihhKWSee2HqVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864489; c=relaxed/simple;
	bh=dlDkx+mPCZivo5gYY65qcyMk8QnTyaoiJ8QBzsOVVGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/ddI6FUXc/7Epy+Yu/E4XcVtdkYTWNOxrzp9B32QRVZ9rHiaFqORZ1473szAibC6h0UorgoYd4p53CIV1ozlXXq88BjJy+r/kJ5bHqJ5iRgO4ZW1ODXtD5xKLrZS0V/MGeG9Cm0Km6ceG8Qp2qZgngj6ra993zDyybByFWW5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OB4jeFYg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864487; x=1773400487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dlDkx+mPCZivo5gYY65qcyMk8QnTyaoiJ8QBzsOVVGA=;
  b=OB4jeFYgWbIzw7IYEJEL6B9KDleWRd3CLf7ORw6fwqxL17IQalPx3E85
   iJ7VAYNNMV7vdUYs4qpGWZKjvjWcgU/Vklh2L4HvTYIZJQI5Hd2S1LcHh
   WlJ63u2zf58SzqeDjMKi/gAztw+1WIsNP1MqG/tAgZ/zpRzO+GCuD7nRM
   mqnMRH6RIOMHe9A0AqI3MgXIzT8HeI29XDa2WPqG6hXXtIbfynHibSigZ
   Jdbp0ipGpl222ztTheK9byrN7yTnFKkrK2PaF+hUCCvJP7pH3ArnQl0fn
   E53Gz5xZCG/XL3VT4sb+Lq2mOIdBpwa6Ceb3un+0fz4ij85Up1ntCG+L1
   Q==;
X-CSE-ConnectionGUID: EoqktvDeScm20c4L51N4Dw==
X-CSE-MsgGUID: yriwrbg2QpiQmIDY8jKzjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="68329357"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="68329357"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:14:46 -0700
X-CSE-ConnectionGUID: zTHF6EZaQ3ey8sTqABBp5A==
X-CSE-MsgGUID: wddYvlqFRxKJ5Y7SO1zX2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="158081717"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 13 Mar 2025 04:14:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4CDCE1FC; Thu, 13 Mar 2025 13:14:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 1/1] spi: Use inclusive language
Date: Thu, 13 Mar 2025 13:14:42 +0200
Message-ID: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "master" by "[host] controller" in the SPI core code and comments.
All the similar to the "slave" by "target [device]" changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       | 96 ++++++++++++++++++++---------------------
 include/linux/spi/spi.h | 34 +++++++--------
 2 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1f7e2551f5d4..78003cf30244 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,7 +43,7 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
-static DEFINE_IDR(spi_master_idr);
+static DEFINE_IDR(spi_controller_idr);
 
 static void spidev_release(struct device *dev)
 {
@@ -306,7 +306,7 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
-static const struct attribute_group *spi_master_groups[] = {
+static const struct attribute_group *spi_controller_groups[] = {
 	&spi_controller_statistics_group,
 	NULL,
 };
@@ -1107,7 +1107,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 					spi_toggle_csgpiod(spi, idx, enable, activate);
 			}
 		}
-		/* Some SPI masters need both GPIO CS & slave_select */
+		/* Some SPI controllers need both GPIO CS & ->set_cs() */
 		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
 		    spi->controller->set_cs)
 			spi->controller->set_cs(spi, !enable);
@@ -2511,7 +2511,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
  * @ctlr:	Pointer to spi_controller device
  *
  * Registers an spi_device for each child node of controller node which
- * represents a valid SPI slave.
+ * represents a valid SPI target device.
  */
 static void of_register_spi_devices(struct spi_controller *ctlr)
 {
@@ -2796,7 +2796,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
 	    device_match_acpi_handle(lookup.ctlr->dev.parent, parent_handle)) {
-		/* Apple does not use _CRS but nested devices for SPI slaves */
+		/* Apple does not use _CRS but nested devices for SPI target devices */
 		acpi_spi_parse_apple_properties(adev, &lookup);
 	}
 
@@ -2888,7 +2888,7 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
 				     SPI_ACPI_ENUMERATE_MAX_DEPTH,
 				     acpi_spi_add_device, NULL, ctlr, NULL);
 	if (ACPI_FAILURE(status))
-		dev_warn(&ctlr->dev, "failed to enumerate SPI slaves\n");
+		dev_warn(&ctlr->dev, "failed to enumerate SPI target devices\n");
 }
 #else
 static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
@@ -2902,16 +2902,15 @@ static void spi_controller_release(struct device *dev)
 	kfree(ctlr);
 }
 
-static const struct class spi_master_class = {
+static const struct class spi_controller_class = {
 	.name		= "spi_master",
 	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_master_groups,
+	.dev_groups	= spi_controller_groups,
 };
 
 #ifdef CONFIG_SPI_SLAVE
 /**
- * spi_target_abort - abort the ongoing transfer request on an SPI slave
- *		     controller
+ * spi_target_abort - abort the ongoing transfer request on an SPI target controller
  * @spi: device used for the current transfer
  */
 int spi_target_abort(struct spi_device *spi)
@@ -2952,13 +2951,13 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 
 	child = device_find_any_child(&ctlr->dev);
 	if (child) {
-		/* Remove registered slave */
+		/* Remove registered target device */
 		device_unregister(child);
 		put_device(child);
 	}
 
 	if (strcmp(name, "(null)")) {
-		/* Register new slave */
+		/* Register new target device */
 		spi = spi_alloc_device(ctlr);
 		if (!spi)
 			return -ENOMEM;
@@ -2977,40 +2976,40 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(slave);
 
-static struct attribute *spi_slave_attrs[] = {
+static struct attribute *spi_target_attrs[] = {
 	&dev_attr_slave.attr,
 	NULL,
 };
 
-static const struct attribute_group spi_slave_group = {
-	.attrs = spi_slave_attrs,
+static const struct attribute_group spi_target_group = {
+	.attrs = spi_target_attrs,
 };
 
-static const struct attribute_group *spi_slave_groups[] = {
+static const struct attribute_group *spi_target_groups[] = {
 	&spi_controller_statistics_group,
-	&spi_slave_group,
+	&spi_target_group,
 	NULL,
 };
 
-static const struct class spi_slave_class = {
+static const struct class spi_target_class = {
 	.name		= "spi_slave",
 	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_slave_groups,
+	.dev_groups	= spi_target_groups,
 };
 #else
-extern struct class spi_slave_class;	/* dummy */
+extern struct class spi_target_class;	/* dummy */
 #endif
 
 /**
- * __spi_alloc_controller - allocate an SPI master or slave controller
+ * __spi_alloc_controller - allocate an SPI host or target controller
  * @dev: the controller, possibly using the platform_bus
  * @size: how much zeroed driver-private data to allocate; the pointer to this
  *	memory is in the driver_data field of the returned device, accessible
  *	with spi_controller_get_devdata(); the memory is cacheline aligned;
  *	drivers granting DMA access to portions of their private data need to
  *	round up @size using ALIGN(size, dma_get_cache_alignment()).
- * @slave: flag indicating whether to allocate an SPI master (false) or SPI
- *	slave (true) controller
+ * @target: flag indicating whether to allocate an SPI host (false) or SPI target (true)
+ *	controller
  * Context: can sleep
  *
  * This call is used only by SPI controller drivers, which are the
@@ -3027,7 +3026,7 @@ extern struct class spi_slave_class;	/* dummy */
  * Return: the SPI controller structure on success, else NULL.
  */
 struct spi_controller *__spi_alloc_controller(struct device *dev,
-					      unsigned int size, bool slave)
+					      unsigned int size, bool target)
 {
 	struct spi_controller	*ctlr;
 	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
@@ -3048,11 +3047,11 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
-	ctlr->slave = slave;
-	if (IS_ENABLED(CONFIG_SPI_SLAVE) && slave)
-		ctlr->dev.class = &spi_slave_class;
+	ctlr->target = target;
+	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
+		ctlr->dev.class = &spi_target_class;
 	else
-		ctlr->dev.class = &spi_master_class;
+		ctlr->dev.class = &spi_controller_class;
 	ctlr->dev.parent = dev;
 	pm_suspend_ignore_children(&ctlr->dev, true);
 	spi_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
@@ -3070,7 +3069,7 @@ static void devm_spi_release_controller(struct device *dev, void *ctlr)
  * __devm_spi_alloc_controller - resource-managed __spi_alloc_controller()
  * @dev: physical device of SPI controller
  * @size: how much zeroed driver-private data to allocate
- * @slave: whether to allocate an SPI master (false) or SPI slave (true)
+ * @target: whether to allocate an SPI host (false) or SPI target (true) controller
  * Context: can sleep
  *
  * Allocate an SPI controller and automatically release a reference on it
@@ -3083,7 +3082,7 @@ static void devm_spi_release_controller(struct device *dev, void *ctlr)
  */
 struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
-						   bool slave)
+						   bool target)
 {
 	struct spi_controller **ptr, *ctlr;
 
@@ -3092,7 +3091,7 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 	if (!ptr)
 		return NULL;
 
-	ctlr = __spi_alloc_controller(dev, size, slave);
+	ctlr = __spi_alloc_controller(dev, size, target);
 	if (ctlr) {
 		ctlr->devm_allocated = true;
 		*ptr = ctlr;
@@ -3106,8 +3105,8 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 EXPORT_SYMBOL_GPL(__devm_spi_alloc_controller);
 
 /**
- * spi_get_gpio_descs() - grab chip select GPIOs for the master
- * @ctlr: The SPI master to grab GPIO descriptors for
+ * spi_get_gpio_descs() - grab chip select GPIOs for the controller
+ * @ctlr: The SPI controller to grab GPIO descriptors for
  */
 static int spi_get_gpio_descs(struct spi_controller *ctlr)
 {
@@ -3205,7 +3204,7 @@ static int spi_controller_id_alloc(struct spi_controller *ctlr, int start, int e
 	int id;
 
 	mutex_lock(&board_lock);
-	id = idr_alloc(&spi_master_idr, ctlr, start, end, GFP_KERNEL);
+	id = idr_alloc(&spi_controller_idr, ctlr, start, end, GFP_KERNEL);
 	mutex_unlock(&board_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -3354,7 +3353,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	spi_destroy_queue(ctlr);
 free_bus_id:
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, ctlr->bus_num);
+	idr_remove(&spi_controller_idr, ctlr->bus_num);
 	mutex_unlock(&board_lock);
 	return status;
 }
@@ -3366,8 +3365,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_spi_register_controller - register managed SPI host or target
- *	controller
+ * devm_spi_register_controller - register managed SPI host or target controller
  * @dev:    device managing SPI controller
  * @ctlr: initialized controller, originally from spi_alloc_host() or
  *	spi_alloc_target()
@@ -3407,7 +3405,7 @@ static int __unregister(struct device *dev, void *null)
 }
 
 /**
- * spi_unregister_controller - unregister SPI master or slave controller
+ * spi_unregister_controller - unregister SPI host or target controller
  * @ctlr: the controller being unregistered
  * Context: can sleep
  *
@@ -3431,7 +3429,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
-	found = idr_find(&spi_master_idr, id);
+	found = idr_find(&spi_controller_idr, id);
 	mutex_unlock(&board_lock);
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
@@ -3446,7 +3444,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	/* Free bus id */
 	mutex_lock(&board_lock);
 	if (found == ctlr)
-		idr_remove(&spi_master_idr, id);
+		idr_remove(&spi_controller_idr, id);
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
@@ -4599,7 +4597,7 @@ EXPORT_SYMBOL_GPL(spi_sync_locked);
 
 /**
  * spi_bus_lock - obtain a lock for exclusive SPI bus usage
- * @ctlr: SPI bus master that should be locked for exclusive bus access
+ * @ctlr: SPI bus controller that should be locked for exclusive bus access
  * Context: can sleep
  *
  * This call may only be used from a context that may sleep.  The sleep
@@ -4630,7 +4628,7 @@ EXPORT_SYMBOL_GPL(spi_bus_lock);
 
 /**
  * spi_bus_unlock - release the lock for exclusive SPI bus usage
- * @ctlr: SPI bus master that was locked for exclusive bus access
+ * @ctlr: SPI bus controller that was locked for exclusive bus access
  * Context: can sleep
  *
  * This call may only be used from a context that may sleep.  The sleep
@@ -4747,9 +4745,9 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_master_class, node);
+	dev = class_find_device_by_of_node(&spi_controller_class, node);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_slave_class, node);
+		dev = class_find_device_by_of_node(&spi_target_class, node);
 	if (!dev)
 		return NULL;
 
@@ -4829,10 +4827,10 @@ struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev
 {
 	struct device *dev;
 
-	dev = class_find_device(&spi_master_class, NULL, adev,
+	dev = class_find_device(&spi_controller_class, NULL, adev,
 				spi_acpi_controller_match);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device(&spi_slave_class, NULL, adev,
+		dev = class_find_device(&spi_target_class, NULL, adev,
 					spi_acpi_controller_match);
 	if (!dev)
 		return NULL;
@@ -4902,12 +4900,12 @@ static int __init spi_init(void)
 	if (status < 0)
 		goto err1;
 
-	status = class_register(&spi_master_class);
+	status = class_register(&spi_controller_class);
 	if (status < 0)
 		goto err2;
 
 	if (IS_ENABLED(CONFIG_SPI_SLAVE)) {
-		status = class_register(&spi_slave_class);
+		status = class_register(&spi_target_class);
 		if (status < 0)
 			goto err3;
 	}
@@ -4920,7 +4918,7 @@ static int __init spi_init(void)
 	return 0;
 
 err3:
-	class_unregister(&spi_master_class);
+	class_unregister(&spi_controller_class);
 err2:
 	bus_unregister(&spi_bus_type);
 err1:
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 056c3834c720..a45413dee88b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -49,7 +49,7 @@ struct spi_offload_config;
 struct spi_transfer;
 
 /*
- * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
+ * INTERFACES between SPI controller-side drivers and SPI target protocol handlers,
  * and SPI infrastructure.
  */
 extern const struct bus_type spi_bus_type;
@@ -144,7 +144,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
 						  struct spi_transfer *xfer);
 
 /**
- * struct spi_device - Controller side proxy for an SPI slave device
+ * struct spi_device - Controller side proxy for an SPI target device
  * @dev: Driver model representation of the device.
  * @controller: SPI controller used with the device.
  * @max_speed_hz: Maximum clock rate to be used with this chip
@@ -188,7 +188,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @pcpu_statistics: statistics for the spi_device
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  *
- * A @spi_device is used to interchange data between an SPI slave
+ * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
  *
  * In @dev, the platform_data is used to hold information about this
@@ -402,15 +402,15 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
 			spi_unregister_driver)
 
 /**
- * struct spi_controller - interface to SPI master or slave controller
+ * struct spi_controller - interface to SPI host or target controller
  * @dev: device interface to this driver
  * @list: link with the global spi_controller list
  * @bus_num: board-specific (and often SOC-specific) identifier for a
  *	given SPI controller.
  * @num_chipselect: chipselects are used to distinguish individual
- *	SPI slaves, and are numbered from zero to num_chipselects.
- *	each slave has a chipselect signal, but it's common that not
- *	every chipselect is connected to a slave.
+ *	SPI targets, and are numbered from zero to num_chipselects.
+ *	each target has a chipselect signal, but it's common that not
+ *	every chipselect is connected to a target.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -439,9 +439,9 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	must fail if an unrecognized or unsupported mode is requested.
  *	It's always safe to call this unless transfers are pending on
  *	the device whose settings are being modified.
- * @set_cs_timing: optional hook for SPI devices to request SPI master
+ * @set_cs_timing: optional hook for SPI devices to request SPI
  * controller for configuring specific CS setup time, hold time and inactive
- * delay interms of clock counts
+ * delay in terms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
@@ -561,7 +561,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *
  * The driver for an SPI controller manages access to those devices through
  * a queue of spi_message transactions, copying data between CPU memory and
- * an SPI slave device.  For each such message it queues, it calls the
+ * an SPI target device.  For each such message it queues, it calls the
  * message's completion function when the transaction completes.
  */
 struct spi_controller {
@@ -611,7 +611,7 @@ struct spi_controller {
 #define SPI_CONTROLLER_NO_TX		BIT(2)	/* Can't do buffer write */
 #define SPI_CONTROLLER_MUST_RX		BIT(3)	/* Requires rx */
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
-#define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
+#define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS must select target device */
 #define SPI_CONTROLLER_SUSPENDED	BIT(6)	/* Currently suspended */
 	/*
 	 * The spi-controller has multi chip select capability and can
@@ -678,7 +678,7 @@ struct spi_controller {
 	 * + To a given spi_device, message queueing is pure FIFO
 	 *
 	 * + The controller's main job is to process its message queue,
-	 *   selecting a chip (for masters), then transferring data
+	 *   selecting a chip (for controllers), then transferring data
 	 * + If there are multiple spi_device children, the i/o queue
 	 *   arbitration algorithm is unspecified (round robin, FIFO,
 	 *   priority, reservations, preemption, etc)
@@ -846,7 +846,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 
 /* The SPI driver core manages memory for the spi_controller classdev */
 extern struct spi_controller *__spi_alloc_controller(struct device *host,
-						unsigned int size, bool slave);
+						unsigned int size, bool target);
 
 static inline struct spi_controller *spi_alloc_host(struct device *dev,
 						    unsigned int size)
@@ -865,7 +865,7 @@ static inline struct spi_controller *spi_alloc_target(struct device *dev,
 
 struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
-						   bool slave);
+						   bool target);
 
 static inline struct spi_controller *devm_spi_alloc_host(struct device *dev,
 							 unsigned int size)
@@ -1003,12 +1003,12 @@ struct spi_res {
  *	purposefully (instead of setting to spi_transfer->len - 1) to denote
  *	that a transfer-level snapshot taken from within the driver may still
  *	be of higher quality.
- * @ptp_sts: Pointer to a memory location held by the SPI slave device where a
+ * @ptp_sts: Pointer to a memory location held by the SPI target device where a
  *	PTP system timestamp structure may lie. If drivers use PIO or their
  *	hardware has some sort of assist for retrieving exact transfer timing,
  *	they can (and should) assert @ptp_sts_supported and populate this
  *	structure using the ptp_read_system_*ts helper functions.
- *	The timestamp must represent the time at which the SPI slave device has
+ *	The timestamp must represent the time at which the SPI target device has
  *	processed the word, i.e. the "pre" timestamp should be taken before
  *	transmitting the "pre" word, and the "post" timestamp after receiving
  *	transmit confirmation from the controller for the "post" word.
@@ -1651,7 +1651,7 @@ struct spi_board_info {
 	 * bus_num is board specific and matches the bus_num of some
 	 * spi_controller that will probably be registered later.
 	 *
-	 * chip_select reflects how this chip is wired to that master;
+	 * chip_select reflects how this chip is wired to that controller;
 	 * it's less than num_chipselect.
 	 */
 	u16		bus_num;
-- 
2.47.2


