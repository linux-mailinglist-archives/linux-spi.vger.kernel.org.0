Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8661C16E
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 06:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfENEcB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 00:32:01 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8371 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENEcB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 00:32:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda44bb0000>; Mon, 13 May 2019 21:31:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 21:31:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 May 2019 21:31:59 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 04:31:59 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 04:31:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 May 2019 04:31:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.159]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cda44bd0000>; Mon, 13 May 2019 21:31:58 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 2/4] spi: tegra114: add support for hw based cs
Date:   Mon, 13 May 2019 21:31:50 -0700
Message-ID: <1557808312-3213-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557808312-3213-1-git-send-email-skomatineni@nvidia.com>
References: <1557808312-3213-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557808315; bh=k2pwjMQe73pMINbpya/u7vDdSHArgZLiAfPjTQcuzGE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GVQjCh/ZP5YvapW/s7RNGkWxGwmNfEWsRtNsKrgaE9lBvtAnavv6SLM4JS+4qKhvm
         01pevPAjUXp7jia8u9nOMR+DnHECG7RbZF4dBBoEANYe6e0Asva8sHgHE3bvBRqp3U
         b4vLZjCTYDSmxCu92ZngBD/JK+j2qxMtYJ2OFtnnFUHCSBX2U7ltx4p4BqURudOVhT
         NRPfpb/uJUZZMf/HMgYgksos5XBYNiiejc48pG8/LB/PfzRgsj5MHeg+QJUarw0H6y
         gISLForlvD4FLI29svtYJSKAOYvcWm1Kjzclm+emDZ1WOBeJu5kDEtBqlm3ipadFRC
         3SEry/rHpPNeA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra SPI controller supports both HW and SW based CS control
for SPI transfers.

This patch adds support for HW based CS control where CS is driven
to active state during the transfer and is driven inactive at the
end of the transfer directly by the HW.

This patch enables the use of HW based CS only for single transfers
without cs_change request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f47417dd9edb..0cb0932d32fd 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -193,6 +193,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -723,7 +724,9 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+					struct spi_transfer *t,
+					bool is_first_of_msg,
+					bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	u32 speed = t->speed_hz;
@@ -780,11 +783,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		if (is_single_xfer && !(t->cs_change)) {
+			tspi->use_hw_based_cs = true;
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		} else {
+			tspi->use_hw_based_cs = false;
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		}
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
@@ -905,11 +914,14 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	if (spi->cs_gpiod)
 		gpiod_set_value(spi->cs_gpiod, 0);
 
-	if (cs_val)
-		tspi->command1_reg |= SPI_CS_SW_VAL;
-	else
-		tspi->command1_reg &= ~SPI_CS_SW_VAL;
-	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	if (!tspi->use_hw_based_cs) {
+		if (cs_val)
+			tspi->command1_reg |= SPI_CS_SW_VAL;
+		else
+			tspi->command1_reg &= ~SPI_CS_SW_VAL;
+		tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
@@ -936,16 +948,19 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
+	int single_xfer;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.7.4

