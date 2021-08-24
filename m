Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC583F5C48
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhHXKlw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:52 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43906 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236394AbhHXKlu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:50 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17OA050S016652;
        Tue, 24 Aug 2021 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=lvWHwXTcSG8h2+K7YJT4jpdOlm1p0Y8DMIJX1xP3hyk=;
 b=dF5S5EbghmXNq5c1ghoQV2oYd6O3jKq/p5VtUALfKOXmpjc80casFmi/Z9x0nAYvld6P
 t9EE6N+wBn+JMPtdO/Af8s1Tr/4EXWUIsOGYcwgFbdIiBiBQKBJUFjpoZ1qw1mM4spKX
 jak6j7gsnzf5mDOTvhCZzJJqjNoq7pA1R0qcjaviDArkfWD7pG8z4ifSNAS+Jy/amfae
 z2+PjSaqIuJ/HtOdHe/dPeY849eMmUV3ivS9QD52w6ahHn/GMYs1k05F+n21+HhE6Bf0
 sfotudrVV9i+mH9FMKPQNtIiEZAf4J1vCxU1XaNqcnsLwUVwArJaHLhUBESlGS6HcT5o kQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3amjmq8wmh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:40:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:40:59 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B5D546E;
        Tue, 24 Aug 2021 10:40:59 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 4/9] spi: amd: Refactor code to use less spi_master_get_devdata
Date:   Tue, 24 Aug 2021 11:40:36 +0100
Message-ID: <20210824104041.708945-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rk44ACb3oTlokmSNf-7aVVPRej19ybEN
X-Proofpoint-GUID: rk44ACb3oTlokmSNf-7aVVPRej19ybEN
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Get master data in the start and then just use struct amd_spi
as it has the needed variable

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 94 ++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 3cf76096a76d..f23467cf6acd 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -41,85 +41,66 @@ struct amd_spi {
 	u8 chip_select;
 };
 
-static inline u8 amd_spi_readreg8(struct spi_master *master, int idx)
+static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-
 	return ioread8((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
-static inline void amd_spi_writereg8(struct spi_master *master, int idx,
-				     u8 val)
+static inline void amd_spi_writereg8(struct amd_spi *amd_spi, int idx, u8 val)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-
 	iowrite8(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
-static inline void amd_spi_setclear_reg8(struct spi_master *master, int idx,
-					 u8 set, u8 clear)
+static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 clear)
 {
-	u8 tmp = amd_spi_readreg8(master, idx);
+	u8 tmp = amd_spi_readreg8(amd_spi, idx);
 
 	tmp = (tmp & ~clear) | set;
-	amd_spi_writereg8(master, idx, tmp);
+	amd_spi_writereg8(amd_spi, idx, tmp);
 }
 
-static inline u32 amd_spi_readreg32(struct spi_master *master, int idx)
+static inline u32 amd_spi_readreg32(struct amd_spi *amd_spi, int idx)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-
 	return ioread32((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
-static inline void amd_spi_writereg32(struct spi_master *master, int idx,
-				      u32 val)
+static inline void amd_spi_writereg32(struct amd_spi *amd_spi, int idx, u32 val)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-
 	iowrite32(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
-static inline void amd_spi_setclear_reg32(struct spi_master *master, int idx,
-					  u32 set, u32 clear)
+static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32 set, u32 clear)
 {
-	u32 tmp = amd_spi_readreg32(master, idx);
+	u32 tmp = amd_spi_readreg32(amd_spi, idx);
 
 	tmp = (tmp & ~clear) | set;
-	amd_spi_writereg32(master, idx, tmp);
+	amd_spi_writereg32(amd_spi, idx, tmp);
 }
 
-static void amd_spi_select_chip(struct spi_master *master)
+static void amd_spi_select_chip(struct amd_spi *amd_spi)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-	u8 chip_select = amd_spi->chip_select;
-
-	amd_spi_setclear_reg8(master, AMD_SPI_ALT_CS_REG, chip_select,
+	amd_spi_setclear_reg8(amd_spi, AMD_SPI_ALT_CS_REG, amd_spi->chip_select,
 			      AMD_SPI_ALT_CS_MASK);
 }
 
-static void amd_spi_clear_fifo_ptr(struct spi_master *master)
+static void amd_spi_clear_fifo_ptr(struct amd_spi *amd_spi)
 {
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR,
-			       AMD_SPI_FIFO_CLEAR);
+	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR, AMD_SPI_FIFO_CLEAR);
 }
 
-static void amd_spi_set_opcode(struct spi_master *master, u8 cmd_opcode)
+static void amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 {
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
-			       AMD_SPI_OPCODE_MASK);
+	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, cmd_opcode, AMD_SPI_OPCODE_MASK);
 }
 
