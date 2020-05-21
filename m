Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB51DCC09
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgEULYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 07:24:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbgEULYT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 07:24:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09BDBD8DE7A7168C8D15;
        Thu, 21 May 2020 19:24:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 19:24:08 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <john.garry@huawei.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: [RFC PATCH 3/3] spi: hisi-sfc-v3xx: Add prepare/unprepare methods to avoid race condition
Date:   Thu, 21 May 2020 19:23:51 +0800
Message-ID: <1590060231-23242-4-git-send-email-yangyicong@hisilicon.com>
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

The controller can be shared with the firmware, which may cause race
problems. As most read/write/erase/lock/unlock of spi-nor flash are
composed of a set of operations, while the firmware may use the controller
and start its own operation in the middle of the process started by the
kernel driver, which may lead to the kernel driver's function broken.

Bit[20] in HISI_SFC_V3XX_CMD_CFG register plays a role of a lock, to
protect the controller from firmware access, which means the firmware
cannot reach the controller if the driver set the bit. Add prepare/
unprepare methods for the controller, we'll hold the lock in prepare
method and release it in unprepare method, which will solve the race
issue.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index e3b5725..13c161c 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -18,6 +18,7 @@
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
+#define HISI_SFC_V3XX_CMD_CFG_LOCK BIT(20)
 #define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
@@ -41,6 +42,34 @@ struct hisi_sfc_v3xx_host {
 	int max_cmd_dword;
 };
 
+int hisi_sfc_v3xx_op_prepare(struct spi_mem *mem)
+{
+	struct spi_device *spi = mem->spi;
+	struct hisi_sfc_v3xx_host *host;
+	u32 reg = HISI_SFC_V3XX_CMD_CFG_LOCK;
+
+	host = spi_controller_get_devdata(spi->master);
+
+	writel(reg, host->regbase + HISI_SFC_V3XX_CMD_CFG);
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
+	if (!(reg & HISI_SFC_V3XX_CMD_CFG_LOCK))
+		return -EIO;
+
+	return 0;
+}
+
+void hisi_sfc_v3xx_op_unprepare(struct spi_mem *mem)
+{
+	struct spi_device *spi = mem->spi;
+	struct hisi_sfc_v3xx_host *host;
+
+	host = spi_controller_get_devdata(spi->master);
+
+	/* Release the lock and clear the command register. */
+	writel(0, host->regbase + HISI_SFC_V3XX_CMD_CFG);
+}
+
 #define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
 #define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10
 
@@ -163,7 +192,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 					 u8 chip_select)
 {
 	int ret, len = op->data.nbytes;
-	u32 config = 0;
+	u32 config;
+
+	/*
+	 * The lock bit is in the command register. Clear the command
+	 * field with lock bit held if it has been set in
+	 * .prepare().
+	 */
+	config = readl(host->regbase + HISI_SFC_V3XX_CMD_CFG);
+	config &= HISI_SFC_V3XX_CMD_CFG_LOCK;
 
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
@@ -248,6 +285,8 @@ static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
+	.prepare	= hisi_sfc_v3xx_op_prepare,
+	.unprepare	= hisi_sfc_v3xx_op_unprepare,
 	.exec_op = hisi_sfc_v3xx_exec_op,
 };
 
-- 
2.8.1

