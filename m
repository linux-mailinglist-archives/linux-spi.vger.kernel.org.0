Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B991E2630A0
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIPdm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 11:33:42 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:19777
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730166AbgIIPbL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQqsN6dlC7gZG7EaoksfZ89XCh6fYpiPC+xCo0us1x0ASSzyLIzUnEKcw0AmOsLzjJRrlKEC5/DMvKfhbIEADoBjbJPi216J0+abY53PkdDuCXlWvh7ynfcA5USLnagzEX07KMGDO9pRX9ZqG93JMGzwXri9ouyrM0JPaUZ02lCmhthDiTUGWyMM4MjSaH0Wo9cwE5vhT57FGWj97mVSZ39ozAJwu5AZdjWGOUXJUr3XClsWtvubka/1y/pV3FKYslbC6HEsBRSpBUB9HWKs5ycQZferW54yV9yZdeQ02RVBRZNUpmOc2VWq8BXNkhCLiaYtTVJip/OWnSGxQleR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgNqM5LXe9l2GNLk+nrf4GQieM7HdPHrEKKAjaMKgnU=;
 b=fp+ta6BDjH6BH6ouxupLJIwbsFEiC91lhSSBKnEiDmA+dNApVo+gVEMF1nKV9RXyIgi1dhoLFXMAA3OUc2ERhQhgJcxMJvOWbWeqhbM34mjt+/3NCb3mk4PIaQr7nVgQn181uaU+JzEWpzM2z1H0Z8p71g5AOyplJFzp2+HiPlOGZ7eZyrZhWpEglSBU3tSAJToakxvB3pse4IX9CWUjNzqDqbihDHFUBjMe+DOLVItHYD7/A1PxdpWtf/ghpg8FKojgPfqN28vVzx4K0mPbIiiOPPyTDS6U8CQW76xNouvGjjXjc5BP/IlP15w7S8U38fU4PqXfx9dqYGVtXSZN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgNqM5LXe9l2GNLk+nrf4GQieM7HdPHrEKKAjaMKgnU=;
 b=E1xcoHedVpMLizZb/qCQ283Fcz+OT05J64hde26ETrzwuSEPEqM3O9l5ipJdtWWuFAzhMtWdM86tWFdsSRJpdlBDpyUnGO/hkQWmUMl0u2MAPrv85wV1cHt9nkgpInPA8Ajf5BiV2VEBGBk5UaAJlRNFLifuHVH1HANH7dbexOs=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by BL0PR02MB4833.namprd02.prod.outlook.com (2603:10b6:208:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:27:26 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::53) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 9 Sep 2020 15:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 15:27:26
 +0000
