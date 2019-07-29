Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0978F03
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfG2PUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 11:20:19 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40105 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728023AbfG2PUT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 11:20:19 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6TEP6AT025572;
        Mon, 29 Jul 2019 17:25:06 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5665861FD4; Mon, 29 Jul 2019 17:25:06 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
        tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
        frieder.schrempf@exceet.de, tglx@linutronix.de
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 1/3] spi: spi-mem: add spi-mem setup function
Date:   Mon, 29 Jul 2019 17:25:02 +0300
Message-Id: <20190729142504.188336-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add spi-mem setup function support SPI memory
operations the spi-mem setup function running
after the spi-mem probe function if the spi-mem
setup function implemented.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-mem.c       | 27 ++++++++++++++++++++++++++-
 include/linux/spi/spi-mem.h |  4 ++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f3116d..21fe3a75d636 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -398,6 +398,26 @@ const char *spi_mem_get_name(struct spi_mem *mem)
 }
 EXPORT_SYMBOL_GPL(spi_mem_get_name);
 
+/**
+ * spi_mem_setup() - Execute spi memory setup
+ * @mem: the SPI memory
+ *
+ * This function allows SPI mem users to execute spi memory
+ * setup after the probe finished.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int spi_mem_setup(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->setup)
+		return ctlr->mem_ops->setup(mem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_mem_setup);
+
 /**
  * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
  *			      match controller limitations
@@ -723,6 +743,7 @@ static int spi_mem_probe(struct spi_device *spi)
 	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_mem *mem;
+	int ret;
 
 	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
 	if (!mem)
@@ -740,7 +761,11 @@ static int spi_mem_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, mem);
 
-	return memdrv->probe(mem);
+	ret = memdrv->probe(mem);
+	if (ret)
+		return ret;
+
+	return spi_mem_setup(mem);
 }
 
 static int spi_mem_remove(struct spi_device *spi)
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index af9ff2f0f1b2..5f7d20bd2b09 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -222,6 +222,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *	      Note that if the implementation of this function allocates memory
  *	      dynamically, then it should do so with devm_xxx(), as we don't
  *	      have a ->free_name() function.
+ * @setup: execute a SPI memory setup
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -256,6 +257,7 @@ struct spi_controller_mem_ops {
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
 	const char *(*get_name)(struct spi_mem *mem);
+	int (*setup)(struct spi_mem *mem);
 	int (*dirmap_create)(struct spi_mem_dirmap_desc *desc);
 	void (*dirmap_destroy)(struct spi_mem_dirmap_desc *desc);
 	ssize_t (*dirmap_read)(struct spi_mem_dirmap_desc *desc,
@@ -334,6 +336,8 @@ int spi_mem_exec_op(struct spi_mem *mem,
 
 const char *spi_mem_get_name(struct spi_mem *mem);
 
+int spi_mem_setup(struct spi_mem *mem);
+
 struct spi_mem_dirmap_desc *
 spi_mem_dirmap_create(struct spi_mem *mem,
 		      const struct spi_mem_dirmap_info *info);
-- 
2.18.0

