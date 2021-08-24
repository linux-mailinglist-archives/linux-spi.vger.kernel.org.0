Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F23F5C4A
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhHXKlz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:55 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45066 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236350AbhHXKlu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhW012561;
        Tue, 24 Aug 2021 05:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2wUntjv+cBhYZZorzhH9FjfWoIl23/Y/M9545kBYFLc=;
 b=Uxee53KxMnf/SJghkIkhhHIEip7Ww+G9o0rpWqqg4N3QU/vNuaHkM76fFWzl8jOrnM8P
 SgJFHhEb9ERDK8AJUhG3LcB5EiFwIwK3v7l51E9ljz3BfuR+iYuPoCyxNTNRdw/UwPo+
 4GQVhYlY9eW0txDJ+EnpZ+NMcnBnqDsXAR9FBVnb8vy1qEC9vDo79koZKzcKta1CYkfO
 2Fc/THEyPeFxiVWVz+2d3dy7fYK9JGRXTXfDTqtx21LX+rNA2+mJLKgIX0b7MBXYBdAX
 UuglWKmaLyI11OP/x/xWM6N+PwrIWvSdZRrlG4mb6VQxT41u/yvtrRbphaPBYJyTVWMq 1w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601k1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:41:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:41:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:41:01 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E8D692BA;
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
Subject: [PATCH 9/9] spi: amd: Add support for latest platform
Date:   Tue, 24 Aug 2021 11:40:41 +0100
Message-ID: <20210824104041.708945-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TtRVHzYK-d7bQ5uej-E_zrG7FGf4nHJP
X-Proofpoint-ORIG-GUID: TtRVHzYK-d7bQ5uej-E_zrG7FGf4nHJP
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for AMDI0062 controllers

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 127 +++++++++++++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index b6308733265e..cd0b38ead150 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -2,9 +2,10 @@
 //
 // AMD SPI controller driver
 //
-// Copyright (c) 2020, Advanced Micro Devices, Inc.
+// Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
 //
 // Authors: Sanjay R Mehta <sanju.mehta@amd.com>
+//          Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>
 //          Lucas Tanure <tanureal@opensource.cirrus.com>
 
 #include <linux/acpi.h>
@@ -15,32 +16,46 @@
 #include <linux/spi/spi.h>
 #include <linux/iopoll.h>
 
-#define AMD_SPI_CTRL0_REG	0x00
-#define AMD_SPI_EXEC_CMD	BIT(16)
-#define AMD_SPI_FIFO_CLEAR	BIT(20)
-#define AMD_SPI_BUSY		BIT(31)
+#define AMD_SPI_CTRL0_REG		0x00
+#define AMD_SPI_EXEC_CMD		BIT(16)
+#define AMD_SPI_FIFO_CLEAR		BIT(20)
+#define AMD_SPI_BUSY			BIT(31)
+#define AMD_SPI_ENABLE_REG		0x20
 
-#define AMD_SPI_OPCODE_MASK	0xFF
+#define AMD_SPI_DUMMY_CYCL_REG		0x32
+#define AMD_SPI_OPCODE_REG		0x45
+#define AMD_SPI_CMD_TRIGGER_REG		0x47
+#define AMD_SPI_TRIGGER_CMD		BIT(7)
+#define AMD_SPI_OPCODE_MASK		0xFF
 
-#define AMD_SPI_ALT_CS_REG	0x1D
-#define AMD_SPI_ALT_CS_MASK	0x3
+#define AMD_SPI_ALT_CS_REG		0x1D
+#define AMD_SPI_ALT_CS_MASK		GENMASK(1, 0)
 
-#define AMD_SPI_FIFO_BASE	0x80
-#define AMD_SPI_TX_COUNT_REG	0x48
-#define AMD_SPI_RX_COUNT_REG	0x4B
-#define AMD_SPI_STATUS_REG	0x4C
+#define AMD_SPI_FIFO_BASE		0x80
+#define AMD_SPI_TX_COUNT_REG		0x48
+#define AMD_SPI_RX_COUNT_REG		0x4B
+#define AMD_SPI_STATUS_REG		0x4C
 