Received: from [149.199.38.66] (port=45090 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG206-00056D-15; Wed, 09 Sep 2020 08:27:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20L-00069R-TE; Wed, 09 Sep 2020 08:27:25 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089FRIa1027853;
        Wed, 9 Sep 2020 08:27:18 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20D-00068K-E7; Wed, 09 Sep 2020 08:27:18 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, nagasure@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 2/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Date:   Wed,  9 Sep 2020 09:27:07 -0600
Message-Id: <20200909152708.2767-3-amit.kumar-mahapatra@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8dd9ef04-9edf-48a1-fe5f-08d854d4db58
X-MS-TrafficTypeDiagnostic: BL0PR02MB4833:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4833CDC85859647A130832A4BA260@BL0PR02MB4833.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8L9n4z7fod8cYsqUhvN+mynOIw4V3TVnQtKnNrl8vc92WcpxsQXa8l00kxaCkh0zT5hCi4iLc3wfPAIlaH2ZarAYwrhugqgW2zg7t32VmRaeHm6z4LqKQ4zObC7Gxbmmy1dBX1NN3CRnNodUVNa5Xgtahz+sePLKlEj5p/ckkhFtfhohiG/zw/Nftw9QEkZbTj7pnVORm0q4lY1TMeXJGeIHpxryI4d9iPs38VxSq36q3Iuv5RDGWjj5BgwhSvQEi/xbRKqfBk1bTeWt5MV6n2uCPHUyXi0Nl31Rk6p4vOvjoYwla87N/35VV9EMZapAkEBGiGALig9WxaAHvElqsv9irOmmKcXwu/jaLCHEdOcN0yKEVfW4b8LTHCNQNw7p4XQqcFuOVUo1pLezKVDpw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(46966005)(82310400003)(70206006)(70586007)(336012)(4326008)(15650500001)(5660300002)(186003)(8936002)(6916009)(6666004)(9786002)(478600001)(2616005)(26005)(2906002)(7696005)(30864003)(8676002)(107886003)(1076003)(426003)(316002)(36756003)(83380400001)(47076004)(356005)(82740400003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:27:26.2717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd9ef04-9edf-48a1-fe5f-08d854d4db58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4833
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Updated Zynqmp qspi controller driver to use spi-mem framework.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 645 +++++++++++++++++++--------------
 1 file changed, 369 insertions(+), 276 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.=
c
index b479b9c3d1e6..7f57923f76ea 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/spi/spi-mem.h>

 /* Generic QSPI register offsets */
 #define GQSPI_CONFIG_OFST              0x00000100
@@ -153,6 +154,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @dma_addr:          DMA address after mapping the kernel buffer
  * @genfifoentry:      Used for storing the genfifoentry instruction.
  * @mode:              Defines the mode in which QSPI is operating
+ * @data_completion:   completion structure
  */
 struct zynqmp_qspi {
        void __iomem *regs;
@@ -170,6 +172,7 @@ struct zynqmp_qspi {
        dma_addr_t dma_addr;
        u32 genfifoentry;
        enum mode_type mode;
+       struct completion data_completion;
 };

 /**
@@ -344,40 +347,6 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_q=
spi *xqspi,
        xqspi->bytes_to_receive -=3D size;
 }

-/**
- * zynqmp_prepare_transfer_hardware - Prepares hardware for transfer.
- * @master:    Pointer to the spi_master structure which provides
- *             information about the controller.
- *
- * This function enables SPI master controller.
- *
- * Return:     0 on success; error value otherwise
- */
-static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
-{
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
-
-       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
-       return 0;
-}
-
-/**
- * zynqmp_unprepare_transfer_hardware - Relaxes hardware after transfer
- * @master:    Pointer to the spi_master structure which provides
- *             information about the controller.
- *
- * This function disables the SPI master controller.
- *
- * Return:     Always 0
- */
-static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
-{
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
-
-       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-       return 0;
-}
-
 /**
  * zynqmp_qspi_chipselect - Select or deselect the chip select line
  * @qspi:      Pointer to the spi_device structure
@@ -387,12 +356,14 @@ static void zynqmp_qspi_chipselect(struct spi_device =
*qspi, bool is_high)
 {
        struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(qspi->master);
        ulong timeout;
-       u32 genfifoentry =3D 0x0, statusreg;
+       u32 genfifoentry =3D 0, statusreg;

        genfifoentry |=3D GQSPI_GENFIFO_MODE_SPI;
-       genfifoentry |=3D xqspi->genfifobus;

        if (!is_high) {
+               xqspi->genfifobus =3D GQSPI_GENFIFO_BUS_LOWER;
+               xqspi->genfifocs =3D GQSPI_GENFIFO_CS_LOWER;
+               genfifoentry |=3D xqspi->genfifobus;
                genfifoentry |=3D xqspi->genfifocs;
                genfifoentry |=3D GQSPI_GENFIFO_CS_SETUP;
        } else {
@@ -424,11 +395,38 @@ static void zynqmp_qspi_chipselect(struct spi_device =
*qspi, bool is_high)
 }

 /**
- * zynqmp_qspi_setup_transfer - Configure QSPI controller for specified
+ * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
+ * @xqspi:     xqspi is a pointer to the GQSPI instance
+ * @spimode:   spimode - SPI or DUAL or QUAD.
+ * Return:     Mask to set desired SPI mode in GENFIFO entry.
+ */
+static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
+                                           u8 spimode)
+{
+       u32 mask =3D 0;
+
+       switch (spimode) {
+       case GQSPI_SELECT_MODE_DUALSPI:
+               mask =3D GQSPI_GENFIFO_MODE_DUALSPI;
+               break;
+       case GQSPI_SELECT_MODE_QUADSPI:
+               mask =3D GQSPI_GENFIFO_MODE_QUADSPI;
+               break;
+       case GQSPI_SELECT_MODE_SPI:
+               mask =3D GQSPI_GENFIFO_MODE_SPI;
+               break;
+       default:
+               dev_warn(xqspi->dev, "Invalid SPI mode\n");
+       }
+
+       return mask;
+}
+
+/**
+ * zynqmp_qspi_config_op - Configure QSPI controller for specified
  *                             transfer
+ * @xqspi:     Pointer to the zynqmp_qspi structure
  * @qspi:      Pointer to the spi_device structure
- * @transfer:  Pointer to the spi_transfer structure which provides
- *             information about next transfer setup parameters
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer=
 and
  * sets the requested clock frequency.
@@ -445,17 +443,11 @@ static void zynqmp_qspi_chipselect(struct spi_device =
*qspi, bool is_high)
  *     by the QSPI controller the driver will set the highest or lowest
  *     frequency supported by controller.
  */
-static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
-                                     struct spi_transfer *transfer)
+static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
+                                struct spi_device *qspi)
 {
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(qspi->master);
        ulong clk_rate;
-       u32 config_reg, req_hz, baud_rate_val =3D 0;
-
-       if (transfer)
-               req_hz =3D transfer->speed_hz;
-       else
-               req_hz =3D qspi->max_speed_hz;
+       u32 config_reg, baud_rate_val =3D 0;

        /* Set the clock frequency */
        /* If req_hz =3D=3D 0, default to lowest speed */
@@ -463,7 +455,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device=
 *qspi,

        while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
               (clk_rate /
-               (GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > req_hz)
+               (GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > qspi->max_speed_=
hz)
                baud_rate_val++;

        config_reg =3D zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
@@ -483,7 +475,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device=
 *qspi,
 }

 /**
- * zynqmp_qspi_setup - Configure the QSPI controller
+ * zynqmp_qspi_setup_op - Configure the QSPI controller
  * @qspi:      Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer=
,
@@ -491,10 +483,30 @@ static int zynqmp_qspi_setup_transfer(struct spi_devi=
ce *qspi,
  *
  * Return:     0 on success; error value otherwise.
  */
-static int zynqmp_qspi_setup(struct spi_device *qspi)
+static int zynqmp_qspi_setup_op(struct spi_device *qspi)
 {
-       if (qspi->master->busy)
+       struct spi_controller *ctlr =3D qspi->master;
+       struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata(ctlr);
+       struct device *dev =3D &ctlr->dev;
+       int ret;
+
+       if (ctlr->busy)
                return -EBUSY;
+
+       ret =3D clk_enable(xqspi->refclk);
+       if (ret) {
+               dev_err(dev, "Cannot enable device clock.\n");
+               return ret;
+       }
+
+       ret =3D clk_enable(xqspi->pclk);
+       if (ret) {
+               dev_err(dev, "Cannot enable APB clock.\n");
+               clk_disable(xqspi->refclk);
+               return ret;
+       }
+       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
+
        return 0;
 }

@@ -552,6 +564,75 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi =
*xqspi, u32 size)
        }
 }

