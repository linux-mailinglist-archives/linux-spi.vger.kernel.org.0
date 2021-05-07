Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A095376BEF
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 23:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEGVyW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 7 May 2021 17:54:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13280 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhEGVyV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 17:54:21 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147LiFFC023024
        for <linux-spi@vger.kernel.org>; Fri, 7 May 2021 14:53:20 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38cspgdph4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-spi@vger.kernel.org>; Fri, 07 May 2021 14:53:20 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 14:53:19 -0700
Received: by devvm2494.atn0.facebook.com (Postfix, from userid 172786)
        id 1A22EAFF26E0; Fri,  7 May 2021 14:53:19 -0700 (PDT)
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     <ribalda@kernel.org>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] spi: xilinx: Inhibit transmitter while filling TX FIFO
Date:   Fri, 7 May 2021 14:53:19 -0700
Message-ID: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lCDySqmjLiSJh8aEqKRUHlQsPGOp-7Ur
X-Proofpoint-ORIG-GUID: lCDySqmjLiSJh8aEqKRUHlQsPGOp-7Ur
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_10:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=333 mlxscore=0
 clxscore=1034 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Contrary to the comment in xilinx_spi_txrx_bufs(), the transmitter
was not disabled on entry.  On my particular board, when sending a PP
sequence, the first address byte was clocked out 3 times, writing data
into the wrong location, and generally locking up the chip.

Fix this by inhibiting the transmitter at initialization time, and
then enabling/disabling it appropriately.

With this patch, I can successfully read/erase/program the flash.

Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 drivers/spi/spi-xilinx.c | 54 +++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 523edfdf5dcd..10eccfb09e20 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -179,8 +179,8 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
 	xspi->write_fn(XSPI_CR_MANUAL_SSELECT |	XSPI_CR_MASTER_MODE |
-		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET,
-		regs_base + XSPI_CR_OFFSET);
+		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET |
+		XSPI_CR_TRANS_INHIBIT, regs_base + XSPI_CR_OFFSET);
 }
 
 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -235,14 +235,46 @@ static int xilinx_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static void
+xilinx_spi_inhibit_master(struct xilinx_spi *xspi, bool inhibit)
+{
+	u16 cr;
+
+	cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
+	if (inhibit)
+		cr |= XSPI_CR_TRANS_INHIBIT;
+	else
+		cr &= ~XSPI_CR_TRANS_INHIBIT;
+	xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+}
+
+static void
+xilinx_spi_enable_transfer(struct xilinx_spi *xspi)
+{
+	xilinx_spi_inhibit_master(xspi, false);
+}
+
+static void
+xilinx_spi_disable_transfer(struct xilinx_spi *xspi)
+{
+	xilinx_spi_inhibit_master(xspi, true);
+}
+
+static bool
+xilinx_spi_is_transfer_disabled(struct xilinx_spi *xspi)
+{
+	u16 cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
+	return !!(cr & XSPI_CR_TRANS_INHIBIT);
+}
+
 static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
 	int remaining_words;	/* the number of words left to transfer */
 	bool use_irq = false;
-	u16 cr = 0;
 
 	/* We get here with transmitter inhibited */
+	WARN_ON_ONCE(!xilinx_spi_is_transfer_disabled(xspi));
 
 	xspi->tx_ptr = t->tx_buf;
 	xspi->rx_ptr = t->rx_buf;
@@ -252,14 +284,13 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		u32 isr;
 		use_irq = true;
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
-		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
-		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
-			       xspi->regs + XSPI_CR_OFFSET);
+
 		/* ACK old irqs (if any) */
 		isr = xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
 		if (isr)
 			xspi->write_fn(isr,
 				       xspi->regs + XIPIF_V123B_IISR_OFFSET);
+
 		/* Enable the global IPIF interrupt */
 		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
 				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
@@ -280,9 +311,9 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		/* Start the transfer by not inhibiting the transmitter any
 		 * longer
 		 */
+		xilinx_spi_enable_transfer(xspi);
 
 		if (use_irq) {
-			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 			wait_for_completion(&xspi->done);
 			/* A transmit has just completed. Process received data
 			 * and check for more data to transmit. Always inhibit
@@ -290,8 +321,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 			 * register/FIFO, or make sure it is stopped if we're
 			 * done.
 			 */
-			xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
-				       xspi->regs + XSPI_CR_OFFSET);
+			xilinx_spi_disable_transfer(xspi);
 			sr = XSPI_SR_TX_EMPTY_MASK;
 		} else
 			sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
@@ -325,10 +355,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		remaining_words -= n_words;
 	}
 
-	if (use_irq) {
+	if (use_irq)
 		xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
-		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
-	}
+
+	xilinx_spi_disable_transfer(xspi);
 
 	return t->len;
 }
-- 
2.27.0