-#define AMD_SPI_FIFO_SIZE	70
-#define AMD_SPI_MEM_SIZE	200
+#define AMD_SPI_FIFO_SIZE		70
+#define AMD_SPI_MEM_SIZE		200
 
 /* M_CMD OP codes for SPI */
-#define AMD_SPI_XFER_TX		1
-#define AMD_SPI_XFER_RX		2
+#define AMD_SPI_XFER_TX			1
+#define AMD_SPI_XFER_RX			2
 
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
+	const struct amd_spi_devtype_data *devtype_data;
+	struct spi_device *spi_dev;
+	struct spi_master *master;
+};
+
+struct amd_spi_devtype_data {
+	u8 version;
+	int (*exec_op)(struct amd_spi *amd_spi);
+	void (*set_op)(struct amd_spi *amd_spi, u8 cmd_opcode);
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -84,16 +99,26 @@ static void amd_spi_select_chip(struct amd_spi *amd_spi, u8 cs)
 	amd_spi_setclear_reg8(amd_spi, AMD_SPI_ALT_CS_REG, cs, AMD_SPI_ALT_CS_MASK);
 }
 
+static inline void amd_spi_clear_chip(struct amd_spi *amd_spi, u8 chip_select)
+{
+	amd_spi_writereg8(amd_spi, AMD_SPI_ALT_CS_REG, chip_select & ~AMD_SPI_ALT_CS_MASK);
+}
+
 static void amd_spi_clear_fifo_ptr(struct amd_spi *amd_spi)
 {
 	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR, AMD_SPI_FIFO_CLEAR);
 }
 
-static void amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
+static void amd_spi_set_opcode_v1(struct amd_spi *amd_spi, u8 cmd_opcode)
 {
 	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, cmd_opcode, AMD_SPI_OPCODE_MASK);
 }
 
+static void amd_spi_set_opcode_v2(struct amd_spi *amd_spi, u8 cmd_opcode)
+{
+	amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
+}
+
 static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
 {
 	amd_spi_setclear_reg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
@@ -104,7 +129,7 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
 }
 
-static int amd_spi_busy_wait(struct amd_spi *amd_spi)
+static int amd_spi_busy_wait_v1(struct amd_spi *amd_spi)
 {
 	u32 val;
 
@@ -112,17 +137,39 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 				 !(val & AMD_SPI_BUSY), 10, 100000);
 }
 
-static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
+static int amd_spi_execute_opcode_v1(struct amd_spi *amd_spi)
 {
-	int ret = amd_spi_busy_wait(amd_spi);
+	int ret;
 
+	ret = amd_spi_busy_wait_v1(amd_spi);
 	if (ret)
 		return ret;
 
-	/* Set ExecuteOpCode bit in the CTRL0 register */
 	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
 
-	return amd_spi_busy_wait(amd_spi);
+	return amd_spi_busy_wait_v1(amd_spi);
+}
+
+static int amd_spi_busy_wait_v2(struct amd_spi *amd_spi)
+{
+	u32 val;
+
+	return readl_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_STATUS_REG, val,
+				 !(val & AMD_SPI_BUSY), 10, 1000);
+}
+
+static int amd_spi_execute_opcode_v2(struct amd_spi *amd_spi)
+{
+	int ret;
+
+	ret = amd_spi_busy_wait_v2(amd_spi);
+	if (ret)
+		return ret;
+
+	amd_spi_setclear_reg8(amd_spi, AMD_SPI_CMD_TRIGGER_REG, AMD_SPI_TRIGGER_CMD,
+			      AMD_SPI_TRIGGER_CMD);
+
+	return amd_spi_busy_wait_v2(amd_spi);
 }
 
 static int amd_spi_master_setup(struct spi_device *spi)
@@ -138,6 +185,7 @@ static int amd_spi_double_write(struct spi_master *mst, u8 *tx1_buf, u8 tx1_len,
 				u8 tx2_len)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(mst);
+	const struct amd_spi_devtype_data *priv = amd_spi->devtype_data;
 	int i, ret;
 
 	if (tx1_len + tx2_len > AMD_SPI_FIFO_SIZE)
