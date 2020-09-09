Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7658326343B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgIIRQG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:16:06 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:38593
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730167AbgIIP2X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQne3eg9/uBTENfc/txBkJPhFVkVtafUzCvZnlTloWPPauVs4T+EFGDIUe9AFZzM+Enh3qNuceBP5dJrQBNoM28kqHFZ8IjU4lQJKSLYt98jqDSROKCEceK0QY0MFeWLI0DIm43INoDLPM5zvI1OWb516Pefi1h70C7QPVOnC8dBFjWj2P7HhoFw/rm49Ja/J6KPFaUEgGOEwkU+N1i+S4k8zLcJE/xRFbVTd1u3lfNx5tr9KwUqB4DeFaMEbt0tmBXlcbnnWp4TaiB2Gvw5jLSqQskYFXDQmGJ8uDx8YHoYZ8ynJFiCV+gVtmN5KOh9wXx9glvzAse+zxc9987sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYm7dvHgevEBLBzV9q39cYMduiZbAfAan1yGqKp/dpU=;
 b=AtKpDw6fI5ddc/eJu8dwEJUvV3uT89QRTkVqQOyjkDADVPld17WloALQ/XphK0SQeOdqYc0kfUJ3YefN6wFCU+9/PVY/JFqTUa0S4RW2+LkQMkkX1Tb3LkyC5fz6V4439ylY2Dtht/aZ0hBD3+kd2VCF0fBkwQBRcg9XYuJqs+2/UddA0EINGvTflQxQNukCQT1Q64wNcGlWGu3cU9eWTN22Y3kW1gvP7X0CovtWjf5xfd2KwRG5gF96sRxdlPRG8WG5dpP0HvAsOKUYvzx1gdrWrFmVOxaymg7osXUqX1StkFvVP9qEjK9XUyl+1eRrZU5ZUc8xV+L74evYhV059A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYm7dvHgevEBLBzV9q39cYMduiZbAfAan1yGqKp/dpU=;
 b=fEbNzoXOSgzE6M+ekwXYWV2Xnlj/7Csnv8026aHbgSqWjO9bGNZeYv5Yr0PIY+cyUq5YVVJi4AazpAgiU1WX9E2vetsaSSphcyxlkrkd7ENM0cfy9LdKpsqyseSJHNhAD7ih1aVef8UCItWIbOjKr2DpQXMlV2ZGXT4jYZin4BU=
Received: from MN2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:208:239::34)
 by BL0PR02MB4433.namprd02.prod.outlook.com (2603:10b6:208:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:27:26 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:239:cafe::1a) by MN2PR08CA0029.outlook.office365.com
 (2603:10b6:208:239::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 15:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 15:27:26
 +0000
Received: from [149.199.38.66] (port=45087 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG205-000567-UF; Wed, 09 Sep 2020 08:27:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20L-00069R-QB; Wed, 09 Sep 2020 08:27:25 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089FRKQA024347;
        Wed, 9 Sep 2020 08:27:20 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20G-00068K-0I; Wed, 09 Sep 2020 08:27:20 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, nagasure@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation
Date:   Wed,  9 Sep 2020 09:27:08 -0600
Message-Id: <20200909152708.2767-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909152708.2767-1-amit.kumar-mahapatra@xilinx.com>
References: <20200909152708.2767-1-amit.kumar-mahapatra@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6c6d7e2-db00-4662-5568-08d854d4db44
X-MS-TrafficTypeDiagnostic: BL0PR02MB4433:
X-Microsoft-Antispam-PRVS: <BL0PR02MB443339844AE1BC63E58E4A30BA260@BL0PR02MB4433.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBZZougCxVzs0FV2ZkRvgqQ8nMK/woq3XU6J+4ErjmN55nIOb79W3HMcs1KGJPQKEoKnS7wJsVjxpNyvogtxDRATS0EUbrV/zvhtXRkk2tirO5S1Q9RsasslEvbt/9kZR+93toWheJRtFPo3tfO/VLmm4jEo93UxU77uL3jqeIjJ8IJZWr/9JWO6vl0WeNZHk6ay2yTgs11OjtinzmIs2/AakYKoqiC4J7fWsukcsyFgY3kmK8R8DGLAyN9re/dd+2PkRjahiPxkIXmrxC2rJFT0S7XazvB2NViiL8HQAGGhI/+LAOzMTRW5X7taDE1t/N8AOc1Er8bjOOxdQudUOEWdT2HBOGYy0BlYTdoOvZEm994e6aIwsJJ2m0SZ9KdDvJJ2wXIfOYTSZMKjwvafSA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(46966005)(6916009)(8936002)(7696005)(4326008)(83380400001)(2906002)(107886003)(2616005)(36756003)(478600001)(47076004)(336012)(82740400003)(9786002)(81166007)(356005)(426003)(316002)(70586007)(70206006)(8676002)(82310400003)(26005)(5660300002)(1076003)(6666004)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:27:26.1363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c6d7e2-db00-4662-5568-08d854d4db44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4433
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixed incorrect indentation in ZynqMP qspi controller driver.

Addresses-checkpatch: "Alignment should match open parenthesis"
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.=
c
index 7f57923f76ea..c8fa6ee18ae7 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -326,8 +326,8 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqs=
pi)
                                 GQSPI_SELECT_FLASH_BUS_LOWER);
        /* Initialize DMA */
        zynqmp_gqspi_write(xqspi,
-                       GQSPI_QSPIDMA_DST_CTRL_OFST,
-                       GQSPI_QSPIDMA_DST_CTRL_RESET_VAL);
+                          GQSPI_QSPIDMA_DST_CTRL_OFST,
+                          GQSPI_QSPIDMA_DST_CTRL_RESET_VAL);

        /* Enable the GQSPI */
        zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
