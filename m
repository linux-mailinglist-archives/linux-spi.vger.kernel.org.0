Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE823616F0
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhDPAtZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:25 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:57440
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237446AbhDPAtY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP4cNNQ3v2DvU8s1MLQBXwpttQRulWZhfkyj0fP0c5/nwcCCKaXmYFDdu4UdYGSlE9laivLJ7tSPYuT7CVYwGB+7rEpQPM3A9EI663aIoTYmNTlr6Deo5yU3KbhzYGIMWyFBQSvchvZKys4RSJdVyxlx0gvX6pGAu9LNSY7HENv2niFYsquRIQkmSO137enfWQdkt1RCRDfXEUUTZg8WZ/ZWVVb9rK70xSUt15y3QCjrJgvlFq2y0ScsboSUMGjNiKSyLepkLlhoFcyE5+F7/YFBNDuuanepyoxEGihwUBAkQYtjHIVhDYFkkQL+69HcPuz+CTqgfll/cw/L0CzGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/EezMl+AMRAE05C1QQmPwko1nGRNn78okU3d+kht3E=;
 b=ctAVbgNYIYVp0sCPwgmcQrTySJ3SqOW4FXj8ConkW2mZPLc3wWExPpuUH/JulG7EP1TTCk3CTC9GGXNDAMqAYdA31k7vwKtdb/2FICHoHKJ795WuSFpGdvw2IQKu0ejRIiPYiLhNhqRST3UNFEtr+iSylcCr/LWK6ah7In42HGZwvPha0yPfOD8Vp4hjNOqAC4NT69PsF827Tjr33gyhUiVdX4V7BjuIMOGsJzOa+dfbBeuJmTZ2dQI0332BTMBbV30ZDoFGgjjuRuNAqtM341q8vfUi1M8udnrv6AfoIk3EYMhD9up1UiBFiqChJTze5whsdYXmf0JH9erjCx1BHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/EezMl+AMRAE05C1QQmPwko1nGRNn78okU3d+kht3E=;
 b=oDYN11H22RCWmnhtWNFYLAGCEbUHlTGmR3I3F8qg9C1IOYTIDOxUg0jad1HuMeguDWvr+Dual/efHpbLvHBZ4Pi4x6kJfaC0cbFGC4aUBEEIppnnt8RsFacTInGRVHGHActkegx32Az77T2HO4iCXihgq1VG8IqsyT0O04ABKeo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:49:00 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:49:00 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails
Date:   Fri, 16 Apr 2021 08:46:52 +0800
Message-Id: <20210416004652.2975446-6-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416004652.2975446-1-quanyang.wang@windriver.com>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcf291b-8a08-4072-d5f6-08d900716c14
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB125622A5587680B1C774B99EF04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bi5Lwz+ZW5n+X6LAFjj9hsz8FBLP1ciDR3vdv0936TS8Rg88CLvyD1ls+uou6YIKqsMfTlTRtM1xPpZnukzi9R5fokp5BWRl4QzJLS3keLaFWNtEC/OaDUtOfLyhKBc3w5vxkP3UcxPwokobB8UcrWx4+QIMPyZ7l5mdlsH0yBJh7zEOm6Z4deu+2kJu/1jQwhUuBoTiVp3lnmDXcADLMObFFrTf3VU4CyM9Fe65ipr3U4rT23OylV+5B6Rspmd4TE8LsUlWI+SRTKZ5R+O2v5H8FODodsBFgHiGuwWS5O2TpQslcd/Bp1n+tBrIN61Y4PuJTpos6LmAiDjK1WAzraPxQy4eiSOCtPWvt7IVauvGYPDeo4yIxVpieag6LPs9DKdxC6wjM7m4m/uCDS9Yj7NB/KhryBBZu3lD0MqUshoqLAIGBH8MJr+m58VBfeR0bzTvGqsvcixOro2yzPkrR7hn8FyPp6O07SPPh6/op+qR2hp9aDTHE9MvDT+8uPtW9j9jhMwHqfGAarOXp9vQczn7qVwlVeIGuiwJzi5/KuaWe9LgJ2hV3baW4GjQJOtekHUMw63cgSJysZe3TD87F4zjwVBOeNeZ3jkzqYB1G16UTiDvTn5FKhfZEd/6hmhR7q5EBgGylKQP4ifaGEuOSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(6666004)(66946007)(86362001)(83380400001)(4326008)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sH5eort9NIO7eIyRFUygEWDWc82HIWBJqWX97AGQQItfqW5O8wtHbtQ2jbqP?=
 =?us-ascii?Q?fQ5ihyP1IV5enTo0cxbiO9QhId1doySpx5FChDzi8eMck2DDgz9zFF1cvSsM?=
 =?us-ascii?Q?HSFHXoMFS9vZoxIZ2wo8jPXzDv6ENNinLsDh9WgdSx2UNnV8zlP7dWKu+SqJ?=
 =?us-ascii?Q?eFTPDHQMnMcEJEpVYcZT5oeVtAVv/EwVLc7BWQ2fsgrtdQy5bXYefrxPF5FD?=
 =?us-ascii?Q?UTLqaK5QEbaD9bneXsr2MJ/ENRN69IVsgRXi6RM334Ke8xi8qwL/Ah536XyB?=
 =?us-ascii?Q?acbJ/L6xjeuiWXnY++2CLrHpBsGUzP40xs0DYKPWGCwLsKvfbBvT+K+iw/Ny?=
 =?us-ascii?Q?v7AWZ7mKKksMHs53ZuDh1HljNIIeDwOn4wR+auVW5TCBnFyye7CERrUabx7v?=
 =?us-ascii?Q?bBDb50hI98HZWb66ep+KqWUdriYhJb1k6OyYp9ntVYsiKQnSVPuIXRpKh1nP?=
 =?us-ascii?Q?JHA5DAupAKUA2nc65A/fZtmQyChxulcltRoSk/yaID0ZY+adsX3MLWb7pZuG?=
 =?us-ascii?Q?JAKDjxCenjXWdpbK5TlGIuQL3ln9vGZRZuTDkRJrEkCrJCIZJIF8rKg5wVBw?=
 =?us-ascii?Q?tMYffp4YNmvviBgwn4MFCHhR/nLqDa4oEkAvZuWVkF+rmgQFsMY2FKbSuqT/?=
 =?us-ascii?Q?FJq7P+nQdsBMIIwVju3Nwh1T3FUNe38bSt/iu/gQuwH0qW5W4OTqAKfhJMXu?=
 =?us-ascii?Q?9NwwUJQDTuFAI5IO/I77LHTdw0C2gwC6xRggVe9zJ42xmdwo9+BjmP1TAa1E?=
 =?us-ascii?Q?PuwOwFiWCQmUB3GYrvF6d5iO7dI3oLNs+RkAnERWymL1i+HXIjFMZoARhosq?=
 =?us-ascii?Q?Svu5y9dh8MMGhKl8o5RilKbRMIpNV4todH4Aqw0RANr5YJ+8M9/fA3XiajBT?=
 =?us-ascii?Q?AHGYKzrd0bSw94HtTfzVp4THYI7ztGKVE5UtGdUkYTvclMjiNI68PuYs5SYu?=
 =?us-ascii?Q?ryDdqfpinqPzzOi2Bo/FwCLdOhjnEgToHcwQdlKmusS4j18NJVh28leTvhOq?=
 =?us-ascii?Q?XdJdpoZP++3H3RVHzjaD6cOLSjZAX1XhKUQtSpg7Xnm1V7z6dUAZ6K/pCMlP?=
 =?us-ascii?Q?UPXnfkl/LXIfK/t4u4wLmlDigilwgxE6SejQhNFQNILmSLTQUWrVIX72tgSN?=
 =?us-ascii?Q?GHKsPLRrZ80Y1BZCi9rOzD7OQYpLJS/KVo2OO8YFlBoRfYUt+RrVl+7IeM3M?=
 =?us-ascii?Q?rIApggsu94LwB2TP6V9yg2wFy2hO9g0viPo9d+HGME/Pys6PvjFJKu2kagGs?=
 =?us-ascii?Q?REL+28MmKwy4134ea6DlvPsJp9V0+5ahAYG19f74wbmtAiZDPNHNW9Z6nbnZ?=
 =?us-ascii?Q?ns1ID5NBwlXV4wmlAxtIMjr2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcf291b-8a08-4072-d5f6-08d900716c14
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:59.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYrkqdtiav9mgpSi3fOXbuhD4QWLtnuv2symjG02Ofrt6wl5Yu9eSx6zNHqga29M9zN5gBW9xQWJsBRK30HyMmcjFYqQzaxh6fMnFMAhUfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The spi controller supports 44-bit address space on AXI in DMA mode,
so set dma_addr_t width to 44-bit to avoid using a swiotlb mapping.
In addition, if dma_map_single fails, it should return immediately
instead of continuing doing the DMA operation which bases on invalid
address.