-static inline void amd_spi_set_rx_count(struct spi_master *master,
-					u8 rx_count)
+static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
 {
-	amd_spi_setclear_reg8(master, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
+	amd_spi_setclear_reg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
 }
 
-static inline void amd_spi_set_tx_count(struct spi_master *master,
-					u8 tx_count)
+static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 {
-	amd_spi_setclear_reg8(master, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
+	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
 }
 
 static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
@@ -142,22 +123,18 @@ static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
 	return 0;
 }
 
-static void amd_spi_execute_opcode(struct spi_master *master)
+static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
 {
-	struct amd_spi *amd_spi = spi_master_get_devdata(master);
-
 	/* Set ExecuteOpCode bit in the CTRL0 register */
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
-			       AMD_SPI_EXEC_CMD);
-
+	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
 	amd_spi_busy_wait(amd_spi);
 }
 
 static int amd_spi_master_setup(struct spi_device *spi)
 {
-	struct spi_master *master = spi->master;
+	struct amd_spi *amd_spi = spi_master_get_devdata(spi->master);
 
-	amd_spi_clear_fifo_ptr(master);
+	amd_spi_clear_fifo_ptr(amd_spi);
 
 	return 0;
 }
@@ -185,19 +162,18 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 			tx_len = xfer->len - 1;
 			cmd_opcode = *(u8 *)xfer->tx_buf;
 			buf++;
-			amd_spi_set_opcode(master, cmd_opcode);
+			amd_spi_set_opcode(amd_spi, cmd_opcode);
 
 			/* Write data into the FIFO. */
 			for (i = 0; i < tx_len; i++) {
-				iowrite8(buf[i],
-					 ((u8 __iomem *)amd_spi->io_remap_addr +
+				iowrite8(buf[i], ((u8 __iomem *)amd_spi->io_remap_addr +
 					 AMD_SPI_FIFO_BASE + i));
 			}
 
-			amd_spi_set_tx_count(master, tx_len);
-			amd_spi_clear_fifo_ptr(master);
+			amd_spi_set_tx_count(amd_spi, tx_len);
+			amd_spi_clear_fifo_ptr(amd_spi);
 			/* Execute command */
-			amd_spi_execute_opcode(master);
+			amd_spi_execute_opcode(amd_spi);
 		}
 		if (m_cmd & AMD_SPI_XFER_RX) {
 			/*
@@ -206,15 +182,13 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 			 */
 			rx_len = xfer->len;
 			buf = (u8 *)xfer->rx_buf;
-			amd_spi_set_rx_count(master, rx_len);
-			amd_spi_clear_fifo_ptr(master);
+			amd_spi_set_rx_count(amd_spi, rx_len);
+			amd_spi_clear_fifo_ptr(amd_spi);
 			/* Execute command */
-			amd_spi_execute_opcode(master);
+			amd_spi_execute_opcode(amd_spi);
 			/* Read data from FIFO to receive buffer  */
 			for (i = 0; i < rx_len; i++)
-				buf[i] = amd_spi_readreg8(master,
-							  AMD_SPI_FIFO_BASE +
-							  tx_len + i);
+				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
 		}
 	}
 
@@ -234,7 +208,7 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 
 	amd_spi->chip_select = spi->chip_select;
-	amd_spi_select_chip(master);
+	amd_spi_select_chip(amd_spi);
 
 	/*
 	 * Extract spi_transfers from the spi message and
-- 
2.33.0

