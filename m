Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BA1C1B0
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 07:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfENFEC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 01:04:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14755 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfENFEB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 01:04:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda4c470000>; Mon, 13 May 2019 22:04:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 22:04:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 22:04:00 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:03:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 May 2019 05:03:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.159]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cda4c3e0001>; Mon, 13 May 2019 22:03:59 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date:   Mon, 13 May 2019 22:03:52 -0700
Message-ID: <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557810247; bh=K7F2P173EQjrqPomTsKC7kMVoDELsjl//sPm6PDIsWw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KPAMBYMrVCV4W0Y7ydQV9hhGtLCVihf7OqaRI0TiZV2fz2+E3Ac+j08POHdUCI/pB
         ZOTVVL9gJ3QxxWLM4394yAmZC4xDc33RwbapyxR54GMEklGa7jcVWar2D/PJbhgD/W
         YEmhV+0Wr2VEZcNmuAvwQDPjvxqAIHgfXB2HrvV1qVnP4aZyfcjSKQ/76p5oJ2LPeW
         ip8dxJD8U9dduHCxc6rkdGq8LntHuT35d263N7DRKCtDJgUxFt7ihr5X4Rfm5nRplu
         g8qFhSJ65Pef1/FQzULs3mjWW7oAt5najv9hOfT7ZdRiV/BbdvgboO9mnLCOfeW9x3
         nH6RmOCxtcKIQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds support for GPIO based CS control through SPI core
function spi_set_cs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b1f31bb16659..f47417dd9edb 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -776,6 +776,10 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		} else
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
+		/* GPIO based chip select control */
+		if (spi->cs_gpiod)
+			gpiod_set_value(spi->cs_gpiod, 1);
+
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= SPI_CS_SW_VAL;
@@ -864,6 +868,10 @@ static int tegra_spi_setup(struct spi_device *spi)
 	}
 
 	spin_lock_irqsave(&tspi->lock, flags);
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi->chip_select);
@@ -893,6 +901,10 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
+	/* GPIO based chip select control */
+	if (spi->cs_gpiod)
+		gpiod_set_value(spi->cs_gpiod, 0);
+
 	if (cs_val)
 		tspi->command1_reg |= SPI_CS_SW_VAL;
 	else
@@ -1199,6 +1211,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
+	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-- 
2.7.4

