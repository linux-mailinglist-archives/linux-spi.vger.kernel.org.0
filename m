Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D632E5FAF3E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Oct 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKJWd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Oct 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKJWc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Oct 2022 05:22:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549465D0CB
        for <linux-spi@vger.kernel.org>; Tue, 11 Oct 2022 02:22:30 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mmqv70BkDzmV7V;
        Tue, 11 Oct 2022 17:17:55 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 17:22:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 17:22:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <geert@linux-m68k.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2] spi: introduce new helpers with using modern naming
Date:   Tue, 11 Oct 2022 17:22:04 +0800
Message-ID: <20221011092204.950288-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For using modern names host/target to instead of all the legacy names,
I think it takes 3 steps:
  - step1: introduce new helpers with modern naming.
  - step2: switch to use these new helpers in all drivers.
  - step3: remove all legacy helpers and update all legacy names.

This patch is for step1, it introduces new helpers with host/target
naming for drivers using.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  make 'target' member into union to initialize it.
---
 drivers/spi/spi.c       | 11 ++++++++++
 include/linux/spi/spi.h | 47 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5f9aedd1f0b6..04b5668a1866 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2759,6 +2759,17 @@ int spi_slave_abort(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_slave_abort);
 
+int spi_target_abort(struct spi_device *spi)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (spi_controller_is_target(ctlr) && ctlr->target_abort)
+		return ctlr->target_abort(ctlr);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(spi_target_abort);
+
 static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fbf8c0d95968..130d5b5e3147 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -356,6 +356,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @max_speed_hz: Highest supported transfer speed
  * @flags: other constraints relevant to this driver
  * @slave: indicates that this is an SPI slave controller
+ * @target: indicates that this is an SPI target controller
  * @devm_allocated: whether the allocation of this struct is devres-managed
  * @max_transfer_size: function that returns the max transfer size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
@@ -440,6 +441,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
+ * @target_abort: abort the ongoing transfer request on an SPI target controller
  * @cs_gpiods: Array of GPIO descs to use as chip select lines; one per CS
  *	number. Any individual value may be NULL for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -535,8 +537,12 @@ struct spi_controller {
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
 
-	/* Flag indicating this is an SPI slave controller */
-	bool			slave;
+	union {
+		/* Flag indicating this is an SPI slave controller */
+		bool			slave;
+		/* Flag indicating this is an SPI target controller */
+		bool			target;
+	};
 
 	/*
 	 * on some hardware transfer / message size may be constrained
@@ -650,6 +656,7 @@ struct spi_controller {
 	int (*unprepare_message)(struct spi_controller *ctlr,
 				 struct spi_message *message);
 	int (*slave_abort)(struct spi_controller *ctlr);
+	int (*target_abort)(struct spi_controller *ctlr);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -727,6 +734,11 @@ static inline bool spi_controller_is_slave(struct spi_controller *ctlr)
 	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->slave;
 }
 
+static inline bool spi_controller_is_target(struct spi_controller *ctlr)
+{
+	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->target;
+}
+
 /* PM calls that need to be issued by the driver */
 extern int spi_controller_suspend(struct spi_controller *ctlr);
 extern int spi_controller_resume(struct spi_controller *ctlr);
@@ -763,6 +775,21 @@ static inline struct spi_controller *spi_alloc_slave(struct device *host,
 	return __spi_alloc_controller(host, size, true);
 }
 
+static inline struct spi_controller *spi_alloc_host(struct device *dev,
+						    unsigned int size)
+{
+	return __spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *spi_alloc_target(struct device *dev,
+						      unsigned int size)
+{
+	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+		return NULL;
+
+	return __spi_alloc_controller(dev, size, true);
+}
+
 struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
 						   bool slave);
@@ -782,6 +809,21 @@ static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
 	return __devm_spi_alloc_controller(dev, size, true);
 }
 
+static inline struct spi_controller *devm_spi_alloc_host(struct device *dev,
+							 unsigned int size)
+{
+	return __devm_spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *devm_spi_alloc_target(struct device *dev,
+							   unsigned int size)
+{
+	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+		return NULL;
+
+	return __devm_spi_alloc_controller(dev, size, true);
+}
+
 extern int spi_register_controller(struct spi_controller *ctlr);
 extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
@@ -1141,6 +1183,7 @@ static inline void spi_message_free(struct spi_message *m)
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_slave_abort(struct spi_device *spi);
+extern int spi_target_abort(struct spi_device *spi);
 
 static inline size_t
 spi_max_message_size(struct spi_device *spi)
-- 
2.25.1

