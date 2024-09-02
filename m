Return-Path: <linux-spi+bounces-4512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F16968835
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B23281CEF
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D61D6180;
	Mon,  2 Sep 2024 13:00:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0920FA94;
	Mon,  2 Sep 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282006; cv=none; b=i8EM0yvxpVpw5VW5vSi+xx1ekRWanDk+RdTMtkwWbSgPDKzCf6ZxXKQ26RFaERAO+hM28PCX42oPca0LW9pgBxHlVphLz4VLOuc5jxv+2Sovy6el1C7ri1UQJW+/JcLthb1DogKOCYzR+c1RP++iMFbTEXovHFsSWeyJT40846o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282006; c=relaxed/simple;
	bh=ef8LxGrRpjdmL/uT5tW7ISEWjInkoyUm4FYUw3dm4Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8Gk0VRm5LtRiAKSaAdfRoJvXAZvyDoRkuvLiQYnygUqr84y19voUFcJ2KZ6VAyN+EcoKc7v8cF5nmDywm+XbrwLN7zZPbPSl2gv6d2WVpZ1L/ky34tA0ojgqzdfKh6HFLn/IczAx08QRsF5V+B5o6ILruo6WiccGHpcnImSv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy83g48zwz4f3m6g;
	Mon,  2 Sep 2024 20:59:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 536A31A154C;
	Mon,  2 Sep 2024 20:59:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.85.165.202])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfEttVmOJPAAA--.25304S11;
	Mon, 02 Sep 2024 20:59:59 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	mchehab@kernel.org,
	Jonathan.Cameron@huawei.com,
	rmfrfs@gmail.com,
	vireshk@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	corbet@lwn.net,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH -next 7/7] spi: remove {devm_}spi_alloc_master/slave()
Date: Mon,  2 Sep 2024 20:59:47 +0800
Message-ID: <20240902125947.1368-8-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
References: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfEttVmOJPAAA--.25304S11
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4ktFW5Jr43tr43Kr1Dtrb_yoWrAw17pF
	4rWFsxAFWktF45uF4Utw4kuFy3Jas7WFW0kwsrG34Fvr1Sgr95XryDCryrXFy5tFWjyFyj
	yrs093y8ua12yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

All the {devm_}spi_alloc_master/slave() have been replaced,
so they can be removed and replaced in doc and comment.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../driver-api/driver-model/devres.rst        |  4 +--
 drivers/spi/spi.c                             | 14 ++++-----
 include/linux/spi/spi.h                       | 30 -------------------
 3 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5f2ee8d717b1..ebbf8e4cc85f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -462,8 +462,8 @@ SLAVE DMA ENGINE
   devm_acpi_dma_controller_free()
 
 SPI
-  devm_spi_alloc_master()
-  devm_spi_alloc_slave()
+  devm_spi_alloc_host()
+  devm_spi_alloc_target()
   devm_spi_optimize_message()
   devm_spi_register_controller()
   devm_spi_register_host()
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 60a2b5a0c85d..2000bce240a6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3249,9 +3249,9 @@ static int spi_controller_id_alloc(struct spi_controller *ctlr, int start, int e
 }
 
 /**
- * spi_register_controller - register SPI master or slave controller
- * @ctlr: initialized master, originally from spi_alloc_master() or
- *	spi_alloc_slave()
+ * spi_register_controller - register SPI host or target controller
+ * @ctlr: initialized controller, originally from spi_alloc_host() or
+ *	spi_alloc_target()
  * Context: can sleep
  *
  * SPI controllers connect to their drivers using some non-SPI bus,
@@ -3401,11 +3401,11 @@ static void devm_spi_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_spi_register_controller - register managed SPI master or slave
+ * devm_spi_register_controller - register managed SPI host or target
  *	controller
  * @dev:    device managing SPI controller
- * @ctlr: initialized controller, originally from spi_alloc_master() or
- *	spi_alloc_slave()
+ * @ctlr: initialized controller, originally from spi_alloc_host() or
+ *	spi_alloc_target()
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_controller() which will
@@ -3489,7 +3489,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/*
 	 * Release the last reference on the controller if its driver
-	 * has not yet been converted to devm_spi_alloc_master/slave().
+	 * has not yet been converted to devm_spi_alloc_host/target().
 	 */
 	if (!ctlr->devm_allocated)
 		put_device(&ctlr->dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d47d5f14ff99..a9a6af11c974 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -833,21 +833,6 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 extern struct spi_controller *__spi_alloc_controller(struct device *host,
 						unsigned int size, bool slave);
 
-static inline struct spi_controller *spi_alloc_master(struct device *host,
-						      unsigned int size)
-{
-	return __spi_alloc_controller(host, size, false);
-}
-
-static inline struct spi_controller *spi_alloc_slave(struct device *host,
-						     unsigned int size)
-{
-	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
-		return NULL;
-
-	return __spi_alloc_controller(host, size, true);
-}
-
 static inline struct spi_controller *spi_alloc_host(struct device *dev,
 						    unsigned int size)
 {
@@ -867,21 +852,6 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
 						   unsigned int size,
 						   bool slave);
 
-static inline struct spi_controller *devm_spi_alloc_master(struct device *dev,
-							   unsigned int size)
-{
-	return __devm_spi_alloc_controller(dev, size, false);
-}
-
-static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
-							  unsigned int size)
-{
-	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
-		return NULL;
-
-	return __devm_spi_alloc_controller(dev, size, true);
-}
-
 static inline struct spi_controller *devm_spi_alloc_host(struct device *dev,
 							 unsigned int size)
 {
-- 
2.33.0


