Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087912746D1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIVQkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 12:40:32 -0400
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:9929
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbgIVQka (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 12:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgzVcpKmrD3yIIhZmUjgJ6RW59xXia36Igj9uY3BuDsQiGzdrjgf5NSMR8j0zgOwN2p0xGu5anl2RWnCxcJ/yalluKSOs1H41WZIrOxpna2sOidUI5NAW/fS6OG9cP1AJgOhN29LnJqCaQraDUddxQ7YFkCQyInYOciyXelcfGdr/9W1vc0dAsuRWZpUyZhozja0rvZjDxoe4kD8hfgAMFMFwB3e3g1m9lxtkKqm6x5ki895MSNtCOSzo6AaABPhceqIEwoFXPe0xCbS1SO8MkGZeNh42RhnEtIY9Sxs1Gh9IuScKGh5aYKrM2RV3TkvbAUcCd/Rf7ZwAFhwiG7erQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qqApRsAgMsTzf4R9+Elk8TFtbikgemheD3QZVJM94=;
 b=XbaCgSWtTJJryolOqDPKROl0GhbtP5j2YHaKPgA1ahHetHcH3bqrIm5qAIEfktdlvXOCri/xqIiFmYBV2J+YiPS4eHh0mUFVBkaRjnba2sNa9innZTBDdezdVyhbBVtZqtee9BoyKILrJokriYMPEEbNY6hOUVYxeI0WU/VIFcWMVKdtL4Rc1jbq4k9WUA+MtTWWA6uHqWDqguak8AISXRfVrb8YpJxLiQyO0BssCGh+0xfzyhJ+9apCLDhYFQAQmS1+KKqa521l1+70yKM0Jpq/kgKqx3WFUklTFwphmPT5tKwLSiTNQOjCMFoT07PrckIjcGRE9U4pXqNKDR/uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qqApRsAgMsTzf4R9+Elk8TFtbikgemheD3QZVJM94=;
 b=rnlqv0Zh0SykpaE01lAd6O56T4IZQgvx1o9JN3HLEvys1psJz7rASXCSeYc6P3eHoDAO88VL75l+VpuAtp/tVQDS/Y1whr769vWSSwbK9hT9QCIFaS41ccAMO8UOlZq5oAr5+JQC4lFgt/okuGMM4cLEAGt8jsxwVCOeyX8RpYM=
Received: from SN6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:805:66::28)
 by MWHPR02MB2512.namprd02.prod.outlook.com (2603:10b6:300:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 16:40:27 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::34) by SN6PR08CA0015.outlook.office365.com
 (2603:10b6:805:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 22 Sep 2020 16:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 16:40:27
 +0000
Received: from [149.199.38.66] (port=57019 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlKu-0003Z4-9Q; Tue, 22 Sep 2020 09:40:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL8-0005BJ-QE; Tue, 22 Sep 2020 09:40:26 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL4-00050B-OY; Tue, 22 Sep 2020 09:40:23 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Tue, 22 Sep 2020 10:40:14 -0600
Message-Id: <20200922164016.30979-2-amit.kumar-mahapatra@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4614ef46-7134-4acc-c2eb-08d85f1635e7
X-MS-TrafficTypeDiagnostic: MWHPR02MB2512:
X-Microsoft-Antispam-PRVS: <MWHPR02MB25124290EEAC30963BAC7D6DBA3B0@MWHPR02MB2512.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Fa0qLRBcE1QGJteqhSUQyKt/rdyeRDyDV/KXu/0Eeq9KCDHEGaSFv3KAClCdbFx/+RA+B3VkjemMz/EUSWYjtqCRdrd7ACic5PwSxUoqazxUkFsSe2GuVI4SAIrZdBfGgFFvxlgrJNvuyw+LmN2iltZgOUU5QbBpKZGK/429SmUDCj3w/U/dDnFEhRSQMoLVOuXACGxHwWC6NeR2I8zEWmY6AH1t/hGsIoYGO4bD/PIw90VAOc6TAl7oIQ57P1RqF1IpFOJvvsz6nGpRDjACdQjB8wVMeOOFgIQvWC6QZuPKbj1MLVyCVjLPLPrM5CZt4vOfZi9nnr8E21/M71o1F0fGAbXHx4fU01tNNAe49QqxlgGiKi2DNxfTa4OmJx0B/gUwHQZ2xCRYJUppIrlIRF7OzGCcTAdXvH3+IWcHiC54Hy81dORK1moQNwniOTT
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(39850400004)(346002)(136003)(396003)(46966005)(83380400001)(7696005)(70586007)(70206006)(1076003)(8676002)(81166007)(107886003)(356005)(47076004)(82740400003)(2906002)(4326008)(6666004)(316002)(36756003)(5660300002)(8936002)(6916009)(2616005)(186003)(82310400003)(426003)(9786002)(478600001)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:40:27.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4614ef46-7134-4acc-c2eb-08d85f1635e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2512
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix kernel-doc warnings in ZynqMP qspi driver file.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 45 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.=
c
index e17a20125255..b479b9c3d1e6 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -173,9 +173,10 @@ struct zynqmp_qspi {
 };

 /**
- * zynqmp_gqspi_read:  For GQSPI controller read operation
+ * zynqmp_gqspi_read - For GQSPI controller read operation
  * @xqspi:     Pointer to the zynqmp_qspi structure
  * @offset:    Offset from where to read
+ * Return:      Value at the offset
  */
 static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset)
 {
@@ -183,7 +184,7 @@ static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi,=
 u32 offset)
 }

 /**
- * zynqmp_gqspi_write: For GQSPI controller write operation
+ * zynqmp_gqspi_write - For GQSPI controller write operation
  * @xqspi:     Pointer to the zynqmp_qspi structure
  * @offset:    Offset where to write
  * @val:       Value to be written
@@ -195,7 +196,7 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qsp=
i *xqspi, u32 offset,
 }

 /**
- * zynqmp_gqspi_selectslave:   For selection of slave device
+ * zynqmp_gqspi_selectslave - For selection of slave device
  * @instanceptr:       Pointer to the zynqmp_qspi structure
  * @slavecs:   For chip select
  * @slavebus:  To check which bus is selected- upper or lower
@@ -242,7 +243,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi=
 *instanceptr,
 }

 /**
- * zynqmp_qspi_init_hw:        Initialize the hardware
+ * zynqmp_qspi_init_hw - Initialize the hardware
  * @xqspi:     Pointer to the zynqmp_qspi structure
  *
  * The default settings of the QSPI controller's configurable parameters o=
n
@@ -330,7 +331,7 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqs=
pi)
 }

 /**
- * zynqmp_qspi_copy_read_data: Copy data to RX buffer
+ * zynqmp_qspi_copy_read_data - Copy data to RX buffer
  * @xqspi:     Pointer to the zynqmp_qspi structure
  * @data:      The variable where data is stored
  * @size:      Number of bytes to be copied from data to RX buffer
@@ -344,7 +345,7 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qs=
pi *xqspi,
 }

 /**
- * zynqmp_prepare_transfer_hardware:   Prepares hardware for transfer.
+ * zynqmp_prepare_transfer_hardware - Prepares hardware for transfer.
  * @master:    Pointer to the spi_master structure which provides
  *             information about the controller.
  *
@@ -361,7 +362,7 @@ static int zynqmp_prepare_transfer_hardware(struct spi_=
master *master)
 }

 /**
- * zynqmp_unprepare_transfer_hardware: Relaxes hardware after transfer
+ * zynqmp_unprepare_transfer_hardware - Relaxes hardware after transfer
  * @master:    Pointer to the spi_master structure which provides
  *             information about the controller.
  *
@@ -378,7 +379,7 @@ static int zynqmp_unprepare_transfer_hardware(struct sp=
i_master *master)
 }

 /**
- * zynqmp_qspi_chipselect:     Select or deselect the chip select line
+ * zynqmp_qspi_chipselect - Select or deselect the chip select line
  * @qspi:      Pointer to the spi_device structure
  * @is_high:   Select(0) or deselect (1) the chip select line
  */