+/**
+ * zynqmp_qspi_fillgenfifo - Fills the GENFIFO.
+ * @xqspi:     Pointer to the zynqmp_qspi structure
+ * @nbits:     Transfer/Receive buswidth.
+ * @genfifoentry:       Variable in which GENFIFO mask is saved
+ */
+static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
+                                   u32 genfifoentry)
+{
+       u32 transfer_len =3D 0;
+
+       if (xqspi->txbuf) {
+               genfifoentry &=3D ~GQSPI_GENFIFO_RX;
+               genfifoentry |=3D GQSPI_GENFIFO_DATA_XFER;
+               genfifoentry |=3D GQSPI_GENFIFO_TX;
+               transfer_len =3D xqspi->bytes_to_transfer;
+       } else {
+               genfifoentry &=3D ~GQSPI_GENFIFO_TX;
+               genfifoentry |=3D GQSPI_GENFIFO_DATA_XFER;
+               genfifoentry |=3D GQSPI_GENFIFO_RX;
+               if (xqspi->mode =3D=3D GQSPI_MODE_DMA)
+                       transfer_len =3D xqspi->dma_rx_bytes;
+               else
+                       transfer_len =3D xqspi->bytes_to_receive;
+       }
+       genfifoentry |=3D zynqmp_qspi_selectspimode(xqspi, nbits);
+       xqspi->genfifoentry =3D genfifoentry;
+
+       if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
+               genfifoentry &=3D ~GQSPI_GENFIFO_IMM_DATA_MASK;
+               genfifoentry |=3D transfer_len;
+               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry=
);
+       } else {
+               int tempcount =3D transfer_len;
+               u32 exponent =3D 8;       /* 2^8 =3D 256 */
+               u8 imm_data =3D tempcount & 0xFF;
+
+               tempcount &=3D ~(tempcount & 0xFF);
+               /* Immediate entry */
+               if (tempcount !=3D 0) {
+                       /* Exponent entries */
+                       genfifoentry |=3D GQSPI_GENFIFO_EXP;
+                       while (tempcount !=3D 0) {
+                               if (tempcount & GQSPI_GENFIFO_EXP_START) {
+                                       genfifoentry &=3D
+                                               ~GQSPI_GENFIFO_IMM_DATA_MAS=
K;
+                                       genfifoentry |=3D exponent;
+                                       zynqmp_gqspi_write(xqspi,
+                                                          GQSPI_GEN_FIFO_O=
FST,
+                                                          genfifoentry);
+                               }
+                               tempcount =3D tempcount >> 1;
+                               exponent++;
+                       }
+               }
+               if (imm_data !=3D 0) {
+                       genfifoentry &=3D ~GQSPI_GENFIFO_EXP;
+                       genfifoentry &=3D ~GQSPI_GENFIFO_IMM_DATA_MASK;
+                       genfifoentry |=3D (u8)(imm_data & 0xFF);
+                       zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
+                                          genfifoentry);
+               }
+       }
+       if (xqspi->mode =3D=3D GQSPI_MODE_IO && xqspi->rxbuf) {
+               /* Dummy generic FIFO entry */
+               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
+       }
+}
+
 /**
  * zynqmp_process_dma_irq - Handler for DMA done interrupt of QSPI
  *                             controller
@@ -614,9 +695,8 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *=
xqspi)
  */
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
-       struct spi_master *master =3D dev_id;
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
-       int ret =3D IRQ_NONE;
+       struct zynqmp_qspi *xqspi =3D (struct zynqmp_qspi *)dev_id;
+       irqreturn_t ret =3D IRQ_NONE;
        u32 status, mask, dma_status =3D 0;

        status =3D zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -648,45 +728,17 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev=