@@ -146,7 +194,7 @@ static int amd_spi_double_write(struct spi_master *mst, u8 *tx1_buf, u8 tx1_len,
 	amd_spi_clear_fifo_ptr(amd_spi);
 	amd_spi_set_rx_count(amd_spi, 0);
 
-	amd_spi_set_opcode(amd_spi, tx1_buf[0]);
+	priv->set_op(amd_spi, tx1_buf[0]);
 	tx1_len--;
 	tx1_buf++;
 
@@ -157,7 +205,7 @@ static int amd_spi_double_write(struct spi_master *mst, u8 *tx1_buf, u8 tx1_len,
 		amd_spi_writereg8(amd_spi, (u8)(AMD_SPI_FIFO_BASE + tx1_len + i), tx2_buf[i]);
 
 	amd_spi_set_tx_count(amd_spi, tx1_len + tx2_len);
-	ret = amd_spi_execute_opcode(amd_spi);
+	ret = priv->exec_op(amd_spi);
 
 	return ret ? ret : tx1_len + 1 + tx2_len;
 }
@@ -165,6 +213,7 @@ static int amd_spi_double_write(struct spi_master *mst, u8 *tx1_buf, u8 tx1_len,
 static int amd_spi_write_read(struct spi_master *mst, u8 *tx_buf, u8 tx_len, u8 *rx_buf, u8 rx_len)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(mst);
+	const struct amd_spi_devtype_data *priv = amd_spi->devtype_data;
 	int i, ret;
 
 	if (tx_len + rx_len > AMD_SPI_FIFO_SIZE)
@@ -174,7 +223,7 @@ static int amd_spi_write_read(struct spi_master *mst, u8 *tx_buf, u8 tx_len, u8
 
 	if (tx_buf) {
 		/* Take the first byte to be written and set as opcode */
-		amd_spi_set_opcode(amd_spi, tx_buf[0]);
+		priv->set_op(amd_spi, tx_buf[0]);
 		/* Set TX count as the number of bytes to be written less one (opcode byte) */
 		tx_len--;
 		tx_buf++;
@@ -191,7 +240,7 @@ static int amd_spi_write_read(struct spi_master *mst, u8 *tx_buf, u8 tx_len, u8
 	amd_spi_set_rx_count(amd_spi, rx_buf ? rx_len : 0);
 
 	/* Trigger the transfer by executing the opcode */
-	ret = amd_spi_execute_opcode(amd_spi);
+	ret = priv->exec_op(amd_spi);
 	if (ret)
 		return ret;
 
@@ -274,6 +323,9 @@ static int amd_spi_master_transfer(struct spi_master *mst, struct spi_message *m
 	msg->status = ret;
 	spi_finalize_current_message(mst);
 
+	if (amd_spi->devtype_data->version)
+		amd_spi_clear_chip(amd_spi, msg->spi->chip_select);
+
 	return ret;
 }
 
@@ -305,6 +357,12 @@ static int amd_spi_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
+	amd_spi->devtype_data = device_get_match_data(dev);
+	if (!amd_spi->devtype_data) {
+		err = -ENODEV;
+		goto err_free_master;
+	}
+
 	/* Initialize the spi_master fields */
 	master->bus_num = 0;
 	master->num_chipselect = 4;
@@ -329,9 +387,23 @@ static int amd_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct amd_spi_devtype_data spi_v1 = {
+	.exec_op	= amd_spi_execute_opcode_v1,
+	.set_op		= amd_spi_set_opcode_v1,
+};
+
+static const struct amd_spi_devtype_data spi_v2 = {
+	.version	= 1,
+	.exec_op	= amd_spi_execute_opcode_v2,
+	.set_op		= amd_spi_set_opcode_v2,
+};
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
-	{ "AMDI0061", 0 },
+	{ "AMDI0061",
+	.driver_data = (kernel_ulong_t)&spi_v1 },
+	{ "AMDI0062",
+	.driver_data = (kernel_ulong_t)&spi_v2 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
@@ -349,4 +421,5 @@ module_platform_driver(amd_spi_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>");
 MODULE_DESCRIPTION("AMD SPI Master Controller Driver");
-- 
2.33.0

