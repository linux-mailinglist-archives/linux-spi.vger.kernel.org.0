Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98852770E7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIXMZz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:25:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727468AbgIXMZy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:25:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 455BBEEFC9594D316F69;
        Thu, 24 Sep 2020 20:25:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 20:25:46 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <john.garry@huawei.com>, <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yangyicong@hisilicon.com>
Subject: [PATCH 3/4] spi: hisi-sfc-v3xx: factor out the bit definition of interrupt register
Date:   Thu, 24 Sep 2020 20:24:29 +0800
Message-ID: <1600950270-52536-4-git-send-email-yangyicong@hisilicon.com>
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

The definition of the register field in the interrupt corresponding
registers are the same. So factor them out to public place.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 62d4ed8..4a241d7 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -18,10 +18,7 @@
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
 #define HISI_SFC_V3XX_INT_STAT (0x120)
-#define HISI_SFC_V3XX_INT_STAT_PP_ERR BIT(2)
-#define HISI_SFC_V3XX_INT_STAT_ADDR_IACCES BIT(5)
 #define HISI_SFC_V3XX_INT_CLR (0x12c)
-#define HISI_SFC_V3XX_INT_CLR_CLEAR (0xff)
 #define HISI_SFC_V3XX_CMD_CFG (0x300)
 #define HISI_SFC_V3XX_CMD_CFG_DATA_CNT_OFF 9
 #define HISI_SFC_V3XX_CMD_CFG_RW_MSK BIT(8)
@@ -34,6 +31,13 @@
 #define HISI_SFC_V3XX_CMD_ADDR (0x30c)
 #define HISI_SFC_V3XX_CMD_DATABUF0 (0x400)
 
+/* Common definition of interrupt bit masks */
+#define HISI_SFC_V3XX_INT_MASK_ALL (0x1ff)	/* all the masks */
+#define HISI_SFC_V3XX_INT_MASK_PP_ERR BIT(2)	/* page progrom error */
+#define HISI_SFC_V3XX_INT_MASK_IACCES BIT(5)	/* error visiting inaccessible/
+						 * protected address
+						 */
+
 /* IO Mode definition in HISI_SFC_V3XX_CMD_CFG */
 #define HISI_SFC_V3XX_STD (0 << 17)
 #define HISI_SFC_V3XX_DIDO (1 << 17)
@@ -266,15 +270,15 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	 * next time judgement.
 	 */
 	int_stat = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
-	writel(HISI_SFC_V3XX_INT_CLR_CLEAR,
+	writel(HISI_SFC_V3XX_INT_MASK_ALL,
 	       host->regbase + HISI_SFC_V3XX_INT_CLR);
 
-	if (int_stat & HISI_SFC_V3XX_INT_STAT_ADDR_IACCES) {
+	if (int_stat & HISI_SFC_V3XX_INT_MASK_IACCES) {
 		dev_err(host->dev, "fail to access protected address\n");
 		return -EIO;
 	}
 
-	if (int_stat & HISI_SFC_V3XX_INT_STAT_PP_ERR) {
+	if (int_stat & HISI_SFC_V3XX_INT_MASK_PP_ERR) {
 		dev_err(host->dev, "page program operation failed\n");
 		return -EIO;
 	}
-- 
2.8.1