_id)
        if ((xqspi->bytes_to_receive =3D=3D 0) && (xqspi->bytes_to_transfer=
 =3D=3D 0)
                        && ((status & GQSPI_IRQ_MASK) =3D=3D GQSPI_IRQ_MASK=
)) {
                zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MAS=
K);
-               spi_finalize_current_transfer(master);
+               complete(&xqspi->data_completion);
                ret =3D IRQ_HANDLED;
        }
        return ret;
 }

 /**
- * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
- * @xqspi:     xqspi is a pointer to the GQSPI instance
- * @spimode:   spimode - SPI or DUAL or QUAD.
- * Return:     Mask to set desired SPI mode in GENFIFO entry.
- */
-static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
-                                               u8 spimode)
-{
-       u32 mask =3D 0;
-
-       switch (spimode) {
-       case GQSPI_SELECT_MODE_DUALSPI:
-               mask =3D GQSPI_GENFIFO_MODE_DUALSPI;
-               break;
-       case GQSPI_SELECT_MODE_QUADSPI:
-               mask =3D GQSPI_GENFIFO_MODE_QUADSPI;
-               break;
-       case GQSPI_SELECT_MODE_SPI:
-               mask =3D GQSPI_GENFIFO_MODE_SPI;
-               break;
-       default:
-               dev_warn(xqspi->dev, "Invalid SPI mode\n");
-       }
-
-       return mask;
-}
-
-/**
- * zynq_qspi_setuprxdma - This function sets up the RX DMA operation
+ * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:     xqspi is a pointer to the GQSPI instance.
  */
-static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
+static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
        u32 rx_bytes, rx_rem, config_reg;
        dma_addr_t addr;
@@ -733,162 +785,44 @@ static void zynq_qspi_setuprxdma(struct zynqmp_qspi =
*xqspi)
 }

 /**
- * zynqmp_qspi_txrxsetup - This function checks the TX/RX buffers in
- *                             the transfer and sets up the GENFIFO entrie=
s,
- *                             TX FIFO as required.
- * @xqspi:     xqspi is a pointer to the GQSPI instance.
- * @transfer:  It is a pointer to the structure containing transfer data.
- * @genfifoentry:      genfifoentry is pointer to the variable in which
- *                     GENFIFO mask is returned to calling function
+ * zynqmp_qspi_write_op - This function sets up the GENFIFO entries,
+ *                     TX FIFO, and fills the TX FIFO with as many
+ *                     bytes as possible.
+ * @xqspi:     Pointer to the GQSPI instance.
+ * @tx_nbits:  Transfer buswidth.
+ * @genfifoentry:      Variable in which GENFIFO mask is returned
+ *                     to calling function
  */
-static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
-                                 struct spi_transfer *transfer,
-                                 u32 *genfifoentry)
+static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
+                                u32 genfifoentry)
 {
        u32 config_reg;

-       /* Transmit */
-       if ((xqspi->txbuf !=3D NULL) && (xqspi->rxbuf =3D=3D NULL)) {
-               /* Setup data to be TXed */
-               *genfifoentry &=3D ~GQSPI_GENFIFO_RX;
-               *genfifoentry |=3D GQSPI_GENFIFO_DATA_XFER;
-               *genfifoentry |=3D GQSPI_GENFIFO_TX;
-               *genfifoentry |=3D
-                       zynqmp_qspi_selectspimode(xqspi, transfer->tx_nbits=
);
-               xqspi->bytes_to_transfer =3D transfer->len;
-               if (xqspi->mode =3D=3D GQSPI_MODE_DMA) {
-                       config_reg =3D zynqmp_gqspi_read(xqspi,
-                                                       GQSPI_CONFIG_OFST);
-                       config_reg &=3D ~GQSPI_CFG_MODE_EN_MASK;
-                       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-                                                               config_reg)=
;
-                       xqspi->mode =3D GQSPI_MODE_IO;
-               }
-               zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
-               /* Discard RX data */
-               xqspi->bytes_to_receive =3D 0;
-       } else if ((xqspi->txbuf =3D=3D NULL) && (xqspi->rxbuf !=3D NULL)) =
{
-               /* Receive */
-
-               /* TX auto fill */
-               *genfifoentry &=3D ~GQSPI_GENFIFO_TX;
-               /* Setup RX */
-               *genfifoentry |=3D GQSPI_GENFIFO_DATA_XFER;
-               *genfifoentry |=3D GQSPI_GENFIFO_RX;
-               *genfifoentry |=3D
-                       zynqmp_qspi_selectspimode(xqspi, transfer->rx_nbits=
);
-               xqspi->bytes_to_transfer =3D 0;
-               xqspi->bytes_to_receive =3D transfer->len;
-               zynq_qspi_setuprxdma(xqspi);
+       zynqmp_qspi_fillgenfifo(xqspi, tx_nbits, genfifoentry);
+       zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
+       if (xqspi->mode =3D=3D GQSPI_MODE_DMA) {
+               config_reg =3D zynqmp_gqspi_read(xqspi,
+                                              GQSPI_CONFIG_OFST);
+               config_reg &=3D ~GQSPI_CFG_MODE_EN_MASK;
+               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                  config_reg);
+               xqspi->mode =3D GQSPI_MODE_IO;
        }
 }

 /**
- * zynqmp_qspi_start_transfer - Initiates the QSPI transfer
- * @master:    Pointer to the spi_master structure which provides
- *             information about the controller.
- * @qspi:      Pointer to the spi_device structure
- * @transfer:  Pointer to the spi_transfer structure which provide informa=
tion
- *             about next transfer parameters
- *
- * This function fills the TX FIFO, starts the QSPI transfer, and waits fo=
r the
- * transfer to be completed.
- *
- * Return:     Number of bytes transferred in the last transfer
+ * zynqmp_qspi_read_op - This function sets up the GENFIFO entries and
+ *                             RX DMA operation.
+ * @xqspi:     xqspi is a pointer to the GQSPI instance.
+ * @rx_nbits:  Receive buswidth.
+ * @genfifoentry:      genfifoentry is pointer to the variable in which
+ *                     GENFIFO mask is returned to calling function
  */
