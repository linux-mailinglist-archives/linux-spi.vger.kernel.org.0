Return-Path: <linux-spi+bounces-4761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1097272E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E9BB2371C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F478149C61;
	Tue, 10 Sep 2024 02:26:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22D61FE1;
	Tue, 10 Sep 2024 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935194; cv=none; b=On3Wh0le2IXt1ehzKeWNbz0Mz7G7Z/XbbtkjzR/KGM0Qs+q/ZEOdZjNfvXnoiLCPBVIw3BpjKlCYoqGfy+a7lID1X7hO6P5OtH95MdDuvcuPc0RyyNQU8tpolroc8EO/cnIkjiYfOIgwl4IhTdXdVoA8QOsUK0AhDODPxAMc94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935194; c=relaxed/simple;
	bh=y1TG+e9LqhH/Wjk+GdG0ujoJ28CWv1vLIC1OiTu3u0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NghUP552hwUNFtiyE4XwMBbIkigL50YE88uFe0SrxqDJNXYwjR7NriXhidC1LK5wVrg1BCBGPfnWyfHRKb5GWw0zzLUOtUyGrXROAePF+erbAd+1QKsqUrqgfFn6R9M72gBA5B6sqiisXShU25oQFULYM44cTg4hOQKBe4NdkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2nd12SlPz4f3kvv;
	Tue, 10 Sep 2024 10:26:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7EBDB1A058E;
	Tue, 10 Sep 2024 10:26:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S11;
	Tue, 10 Sep 2024 10:26:29 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 7/7] spi: remove spi_controller_is_slave() and spi_slave_abort()
Date: Tue, 10 Sep 2024 10:26:17 +0800
Message-ID: <20240910022618.1397-8-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
References: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UAF4Dur47uFWUZF4ktFb_yoW5ZFW7pF
	47GF47AFZ5CFW5uFy5Kw48uF9xWFZa9rZ8G397t34fJw4aqa4UAFyUAr4FvFy5XFWxKw4U
	urW2vr1kGF1jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

spi_controller_is_slave() and spi_slave_abort() are all replaced,
so they can be removed.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi.c       | 13 +------------
 include/linux/spi/spi.h | 12 +-----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 03032bb7397c..073ffae97767 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2934,21 +2934,10 @@ static struct class spi_master_class = {
 
 #ifdef CONFIG_SPI_SLAVE
 /**
- * spi_slave_abort - abort the ongoing transfer request on an SPI slave
+ * spi_target_abort - abort the ongoing transfer request on an SPI slave
  *		     controller
  * @spi: device used for the current transfer
  */
-int spi_slave_abort(struct spi_device *spi)
-{
-	struct spi_controller *ctlr = spi->controller;
-
-	if (spi_controller_is_slave(ctlr) && ctlr->slave_abort)
-		return ctlr->slave_abort(ctlr);
-
-	return -ENOTSUPP;
-}
-EXPORT_SYMBOL_GPL(spi_slave_abort);
-
 int spi_target_abort(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a9a6af11c974..8497f4747e24 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -498,7 +498,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     controller has native support for memory like operations.
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
- * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @target_abort: abort the ongoing transfer request on an SPI target controller
  * @cs_gpiods: Array of GPIO descriptors to use as chip select lines; one per CS
  *	number. Any individual value may be NULL for CS lines that
@@ -725,10 +724,7 @@ struct spi_controller {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_controller *ctlr,
 				 struct spi_message *message);
-	union {
-		int (*slave_abort)(struct spi_controller *ctlr);
-		int (*target_abort)(struct spi_controller *ctlr);
-	};
+	int (*target_abort)(struct spi_controller *ctlr);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -802,11 +798,6 @@ static inline void spi_controller_put(struct spi_controller *ctlr)
 		put_device(&ctlr->dev);
 }
 
-static inline bool spi_controller_is_slave(struct spi_controller *ctlr)
-{
-	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->slave;
-}
-
 static inline bool spi_controller_is_target(struct spi_controller *ctlr)
 {
 	return IS_ENABLED(CONFIG_SPI_SLAVE) && ctlr->target;
@@ -1266,7 +1257,6 @@ extern int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-extern int spi_slave_abort(struct spi_device *spi);
 extern int spi_target_abort(struct spi_device *spi);
 
 static inline size_t
-- 
2.33.0


