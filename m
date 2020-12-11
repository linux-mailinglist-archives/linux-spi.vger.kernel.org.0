Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631882D8105
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbgLKVSU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:18:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8593 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392760AbgLKVQ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:16:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e19e0001>; Fri, 11 Dec 2020 13:16:14 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:11 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:10 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 6/9] spi: tegra210-quad: Add support for hardware dummy cycles
Date:   Fri, 11 Dec 2020 13:16:00 -0800
Message-ID: <1607721363-8879-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721374; bh=UDrsTDiQs8eElO67iIY2kdbQNgxNBN6S/8FNEm5eF/U=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=LW79nXYWW3JoD1csdmjurlXEOJnQHkrqI7khTW134Fj9zNlOtLtZJv+NiOYQNkFE1
         GCFfXMtXsDL7AiSw7i+CJ5t5slh8pnvcZ3G+RGg3gzYuRtrc1nxru4p+KS9QXmpcPV
         QqfIcehNwDHpzBZ4X8EKjARCRogAXiN2i/uPQZv1DMnljtc0A53z9ojM+qSht4WIca
         46PFh+jJCV/7iinOSFCKjUXthXr7gIlQWhzOBdjF0OgD53rYogEIshjYR/yw7PVgYy
         ZKAnXCcYIikdJMxljiO435kzatI1NfIYIwu1LeMs8Z0f3L3sOUTC9G1SwRDZBOkURe
         cyAbtbd3yGJWA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra Quad SPI controller hardware supports sending dummy cycles
after address bytes.

This patch adds this support.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 624f395..1d1b125 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -124,6 +124,13 @@
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
 
+enum transfer_phase {
+	CMD_BYTE_XFER = 0,
+	ADDR_BYTES_XFER,
+	DATA_BYTES_XFER,
+	MAX_XFERS,
+};
+
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
@@ -857,6 +864,8 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 
 	tqspi->command1_reg = command1;
 
+	tegra_qspi_writel(tqspi, QSPI_NUM_DUMMY_CYCLE(tqspi->dummy_cycles), QSPI_MISC_REG);
+
 	ret = tegra_qspi_flush_fifos(tqspi, false);
 	if (ret < 0)
 		return ret;
@@ -977,7 +986,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_msg = true;
-	int ret;
+	int ret, xfer_phase = 0;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -987,6 +996,15 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
+		/*
+		 * Program dummy clock cycles in Tegra QSPI register only
+		 * during address transfer phase.
+		 */
+		if (xfer_phase == ADDR_BYTES_XFER)
+			tqspi->dummy_cycles = msg->dummy_cycles;
+		else
+			tqspi->dummy_cycles = 0;
+
 		reinit_completion(&tqspi->xfer_completion);
 
 		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);
@@ -1018,6 +1036,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 		}
 
 		msg->actual_length += xfer->len;
+		xfer_phase++;
 
 complete_xfer:
 		if (ret < 0) {
@@ -1203,6 +1222,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->flags = SPI_MASTER_USES_HW_DUMMY_CYCLES;
 	master->setup = tegra_qspi_setup;
 	master->cleanup = tegra_qspi_cleanup;
 	master->transfer_one_message = tegra_qspi_transfer_one_message;
-- 
2.7.4