@@ -423,7 +424,7 @@ static void zynqmp_qspi_chipselect(struct spi_device *q=
spi, bool is_high)
 }

 /**
- * zynqmp_qspi_setup_transfer: Configure QSPI controller for specified
+ * zynqmp_qspi_setup_transfer - Configure QSPI controller for specified
  *                             transfer
  * @qspi:      Pointer to the spi_device structure
  * @transfer:  Pointer to the spi_transfer structure which provides
@@ -482,7 +483,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device=
 *qspi,
 }

 /**
- * zynqmp_qspi_setup:  Configure the QSPI controller
+ * zynqmp_qspi_setup - Configure the QSPI controller
  * @qspi:      Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer=
,
@@ -498,7 +499,7 @@ static int zynqmp_qspi_setup(struct spi_device *qspi)
 }

 /**
- * zynqmp_qspi_filltxfifo:     Fills the TX FIFO as long as there is room =
in
+ * zynqmp_qspi_filltxfifo - Fills the TX FIFO as long as there is room in
  *                             the FIFO or the bytes required to be
  *                             transmitted.
  * @xqspi:     Pointer to the zynqmp_qspi structure
@@ -524,7 +525,7 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *=
xqspi, int size)
 }

 /**
- * zynqmp_qspi_readrxfifo:     Fills the RX FIFO as long as there is room =
in
+ * zynqmp_qspi_readrxfifo - Fills the RX FIFO as long as there is room in
  *                             the FIFO.
  * @xqspi:     Pointer to the zynqmp_qspi structure
  * @size:      Number of bytes to be copied from RX buffer to RX FIFO
@@ -552,7 +553,7 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *=
xqspi, u32 size)
 }

 /**
- * zynqmp_process_dma_irq:     Handler for DMA done interrupt of QSPI
+ * zynqmp_process_dma_irq - Handler for DMA done interrupt of QSPI
  *                             controller
  * @xqspi:     zynqmp_qspi instance pointer
  *
@@ -600,7 +601,7 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *=
xqspi)
 }

 /**
- * zynqmp_qspi_irq:    Interrupt service routine of the QSPI controller
+ * zynqmp_qspi_irq - Interrupt service routine of the QSPI controller
  * @irq:       IRQ number
  * @dev_id:    Pointer to the xqspi structure
  *
@@ -654,7 +655,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_i=
d)
 }

 /**
- * zynqmp_qspi_selectspimode:  Selects SPI mode - x1 or x2 or x4.
+ * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
  * @xqspi:     xqspi is a pointer to the GQSPI instance
  * @spimode:   spimode - SPI or DUAL or QUAD.
  * Return:     Mask to set desired SPI mode in GENFIFO entry.
@@ -682,7 +683,7 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynq=
mp_qspi *xqspi,
 }

 /**
- * zynq_qspi_setuprxdma:       This function sets up the RX DMA operation
+ * zynq_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:     xqspi is a pointer to the GQSPI instance.
  */
 static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
