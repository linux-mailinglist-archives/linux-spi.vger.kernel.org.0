Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101EB362220
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbhDPOWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:52 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:29089
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244696AbhDPOWw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+rW5bsTS+hAp7er79LsJSnl8Gx4nZvDU5TVkKfP1STVpPcHarsIxaNi3LPhAGz7v4aigDwfVyWD4NNvh6bAiCIGsAqwVDyg/L2csfFXb8THha76Y2//riDMxZwDTuSRWEP1615Wg+v2QntKiE1TdIVntY9m0/bAQsUr9RXSXuASGFYPSgUG1FRi2PfbA2UtxlpteFBAiJskHFu3Kbd3Sr50r3Ytvgzdi6lT9qz5ydspVoGjKz58SBHzAh0g6BAVA655uMjEBP5l/yP8XVNNCUQWJURSjTa1TbGWnu/tZRM/c1FisYrbXsYEnpaF/BG5+vXKZssSMdo0ygkrs6mi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEEseomfkt/2DJqbH8TTqFjQdRgIigv5Y586PQH9HzI=;
 b=bE2gNBjE26eXhLGgUdw+KPKZp/P4CRTKGfdxFEwC4ZqaNC2nLHSvVYDsyPxDC9vjBtSeq67k3yIM5IUlznFPcPA5VEHBP3lR37dFCm8lNHcYO3KXO6ae6GJMf65Cv6cQinuVgscVufWuZfr0DX1K5uJxgxR5uKGncQATIgjJ2do79B4dYfFEhMOG3E8Sk3H1gMMQ8lwLtcqP4NyHTumo+ufqDcp0k0ggA0Bi43kff7KXlmDwdfaeCSz5+K3V+nQ2q7o7cmHzm5jaWjDZr9Vrh98NIRAx9D8YAMHmXQa5+14vXzSvehC/L9phQuBkg96t9cdCzVuEukJl5KaXbjApxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEEseomfkt/2DJqbH8TTqFjQdRgIigv5Y586PQH9HzI=;
 b=DBcoQ0NV863uk/23xkqFaFd3GtooXSZXb/y76vAVvBImzeiaFnDUDb7c3kdaJk2auI2jt/M4Lbl4RewLF3zbJCFC19KH8UvLSSlgM/Tyv3kECg+CtdvrHzqIof0wH9gYjcTDkmF25PC2jZJjko0CV8wE1cpj7S4X45UkNjjLZhE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:26 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:26 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails
