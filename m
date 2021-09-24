Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE53A417015
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbhIXKMV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 06:12:21 -0400
Received: from mail-mw2nam12on2086.outbound.protection.outlook.com ([40.107.244.86]:56193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245602AbhIXKMC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt+1I7Ooruh1v19LEpp1c1Y3Nkt9TiCV46lFCV5qJZ7ocuhUeBoEMrqpG/JtnhJEl0frlzh+SNJd17+pvryEqjtv1kyGD1D+ZWJpGjRwphBWyi9DyBfeQKGfsTzi3MVlp75piqIgRuvOS8zSrU7DxzsOE96Nrovk60rsk1ya6Fj6bdldXUmSXDkYpzlDF/+h+CqOkzyWnAG+bItvP4bO182LeTqAgUl5YaZO0xeJ85kibYWhg+K/D5kLMb9llNqCI7/HjZI1SE+hsLZjDupBAuf2ZPOIEu1Ft/KVY3kucXCt2XJLlEl3D8BdKPmsUm9sMjWgrF5V6jkJju4ZLfrI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qkF3KBKI+Ob3tRZnw4hvPPMNYZooDP4oyCh0vbH0fMU=;
 b=hPg6YpYvxtWG+tOZCgzoczSgG64Wl2OdT+wonXt0/82EG3hpj3nU471heD1l8CH4be95Mln/kxQPRHwgRvgFdrCPSRNfP3TfgrZRxGZ/XuOp4GHnTtUjxV0P57FgBqYny3zFgjOLKqR15H/0B7PkUxeCq4s6Wr8Mj4cN7D1R/ILMQLC2tCD+iC3XJABw8ZBxYmNUmWr4lIv2XliLvUtcGLIONIr0Wzmd50CHJTVjxhNsh88YFJCq7k9ceRlOFlHTBXFlIAwxRyEcjCXuxwoNDLtu00wqK6aIvrLju2Ut6bE1cNAVRAM7DpC8hc5VOGnuDXifLpz5sJm5IPT4FbtILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkF3KBKI+Ob3tRZnw4hvPPMNYZooDP4oyCh0vbH0fMU=;
 b=oxPZW8YLIhKwwTSnSUCRpyj9lng9PLMHTOb5BN3s3M/fO9ATzbRI47V8YvS4P+wzfwBwANGIG5zTwdTKJK2l3y/t730p3CZnadS1ogqp+lpVsg5WRWYclKXKYf+Lot3EGs6TJSEFzsfbgVWYMDjO416TxGacUNDHvga4DdChlJI=
Received: from BN8PR16CA0034.namprd16.prod.outlook.com (2603:10b6:408:4c::47)
 by SN6PR02MB4239.namprd02.prod.outlook.com (2603:10b6:805:2d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 10:10:26 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::5d) by BN8PR16CA0034.outlook.office365.com
 (2603:10b6:408:4c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 10:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 10:10:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 03:10:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 03:10:11 -0700
Envelope-to: git@xilinx.com,
 arnd@arndb.de,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.63.68] (port=41934 helo=xhdvnc208.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1mTi9h-000EgD-S3; Fri, 24 Sep 2021 03:10:10 -0700
Received: by xhdvnc208.xilinx.com (Postfix, from userid 14964)
        id 4FBC52089D; Fri, 24 Sep 2021 15:39:16 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 4/4] spi: cadence-quadspi: Add Xilinx Versal external DMA support
Date:   Fri, 24 Sep 2021 15:37:11 +0530
Message-ID: <1632478031-12242-5-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4621995c-8514-4e0a-d4fb-08d97f4387d1
X-MS-TrafficTypeDiagnostic: SN6PR02MB4239:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4239FAE00AAD3AA5A9B49E99BDA49@SN6PR02MB4239.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F7xDAB7q7zSGWUMxifypAGwP6Cenw1a390z4PhmlTJCcrlSLqOauLjkA+72ZLuLzKhrkgLSKW+V46mLwafabL9Q4O3egQAy69qjVCy8Qy56xc2lghMpTs9wyWTCTHV9C50vI/VVqgkPyFo0lfKaikuGb0ZiwZ4p9sHeka9xGWxLQ4NLGG84NFhTQnKh5uEHpmeZTnwfF+Rgvd+CTRK9aMn/cmBBwNePmAHDHNSb3NaGRuzpKkJVk6+cWUJyFJalgwq2CGHnLyE3tGifheucG1cf4s5q1XjHAnBB9p4p8iO54xjsUbXVCmzyNjTfM22L60sDhoFXZL7FFY9I18D7Rrreq5tZzeE4/1oCIg5UNVYm+Nae+SNH8pu51jT+Ml8wCzekRghm+wH2yp1QGYvN5SvTrwhFKqOk8I3c9a+o2fXUmhBvQjRopTj0Irkb6Gh6qrvImMru5PmCeDIHTlbx8IOT2mE8iaJaHmxsr0mfF1z7bHtVaxgn4Fnm3nItf21gBwIHq9kr8M2a088nxk+8aftBnldMoADDhDp2W39sBw7liJeB5/mDwnpJkaiuh7HbXFHwLqWPs1ys4EshT/0HNDO/YMrS3wbqmdJqWfP8lMfeclIXGpwJK3+WX2BR2AlWD0hTfx2OqjRCiXNrCjIXPVTb/nQn/WWoVHBjpZWpSBiPhG1f+AipLlHVoIEvgFQzxmL9iDFGhWGPrT6D1ttkwMZQBo1xQ4fTJ8OA0+xMf70=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(36860700001)(2906002)(70206006)(508600001)(82310400003)(30864003)(186003)(2616005)(6666004)(26005)(8676002)(5660300002)(426003)(336012)(47076005)(36756003)(6266002)(316002)(7636003)(36906005)(7416002)(107886003)(110136005)(4326008)(356005)(70586007)(54906003)(83380400001)(42186006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 10:10:26.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621995c-8514-4e0a-d4fb-08d97f4387d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4239
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support to read the data from the flash using external DMA.
Cadence Octal SPI Flash Controller has optional DMA peripheral interface
to communicate indirect mode of operations with external DMA.
Xilinx Versal OSPI has external DMA enabled, this will automatically
request the external DMA to fetch the data from SRAM. It supports only
reading the data from SRAM (DMA read) and doesn't support writing the
data to SRAM (DMA write).
Xilinx Versal OSPI read the data from the flash device using external DMA
and write the data to the flash device using software triggered
indirect mode.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/spi/spi-cadence-quadspi.c | 207 ++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 32cba7830b58..5bdb1bae5c99 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -36,6 +36,7 @@
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -83,12 +84,16 @@ struct cqspi_st {
 	u32			wr_delay;
 	bool			use_direct_mode;
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
+	bool			use_dma_read;
 	u32			pd_dev_id;
 };
 
 struct cqspi_driver_platdata {
 	u32 hwcaps_mask;
 	u8 quirks;
+	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
+				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
+	u32 (*get_dma_status)(struct cqspi_st *cqspi);
 };
 
 /* Operation timeout value */
@@ -219,6 +224,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_INDIRECTWRSTARTADDR		0x78
 #define CQSPI_REG_INDIRECTWRBYTES		0x7C
 
+#define CQSPI_REG_INDTRIG_ADDRRANGE		0x80
+
 #define CQSPI_REG_CMDADDRESS			0x94
 #define CQSPI_REG_CMDREADDATALOWER		0xA0
 #define CQSPI_REG_CMDREADDATAUPPER		0xA4
@@ -233,6 +240,23 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
 #define CQSPI_REG_OP_EXT_STIG_LSB		0
 
+#define CQSPI_REG_VERSAL_DMA_SRC_ADDR		0x1000
+
+#define CQSPI_REG_VERSAL_DMA_DST_ADDR		0x1800
+#define CQSPI_REG_VERSAL_DMA_DST_SIZE		0x1804
+
+#define CQSPI_REG_VERSAL_DMA_DST_CTRL		0x180C
+
+#define CQSPI_REG_VERSAL_DMA_DST_I_STS		0x1814
+#define CQSPI_REG_VERSAL_DMA_DST_I_EN		0x1818
+#define CQSPI_REG_VERSAL_DMA_DST_I_DIS		0x181C
+#define CQSPI_REG_VERSAL_DMA_DST_DONE_MASK	BIT(1)
+
+#define CQSPI_REG_VERSAL_DMA_DST_ADDR_MSB	0x1828
+
+#define CQSPI_REG_VERSAL_DMA_DST_CTRL_VAL	0xF43FFA00
+#define CQSPI_REG_VERSAL_ADDRRANGE_WIDTH_VAL	0x6
+
 /* Interrupt status bits */
 #define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
 #define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
@@ -252,6 +276,9 @@ struct cqspi_driver_platdata {
 					 CQSPI_REG_IRQ_UNDERFLOW)
 
 #define CQSPI_IRQ_STATUS_MASK		0x1FFFF
+#define CQSPI_DMA_UNALIGN		0x3
+
+#define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
 static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
 {
@@ -277,10 +304,26 @@ static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
 	return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
 }
 
+static u32 cqspi_get_versal_dma_status(struct cqspi_st *cqspi)
+{
+	u32 dma_status;
+
+	dma_status = readl(cqspi->iobase +
+					   CQSPI_REG_VERSAL_DMA_DST_I_STS);
+	writel(dma_status, cqspi->iobase +
+		   CQSPI_REG_VERSAL_DMA_DST_I_STS);
+
+	return dma_status & CQSPI_REG_VERSAL_DMA_DST_DONE_MASK;
+}
+
 static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 {
 	struct cqspi_st *cqspi = dev;
 	unsigned int irq_status;
+	struct device *device = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata;
+
+	ddata = of_device_get_match_data(device);
 
 	/* Read interrupt status */
 	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
@@ -288,6 +331,13 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	/* Clear interrupt */
 	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
 
+	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
+		if (ddata->get_dma_status(cqspi)) {
+			complete(&cqspi->transfer_complete);
+			return IRQ_HANDLED;
+		}
+	}
+
 	irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
 
 	if (irq_status)
@@ -783,6 +833,131 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
+					  u_char *rxbuf, loff_t from_addr,
+					  size_t n_rx)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg, bytes_to_dma;
+	loff_t addr = from_addr;
+	void *buf = rxbuf;
+	dma_addr_t dma_addr;
+	u8 bytes_rem;
+	int ret = 0;
+
+	bytes_rem = n_rx % 4;
+	bytes_to_dma = (n_rx - bytes_rem);
+
+	if (!bytes_to_dma)
+		goto nondmard;
+
+	ret = zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id, PM_OSPI_MUX_SEL_DMA);
+	if (ret)
+		return ret;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_DMA_MASK;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+
+	dma_addr = dma_map_single(dev, rxbuf, bytes_to_dma, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(dev, "dma mapping failed\n");
+		return -ENOMEM;
+	}
+
+	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
+	writel(bytes_to_dma, reg_base + CQSPI_REG_INDIRECTRDBYTES);
+	writel(CQSPI_REG_VERSAL_ADDRRANGE_WIDTH_VAL,
+	       reg_base + CQSPI_REG_INDTRIG_ADDRRANGE);
+
+	/* Clear all interrupts. */
+	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
+
+	/* Enable DMA done interrupt */
+	writel(CQSPI_REG_VERSAL_DMA_DST_DONE_MASK,
+	       reg_base + CQSPI_REG_VERSAL_DMA_DST_I_EN);
+
+	/* Default DMA periph configuration */
+	writel(CQSPI_REG_VERSAL_DMA_VAL, reg_base + CQSPI_REG_DMA);
+
+	/* Configure DMA Dst address */
+	writel(lower_32_bits(dma_addr),
+	       reg_base + CQSPI_REG_VERSAL_DMA_DST_ADDR);
+	writel(upper_32_bits(dma_addr),
+	       reg_base + CQSPI_REG_VERSAL_DMA_DST_ADDR_MSB);
+
+	/* Configure DMA Src address */
+	writel(cqspi->trigger_address, reg_base +
+	       CQSPI_REG_VERSAL_DMA_SRC_ADDR);
+
+	/* Set DMA destination size */
+	writel(bytes_to_dma, reg_base + CQSPI_REG_VERSAL_DMA_DST_SIZE);
+
+	/* Set DMA destination control */
+	writel(CQSPI_REG_VERSAL_DMA_DST_CTRL_VAL,
+	       reg_base + CQSPI_REG_VERSAL_DMA_DST_CTRL);
+
+	writel(CQSPI_REG_INDIRECTRD_START_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+
+	reinit_completion(&cqspi->transfer_complete);
+
+	if (!wait_for_completion_timeout(&cqspi->transfer_complete,
+					 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS))) {
+		ret = -ETIMEDOUT;
+		goto failrd;
+	}
+
+	/* Disable DMA interrupt */
+	writel(0x0, cqspi->iobase + CQSPI_REG_VERSAL_DMA_DST_I_DIS);
+
+	/* Clear indirect completion status */
+	writel(CQSPI_REG_INDIRECTRD_DONE_MASK,
+	       cqspi->iobase + CQSPI_REG_INDIRECTRD);
+	dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_FROM_DEVICE);
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_DMA_MASK;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+
+	ret = zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id,
+					PM_OSPI_MUX_SEL_LINEAR);
+	if (ret)
+		return ret;
+
+nondmard:
+	if (bytes_rem) {
+		addr += bytes_to_dma;
+		buf += bytes_to_dma;
+		ret = cqspi_indirect_read_execute(f_pdata, buf, addr,
+						  bytes_rem);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+
+failrd:
+	/* Disable DMA interrupt */
+	writel(0x0, reg_base + CQSPI_REG_VERSAL_DMA_DST_I_DIS);
+
+	/* Cancel the indirect read */
+	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+
+	dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_DEV_TO_MEM);
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_DMA_MASK;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+
+	zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id, PM_OSPI_MUX_SEL_LINEAR);
+
+	return ret;
+}
+
 static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 			     const struct spi_mem_op *op)
 {
@@ -1182,11 +1357,15 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata;
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
+	u64 dma_align = (u64)(uintptr_t)buf;
 	int ret;
 
+	ddata = of_device_get_match_data(dev);
 	ret = cqspi_set_protocol(f_pdata, op);
 	if (ret)
 		return ret;
@@ -1198,6 +1377,10 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
 		return cqspi_direct_read_execute(f_pdata, buf, from, len);
 
+	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
+	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
+		return ddata->indirect_read_dma(f_pdata, buf, from, len);
+
 	return cqspi_indirect_read_execute(f_pdata, buf, from, len);
 }
 
@@ -1366,6 +1549,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 	}
 
+	/* Enable DMA interface */
+	if (cqspi->use_dma_read) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_DMA_MASK;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
+
 	cqspi_controller_enable(cqspi, 1);
 }
 
@@ -1555,15 +1745,12 @@ static int cqspi_probe(struct platform_device *pdev)
 			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_direct_mode = true;
+		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
+			cqspi->use_dma_read = true;
+
 		if (of_device_is_compatible(pdev->dev.of_node,
-					    "xlnx,versal-ospi-1.0")) {
-			ret = zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id,
-							PM_OSPI_MUX_SEL_LINEAR);
-			if (ret) {
-				dev_err(dev, "failed to select OSPI Mux.\n");
-				goto probe_reset_failed;
-			}
-		}
+					    "xlnx,versal-ospi-1.0"))
+			dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	}
 
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
@@ -1674,7 +1861,9 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA,
+	.indirect_read_dma = cqspi_versal_indirect_read_dma,
+	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
 static const struct of_device_id cqspi_dt_ids[] = {
-- 
2.17.1