This fixes the following crash which occurs in reading a big block
from flash:

[  123.633577] zynqmp-qspi ff0f0000.spi: swiotlb buffer is full (sz: 4194304 bytes), total 32768 (slots), used 0 (slots)
[  123.644230] zynqmp-qspi ff0f0000.spi: ERR:rxdma:memory not mapped
[  123.784625] Unable to handle kernel paging request at virtual address 00000000003fffc0
[  123.792536] Mem abort info:
[  123.795313]   ESR = 0x96000145
[  123.798351]   EC = 0x25: DABT (current EL), IL = 32 bits
[  123.803655]   SET = 0, FnV = 0
[  123.806693]   EA = 0, S1PTW = 0
[  123.809818] Data abort info:
[  123.812683]   ISV = 0, ISS = 0x00000145
[  123.816503]   CM = 1, WnR = 1
[  123.819455] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000805047000
[  123.825887] [00000000003fffc0] pgd=0000000803b45003, p4d=0000000803b45003, pud=0000000000000000
[  123.834586] Internal error: Oops: 96000145 [#1] PREEMPT SMP

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 419bc1e6358b..328b6559bb19 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -733,7 +733,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
  * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
  */
-static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
+static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
 	u32 rx_bytes, rx_rem, config_reg;
 	dma_addr_t addr;
@@ -747,7 +747,7 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 		xqspi->mode = GQSPI_MODE_IO;
 		xqspi->dma_rx_bytes = 0;
-		return;
+		return 0;
 	}
 
 	rx_rem = xqspi->bytes_to_receive % 4;
@@ -755,8 +755,10 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 
 	addr = dma_map_single(xqspi->dev, (void *)xqspi->rxbuf,
 			      rx_bytes, DMA_FROM_DEVICE);
-	if (dma_mapping_error(xqspi->dev, addr))
+	if (dma_mapping_error(xqspi->dev, addr)) {
 		dev_err(xqspi->dev, "ERR:rxdma:memory not mapped\n");
+		return -ENOMEM;
+	}
 
 	xqspi->dma_rx_bytes = rx_bytes;
 	xqspi->dma_addr = addr;
@@ -777,6 +779,8 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 
 	/* Write the number of bytes to transfer */
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_SIZE_OFST, rx_bytes);
+
+	return 0;
 }
 
 /**
@@ -813,11 +817,17 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
  * @genfifoentry:	genfifoentry is pointer to the variable in which
  *			GENFIFO	mask is returned to calling function
  */
-static void zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
+static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
 {
-	zynqmp_qspi_setuprxdma(xqspi);
+	int ret;
+
+	ret = zynqmp_qspi_setuprxdma(xqspi);
+	if (ret)
+		return ret;
 	zynqmp_qspi_fillgenfifo(xqspi, rx_nbits, genfifoentry);
+
+	return 0;
 }
 
 /**
@@ -1031,8 +1041,11 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 			xqspi->rxbuf = (u8 *)op->data.buf.in;
 			xqspi->bytes_to_receive = op->data.nbytes;
 			xqspi->bytes_to_transfer = 0;
-			zynqmp_qspi_read_op(xqspi, op->data.buswidth,
+			err = zynqmp_qspi_read_op(xqspi, op->data.buswidth,
 					    genfifoentry);
+			if (err)
+				goto return_err;
+
 			zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 					   zynqmp_gqspi_read
 					   (xqspi, GQSPI_CONFIG_OFST) |
@@ -1159,6 +1172,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
-- 
2.25.1

