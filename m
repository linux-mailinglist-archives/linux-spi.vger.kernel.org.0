Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA54038E0
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbhIHLgP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:15 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:10332 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349260AbhIHLgI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:08 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mnx005982;
        Wed, 8 Sep 2021 06:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=r8rlPxkjnx4t2zjv5bpgb48oXydfc5StSuoYQheuYG0=;
 b=FZrQHj/U+A0twoHgNbRNqv1ig0tfPKL7MBt+dhbHc5YosBfOhCIx3BRtLhVsZpWvunnS
 WkAbqVIGxzLffpWQ1w9NuWl2Vc/I+29Aj32apC8VcxRYgpbrZN6HAV/5eF2R8zISZqim
 qDQTh5yDC/3+/ovoyt1fuKmLzUih6rczJcqxXZ/svNCLPtgJqCEvy15wZhO6FnHdI0ES
 7x9/C56aN6dTnusu5kMbJA7KluPSDprThKvHdBYewndOTbyNr9MXtShCNJXzmKhKv4S3
 tt389u1g3Kq3S1heU9D80ZPsgzd11QF4LQ6beEbv+kajj71ZQ8kklGPCJLZqAWo36fNr mQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:57 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:56 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CFD26B13;
        Wed,  8 Sep 2021 11:34:55 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 08/10] spi: amd: Fill FIFO buffer with the whole message
Date:   Wed, 8 Sep 2021 12:34:49 +0100
Message-ID: <20210908113450.788452-9-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: u7UwV8Zb2IVpBDCO9pd_puPIv6WND8cs
X-Proofpoint-ORIG-GUID: u7UwV8Zb2IVpBDCO9pd_puPIv6WND8cs
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The controller is half-duplex, in that it cannot
read data while it is sending data. But the FIFO
is full-duplex, the writes and reads must be
queued and executed together, and the read data
will be offset in the FIFO by the length of the
initial write data (as it would in a full-duplex
SPI).

And the controller has an automatic CS which can
only be activated during the transmission of the
FIFO, which can make read|write data lose meaning
as the CS will be toggle after the required
read|write address.
To avoid that set the max transfer and message
size as AMD_SPI_FIFO_SIZE ensuring that incoming
messages always fit inside a FIFO buffer

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 193 +++++++++++++++++++++++++++---------------
 1 file changed, 125 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 99b2b0ccff08..0face11740ea 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -4,7 +4,8 @@
 //
 // Copyright (c) 2020, Advanced Micro Devices, Inc.
 //
-// Author: Sanjay R Mehta <sanju.mehta@amd.com>
+// Authors: Sanjay R Mehta <sanju.mehta@amd.com>
+//          Lucas Tanure <tanureal@opensource.cirrus.com>
 
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -28,6 +29,7 @@
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
 
+#define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 
 /* M_CMD OP codes for SPI */
@@ -38,6 +40,13 @@ struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
+	struct list_head rbuf_head;
+};
+
+struct amd_spi_read_buffer {
+	struct list_head node;
+	u8 *buf;
+	u8 len;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -138,83 +147,127 @@ static int amd_spi_master_setup(struct spi_device *spi)
 	return 0;
 }
 
