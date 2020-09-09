Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7601B26343D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgIIRQF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:16:05 -0400
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:56030
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730176AbgIIP2Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Uv95ZxI/0nMiPe4pKM+LEmyZEQQo2GvRkMWl5jRPQYaJc9siuuFSF/oGUO5z2Cp4YFf6nW6XoHnPmh5elAb34HtZNyIgxt05E4QDyiaC7iHEW714IqZlHVUGBg6zKezk/c9FmfPuc3vOISdiDymXb2lr109MNQFzuDVQzkvQFZ5v7d000JUh4IuTp4FxCXumllPG5g10673bVLUAZj3SmLTQ6ltfeYZyBbZlzWx2qs9ZGNDlojE1JM6YXmLgmsGzamSn8BcCqp/QGv17J3zMCj6tnQW/j6mK2BNS+/3FzMMa7pdsYSlkrqU7vzqHeEbLjjXRCDaat6qAlMKiSrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qqApRsAgMsTzf4R9+Elk8TFtbikgemheD3QZVJM94=;
 b=Y0yoieQ4VI7UZtist7k5ct458iyQs6/d8kgI+XD7pjzlXbPw/2FgN6vqA7oo1O0tyLxj2yvRx9Tsfa0fX68umssFCMGPE2vbTh99IdvXfopYQeGBOTX9cmKoUb2KEdi55JYsInUvoVCt/Iv06BqpcyXXiqfUtG9K3oCeap//+aKAhaim6U/Gkb39xZgVRA5kl51Q03BGBm7igei2CRrvaX3s+Lv2eYeZSGF8oVg/K3Igy8du1r+TJxlL3kqJf5gVZxQvU/1EBhYOdre1a9jXV524vhkj60JTq7ffdT+GW4WpjPml2/laDOagvThz1FFQ1h1YqP8KH0G3ccCt8P9pXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qqApRsAgMsTzf4R9+Elk8TFtbikgemheD3QZVJM94=;
 b=SYJQ6Nk1xiWPerJhzLL5LEPWUKQ3llkp2sbFsHc9P8KaqfT60P8yjO7HxvLiUgJ1eCBUTemAlewq/VTg65Jkn3CH/9WD5rElfl/z8Bc6E0Rr59Z4gJ41w65kstymYCn45c6IWP6xqVne1jBZhucE6Qvd9PVtDfqB1wzOSoCEp0k=
Received: from SN4PR0501CA0144.namprd05.prod.outlook.com
 (2603:10b6:803:2c::22) by SN1PR02MB3776.namprd02.prod.outlook.com
 (2603:10b6:802:2c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 15:27:29 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::41) by SN4PR0501CA0144.outlook.office365.com
 (2603:10b6:803:2c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Wed, 9 Sep 2020 15:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 15:27:28
 +0000
Received: from [149.199.38.66] (port=45089 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG205-00056A-Vp; Wed, 09 Sep 2020 08:27:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20L-00069R-Rd; Wed, 09 Sep 2020 08:27:25 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089FRF8n027841;
        Wed, 9 Sep 2020 08:27:15 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20B-00068K-2E; Wed, 09 Sep 2020 08:27:15 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, nagasure@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Wed,  9 Sep 2020 09:27:06 -0600
Message-Id: <20200909152708.2767-2-amit.kumar-mahapatra@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0777d51-bbf7-4a0c-519d-08d854d4dcf5
X-MS-TrafficTypeDiagnostic: SN1PR02MB3776:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3776DC0A15C2C050722295B5BA260@SN1PR02MB3776.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrZWJqIr2XNxgQh+To20Nat/056xMNTzer6GuT1eqnRzJhX6H1H4vTP9MLp5vMIyKZeJTp00wmJ0Fexv/5LKos6eH6e6YxgZ2M/utCcbY7ErGv2cyAGFBHK5OsU/eXG/S84nRk32mBzsjO1H4/0pJEO6tGadkFczLnZzkaqcABJoh3oorSvySLl2VV6y1t2moRp3vR1BtOAHtKW0Seu5EtKXThBsFJjNgn29mxj+LrD20T7i9YLYxn4MbXJDokGjD3+8SXb3upo/5tdKcr/j4jsZinRUqpVobSIw4dve+jnAU05dIjW6PCn2h26za7UdjN5ECoQJexYofHW6/DvFprNoEjktxroB/VV69ac8DoTPU2NSNX69LbaQ/fSXJxKMFrK/WecWJS25ODsoVcv70A==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(39860400002)(46966005)(8936002)(6916009)(47076004)(107886003)(8676002)(70206006)(9786002)(336012)(186003)(2906002)(426003)(82310400003)(2616005)(478600001)(70586007)(1076003)(4326008)(36756003)(82740400003)(26005)(83380400001)(5660300002)(356005)(6666004)(7696005)(316002)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:27:28.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0777d51-bbf7-4a0c-519d-08d854d4dcf5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3776
Sender: linux-spi-owner@vger.kernel.org
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
