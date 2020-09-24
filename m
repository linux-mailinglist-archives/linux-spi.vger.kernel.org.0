Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBE2770EB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgIXMZ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:25:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727651AbgIXMZ7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:25:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CA398AAA78F95E889DD;
        Thu, 24 Sep 2020 20:25:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 20:25:46 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <john.garry@huawei.com>, <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yangyicong@hisilicon.com>
Subject: [PATCH 2/4] spi: hisi-sfc-v3xx: factor out bus config and transfer functions
Date:   Thu, 24 Sep 2020 20:24:28 +0800
Message-ID: <1600950270-52536-3-git-send-email-yangyicong@hisilicon.com>
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

In hisi_sfc_v3xx_generic_exec_op(), we will write the data to the buffer,
configure and start the transfer, read the data to the buffer and check
whether occurs an error. Factor out the config and transfer start codes
as individual functions, to make the process a bit clearer.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 69f5a7b..62d4ed8 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -198,12 +198,12 @@ static void hisi_sfc_v3xx_write_databuf(struct hisi_sfc_v3xx_host *host,
 	}
 }
 
-static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
-					 const struct spi_mem_op *op,
-					 u8 chip_select)
+static int hisi_sfc_v3xx_start_bus(struct hisi_sfc_v3xx_host *host,
+				   const struct spi_mem_op *op,
+				   u8 chip_select)
 {
-	int ret = 0, len = op->data.nbytes, buswidth_mode;
-	u32 int_stat, config = 0;
+	int len = op->data.nbytes, buswidth_mode;
+	u32 config = 0;
 
 	if (op->addr.nbytes)
 		config |= HISI_SFC_V3XX_CMD_CFG_ADDR_EN_MSK;
@@ -227,9 +227,7 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 		config |= HISI_SFC_V3XX_CMD_CFG_DATA_EN_MSK;
 	}
 
-	if (op->data.dir == SPI_MEM_DATA_OUT)
-		hisi_sfc_v3xx_write_databuf(host, op->data.buf.out, len);
-	else if (op->data.dir == SPI_MEM_DATA_IN)
+	if (op->data.dir == SPI_MEM_DATA_IN)
 		config |= HISI_SFC_V3XX_CMD_CFG_RW_MSK;
 
 	config |= op->dummy.nbytes << HISI_SFC_V3XX_CMD_CFG_DUMMY_CNT_OFF |
@@ -241,6 +239,23 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 
 	writel(config, host->regbase + HISI_SFC_V3XX_CMD_CFG);
 
+	return 0;
+}
+
+static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
+					 const struct spi_mem_op *op,
+					 u8 chip_select)
+{
+	u32 int_stat;
+	int ret;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		hisi_sfc_v3xx_write_databuf(host, op->data.buf.out, op->data.nbytes);
+
+	ret = hisi_sfc_v3xx_start_bus(host, op, chip_select);
+	if (ret)
+		return ret;
+
 	ret = hisi_sfc_v3xx_wait_cmd_idle(host);
 	if (ret)
 		return ret;
@@ -265,7 +280,7 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 	}
 
 	if (op->data.dir == SPI_MEM_DATA_IN)
-		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, len);
+		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, op->data.nbytes);
 
 	return 0;
 }
-- 
2.8.1

