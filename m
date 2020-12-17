Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F62DDA11
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 21:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgLQUaS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 15:30:18 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8611 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731389AbgLQUaR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:30:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf8d0001>; Thu, 17 Dec 2020 12:29:01 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:56 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:55 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 6/9] spi: tegra210-quad: Add support for hardware dummy cycles transfer
Date:   Thu, 17 Dec 2020 12:28:44 -0800
Message-ID: <1608236927-28701-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236941; bh=jmc7L6L+XTlt/mdhhipcIsZ+/q6GiritSmf7bmM215U=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=V7AFKY98NtHczjdjj2QTpZICckChqpZsbFZmqqZPUylPa67e5KY07kXijX9f+k1ZF
         UbJ+fYZXWjmT8uSwIjEVFgcBCcQmeZ6yN3y2I1sojZagNf/OWit11H7PFedpr0gNqH
         XtotAIF8aWeCDK2o7T02YaGH2vxBTOJG6FbTFty26M5ZcSX+7TP5b5QiabOOMin/M/
         2d72OxjH0QpS4gF4qHJVxixiSuKVtlBhMSUtsrEdhWF0dLNq0tDIqeiOdIC6vMagg3
         LkEvtXparipybt/9ONNh8Z8irFhkMYX+sFAYCym0J/CxSkc73IVSyM8fojI92knkdo
         foPAly5lSd72Q==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra Quad SPI controller hardware supports sending dummy bytes based
on programmed dummy clock cycles after the actual transfer bytes.

This patch adds this support of hardware dummy bytes transfer and
skips transfer of dummy bytes from the software.

For dummy cycles more than Tegra Quad SPI hardware maximum dummy
cycles limit, driver transfers dummy bytes from the software.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index e7bee8d..695a296 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -117,6 +117,7 @@
 
 #define QSPI_MISC_REG                           0x194
 #define QSPI_NUM_DUMMY_CYCLE(x)			(((x) & 0xff) << 0)
+#define QSPI_DUMMY_CYCLES_MAX			0xff
 
 #define DATA_DIR_TX				BIT(0)
 #define DATA_DIR_RX				BIT(1)
@@ -170,6 +171,7 @@ struct tegra_qspi {
 	u32					def_command2_reg;
 	u32					spi_cs_timing1;
 	u32					spi_cs_timing2;
+	u8					dummy_cycles;
 
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
@@ -856,6 +858,8 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 
 	tqspi->command1_reg = command1;
 
+	tegra_qspi_writel(tqspi, QSPI_NUM_DUMMY_CYCLE(tqspi->dummy_cycles), QSPI_MISC_REG);
+
 	ret = tegra_qspi_flush_fifos(tqspi, false);
 	if (ret < 0)
 		return ret;
@@ -974,7 +978,8 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 {
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
-	struct spi_transfer *xfer;
+	struct spi_transfer *xfer, *next_xfer;
+	bool use_hw_dummy_cycles = false;
 	bool is_first_msg = true;
 	int ret;
 
@@ -984,8 +989,42 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	tqspi->rx_status = 0;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		u8 dummy_cycles = 0;
 		u32 cmd1;
 
+		/*
+		 * Skip dummy bytes transfer if they are transferred by the hardware along
+		 * with previous transfer.
+		 */
+		if (xfer->dummy_data && use_hw_dummy_cycles) {
+			msg->actual_length += xfer->len;
+			continue;
+		}
+
+		/*
+		 * Tegra QSPI hardware supports dummy bytes transfer after actual transfer
+		 * bytes based on programmed dummy clock cycles in the QSPI_MISC register.
+		 * So, check if the next transfer is dummy data transfer and program dummy
+		 * clock cycles along with the current transfer.
+		 */
+		if (!list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			next_xfer = list_next_entry(xfer, transfer_list);
+			if (next_xfer && next_xfer->dummy_data) {
+				dummy_cycles = next_xfer->len * 8 / next_xfer->tx_nbits;
+				use_hw_dummy_cycles = true;
+				/*
+				 * Use software dummy bytes transfer if dummy cycles exceeds
+				 * Tegra QSPI hardware maximum dummy cycles limit.
+				 */
+				if (dummy_cycles > QSPI_DUMMY_CYCLES_MAX) {
+					use_hw_dummy_cycles = false;
+					dummy_cycles = 0;
+				}
+			}
+		}
+
+		tqspi->dummy_cycles = dummy_cycles;
+
 		reinit_completion(&tqspi->xfer_completion);
 
 		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);
-- 
2.7.4