-static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
-				    struct spi_master *master,
-				    struct spi_message *message)
+static void amd_spi_clear_list(struct amd_spi *amd_spi)
 {
-	struct spi_transfer *xfer = NULL;
-	u8 cmd_opcode;
-	u8 *buf = NULL;
-	u32 m_cmd = 0;
-	u32 i = 0;
-	u32 tx_len = 0, rx_len = 0;
-
-	list_for_each_entry(xfer, &message->transfers,
-			    transfer_list) {
-		if (xfer->rx_buf)
-			m_cmd = AMD_SPI_XFER_RX;
-		if (xfer->tx_buf)
-			m_cmd = AMD_SPI_XFER_TX;
-
-		if (m_cmd & AMD_SPI_XFER_TX) {
-			buf = (u8 *)xfer->tx_buf;
-			tx_len = xfer->len - 1;
-			cmd_opcode = *(u8 *)xfer->tx_buf;
-			buf++;
-			amd_spi_set_opcode(amd_spi, cmd_opcode);
-
-			/* Write data into the FIFO. */
-			for (i = 0; i < tx_len; i++) {
-				iowrite8(buf[i], ((u8 __iomem *)amd_spi->io_remap_addr +
-					 AMD_SPI_FIFO_BASE + i));
-			}
+	struct amd_spi_read_buffer *rbuf, *tmp;
 
-			amd_spi_set_tx_count(amd_spi, tx_len);
-			amd_spi_clear_fifo_ptr(amd_spi);
-			/* Execute command */
-			amd_spi_execute_opcode(amd_spi);
-		}
-		if (m_cmd & AMD_SPI_XFER_RX) {
-			/*
-			 * Store no. of bytes to be received from
-			 * FIFO
-			 */
-			rx_len = xfer->len;
-			buf = (u8 *)xfer->rx_buf;
-			amd_spi_set_rx_count(amd_spi, rx_len);
-			amd_spi_clear_fifo_ptr(amd_spi);
-			/* Execute command */
-			amd_spi_execute_opcode(amd_spi);
-			/* Read data from FIFO to receive buffer  */
-			for (i = 0; i < rx_len; i++)
-				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
-		}
+	list_for_each_entry_safe(rbuf, tmp, &amd_spi->rbuf_head, node) {
+		list_del(&rbuf->node);
+		kfree(rbuf);
 	}
+}
 
-	/* Update statistics */
-	message->actual_length = tx_len + rx_len + 1;
-	/* complete the transaction */
-	message->status = 0;
-	spi_finalize_current_message(master);
+static int amd_spi_transfer(struct amd_spi *amd_spi, u8 opcode, u8 tx_len, u8 rx_len, u8 fifo_pos)
+{
+	struct amd_spi_read_buffer *rbuf;
+	struct list_head *p;
+	int ret, i;
+
+	amd_spi_set_opcode(amd_spi, opcode);
+	amd_spi_set_tx_count(amd_spi, tx_len);
+	amd_spi_set_rx_count(amd_spi, rx_len);
+
+	ret = amd_spi_execute_opcode(amd_spi);
+	if (ret)
+		return ret;
+
+	if (!list_empty(&amd_spi->rbuf_head)) {
+		ret = amd_spi_busy_wait(amd_spi);
+		if (ret)
+			return ret;
+		list_for_each(p, &amd_spi->rbuf_head) {
+			rbuf = list_entry(p, struct amd_spi_read_buffer, node);
+			for (i = 0; i < rbuf->len; i++)
+				rbuf->buf[i] = amd_spi_readreg8(amd_spi, fifo_pos++);
+		}
+		amd_spi_clear_list(amd_spi);
+	}
 
 	return 0;
 }
 
-static int amd_spi_master_transfer(struct spi_master *master,
-				   struct spi_message *msg)
+/* amd_spi_master_transfer expects a spi_message with no more than AMD_SPI_FIFO_SIZE and no TX after
+ * a RX in the same CS
+ * The CS can not be held between two amd_spi_execute_opcode so fill the FIFO with all transfers
+ * until the first RX transfer
+ */
+static int amd_spi_transfer_one_message(struct spi_controller *ctrl, struct spi_message *msg)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
+	struct amd_spi *amd_spi = spi_master_get_devdata(ctrl);
+	u8 tx_len = 0, rx_len = 0, opcode = 0, fifo_pos = AMD_SPI_FIFO_BASE;
+	struct amd_spi_read_buffer *rbuf;
+	struct spi_transfer *xfer;
+	u8 *tx_buf;
+	int ret, i;
+
+	amd_spi_select_chip(amd_spi, msg->spi->chip_select);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->tx_buf) {
+			tx_buf = (u8 *)xfer->tx_buf;
+			if (!tx_len) {
+				opcode = tx_buf[0];
+				xfer->len--;
+				tx_buf++;
+			}
+			tx_len += xfer->len;
+			for (i = 0; i < xfer->len; i++)
+				amd_spi_writereg8(amd_spi, fifo_pos++, tx_buf[i]);
+		}
 
-	amd_spi_select_chip(amd_spi, spi->chip_select);
+		if (xfer->rx_buf) {
+			rx_len += xfer->len;
+			rbuf = kmalloc(sizeof(*rbuf), GFP_KERNEL);
+			if (!rbuf) {
+				ret = -ENOMEM;
+				goto complete;
+			}
 
-	/*
-	 * Extract spi_transfers from the spi message and
-	 * program the controller.
-	 */
-	amd_spi_fifo_xfer(amd_spi, master, msg);
+			rbuf->buf = (u8 *)xfer->rx_buf;
+			rbuf->len = xfer->len;
+			list_add(&rbuf->node, &amd_spi->rbuf_head);
+		}
 
-	return 0;
+		if (xfer->cs_change) {
+			ret = amd_spi_transfer(amd_spi, opcode, tx_len, rx_len, fifo_pos);
+			if (ret)
+				goto complete;
+
+			msg->actual_length += rx_len;
+			if (tx_len)
+				msg->actual_length += tx_len + 1;
+
+			fifo_pos = AMD_SPI_FIFO_BASE;
+			opcode = 0;
+			tx_len = 0;
+			rx_len = 0;
+		}
+	}
+
+	if (tx_len || rx_len) {
+		ret = amd_spi_transfer(amd_spi, opcode, tx_len, rx_len, fifo_pos);
+		if (ret)
+			goto complete;
+
+		msg->actual_length += rx_len;
+		if (tx_len)
+			msg->actual_length += tx_len + 1;
+	}
+	ret = 0;
+
+complete:
+	if (!list_empty(&amd_spi->rbuf_head))
+		amd_spi_clear_list(amd_spi);
+	/* complete the transaction */
+	msg->status = ret;
+	spi_finalize_current_message(ctrl);
+
+	return ret;
+}
+
+static size_t amd_spi_max_transfer_size(struct spi_device *spi)
+{
+	return AMD_SPI_FIFO_SIZE;
 }
 
 static int amd_spi_probe(struct platform_device *pdev)
@@ -244,9 +297,13 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX | SPI_CONTROLLER_NO_TX_RX_CS;
 	master->setup = amd_spi_master_setup;
-	master->transfer_one_message = amd_spi_master_transfer;
+	master->max_transfer_size = amd_spi_max_transfer_size;
+	master->max_message_size = amd_spi_max_transfer_size;
+	master->transfer_one_message = amd_spi_transfer_one_message;
+
+	INIT_LIST_HEAD(&amd_spi->rbuf_head);
 
 	/* Register the controller with SPI framework */
 	err = devm_spi_register_master(dev, master);
-- 
2.33.0

