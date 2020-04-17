Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E231AD7F4
	for <lists+linux-spi@lfdr.de>; Fri, 17 Apr 2020 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgDQHsl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Apr 2020 03:48:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728925AbgDQHsk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Apr 2020 03:48:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C924D82A5D41BD46BDB;
        Fri, 17 Apr 2020 15:48:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 15:48:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] spi: hisi-sfc-v3xx: add error check after per operation
Date:   Fri, 17 Apr 2020 15:48:27 +0800
Message-ID: <1587109707-23597-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The controller may receive instructions of accessing protected address,
or may perform failed page program. These operations will not succeed
and the controller will receive interrupts when such failure occur.
Previously we don't check the interrupts and return 0 even if such
operation fails.

Check the interrupts after per command and inform the user
if there is an error.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: John Garry <john.garry@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index e3b5725..64a18d0 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -17,6 +17,11 @@
 
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
+#define HISI_SFC_V3XX_INT_STAT (0x120)
+#define HISI_SFC_V3XX_INT_STAT_PP_ERR BIT(2)
+#define HISI_SFC_V3XX_INT_STAT_ADDR_IACCES BIT(5)
+#define HISI_SFC_V3XX_INT_CLR (0x12c)
+#define HISI_SFC_V3XX_INT_CLR_CLEAR (0xff)
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
 #define HISI_SFC_V3XX_CMD_CFG_DUAL_IN_DUAL_OUT (1 << 17)
 #define HISI_SFC_V3XX_CMD_CFG_DUAL_IO (2 << 17)
@@ -163,7 +168,7 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 					 u8 chip_select)
 {
 	int ret, len = op->data.nbytes;
-	u32 config = 0;
+	u32 int_stat, config = 0;
 
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
@@ -228,6 +233,25 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	if (ret)
 		return ret;
 
+	/*
+	 * The interrupt status register indicates whether an error occurs
+	 * after per operation. Check it, and clear the interrupts for
+	 * next time judgement.
+	 */
+	int_stat = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
+	writel(HISI_SFC_V3XX_INT_CLR_CLEAR,
+	       host->regbase + HISI_SFC_V3XX_INT_CLR);
+
+	if (int_stat & HISI_SFC_V3XX_INT_STAT_ADDR_IACCES) {
+		dev_err(host->dev, "fail to access protected address\n");
+		return -EIO;
+	}
+
+	if (int_stat & HISI_SFC_V3XX_INT_STAT_PP_ERR) {
+		dev_err(host->dev, "page program operation failed\n");
+		return -EIO;
+	}
+
 	if (op->data.dir == SPI_MEM_DATA_IN)
 		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, len);
 
-- 
2.8.1

