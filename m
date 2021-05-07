Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46E3765FA
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhEGNTZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 09:19:25 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57564 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229886AbhEGNTY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 09:19:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147DD5M5030751;
        Fri, 7 May 2021 15:18:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=J1kgdyPnZVAZmjhvFTZCtchyF+JveNeIja4j9TKTgUA=;
 b=d4eBMXrSo4PX1jE1BFuLEjKJSC3NWM6Fw5K6AqdeORQzy9t3GBlCK04m5yURQhycz8vZ
 IfYvU+I4RBc/lgSRF3Hx4TRCJ/76p66K3Qus0s5XGpPg6fVJ/E3OHGBaOjHPF3jalkjz
 PhTfoG3QonBp1DaO80QHaSqAZz2EmjxLDDJDGCAoDkeRNmUbWiUrOqop31sdzaMlEeHs
 h2uheWvFWnbDpBCMRvzQ6IGVkrIfCJESnhFMHqyKObwWPjQKSHhl0DPtZ7bnBo55pohR
 R6SOvUEzvDDgql0ae2H2GWzMfBAsYDM3m4WYoz4dGOcANuMlXbeTGg+zXySjabYv4i6i cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38csqbv68q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 15:18:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD440100034;
        Fri,  7 May 2021 15:18:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5C68221F79;
        Fri,  7 May 2021 15:18:13 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May 2021 15:18:13
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: [PATCH v2 1/3] spi: spi-mem: add automatic poll status functions
Date:   Fri, 7 May 2021 15:17:54 +0200
Message-ID: <20210507131756.17028-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507131756.17028-1-patrice.chotard@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

With STM32 QSPI, it is possible to poll the status register of the device.
This could be done to offload the CPU during an operation (erase or
program a SPI NAND for example).

spi_mem_poll_status API has been added to handle this feature.
This new function take care of the offload/non-offload cases.

For the non-offload case, use read_poll_timeout() to poll the status in
order to release CPU during this phase.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
  - Indicates the spi_mem_poll_status() timeout unit
  - Use 2-byte wide status register
  - Add spi_mem_supports_op() call in spi_mem_poll_status()
  - Add completion management in spi_mem_poll_status()
  - Add offload/non-offload case mangement in spi_mem_poll_status()
  - Optimize the non-offload case by using read_poll_timeout()

 drivers/spi/spi-mem.c       | 71 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 10 ++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1513553e4080..3f29c604df7d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -6,6 +6,7 @@
  * Author: Boris Brezillon <boris.brezillon@bootlin.com>
  */
 #include <linux/dmaengine.h>
+#include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
@@ -743,6 +744,75 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 	return container_of(drv, struct spi_mem_driver, spidrv.driver);
 }
 
+/**
+ * spi_mem_finalize_op - report completion of spi_mem_op
+ * @ctlr: the controller reporting completion
+ *
+ * Called by SPI drivers using the spi-mem spi_mem_poll_status()
+ * implementation to notify it that the current spi_mem_op has
+ * finished.
+ */
+void spi_mem_finalize_op(struct spi_controller *ctlr)
+{
+	complete(&ctlr->xfer_completion);
+}
+EXPORT_SYMBOL_GPL(spi_mem_finalize_op);
+
+/**
+ * spi_mem_poll_status() - Poll memory device status
+ * @mem: SPI memory device
+ * @op: the memory operation to execute
+ * @mask: status bitmask to ckeck
+ * @match: (status & mask) expected value
+ * @timeout_ms: timeout in milliseconds
+ *
+ * This function send a polling status request to the controller driver
+ *
+ * Return: 0 in case of success, -ETIMEDOUT in case of error,
+ *         -EOPNOTSUPP if not supported.
+ */
+int spi_mem_poll_status(struct spi_mem *mem,
+			const struct spi_mem_op *op,
+			u16 mask, u16 match, u16 timeout_ms)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	unsigned long ms;
+	int ret = -EOPNOTSUPP;
+	int exec_op_ret;
+	u16 *status;
+
+	if (!spi_mem_supports_op(mem, op))
+		return ret;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
+		ret = spi_mem_access_start(mem);
+		if (ret)
+			return ret;
+
+		reinit_completion(&ctlr->xfer_completion);
+
+		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
+						 timeout_ms);
+
+		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+						 msecs_to_jiffies(timeout_ms));
+
+		spi_mem_access_end(mem);
+		if (!ms)
+			return -ETIMEDOUT;
+	} else {
+		status = (u16 *)op->data.buf.in;
+		ret = read_poll_timeout(spi_mem_exec_op, exec_op_ret,
+					((*status) & mask) == match, 20,
+					timeout_ms * 1000, false, mem, op);
+		if (exec_op_ret)
+			return exec_op_ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_poll_status);
+
 static int spi_mem_probe(struct spi_device *spi)
 {
 	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
@@ -763,6 +833,7 @@ static int spi_mem_probe(struct spi_device *spi)
 	if (IS_ERR_OR_NULL(mem->name))
 		return PTR_ERR_OR_ZERO(mem->name);
 
+	init_completion(&ctlr->xfer_completion);
 	spi_set_drvdata(spi, mem);
 
 	return memdrv->probe(mem);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 2b65c9edc34e..0fbf5d0a3d31 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -250,6 +250,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		  the currently mapped area), and the caller of
  *		  spi_mem_dirmap_write() is responsible for calling it again in
  *		  this case.
+ * @poll_status: poll memory device status
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -274,6 +275,9 @@ struct spi_controller_mem_ops {
 			       u64 offs, size_t len, void *buf);
 	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
 				u64 offs, size_t len, const void *buf);
+	int (*poll_status)(struct spi_mem *mem,
+			   const struct spi_mem_op *op,
+			   u16 mask, u16 match, unsigned long timeout);
 };
 
 /**
@@ -369,6 +373,12 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
 void devm_spi_mem_dirmap_destroy(struct device *dev,
 				 struct spi_mem_dirmap_desc *desc);
 
+void spi_mem_finalize_op(struct spi_controller *ctlr);
+
+int spi_mem_poll_status(struct spi_mem *mem,
+			const struct spi_mem_op *op,
+			u16 mask, u16 match, u16 timeout);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.17.1