Date:   Fri, 16 Apr 2021 22:20:47 +0800
Message-Id: <20210416142047.6349-6-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416142047.6349-1-quanyang.wang@windriver.com>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97494371-f883-4191-6bbc-08d900e30f09
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2264AAC9D60E06B363974180F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0PssXsM8sDSzkKBFvt2afBWdd3C2F63HVVIndKD5j1JnAe2ftnP3OtwWDivWcd0ItHw2AJcRCrBNAvRupZ5xRRsCpnajrAxPeeXLwMDNVgBtkwozyh1eY/tao4GWIlP8LcMENlG+mi5NEDl32ZYa9Y9udQgS1CtnrkZkSJrz5U0aUaex+kD739qhB3rN1cAT/eMzhW6FVZzCkYrjlT/Ooh88RogNL1G1tZJnxMBr8ZDnrJOYFmdBNgBEPXCLwsNRQhvxxtU79HSDhEy1gbrHA9j2PWk88+HWuKTLVNvjr391vW4im0AQd6B+sjY63U7Dp58Z3fCgVsjzoNmtp50x3tu5HNsydXoIR/JkxNpoYMkabJeZyHSXJKNYDA1Wvh7AtpmVJoABiNJeu5RuaEGe1G3gDzstIhFhSP8ZPzOQORgACYNLTBPIzbLwyCeTSAVZXAv4OpEeHYjRC330jrYwfkV/+T+FrYueC8wOSRQB7bMOIi9yW87aPnQh/MFoyL2HZXjxOOzniCO+F7HD9xWuFUmniW7SMegmDCY/99YzC8uxDnPA72F1z1YuljQjVglrU00W+Z3/pS9dzebMTVARm55dRpWKL2f+ZzxJ17SXL65KRIncYXY4vEOI3HiuNaoX7DGhQqSoGYTBvAwNmF0Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Cv/yTRUX2QunEK//59kSOJL9G5wV51AQGYd76dP4TNkzLoafF0+I6PH2zsRP?=
 =?us-ascii?Q?gmnkj7qArX3FvkJCos9BiW+L/7x41QPqRin/w2yu+ERvg21nu5GVyqzE/URV?=
 =?us-ascii?Q?Y0TOmmMqsWGEvUFPRM6k52dayUOqiMMdlr1F8v7IVXw7949YP9s3/Bqp0xD8?=
 =?us-ascii?Q?QWYkITfnx+9bczw14JJm3ys1ZZc/KawzBcfO5FTMj/cO8l25uGDpffvpxQxD?=
 =?us-ascii?Q?ix64Q61yD1jaVAIWc+hPQBKrnMxArE1Sztupe5jmjorBviFdSS/TBY+6Vkmy?=
 =?us-ascii?Q?LHLY9zEJV2+fR85etdXBzQHCPtVaKLeIvnfHYkLfbkvvaCRG3/wzMCmZWcD8?=
 =?us-ascii?Q?IsGXrEr3INcmX5SzURiO97QTCI5SXeGWjI0itVYOYzuICWPcAZZC8OThmRDF?=
 =?us-ascii?Q?cbDJi4/G/SBHziFpv1lOiYAoz/8Rb3crm4mopVri2MLtWyedBuKFpvWDvi+W?=
 =?us-ascii?Q?Pp0XK2T7DUXT4LKNcP00C7D6aWJy8gF9eiW4Dszx5mqEfAgVwUo7joZpfWNa?=
 =?us-ascii?Q?VHklFsibSEDPwIMg/zX6YQGNjSuC3La3JWM5UKSwyGaTetOcWLDjZ1Kzzla3?=
 =?us-ascii?Q?yugOX0UVlxGf7Lx/JOTRLgGG9/5PalPylYec9+0X35YHAwxEZ4ZFXZExsoJh?=
 =?us-ascii?Q?jDSBHG/sWkMaDkUg3RSWS///m4pqUrFAhUeNObK+w42iDpaILlgHdr7MCo3X?=
 =?us-ascii?Q?BToORTrV1XhaFzufDNojxz5RuZQDJO93mfdzayZVaS/6qCDo4Shw7mwEAtnb?=
 =?us-ascii?Q?3SusN+pi5ZO+Ug7i95oRPpya4HokvGH3A9nErHJfwKZO+sZEDph94s9QUzdZ?=
 =?us-ascii?Q?jrvQ3ufpQMRSsQxBolHrJAbu93olHwzRYDx1fXDoZ7ZSnzT8ZUBKGA25anBP?=
 =?us-ascii?Q?MUlmWRo/b/ohlaBIqEfeIPqenEjMyDAZ+gi5YEDFn3DP4WTXp96NBtjBeEMb?=
 =?us-ascii?Q?QhvkeW1kV5E5PFmVSSwwARU9UOg4mD4kDpXFmvaVETB2uN60sjUEqL79hQOe?=
 =?us-ascii?Q?nArJKwrkuWXCGVSgGBBZIQ2mDe9XOrCqx8ei6GUp8I2SfEF/oTJYiukASzT7?=
 =?us-ascii?Q?64BaT6AoDCGLd9cD8TRDppRMgRwcHOTU3zEBTEdxfGRbvfDjXE8Nd18buxh0?=
 =?us-ascii?Q?NK8hiuYvMU+a9qncbkAOOOZLO4/4pWrGzpX9EvWRTuPsqKlK+kYeEY7ZtvrV?=
 =?us-ascii?Q?moqXZPfG0NuVVVqo5tRWxqjdefkIV+0asmnGaw6v8CKwTIt9Vm4DlVz4GDUL?=
 =?us-ascii?Q?GciDveXVNDSLoCZbevpNRscw4L/efQfJLLZ/uPDOncRWzFrBWjVmsi5B3rsp?=
 =?us-ascii?Q?f9TkPSvovLyy2kkAoyo95BU/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97494371-f883-4191-6bbc-08d900e30f09
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:26.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tJzrjZvql/ijI16JyfAFgwbuoDRHGM97qPlL2TUeY9WO5/p/IoOsi3w8jFtlouCDMLFjlaY5Y1bw/2t4HTaxUlRo5/5CDCtNnf6dCBl8Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
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

