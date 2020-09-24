Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F62770EA
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgIXMZz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727593AbgIXMZz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71BA3946B41F1798A923;
        Thu, 24 Sep 2020 20:25:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 20:25:45 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <john.garry@huawei.com>, <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yangyicong@hisilicon.com>
Subject: [PATCH 1/4] spi: hisi-sfc-v3xx: factor out IO modes configuration
Date:   Thu, 24 Sep 2020 20:24:27 +0800
Message-ID: <1600950270-52536-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
References: <1600950270-52536-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Factor IO modes configuration out of hisi_sfc_v3xx_generic_exec_op()
using an IO modes lookup table. This will make the process a bit clearer
and reduce the cyclomatic complexity. Simplify the IO mode definition
macros a little bit as well.

Also add the .supports_op() method for the controller mem ops, in order
to avoid OOB access.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 97 +++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 64a18d0..69f5a7b 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -23,12 +23,6 @@
 #define HISI_SFC_V3XX_INT_CLR (0x12c)
 #define HISI_SFC_V3XX_INT_CLR_CLEAR (0xff)
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
-#define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
-#define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
-#define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
-#define HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT (5 << 17)
-#define HISI_SFC_V3XX_CMD_CFG_QUAD_IO (6 << 17)
-#define HISI_SFC_V3XX_CMD_CFG_FULL_QIO (7 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
 #define HISI_SFC_V3XX_CMD_CFG_RW_MSK BIT(8)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK BIT(7)
@@ -40,6 +34,33 @@
 #define HISI_SFC_V3XX_CMD_ADDR (0x30c)
 #define HISI_SFC_V3XX_CMD_DATABUF0 (0x400)
 
+/* IO Mode definition in HISI_SFC_V3XX_CMD_CFG */
+#define HISI_SFC_V3XX_STD (0 << 17)
+#define HISI_SFC_V3XX_DIDO (1 << 17)
+#define HISI_SFC_V3XX_DIO (2 << 17)
+#define HISI_SFC_V3XX_FULL_DIO (3 << 17)
+#define HISI_SFC_V3XX_QIQO (5 << 17)
+#define HISI_SFC_V3XX_QIO (6 << 17)
+#define HISI_SFC_V3XX_FULL_QIO (7 << 17)
+
+/*
+ * The IO modes lookup table. hisi_sfc_v3xx_io_modes[(z - 1) / 2][y / 2][x / 2]
+ * stands for x-y-z mode, as described in SFDP terminology. -EIO indicates
+ * an invalid mode.
+ */
+static const int hisi_sfc_v3xx_io_modes[2][3][3] = {
+	{
+		{ HISI_SFC_V3XX_DIDO, HISI_SFC_V3XX_DIDO, HISI_SFC_V3XX_DIDO },
+		{ HISI_SFC_V3XX_DIO, HISI_SFC_V3XX_FULL_DIO, -EIO },
+		{ -EIO, -EIO, -EIO },
+	},
+	{
+		{ HISI_SFC_V3XX_QIQO, HISI_SFC_V3XX_QIQO, HISI_SFC_V3XX_QIQO },
+		{ -EIO, -EIO, -EIO },
+		{ HISI_SFC_V3XX_QIO, -EIO, HISI_SFC_V3XX_FULL_QIO },
+	},
+};
+
 struct hisi_sfc_v3xx_host {
 	struct device *dev;
 	void __iomem *regbase;
@@ -80,6 +101,20 @@ static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem *mem,
 }
 
 /*
+ * The controller only supports Standard SPI mode, Duall mode and
+ * Quad mode. Double sanitize the ops here to avoid OOB access.
+ */
+static bool hisi_sfc_v3xx_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 4 || op->dummy.buswidth > 4 ||
+	    op->addr.buswidth > 4 || op->cmd.buswidth > 4)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+/*
  * memcpy_{to,from}io doesn't gurantee 32b accesses - which we require for the
  * DATABUF registers -so use __io{read,write}32_copy when possible. For
  * trailing bytes, copy them byte-by-byte from the DATABUF register, as we
@@ -167,48 +202,25 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 					 const struct spi_mem_op *op,
 					 u8 chip_select)
 {
-	int ret, len = op->data.nbytes;
+	int ret = 0, len = op->data.nbytes, buswidth_mode;
 	u32 int_stat, config = 0;
 
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
 
-	switch (op->data.buswidth) {
-	case 0 ... 1:
-		break;
-	case 2:
-		if (op->addr.buswidth <= 1) {
-			config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT;
-		} else if (op->addr.buswidth == 2) {
-			if (op->cmd.buswidth <= 1) {
-				config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IO;
-			} else if (op->cmd.buswidth == 2) {
-				config |= HISI_SFC_V3XX_CMD_CFG_FULL_DIO;
-			} else {
-				return -EIO;
-			}
-		} else {
-			return -EIO;
-		}
-		break;
-	case 4:
-		if (op->addr.buswidth <= 1) {
-			config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT;
-		} else if (op->addr.buswidth == 4) {
-			if (op->cmd.buswidth <= 1) {
-				config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IO;
-			} else if (op->cmd.buswidth == 4) {
-				config |= HISI_SFC_V3XX_CMD_CFG_FULL_QIO;
-			} else {
-				return -EIO;
-			}
-		} else {
-			return -EIO;
-		}
-		break;
-	default:
-		return -EOPNOTSUPP;
+	if (op->data.buswidth == 0 || op->data.buswidth == 1) {
+		buswidth_mode = HISI_SFC_V3XX_STD;
+	} else {
+		int data_idx, addr_idx, cmd_idx;
+
+		data_idx = (op->data.buswidth - 1) / 2;
+		addr_idx = op->addr.buswidth / 2;
+		cmd_idx = op->cmd.buswidth / 2;
+		buswidth_mode = hisi_sfc_v3xx_io_modes[data_idx][addr_idx][cmd_idx];
 	}
+	if (buswidth_mode < 0)
+		return buswidth_mode;
+	config |= buswidth_mode;
 
 	if (op->data.dir != SPI_MEM_NO_DATA) {
 		config |= (len - 1) << HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF;
@@ -272,6 +284,7 @@ static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
 
 static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
+	.supports_op = hisi_sfc_v3xx_supports_op,
 	.exec_op = hisi_sfc_v3xx_exec_op,
 };
 
-- 
2.8.1

