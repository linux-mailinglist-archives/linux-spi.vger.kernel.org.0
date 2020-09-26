Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4B279580
	for <lists+linux-spi@lfdr.de>; Sat, 26 Sep 2020 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIZATe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 20:19:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgIZATe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Sep 2020 20:19:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EAEC989080C1AC6D09FC;
        Sat, 26 Sep 2020 08:19:31 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.248) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 26 Sep 2020 08:19:26 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 1/2] spi: spi-tegra20-sflash: remove redundant irqsave and irqrestore in hardIRQ
Date:   Sat, 26 Sep 2020 12:16:15 +1200
Message-ID: <20200926001616.21292-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Running in hardIRQ, disabling IRQ is redundant.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/spi/spi-tegra20-sflash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 02cf5f463ba6..b59015c7c8a8 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -359,9 +359,8 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 {
 	struct spi_transfer *t = tsd->curr_xfer;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tsd->lock, flags);
+	spin_lock(&tsd->lock);
 	if (tsd->tx_status || tsd->rx_status || (tsd->status_reg & SPI_BSY)) {
 		dev_err(tsd->dev,
 			"CpuXfer ERROR bit set 0x%x\n", tsd->status_reg);
@@ -391,7 +390,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 	tegra_sflash_calculate_curr_xfer_param(tsd->cur_spi, tsd, t);
 	tegra_sflash_start_cpu_based_transfer(tsd, t);
 exit:
-	spin_unlock_irqrestore(&tsd->lock, flags);
+	spin_unlock(&tsd->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

