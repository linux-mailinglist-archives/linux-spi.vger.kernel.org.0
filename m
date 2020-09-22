Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC702746D9
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIVQku (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 12:40:50 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:21696
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbgIVQkr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 12:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMWvsUaX2JJozDd5FQAiqw0Qp5U4qsW4y+5Uanbx7EjxhntYcYt4Y7+Dtfa4+awPg99M3ZT5V+ra6DO+visDi0DNQznIMLuvOWbF75N+G3dPrUgv0ROWO3fWeZykP5/EgvUGw0Ft9xM4jD5bttg+O1l/lH6AZH3EL/a0u6gZXt8mpQbGJbIebflTfCrJuNjQS6KkHjLckk3bPRSUoa2ZLdBaa4sm6ABJ1NixT1fYqVa4YvONrjcT1+AAvtPdrLTYiKx8tIaDwwlTfCvDgq9bmuFZRTDfhbq+b6Jl8p7CP3lv1wi8mVkdHNYs23xWHVM9aFgceCmc0bHpEIjnV+6bMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYm7dvHgevEBLBzV9q39cYMduiZbAfAan1yGqKp/dpU=;
 b=l/6arIlAXyoZuOd4IpyRKyb2KdKOGIjtXm5Bql/3LDmS8nM1al2Rc8a4FYe8Sr8Qhor2osPCbONb5lmdiIJk8WBhJ27wuHnyMJFL6D4fFBi+WzG3wPMbbOygmFkj6WZVJllubJSRBk57lQmR1drc+6tPQoBkQ3BO4flaP71TKD9ErzCCW4Cf5GiAgA6pMn7uzwIzy/ypE76fzhJivO0U0xX4Dvd2OyBKR5fRTIWR4gvVB3LkijSwu07cRG2zUieVNsXVnaRbs2jFYKsHHRjBVWTMQJVlKqsOjv8E/gRonIrXx3Dmd976q3hEeiNUvkJSfeFQk8kAecK+jvdcSG2I4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYm7dvHgevEBLBzV9q39cYMduiZbAfAan1yGqKp/dpU=;
 b=PXSRcDzb2D6UMRRg8dHrbZ+wgL4UQo07zYSUviwm15J5TQ3hSflWi3Ay73U7vaILYiChnwHr5erSUxKG0GOd8C0DVmnHXYyb+ZG20gDill7MGRyjY3c0przzZniGz30LzBIX+Bx6LI3xqsRUsU79mf7oz9NKko4sn3o4SkvacXk=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by SN4PR0201MB3488.namprd02.prod.outlook.com (2603:10b6:803:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Tue, 22 Sep
 2020 16:40:38 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::85) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Tue, 22 Sep 2020 16:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 16:40:37
 +0000
Received: from [149.199.38.66] (port=58141 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL4-0003ZU-Ky; Tue, 22 Sep 2020 09:40:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlLJ-0005PJ-63; Tue, 22 Sep 2020 09:40:37 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL8-00050B-RF; Tue, 22 Sep 2020 09:40:27 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH 3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation
Date:   Tue, 22 Sep 2020 10:40:16 -0600
Message-Id: <20200922164016.30979-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
References: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 95992c36-e109-4850-967e-08d85f163c1b
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3488:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3488B4EA71BF2932CA50D16CBA3B0@SN4PR0201MB3488.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5SgOKQMVE4JgtQshQhcAUK19eZUuLPw87jN/43QN8q8gvj7qzxJekUBitYzaFb0OJrRSY3CMZGHlkiY2R2SS3iwihepIDIJuFP2WkJNTf3mQg37bbYAvgkVj2CCF2KW4Fib+SGvoR5SWMR8peAHbfCSwlfL+lcfeIJFRvsC09PCD0OqqAV/zz/hhQlIvJwaPNgaKDEBSSKFRXRXFfkFaYoxBnmtRMZz+rxOSrl7fuR/s/T9nSJFAe3HjntS0Z4iMxXNVoXpVeWc1yd5k1sLbwIA5LurrkhjYlyez2HEbe6UR7f5zdYJ92HuCsBLsMw3TNcA0KnE+gk0xapeOCmdZ6MQngEShcGWCvJ5YPPTzG+kse5LQwuFlx+2E/fMqt3NIuTkdmnWzt1Zz3kY4bKuEA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(136003)(39850400004)(396003)(46966005)(336012)(47076004)(70586007)(5660300002)(316002)(6916009)(1076003)(82740400003)(356005)(81166007)(83380400001)(70206006)(82310400003)(478600001)(2616005)(9786002)(7696005)(8936002)(107886003)(2906002)(6666004)(426003)(26005)(36756003)(8676002)(186003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:40:37.5245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95992c36-e109-4850-967e-08d85f163c1b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3488
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
