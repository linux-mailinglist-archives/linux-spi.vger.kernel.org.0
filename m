Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3047E3F5C49
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhHXKlx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:23220 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236398AbhHXKlu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:50 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17OA050T016652;
        Tue, 24 Aug 2021 05:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bXPtQd8HEeyWR8X7GQzCqp25D8O8/msbik0SSpewS80=;
 b=eGSahquyMF4truea7sizxDcPXaCHGOTalqZxVraZgk8XwkpB7Sa8NFw09KmxP6QHA8lr
 UKZEwjfDltbBLTQznW5UH6TWSvxmJNLSHluxnrfVNU8DhfCl9I0LZpF7ZqefyJqv5fXW
 BTnekxDkJ2RvJ8jd17qcvXyenWTLiAjgSHgByEeeOhfqsMIiuFNvg4QioTT5U0NvBADX
 Zs7uOzrMJdcd9NoqWzJaxvYhRfe5hATFca8qZvumX33QCidvhXMWlQvyHmhTm38rxKbc
 0Cn/inLB7FVC5F3ObFrzSg9PwK05ycJ7+WgjbFNkQDsbSCSNQdSZEKcF1iM6wrQk3Umm cw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3amjmq8wmh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:41:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:41:00 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A5E262A9;
        Tue, 24 Aug 2021 10:41:00 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 8/9] spi: amd: Refactor to overcome 70 bytes per CS limitation
Date:   Tue, 24 Aug 2021 11:40:40 +0100
Message-ID: <20210824104041.708945-9-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: epGmpNXcnVKqNZ3X9hehhtdArML38hDr
X-Proofpoint-GUID: epGmpNXcnVKqNZ3X9hehhtdArML38hDr
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

AMD SPI controller has 70 bytes for its FIFO and it has an
automatic way of controlling it`s internal CS, which can
only be activated during the time that the FIFO is being
transfered.

SPI_MASTER_HALF_DUPLEX here means that it can only read
RX bytes after TX bytes were written, and RX+TX must be
less than 70. If you write 4 bytes the first byte of read
is in position 5 of the FIFO.

All of that means that for devices that require an address
for reads and writes, the 2 transfers must be put in the same
FIFO so the CS can be hold for address and data, otherwise
the data would lose it`s meaning.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 208 ++++++++++++++++++++++++++++--------------
 1 file changed, 140 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 75390fcb0481..b6308733265e 100644
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
@@ -29,6 +30,7 @@
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
 
+#define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 
 /* M_CMD OP codes for SPI */
@@ -132,83 +134,152 @@ static int amd_spi_master_setup(struct spi_device *spi)
 	return 0;
 }
 
-static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
-				    struct spi_master *master,
-				    struct spi_message *message)
+static int amd_spi_double_write(struct spi_master *mst, u8 *tx1_buf, u8 tx1_len, u8 *tx2_buf,
+				u8 tx2_len)
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
+	struct amd_spi *amd_spi = spi_master_get_devdata(mst);
+	int i, ret;
 
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
-	}
+	if (tx1_len + tx2_len > AMD_SPI_FIFO_SIZE)
+		return -EINVAL;
 
-	/* Update statistics */
-	message->actual_length = tx_len + rx_len + 1;
-	/* complete the transaction */
-	message->status = 0;
-	spi_finalize_current_message(master);
+	amd_spi_clear_fifo_ptr(amd_spi);
+	amd_spi_set_rx_count(amd_spi, 0);
 
-	return 0;
+	amd_spi_set_opcode(amd_spi, tx1_buf[0]);
+	tx1_len--;
+	tx1_buf++;
+
+	for (i = 0; i < tx1_len; i++)
+		amd_spi_writereg8(amd_spi, (u8)(AMD_SPI_FIFO_BASE + i), tx1_buf[i]);
+
+	for (i = 0; i < tx2_len; i++)
+		amd_spi_writereg8(amd_spi, (u8)(AMD_SPI_FIFO_BASE + tx1_len + i), tx2_buf[i]);
+
+	amd_spi_set_tx_count(amd_spi, tx1_len + tx2_len);
+	ret = amd_spi_execute_opcode(amd_spi);
+
+	return ret ? ret : tx1_len + 1 + tx2_len;
 }
 
