Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B03305739
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhA0JpL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 04:45:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11453 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhA0Jnu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jan 2021 04:43:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQdt95jmBzjCw0;
        Wed, 27 Jan 2021 17:42:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 17:42:59 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH 2/2] spi: hisi-sfc-v3xx: add address mode check
Date:   Wed, 27 Jan 2021 17:40:50 +0800
Message-ID: <1611740450-47975-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
References: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The address mode is either 3 or 4 for the controller, which is configured
by the firmware and cannot be modified in the OS driver. Get the
firmware configuration and add address mode check in the .supports_op()
to block invalid operations.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: John Garry <john.garry@huawei.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 4650b48..f71b780 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -19,6 +19,8 @@
 
 #define HISI_SFC_V3XX_VERSION (0x1f8)
 
+#define HISI_SFC_V3XX_GLB_CFG (0x100)
+#define HISI_SFC_V3XX_GLB_CFG_CS0_ADDR_MODE BIT(2)
 #define HISI_SFC_V3XX_RAW_INT_STAT (0x120)
 #define HISI_SFC_V3XX_INT_STAT (0x124)
 #define HISI_SFC_V3XX_INT_MASK (0x128)
@@ -75,6 +77,7 @@ struct hisi_sfc_v3xx_host {
 	void __iomem *regbase;
 	int max_cmd_dword;
 	struct completion *completion;
+	u8 address_mode;
 	int irq;
 };
 
@@ -168,10 +171,18 @@ static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem *mem,
 static bool hisi_sfc_v3xx_supports_op(struct spi_mem *mem,
 				      const struct spi_mem_op *op)
 {
+	struct spi_device *spi = mem->spi;
+	struct hisi_sfc_v3xx_host *host;
+
+	host = spi_controller_get_devdata(spi->master);
+
 	if (op->data.buswidth > 4 || op->dummy.buswidth > 4 ||
 	    op->addr.buswidth > 4 || op->cmd.buswidth > 4)
 		return false;
 
+	if (op->addr.nbytes != host->address_mode && op->addr.nbytes)
+		return false;
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -416,7 +427,7 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct hisi_sfc_v3xx_host *host;
 	struct spi_controller *ctlr;
-	u32 version;
+	u32 version, glb_config;
 	int ret;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*host));
@@ -463,6 +474,18 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &hisi_sfc_v3xx_mem_ops;
 
+	/*
+	 * The address mode of the controller is either 3 or 4,
+	 * which is indicated by the address mode bit in
+	 * the global config register. The register is read only
+	 * for the OS driver.
+	 */
+	glb_config = readl(host->regbase + HISI_SFC_V3XX_GLB_CFG);
+	if (glb_config & HISI_SFC_V3XX_GLB_CFG_CS0_ADDR_MODE)
+		host->address_mode = 4;
+	else
+		host->address_mode = 3;
+
 	version = readl(host->regbase + HISI_SFC_V3XX_VERSION);
 
 	switch (version) {
-- 
2.8.1

