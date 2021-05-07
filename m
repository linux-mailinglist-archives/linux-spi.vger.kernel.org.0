Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7282D3768B8
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhEGQ1n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 12:27:43 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:24106 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbhEGQ1m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 12:27:42 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d33 with ME
        id 1sSf2500j21Fzsu03sSgHa; Fri, 07 May 2021 18:26:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 May 2021 18:26:40 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: tegra210-quad: Fix an error message
Date:   Fri,  7 May 2021 18:26:39 +0200
Message-Id: <b990c1bb5830196142c3d70e3e3c6c0245a7e75f.1620404705.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'ret' is known to be 0 here.
No error code is available, so just remove it from the error message.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2f806f4b2c34..2354ca1e3858 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1028,7 +1028,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tqspi->dev, "transfer timeout: %d\n", ret);
+			dev_err(tqspi->dev, "transfer timeout\n");
 			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
 				dmaengine_terminate_all(tqspi->tx_dma_chan);
 			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
-- 
2.30.2