-static int amd_spi_master_transfer(struct spi_master *master,
-				   struct spi_message *msg)
+static int amd_spi_write_read(struct spi_master *mst, u8 *tx_buf, u8 tx_len, u8 *rx_buf, u8 rx_len)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
+	struct amd_spi *amd_spi = spi_master_get_devdata(mst);
+	int i, ret;
+
+	if (tx_len + rx_len > AMD_SPI_FIFO_SIZE)
+		return -EINVAL;
+
+	amd_spi_clear_fifo_ptr(amd_spi);
+
+	if (tx_buf) {
+		/* Take the first byte to be written and set as opcode */
+		amd_spi_set_opcode(amd_spi, tx_buf[0]);
+		/* Set TX count as the number of bytes to be written less one (opcode byte) */
+		tx_len--;
+		tx_buf++;
 
-	amd_spi_select_chip(amd_spi, spi->chip_select);
+		/* Copy to the FIFO the remaining bytes */
+		for (i = 0; i < tx_len; i++)
+			amd_spi_writereg8(amd_spi, (AMD_SPI_FIFO_BASE + i), tx_buf[i]);
 
-	/*
-	 * Extract spi_transfers from the spi message and
-	 * program the controller.
+		amd_spi_set_tx_count(amd_spi, tx_len);
+	}
+	/* Set RX count as the number of bytes that will be read AFTER the TX bytes are sent
+	 * Or set to zero to avoid extra bytes after the write cycle
 	 */
-	amd_spi_fifo_xfer(amd_spi, master, msg);
+	amd_spi_set_rx_count(amd_spi, rx_buf ? rx_len : 0);
 
-	return 0;
+	/* Trigger the transfer by executing the opcode */
+	ret = amd_spi_execute_opcode(amd_spi);
+	if (ret)
+		return ret;
+
+	/* Wait for the SPI bus to be idle and copy the RX bytes from the FIFO from the starting
+	 * position of TX bytes
+	 */
+	if (rx_buf) {
+		for (i = 0; i < rx_len; i++)
+			rx_buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
+	}
+
+	return tx_len + 1 + rx_len;
+}
+
+/* amd_spi_master_transfer expects a spi_message with one or two transfers only
+ * Where a message with one transfer is a single write or read to a device
+ * And a message with two transfer is an address write followed by a read or
+ * write data into that address
+ */
+static int amd_spi_master_transfer(struct spi_master *mst, struct spi_message *msg)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(mst);
+	struct spi_transfer *xfer, *xfer_n;
+	struct list_head *pos;
+	int ret, count = 0;
+
+	list_for_each(pos, &msg->transfers)
+		count++;
+
+	amd_spi_select_chip(amd_spi, msg->spi->chip_select);
+
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	switch (count) {
+	case 1:
+		/* This controller can't write and read simultaneously
+		 * It can only write data first and read afterwards
+		 */
+		if (xfer->tx_buf && xfer->rx_buf) {
+			ret = -EINVAL;
+			dev_err(&mst->dev, "Error. Can't write and read simultaneously\n");
+			goto complete;
+		}
+
+		ret = amd_spi_write_read(mst, (u8 *)xfer->tx_buf, xfer->len,
+					      (u8 *)xfer->rx_buf, xfer->len);
+		if (ret < 0)
+			goto complete;
+		break;
+	case 2:
+		xfer_n = list_last_entry(&msg->transfers, struct spi_transfer, transfer_list);
+		if (xfer->tx_buf && !xfer->rx_buf) {
+			if (xfer_n->rx_buf && !xfer_n->tx_buf) {
+				ret = amd_spi_write_read(mst, (u8 *)xfer->tx_buf, xfer->len,
+							      (u8 *)xfer_n->rx_buf, xfer_n->len);
+				if (ret < 0)
+					goto complete;
+				break;
+			} else if (xfer_n->tx_buf && !xfer_n->rx_buf) {
+				ret = amd_spi_double_write(mst, (u8 *)xfer->tx_buf, xfer->len,
+								(u8 *)xfer_n->tx_buf, xfer_n->len);
+				if (ret < 0)
+					goto complete;
+				break;
+			}
+		}
+		ret = -EINVAL;
+		dev_err(&mst->dev, "Error. Message not supported\n");
+		goto complete;
+	default:
+		ret = -EINVAL;
+		dev_err(&mst->dev, "Message with %d transfers is not supported\n", count);
+		goto complete;
+	}
+
+	msg->actual_length += ret;
+	ret = 0;
+
+complete:
+	/* complete the transaction */
+	msg->status = ret;
+	spi_finalize_current_message(mst);
+
+	return ret;
+}
+
+static size_t amd_spi_max_transfer_size(struct spi_device *spi)
+{
+	return AMD_SPI_FIFO_SIZE;
 }
 
 static int amd_spi_probe(struct platform_device *pdev)
@@ -238,8 +309,9 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->flags = SPI_MASTER_HALF_DUPLEX | SPI_CONTROLLER_CS_PER_TRANSFER;
 	master->setup = amd_spi_master_setup;
+	master->max_transfer_size = amd_spi_max_transfer_size;
 	master->transfer_one_message = amd_spi_master_transfer;
 
 	/* Register the controller with SPI framework */
-- 
2.33.0

