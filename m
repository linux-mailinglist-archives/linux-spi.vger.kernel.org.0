Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892BC173B3D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgB1PXB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 10:23:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbgB1PXA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 10:23:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE65CFFEE367F48376C9;
        Fri, 28 Feb 2020 23:22:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Feb 2020 23:22:44 +0800
From:   John Garry <john.garry@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 2/3] spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes
Date:   Fri, 28 Feb 2020 23:18:50 +0800
Message-ID: <1582903131-160033-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The CMD_CONFIG register memory interface type field is not set configured
for Dual and Quad modes, so set appropriately.

This was not detected previously as we only ever operated in standard SPI
mode.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4cf8fc80a7b7..45d906110ed1 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -17,6 +17,12 @@
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
+#define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_FULL_DIO (3 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT (5 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_QUAD_IO (6 << 17)
+#define HISI_SFC_V3XX_CMD_CFG_FULL_QIO (7 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
 #define HISI_SFC_V3XX_CMD_CFG_RW_MSK BIT(8)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK BIT(7)
@@ -161,6 +167,43 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
 
+	switch (op->data.buswidth) {
+	case 0 ... 1:
+		break;
+	case 2:
+		if (op->addr.buswidth <= 1) {
+			config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT;
+		} else if (op->addr.buswidth == 2) {
+			if (op->cmd.buswidth <= 1) {
+				config |= HISI_SFC_V3XX_CMD_CFG_DUAL_IO;
+			} else if (op->cmd.buswidth == 2) {
+				config |= HISI_SFC_V3XX_CMD_CFG_FULL_DIO;
+			} else {
+				return -EIO;
+			}
+		} else {
+			return -EIO;
+		}
+		break;
+	case 4:
+		if (op->addr.buswidth <= 1) {
+			config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IN_QUAD_OUT;
+		} else if (op->addr.buswidth == 4) {
+			if (op->cmd.buswidth <= 1) {
+				config |= HISI_SFC_V3XX_CMD_CFG_QUAD_IO;
+			} else if (op->cmd.buswidth == 4) {
+				config |= HISI_SFC_V3XX_CMD_CFG_FULL_QIO;
+			} else {
+				return -EIO;
+			}
+		} else {
+			return -EIO;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (op->data.dir != SPI_MEM_NO_DATA) {
 		config |= (len - 1) << HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF;
 		config |= HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK;
-- 
2.17.1