-static int zynqmp_qspi_start_transfer(struct spi_master *master,
-                                     struct spi_device *qspi,
-                                     struct spi_transfer *transfer)
+static void zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
+                               u32 genfifoentry)
 {
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
-       u32 genfifoentry =3D 0x0, transfer_len;
-
-       xqspi->txbuf =3D transfer->tx_buf;
-       xqspi->rxbuf =3D transfer->rx_buf;
-
-       zynqmp_qspi_setup_transfer(qspi, transfer);
-
-       genfifoentry |=3D xqspi->genfifocs;
-       genfifoentry |=3D xqspi->genfifobus;
-
-       zynqmp_qspi_txrxsetup(xqspi, transfer, &genfifoentry);
-
-       if (xqspi->mode =3D=3D GQSPI_MODE_DMA)
-               transfer_len =3D xqspi->dma_rx_bytes;
-       else
-               transfer_len =3D transfer->len;
-
-       xqspi->genfifoentry =3D genfifoentry;
-       if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
-               genfifoentry &=3D ~GQSPI_GENFIFO_IMM_DATA_MASK;
-               genfifoentry |=3D transfer_len;
-               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry=
);
-       } else {
-               int tempcount =3D transfer_len;
-               u32 exponent =3D 8;       /* 2^8 =3D 256 */
-               u8 imm_data =3D tempcount & 0xFF;
-
-               tempcount &=3D ~(tempcount & 0xFF);
-               /* Immediate entry */
-               if (tempcount !=3D 0) {
-                       /* Exponent entries */
-                       genfifoentry |=3D GQSPI_GENFIFO_EXP;
-                       while (tempcount !=3D 0) {
-                               if (tempcount & GQSPI_GENFIFO_EXP_START) {
-                                       genfifoentry &=3D
-                                           ~GQSPI_GENFIFO_IMM_DATA_MASK;
-                                       genfifoentry |=3D exponent;
-                                       zynqmp_gqspi_write(xqspi,
-                                                          GQSPI_GEN_FIFO_O=
FST,
-                                                          genfifoentry);
-                               }
-                               tempcount =3D tempcount >> 1;
-                               exponent++;
-                       }
-               }
-               if (imm_data !=3D 0) {
-                       genfifoentry &=3D ~GQSPI_GENFIFO_EXP;
-                       genfifoentry &=3D ~GQSPI_GENFIFO_IMM_DATA_MASK;
-                       genfifoentry |=3D (u8) (imm_data & 0xFF);
-                       zynqmp_gqspi_write(xqspi,
-                                          GQSPI_GEN_FIFO_OFST, genfifoentr=
y);
-               }
-       }
-
-       if ((xqspi->mode =3D=3D GQSPI_MODE_IO) &&
-                       (xqspi->rxbuf !=3D NULL)) {
-               /* Dummy generic FIFO entry */
-               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-       }
-
-       /* Since we are using manual mode */
-       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-                          zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-                          GQSPI_CFG_START_GEN_FIFO_MASK);
-
-       if (xqspi->txbuf !=3D NULL)
-               /* Enable interrupts for TX */
-               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-                                  GQSPI_IER_TXEMPTY_MASK |
-                                       GQSPI_IER_GENFIFOEMPTY_MASK |
-                                       GQSPI_IER_TXNOT_FULL_MASK);
-
-       if (xqspi->rxbuf !=3D NULL) {
-               /* Enable interrupts for RX */
-               if (xqspi->mode =3D=3D GQSPI_MODE_DMA) {
-                       /* Enable DMA interrupts */
-                       zynqmp_gqspi_write(xqspi,
-                                       GQSPI_QSPIDMA_DST_I_EN_OFST,
-                                       GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
-               } else {
-                       zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-                                       GQSPI_IER_GENFIFOEMPTY_MASK |
-                                       GQSPI_IER_RXNEMPTY_MASK |
-                                       GQSPI_IER_RXEMPTY_MASK);
-               }
-       }
-
-       return transfer->len;
+       zynqmp_qspi_fillgenfifo(xqspi, rx_nbits, genfifoentry);
+       zynqmp_qspi_setuprxdma(xqspi);
 }

 /**
@@ -901,11 +835,12 @@ static int zynqmp_qspi_start_transfer(struct spi_mast=
er *master,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-       struct spi_master *master =3D dev_get_drvdata(dev);
+       struct spi_controller *ctlr =3D dev_get_drvdata(dev);
+       struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata(ctlr);

-       spi_master_suspend(master);
+       spi_controller_suspend(ctlr);

-       zynqmp_unprepare_transfer_hardware(master);
+       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);

        return 0;
 }
@@ -921,8 +856,8 @@ static int __maybe_unused zynqmp_qspi_suspend(struct de=
vice *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-       struct spi_master *master =3D dev_get_drvdata(dev);
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
+       struct spi_controller *ctlr =3D dev_get_drvdata(dev);
+       struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata(ctlr);
        int ret =3D 0;

        ret =3D clk_enable(xqspi->pclk);
@@ -938,7 +873,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct dev=
ice *dev)
                return ret;
        }

-       spi_master_resume(master);
+       spi_controller_resume(ctlr);

        clk_disable(xqspi->refclk);
        clk_disable(xqspi->pclk);
@@ -955,8 +890,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct dev=
ice *dev)
  */
 static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
 {
-       struct spi_master *master =3D dev_get_drvdata(dev);
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
+       struct zynqmp_qspi *xqspi =3D (struct zynqmp_qspi *)dev_get_drvdata=
(dev);

        clk_disable(xqspi->refclk);
        clk_disable(xqspi->pclk);
@@ -974,8 +908,7 @@ static int __maybe_unused zynqmp_runtime_suspend(struct=
 device *dev)
  */
 static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 {
-       struct spi_master *master =3D dev_get_drvdata(dev);
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
+       struct zynqmp_qspi *xqspi =3D (struct zynqmp_qspi *)dev_get_drvdata=
(dev);
        int ret;

        ret =3D clk_enable(xqspi->pclk);
@@ -994,12 +927,177 @@ static int __maybe_unused zynqmp_runtime_resume(stru=
ct device *dev)
        return 0;
 }

+/**
+ * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
+ * @mem: The SPI memory
+ * @op: The memory operation to execute
+ *
+ * Executes a memory operation.
+ *
+ * This function first selects the chip and starts the memory operation.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int zynqmp_qspi_exec_op(struct spi_mem *mem,
+                              const struct spi_mem_op *op)
+{
+       struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata
+                                   (mem->spi->master);
+       int err =3D 0, i;
+       u8 *tmpbuf;
+       u32 genfifoentry =3D 0;
+
+       dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
+               op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+               op->dummy.buswidth, op->data.buswidth);
+
+       zynqmp_qspi_config_op(xqspi, mem->spi);
+       zynqmp_qspi_chipselect(mem->spi, false);
+       genfifoentry |=3D xqspi->genfifocs;
+       genfifoentry |=3D xqspi->genfifobus;
+
+       if (op->cmd.opcode) {
+               tmpbuf =3D kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
+               if (!tmpbuf)
+                       return -ENOMEM;
+               tmpbuf[0] =3D op->cmd.opcode;
+               reinit_completion(&xqspi->data_completion);
+               xqspi->txbuf =3D tmpbuf;
+               xqspi->rxbuf =3D NULL;
+               xqspi->bytes_to_transfer =3D op->cmd.nbytes;
+               xqspi->bytes_to_receive =3D 0;
+               zynqmp_qspi_write_op(xqspi, op->cmd.buswidth, genfifoentry)=
;
+               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                  zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OF=
ST) |
+                                  GQSPI_CFG_START_GEN_FIFO_MASK);
+               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+                                  GQSPI_IER_GENFIFOEMPTY_MASK |
+                                  GQSPI_IER_TXNOT_FULL_MASK);
+               if (!wait_for_completion_interruptible_timeout
+                   (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+                       err =3D -ETIMEDOUT;
+                       kfree(tmpbuf);
+                       goto return_err;
+               }
+               kfree(tmpbuf);
+       }
+
+       if (op->addr.nbytes) {
+               for (i =3D 0; i < op->addr.nbytes; i++) {
+                       *(((u8 *)xqspi->txbuf) + i) =3D op->addr.val >>
+                                       (8 * (op->addr.nbytes - i - 1));
+               }
+
+               reinit_completion(&xqspi->data_completion);
+               xqspi->rxbuf =3D NULL;
+               xqspi->bytes_to_transfer =3D op->addr.nbytes;
+               xqspi->bytes_to_receive =3D 0;
+               zynqmp_qspi_write_op(xqspi, op->addr.buswidth, genfifoentry=
);
+               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                  zynqmp_gqspi_read(xqspi,
+                                                    GQSPI_CONFIG_OFST) |
+                                  GQSPI_CFG_START_GEN_FIFO_MASK);
+               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+                                  GQSPI_IER_TXEMPTY_MASK |
+                                  GQSPI_IER_GENFIFOEMPTY_MASK |
+                                  GQSPI_IER_TXNOT_FULL_MASK);
+               if (!wait_for_completion_interruptible_timeout
+                   (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+                       err =3D -ETIMEDOUT;
+                       goto return_err;
+               }
+       }
+
+       if (op->dummy.nbytes) {
+               tmpbuf =3D kzalloc(op->dummy.nbytes, GFP_KERNEL | GFP_DMA);
+               if (!tmpbuf)
+                       return -ENOMEM;
+               memset(tmpbuf, 0xff, op->dummy.nbytes);
+               reinit_completion(&xqspi->data_completion);
+               xqspi->txbuf =3D tmpbuf;
+               xqspi->rxbuf =3D NULL;
+               xqspi->bytes_to_transfer =3D op->dummy.nbytes;
+               xqspi->bytes_to_receive =3D 0;
+               zynqmp_qspi_write_op(xqspi, op->dummy.buswidth,
+                                    genfifoentry);
+               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                  zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OF=
ST) |
+                                  GQSPI_CFG_START_GEN_FIFO_MASK);
+               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+                                  GQSPI_IER_TXEMPTY_MASK |
+                                  GQSPI_IER_GENFIFOEMPTY_MASK |
+                                  GQSPI_IER_TXNOT_FULL_MASK);
+               if (!wait_for_completion_interruptible_timeout
+                   (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+                       err =3D -ETIMEDOUT;
+                       kfree(tmpbuf);
+                       goto return_err;
+               }
+
+               kfree(tmpbuf);
+       }
+
+       if (op->data.nbytes) {
+               reinit_completion(&xqspi->data_completion);
+               if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+                       xqspi->txbuf =3D (u8 *)op->data.buf.out;
+                       xqspi->rxbuf =3D NULL;
+                       xqspi->bytes_to_transfer =3D op->data.nbytes;
+                       xqspi->bytes_to_receive =3D 0;
+                       zynqmp_qspi_write_op(xqspi, op->data.buswidth,
+                                            genfifoentry);
+                       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                          zynqmp_gqspi_read
+                                          (xqspi, GQSPI_CONFIG_OFST) |
+                                          GQSPI_CFG_START_GEN_FIFO_MASK);
+                       zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+                                          GQSPI_IER_TXEMPTY_MASK |
+                                          GQSPI_IER_GENFIFOEMPTY_MASK |
+                                          GQSPI_IER_TXNOT_FULL_MASK);
+               } else {
+                       xqspi->txbuf =3D NULL;
+                       xqspi->rxbuf =3D (u8 *)op->data.buf.in;
+                       xqspi->bytes_to_receive =3D op->data.nbytes;
+                       xqspi->bytes_to_transfer =3D 0;
+                       zynqmp_qspi_read_op(xqspi, op->data.buswidth,
+                                           genfifoentry);
+                       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
+                                          zynqmp_gqspi_read
+                                          (xqspi, GQSPI_CONFIG_OFST) |
+                                          GQSPI_CFG_START_GEN_FIFO_MASK);
+                       if (xqspi->mode =3D=3D GQSPI_MODE_DMA) {
+                               zynqmp_gqspi_write
+                                       (xqspi, GQSPI_QSPIDMA_DST_I_EN_OFST=
,
+                                        GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
+                       } else {
+                               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
+                                                  GQSPI_IER_GENFIFOEMPTY_M=
ASK |
+                                                  GQSPI_IER_RXNEMPTY_MASK =
|
+                                                  GQSPI_IER_RXEMPTY_MASK);
+                       }
+               }
+               if (!wait_for_completion_interruptible_timeout
+                   (&xqspi->data_completion, msecs_to_jiffies(1000)))
+                       err =3D -ETIMEDOUT;
+       }
+
+return_err:
+
+       zynqmp_qspi_chipselect(mem->spi, true);
+
+       return err;
+}
+
 static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops =3D {
        SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
                           zynqmp_runtime_resume, NULL)
        SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };

+static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops =3D {
+       .exec_op =3D zynqmp_qspi_exec_op,
+};
+
 /**
  * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:      Pointer to the platform_device structure
@@ -1011,17 +1109,18 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_o=
ps =3D {
 static int zynqmp_qspi_probe(struct platform_device *pdev)
 {
        int ret =3D 0;
-       struct spi_master *master;
+       struct spi_controller *ctlr;
        struct zynqmp_qspi *xqspi;
        struct device *dev =3D &pdev->dev;
+       struct device_node *np =3D dev->of_node;

-       master =3D spi_alloc_master(&pdev->dev, sizeof(*xqspi));
-       if (!master)
+       ctlr =3D spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+       if (!ctlr)
                return -ENOMEM;

-       xqspi =3D spi_master_get_devdata(master);
-       master->dev.of_node =3D pdev->dev.of_node;
-       platform_set_drvdata(pdev, master);
+       xqspi =3D spi_controller_get_devdata(ctlr);
+       xqspi->dev =3D dev;
+       platform_set_drvdata(pdev, xqspi);

        xqspi->regs =3D devm_platform_ioremap_resource(pdev, 0);
        if (IS_ERR(xqspi->regs)) {
@@ -1029,7 +1128,6 @@ static int zynqmp_qspi_probe(struct platform_device *=
pdev)
                goto remove_master;
        }

-       xqspi->dev =3D dev;
        xqspi->pclk =3D devm_clk_get(&pdev->dev, "pclk");
        if (IS_ERR(xqspi->pclk)) {
                dev_err(dev, "pclk clock not found.\n");
@@ -1037,11 +1135,7 @@ static int zynqmp_qspi_probe(struct platform_device =
*pdev)
                goto remove_master;
        }

-       ret =3D clk_prepare_enable(xqspi->pclk);
-       if (ret) {
-               dev_err(dev, "Unable to enable APB clock.\n");
-               goto remove_master;
-       }
+       init_completion(&xqspi->data_completion);

        xqspi->refclk =3D devm_clk_get(&pdev->dev, "ref_clk");
        if (IS_ERR(xqspi->refclk)) {
@@ -1050,6 +1144,12 @@ static int zynqmp_qspi_probe(struct platform_device =
*pdev)
                goto clk_dis_pclk;
        }

+       ret =3D clk_prepare_enable(xqspi->pclk);
+       if (ret) {
+               dev_err(dev, "Unable to enable APB clock.\n");
+               goto remove_master;
+       }
+
        ret =3D clk_prepare_enable(xqspi->refclk);
        if (ret) {
                dev_err(dev, "Unable to enable device clock.\n");
@@ -1071,32 +1171,28 @@ static int zynqmp_qspi_probe(struct platform_device=
 *pdev)
                goto clk_dis_all;
        }
        ret =3D devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
-                              0, pdev->name, master);
+                              0, pdev->name, xqspi);
        if (ret !=3D 0) {
                ret =3D -ENXIO;
                dev_err(dev, "request_irq failed\n");
                goto clk_dis_all;
        }

-       master->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
-
-       master->setup =3D zynqmp_qspi_setup;
-       master->set_cs =3D zynqmp_qspi_chipselect;
-       master->transfer_one =3D zynqmp_qspi_start_transfer;
-       master->prepare_transfer_hardware =3D zynqmp_prepare_transfer_hardw=
are;
-       master->unprepare_transfer_hardware =3D
-                                       zynqmp_unprepare_transfer_hardware;
-       master->max_speed_hz =3D clk_get_rate(xqspi->refclk) / 2;
-       master->bits_per_word_mask =3D SPI_BPW_MASK(8);
-       master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QU=
AD |
+       ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
+       ctlr->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
+       ctlr->mem_ops =3D &zynqmp_qspi_mem_ops;
+       ctlr->setup =3D zynqmp_qspi_setup_op;
+       ctlr->max_speed_hz =3D clk_get_rate(xqspi->refclk) / 2;
+       ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
+       ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD=
 |
                            SPI_TX_DUAL | SPI_TX_QUAD;
+       ctlr->dev.of_node =3D np;

-       if (master->dev.parent =3D=3D NULL)
-               master->dev.parent =3D &master->dev;
-
-       ret =3D spi_register_master(master);
-       if (ret)
+       ret =3D devm_spi_register_controller(&pdev->dev, ctlr);
+       if (ret) {
+               dev_err(&pdev->dev, "spi_register_controller failed\n");
                goto clk_dis_all;
+       }

        return 0;

@@ -1107,7 +1203,7 @@ static int zynqmp_qspi_probe(struct platform_device *=
pdev)
 clk_dis_pclk:
        clk_disable_unprepare(xqspi->pclk);
 remove_master:
-       spi_master_put(master);
+       spi_controller_put(ctlr);

        return ret;
 }
@@ -1124,8 +1220,7 @@ static int zynqmp_qspi_probe(struct platform_device *=
pdev)
  */
 static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
-       struct spi_master *master =3D platform_get_drvdata(pdev);
-       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
+       struct zynqmp_qspi *xqspi =3D platform_get_drvdata(pdev);

        zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
        clk_disable_unprepare(xqspi->refclk);
@@ -1133,8 +1228,6 @@ static int zynqmp_qspi_remove(struct platform_device =
*pdev)
        pm_runtime_set_suspended(&pdev->dev);
        pm_runtime_disable(&pdev->dev);

-       spi_unregister_master(master);
-
        return 0;
 }

--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
