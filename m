Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA9387D70
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350689AbhERQ3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 12:29:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8610 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1350643AbhERQ33 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 12:29:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IGLm4w023140;
        Tue, 18 May 2021 18:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=0bHg0ARHkdCFC1flU57WX7u1lRnnB5XX9tbgb0TFL7c=;
 b=sZfuDR4Fs030jFiaYA2JrwUeEipTWD3UJpYSC53fZ0KCudE8DwBCWYW0Qvw63QR/LHEP
 zbWID4KUHLMePbWr1DyorEVWls3ujhyVjTAhWJXl5WTDL0QBdFw71v79fBeja17XEMOG
 0MR/CggrUSlMynJjm159OLie2SK3sv7mNEbd6kaWbY39I3SP6ey7cOs0ZiKWtn2EwTi9
 mhnFsO2PIlyOfxCnWfGLr7H1GghiXGvwLmncvoaeeRH9/6PnFwkpfg/vE8cllgesSL/N
 7a4KL47DD0s7bqUpUq0AyK9yIc3aI1vXZhWgL9oP4kYBPwgUW/mZbMvyDv3K+Umo9miv +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38mekkrvjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 18:27:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 293FC100034;
        Tue, 18 May 2021 18:27:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C34E23FE73;
        Tue, 18 May 2021 18:27:57 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 18:27:56
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
Subject: [PATCH v5 1/3] spi: spi-mem: add automatic poll status functions
Date:   Tue, 18 May 2021 18:27:52 +0200
Message-ID: <20210518162754.15940-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518162754.15940-1-patrice.chotard@foss.st.com>
References: <20210518162754.15940-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_08:2021-05-18,2021-05-18 signatures=0
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
For example, previously, when erasing large area, in non-offload case,
CPU load can reach ~50%, now it decrease to ~35%.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v5:
  - Update spi_mem_read_status() description.
  - Update poll_status() description API by indicating that data buffer is
    filled with last status value.
  - Update timeout parameter by timeout_ms in spi_mem_poll_status() prototype.
  - Remove parenthesys arount -EINVAL in spi_mem_poll_status().
  - Add Boris Reviewed-by.

Changes in v4:
  - Remove init_completion() from spi_mem_probe() added in v2.
  - Add missing static for spi_mem_read_status().
  - Check if operation in spi_mem_poll_status() is a READ.

Changes in v3:
  - Add spi_mem_read_status() which allows to read 8 or 16 bits status.
  - Add initial_delay_us and polling_delay_us parameters to spi_mem_poll_status()
    and also to poll_status() callback.
  - Move spi_mem_supports_op() in SW-based polling case.
  - Add delay before invoking read_poll_timeout().
  - Remove the reinit/wait_for_completion() added in v2.

Changes in v2:
  - Indicates the spi_mem_poll_status() timeout unit
  - Use 2-byte wide status register
  - Add spi_mem_supports_op() call in spi_mem_poll_status()
  - Add completion management in spi_mem_poll_status()
  - Add offload/non-offload case management in spi_mem_poll_status()
  - Optimize the non-offload case by using read_poll_timeout()

 drivers/spi/spi-mem.c       | 86 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 16 +++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1513553e4080..177b3e21febf 100644
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
@@ -743,6 +744,91 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 	return container_of(drv, struct spi_mem_driver, spidrv.driver);
 }
 
+static int spi_mem_read_status(struct spi_mem *mem,
+			       const struct spi_mem_op *op,
+			       u16 *status)
+{
+	const u8 *bytes = (u8 *)op->data.buf.in;
+	int ret;
+
+	ret = spi_mem_exec_op(mem, op);
+	if (ret)
+		return ret;
+
+	if (op->data.nbytes > 1)
+		*status = ((u16)bytes[0] << 8) | bytes[1];
+	else
+		*status = bytes[0];
+
+	return 0;
+}
+
+/**
+ * spi_mem_poll_status() - Poll memory device status
+ * @mem: SPI memory device
+ * @op: the memory operation to execute
+ * @mask: status bitmask to ckeck
+ * @match: (status & mask) expected value
+ * @initial_delay_us: delay in us before starting to poll
+ * @polling_delay_us: time to sleep between reads in us
+ * @timeout_ms: timeout in milliseconds
+ *
+ * This function polls a status register and returns when
+ * (status & mask) == match or when the timeout has expired.
+ *
+ * Return: 0 in case of success, -ETIMEDOUT in case of error,
+ *         -EOPNOTSUPP if not supported.
+ */
+int spi_mem_poll_status(struct spi_mem *mem,
+			const struct spi_mem_op *op,
+			u16 mask, u16 match,
+			unsigned long initial_delay_us,
+			unsigned long polling_delay_us,
+			u16 timeout_ms)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	int ret = -EOPNOTSUPP;
+	int read_status_ret;
+	u16 status;
+
+	if (op->data.nbytes < 1 || op->data.nbytes > 2 ||
+	    op->data.dir != SPI_MEM_DATA_IN)
+		return -EINVAL;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
+		ret = spi_mem_access_start(mem);
+		if (ret)
+			return ret;
+
+		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
+						 initial_delay_us, polling_delay_us,
+						 timeout_ms);
+
+		spi_mem_access_end(mem);
+	}
+
+	if (ret == -EOPNOTSUPP) {
+		if (!spi_mem_supports_op(mem, op))
+			return ret;
+
+		if (initial_delay_us < 10)
+			udelay(initial_delay_us);
+		else
+			usleep_range((initial_delay_us >> 2) + 1,
+				     initial_delay_us);
+
+		ret = read_poll_timeout(spi_mem_read_status, read_status_ret,
+					(read_status_ret || ((status) & mask) == match),
+					polling_delay_us, timeout_ms * 1000, false, mem,
+					op, &status);
+		if (read_status_ret)
+			return read_status_ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_poll_status);
+
 static int spi_mem_probe(struct spi_device *spi)
 {
 	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 2b65c9edc34e..85e2ff7b840d 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -250,6 +250,9 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		  the currently mapped area), and the caller of
  *		  spi_mem_dirmap_write() is responsible for calling it again in
  *		  this case.
+ * @poll_status: poll memory device status until (status & mask) == match or
+ *               when the timeout has expired. It fills the data buffer with
+ *               the last status value.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -274,6 +277,12 @@ struct spi_controller_mem_ops {
 			       u64 offs, size_t len, void *buf);
 	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
 				u64 offs, size_t len, const void *buf);
+	int (*poll_status)(struct spi_mem *mem,
+			   const struct spi_mem_op *op,
+			   u16 mask, u16 match,
+			   unsigned long initial_delay_us,
+			   unsigned long polling_rate_us,
+			   unsigned long timeout_ms);
 };
 
 /**
@@ -369,6 +378,13 @@ devm_spi_mem_dirmap_create(struct device *dev, struct spi_mem *mem,
 void devm_spi_mem_dirmap_destroy(struct device *dev,
 				 struct spi_mem_dirmap_desc *desc);
 
+int spi_mem_poll_status(struct spi_mem *mem,
+			const struct spi_mem_op *op,
+			u16 mask, u16 match,
+			unsigned long initial_delay_us,
+			unsigned long polling_delay_us,
+			u16 timeout_ms);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.17.1

