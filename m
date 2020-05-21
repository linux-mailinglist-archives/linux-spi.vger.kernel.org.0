Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF21DCC0A
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgEULYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 07:24:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728887AbgEULYU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 07:24:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F079B301C4E315FE73B4;
        Thu, 21 May 2020 19:24:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 19:24:07 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <john.garry@huawei.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: [RFC PATCH 1/3] spi: spi-mem: add optional prepare/unprepare methods in spi_controller_mem_ops
Date:   Thu, 21 May 2020 19:23:49 +0800
Message-ID: <1590060231-23242-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
References: <1590060231-23242-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some prepare/unprepare works may be necessary before/after a set of
operations of the spimem device. For example, before/after spi-nor
flash's read/write/erase/lock/unlock.

Add optional prepare/unprepare methods in spi_controller_mem_ops to allow
the controller to do specific works after/before the operations. The upper
user can use spi_mem_{prepare, unprepare}() to call the methods of the
controller.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-mem.c       | 20 ++++++++++++++++++++
 include/linux/spi/spi-mem.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index adaa0c4..f09cef1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -220,6 +220,26 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
+int spi_mem_prepare(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->prepare)
+		return ctlr->mem_ops->prepare(mem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_mem_prepare);
+
+void spi_mem_unprepare(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->unprepare)
+		ctlr->mem_ops->unprepare(mem);
+}
+EXPORT_SYMBOL_GPL(spi_mem_unprepare);
+
 static int spi_mem_access_start(struct spi_mem *mem)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index af9ff2f..e40b5c3 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -215,6 +215,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ * @prepare: do some prepare works before a set of operations. for example,
+ *	     read/write/erase/lock/unlock operations of spi-nor flash. This
+ *	     method is optional.
+ * @unprepare: do some post works after a set of operations. for example,
+ *	       read/write/erase/lock/unlock operations of spi-nor flash. This
+ *	       method is optional.
  * @get_name: get a custom name for the SPI mem device from the controller.
  *	      This might be needed if the controller driver has been ported
  *	      to use the SPI mem layer and a custom name is used to keep
@@ -253,6 +259,8 @@ struct spi_controller_mem_ops {
 	int (*adjust_op_size)(struct spi_mem *mem, struct spi_mem_op *op);
 	bool (*supports_op)(struct spi_mem *mem,
 			    const struct spi_mem_op *op);
+	int (*prepare)(struct spi_mem *mem);
+	void (*unprepare)(struct spi_mem *mem);
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
 	const char *(*get_name)(struct spi_mem *mem);
@@ -329,6 +337,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
+int spi_mem_prepare(struct spi_mem *mem);
+void spi_mem_unprepare(struct spi_mem *mem);
+
 int spi_mem_exec_op(struct spi_mem *mem,
 		    const struct spi_mem_op *op);
 
-- 
2.8.1

