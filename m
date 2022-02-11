Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE914B27F1
	for <lists+linux-spi@lfdr.de>; Fri, 11 Feb 2022 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350860AbiBKOcU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Feb 2022 09:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbiBKOcS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Feb 2022 09:32:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DFBCC;
        Fri, 11 Feb 2022 06:32:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 19E671F46F5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644589934;
        bh=S+FC0Hq3W/fuvMSspDsQ7mypGtl6UOx2hHL2pfs0UnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REfZK3qLHZsuXMkhk/ZQHOfFyjBOBYMki/t+yX0j7XdmxYXVllivMECibP+R4Un67
         At0oe/YxTsqd4b9HFAS+WrWLM6QdxhxEojCEPKH4uOguwRS65lr8uecnsHiHYeuTYC
         XE6RY988ncTu7a3b9LwBQMmGky2+ryAVC+ANJfZLWUot8fmnbnOZoDB2f0Jb4xztLU
         CnrzeAAU+jR8DopW4xfqlQVE1oV3/MyQOTy3CdsyyjBjvFWV+0TyadjgGAJP8LxEeZ
         g0F78MifFgg/WbhrPdikd1Nhe4zpCQTvS40STorUxvWppiD9qkupicI1FlRHFqOtd9
         p5UMvKVk8tLKA==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 3/3] spi: amd: Add support for version AMDI0062
Date:   Fri, 11 Feb 2022 11:31:55 -0300
Message-Id: <20220211143155.75513-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220211143155.75513-1-andrealmeid@collabora.com>
References: <20220211143155.75513-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for the AMD SPI controller version AMDI0062. Do this in a
modular way where's easy to add new versions.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Change from v1:
- Replace `if (version == 2)` with a more extensible switch case.

 drivers/spi/spi-amd.c | 81 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 417ce14a21c6..d909afac6e21 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -19,6 +19,10 @@
 #define AMD_SPI_FIFO_CLEAR	BIT(20)
 #define AMD_SPI_BUSY		BIT(31)
 
+#define AMD_SPI_OPCODE_REG	0x45
+#define AMD_SPI_CMD_TRIGGER_REG	0x47
+#define AMD_SPI_TRIGGER_CMD	BIT(7)
+
 #define AMD_SPI_OPCODE_MASK	0xFF
 
 #define AMD_SPI_ALT_CS_REG	0x1D
@@ -35,9 +39,15 @@
 #define AMD_SPI_XFER_TX		1
 #define AMD_SPI_XFER_RX		2
 
+enum amd_spi_versions {
+	AMD_SPI_V1 = 1,	/* AMDI0061 */
+	AMD_SPI_V2,	/* AMDI0062 */
+};
+
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
+	enum amd_spi_versions version;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
@@ -81,14 +91,29 @@ static void amd_spi_select_chip(struct amd_spi *amd_spi, u8 cs)
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
+static int amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
 {
-	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, cmd_opcode, AMD_SPI_OPCODE_MASK);
+	switch (amd_spi->version) {
+	case AMD_SPI_V1:
+		amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, cmd_opcode,
+				       AMD_SPI_OPCODE_MASK);
+		return 0;
+	case AMD_SPI_V2:
+		amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
+		return 0;
+	default:
+		return -ENODEV;
+	}
 }
 
 static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
@@ -104,9 +129,21 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
 static int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
 	u32 val;
+	int reg;
+
+	switch (amd_spi->version) {
+	case AMD_SPI_V1:
+		reg = AMD_SPI_CTRL0_REG;
+		break;
+	case AMD_SPI_V2:
+		reg = AMD_SPI_STATUS_REG;
+		break;
+	default:
+		return -ENODEV;
+	}
 
-	return readl_poll_timeout(amd_spi->io_remap_addr + AMD_SPI_CTRL0_REG,
-				  val, !(val & AMD_SPI_BUSY), 20, 2000000);
+	return readl_poll_timeout(amd_spi->io_remap_addr + reg, val,
+				  !(val & AMD_SPI_BUSY), 20, 2000000);
 }
 
 static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
@@ -117,10 +154,20 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
 	if (ret)
 		return ret;
 
-	/* Set ExecuteOpCode bit in the CTRL0 register */
-	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
-
-	return 0;
+	switch (amd_spi->version) {
+	case AMD_SPI_V1:
+		/* Set ExecuteOpCode bit in the CTRL0 register */
+		amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
+				       AMD_SPI_EXEC_CMD);
+		return 0;
+	case AMD_SPI_V2:
+		/* Trigger the command execution */
+		amd_spi_setclear_reg8(amd_spi, AMD_SPI_CMD_TRIGGER_REG,
+				      AMD_SPI_TRIGGER_CMD, AMD_SPI_TRIGGER_CMD);
+		return 0;
+	default:
+		return -ENODEV;
+	}
 }
 
 static int amd_spi_master_setup(struct spi_device *spi)
@@ -190,6 +237,17 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	message->actual_length = tx_len + rx_len + 1;
 	/* complete the transaction */
 	message->status = 0;
+
+	switch (amd_spi->version) {
+	case AMD_SPI_V1:
+		break;
+	case AMD_SPI_V2:
+		amd_spi_clear_chip(amd_spi, message->spi->chip_select);
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	spi_finalize_current_message(master);
 
 	return 0;
@@ -235,6 +293,8 @@ static int amd_spi_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
+	amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
+
 	/* Initialize the spi_master fields */
 	master->bus_num = 0;
 	master->num_chipselect = 4;
@@ -260,7 +320,8 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
-	{ "AMDI0061", 0 },
+	{ "AMDI0061", AMD_SPI_V1 },
+	{ "AMDI0062", AMD_SPI_V2 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
@@ -269,7 +330,7 @@ MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
 static struct platform_driver amd_spi_driver = {
 	.driver = {
 		.name = "amd_spi",
-		.acpi_match_table = ACPI_PTR(spi_acpi_match),
+		.acpi_match_table = spi_acpi_match,
 	},
 	.probe = amd_spi_probe,
 };
-- 
2.35.0