@@ -732,7 +733,7 @@ static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xq=
spi)
 }

 /**
- * zynqmp_qspi_txrxsetup:      This function checks the TX/RX buffers in
+ * zynqmp_qspi_txrxsetup - This function checks the TX/RX buffers in
  *                             the transfer and sets up the GENFIFO entrie=
s,
  *                             TX FIFO as required.
  * @xqspi:     xqspi is a pointer to the GQSPI instance.
@@ -783,7 +784,7 @@ static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *x=
qspi,
 }

 /**
- * zynqmp_qspi_start_transfer: Initiates the QSPI transfer
+ * zynqmp_qspi_start_transfer - Initiates the QSPI transfer
  * @master:    Pointer to the spi_master structure which provides
  *             information about the controller.
  * @qspi:      Pointer to the spi_device structure
@@ -891,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master=
 *master,
 }

 /**
- * zynqmp_qspi_suspend:        Suspend method for the QSPI driver
+ * zynqmp_qspi_suspend - Suspend method for the QSPI driver
  * @dev:       Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI control=
ler
@@ -910,7 +911,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct de=
vice *dev)
 }

 /**
- * zynqmp_qspi_resume: Resume method for the QSPI driver
+ * zynqmp_qspi_resume - Resume method for the QSPI driver
  * @dev:       Address of the platform_device structure
  *
  * The function starts the QSPI driver queue and initializes the QSPI
@@ -1000,7 +1001,7 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops=
 =3D {
 };

 /**
- * zynqmp_qspi_probe:  Probe method for the QSPI driver
+ * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:      Pointer to the platform_device structure
  *
  * This function initializes the driver data structures and the hardware.
@@ -1112,7 +1113,7 @@ static int zynqmp_qspi_probe(struct platform_device *=
pdev)
 }

 /**
- * zynqmp_qspi_remove: Remove method for the QSPI driver
+ * zynqmp_qspi_remove - Remove method for the QSPI driver
  * @pdev:      Pointer to the platform_device structure
  *
  * This function is called if a device is physically removed from the syst=
em or
--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
