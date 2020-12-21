Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC42E01E1
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLUVSa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:18:30 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4547 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgLUVSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:18:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe110fd0008>; Mon, 21 Dec 2020 13:17:49 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:44 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:44 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 6/9] spi: tegra210-quad: Add support for hardware dummy cycles transfer
Date:   Mon, 21 Dec 2020 13:17:36 -0800
Message-ID: <1608585459-17250-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585469; bh=5xQLb2sWtAGzefv1tnfhjT/+4lUyvepFNtfHqTrm+TM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=PaMGgqMo5vrg9HiXuxRB5aS6XWWZVBZjL4Gln4c/2h8mSEFmIV1QGuCQTbiYGYo/4
         55OMIF5cDomyoZPpdFB0wRAWHt4D6Zeff732cLlmxmJyZ00EqTAAtvmjwcWu/k0qrP
         J8VY7bAvc5ofnvFvWWHOxhT9q6b4ffqjafY2JO2mJhH3mPDf601rhOhdb3Z5lDp1k4
         wQzkJhMlq1PtfBrg6d5Mj7yk/dQozEIjxDiUSFcb2E/GLwrc66ygCrCZWBxEu3RpNj
         MsMPinN8r1tFSJ+e4oul6vpNL7ZSucyLNhlgbj/dXHBiYcf733zXG9iwMLxVYy+nm+
         QJ1IDLHtCEQEg==
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
 drivers/spi/spi-tegra210-quad.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index e7bee8d..2f806f4 100644
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
@@ -974,7 +978,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 {
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
-	struct spi_transfer *xfer;
+	struct spi_transfer *transfer;
 	bool is_first_msg = true;
 	int ret;
 
@@ -983,9 +987,33 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	tqspi->tx_status = 0;
 	tqspi->rx_status = 0;
 
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+		struct spi_transfer *xfer = transfer;
+		u8 dummy_bytes = 0;
 		u32 cmd1;
 
+		tqspi->dummy_cycles = 0;
+		/*
+		 * Tegra QSPI hardware supports dummy bytes transfer after actual transfer
+		 * bytes based on programmed dummy clock cycles in the QSPI_MISC register.
+		 * So, check if the next transfer is dummy data transfer and program dummy
+		 * clock cycles along with the current transfer and skip next transfer.
+		 */
+		if (!list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			struct spi_transfer *next_xfer;
+
+			next_xfer = list_next_entry(xfer, transfer_list);
+			if (next_xfer->dummy_data) {
+				u32 dummy_cycles = next_xfer->len * 8 / next_xfer->tx_nbits;
+
+				if (dummy_cycles <= QSPI_DUMMY_CYCLES_MAX) {
+					tqspi->dummy_cycles = dummy_cycles;
+					dummy_bytes = next_xfer->len;
+					transfer = next_xfer;
+				}
+			}
+		}
+
 		reinit_completion(&tqspi->xfer_completion);
 
 		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);
@@ -1016,7 +1044,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 			goto complete_xfer;
 		}
 
-		msg->actual_length += xfer->len;
+		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
 		if (ret < 0) {
-- 
2.7.4