@@ -374,8 +374,8 @@ static void zynqmp_qspi_chipselect(struct spi_device *q=
spi, bool is_high)

        /* Manually start the generic FIFO command */
        zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-                       zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-                       GQSPI_CFG_START_GEN_FIFO_MASK);
+                          zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
+                          GQSPI_CFG_START_GEN_FIFO_MASK);

        timeout =3D jiffies + msecs_to_jiffies(1000);

@@ -384,10 +384,9 @@ static void zynqmp_qspi_chipselect(struct spi_device *=
qspi, bool is_high)
                statusreg =3D zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);

                if ((statusreg & GQSPI_ISR_GENFIFOEMPTY_MASK) &&
-                       (statusreg & GQSPI_ISR_TXEMPTY_MASK))
+                   (statusreg & GQSPI_ISR_TXEMPTY_MASK))
                        break;
-               else
-                       cpu_relax();
+               cpu_relax();
        } while (!time_after_eq(jiffies, timeout));

        if (time_after_eq(jiffies, timeout))
@@ -549,7 +548,7 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *=
xqspi, u32 size)

        while ((count < size) && (xqspi->bytes_to_receive > 0)) {
                if (xqspi->bytes_to_receive >=3D 4) {
-                       (*(u32 *) xqspi->rxbuf) =3D
+                       (*(u32 *)xqspi->rxbuf) =3D
                        zynqmp_gqspi_read(xqspi, GQSPI_RXD_OFST);
                        xqspi->rxbuf +=3D 4;
                        xqspi->bytes_to_receive -=3D 4;
@@ -645,14 +644,14 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi=
 *xqspi)
        u32 config_reg, genfifoentry;

        dma_unmap_single(xqspi->dev, xqspi->dma_addr,
-                               xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
+                        xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
        xqspi->rxbuf +=3D xqspi->dma_rx_bytes;
        xqspi->bytes_to_receive -=3D xqspi->dma_rx_bytes;
        xqspi->dma_rx_bytes =3D 0;

        /* Disabling the DMA interrupts */
        zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_DIS_OFST,
-                                       GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
+                          GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);

        if (xqspi->bytes_to_receive > 0) {
                /* Switch to IO mode,for remaining bytes to receive */
@@ -670,14 +669,15 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi=
 *xqspi)

                /* Manual start */
                zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-                       (zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-                       GQSPI_CFG_START_GEN_FIFO_MASK));
+                                  (zynqmp_gqspi_read(xqspi,
+                                                     GQSPI_CONFIG_OFST) |
+                                  GQSPI_CFG_START_GEN_FIFO_MASK));

                /* Enable the RX interrupts for IO mode */
                zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-                               GQSPI_IER_GENFIFOEMPTY_MASK |
-                               GQSPI_IER_RXNEMPTY_MASK |
-                               GQSPI_IER_RXEMPTY_MASK);
+                                  GQSPI_IER_GENFIFOEMPTY_MASK |
+                                  GQSPI_IER_RXNEMPTY_MASK |
+                                  GQSPI_IER_RXEMPTY_MASK);
        }
 }

@@ -708,7 +708,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_i=
d)
                dma_status =3D
                        zynqmp_gqspi_read(xqspi, GQSPI_QSPIDMA_DST_I_STS_OF=
ST);
                zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST,
-                                                               dma_status)=
;
+                                  dma_status);
        }

        if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
@@ -725,8 +725,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_i=
d)
                ret =3D IRQ_HANDLED;
        }

-       if ((xqspi->bytes_to_receive =3D=3D 0) && (xqspi->bytes_to_transfer=
 =3D=3D 0)
-                       && ((status & GQSPI_IRQ_MASK) =3D=3D GQSPI_IRQ_MASK=
)) {
+       if (xqspi->bytes_to_receive =3D=3D 0 && xqspi->bytes_to_transfer =
=3D=3D 0 &&
+           ((status & GQSPI_IRQ_MASK) =3D=3D GQSPI_IRQ_MASK)) {
                zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MAS=
K);
                complete(&xqspi->data_completion);
                ret =3D IRQ_HANDLED;
@@ -744,8 +744,8 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *=
xqspi)
        dma_addr_t addr;
        u64 dma_align =3D  (u64)(uintptr_t)xqspi->rxbuf;

-       if ((xqspi->bytes_to_receive < 8) ||
-               ((dma_align & GQSPI_DMA_UNALIGN) !=3D 0x0)) {
+       if (xqspi->bytes_to_receive < 8 ||
+           ((dma_align & GQSPI_DMA_UNALIGN) !=3D 0x0)) {
                /* Setting to IO mode */
                config_reg =3D zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
                config_reg &=3D ~GQSPI_CFG_MODE_EN_MASK;
@@ -759,17 +759,17 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi=
 *xqspi)
        rx_bytes =3D (xqspi->bytes_to_receive - rx_rem);

        addr =3D dma_map_single(xqspi->dev, (void *)xqspi->rxbuf,
-                                               rx_bytes, DMA_FROM_DEVICE);
+                             rx_bytes, DMA_FROM_DEVICE);
        if (dma_mapping_error(xqspi->dev, addr))
                dev_err(xqspi->dev, "ERR:rxdma:memory not mapped\n");

        xqspi->dma_rx_bytes =3D rx_bytes;
        xqspi->dma_addr =3D addr;
        zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_OFST,
-                               (u32)(addr & 0xffffffff));
+                          (u32)(addr & 0xffffffff));
        addr =3D ((addr >> 16) >> 16);
        zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_MSB_OFST,
-                               ((u32)addr) & 0xfff);
+                          ((u32)addr) & 0xfff);

        /* Enabling the DMA mode */
        config_reg =3D zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
