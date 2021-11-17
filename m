Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B513454740
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhKQNe0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 08:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237596AbhKQNeZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 08:34:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B0061B1E;
        Wed, 17 Nov 2021 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637155887;
        bh=pTV4LcjmVPnAyqU7zEzrz73e0jNTWFPJ2DUCAvoW0BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSO834autQlUdOukJw2HuAJQC/irBqU/V8BpNazOOKqz0YbeV0fdHfUjoZ9fZw9dW
         402NVJly+e/bcwnJo10prMtWsOiUBYm7DsCJSJWXDp63EtFxLVdmtluL5jYfj0gZep
         lVSZZPgbN1iMnH5bk9261fcTtGdew8Z0/q/jkJht/K2glLZVcIr9cFx3Kyz3coY+my
         lpjVTf17jR9trPInXk66h/oYkg3AyGosHwsvhefTvP/Bdi38I0izwW1eqrLUoWED0b
         a9WNW4git2jYRwdLZsk23ESLnV7yeeczReQ5eTQOAMwOIRcmuDivog68mpz9Ghx+6B
         TdMBlG4NIrxXg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: qcom: geni: handle timeout for gpi mode
Date:   Wed, 17 Nov 2021 19:01:10 +0530
Message-Id: <20211117133110.2682631-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117133110.2682631-1-vkoul@kernel.org>
References: <20211117133110.2682631-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We missed adding handle_err for gpi mode, so add a new function
spi_geni_handle_err() which would call handle_fifo_timeout() or newly
added handle_gpi_timeout() based on mode

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b9769de1f5f0..5b6e9a6643d8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -164,6 +164,30 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	}
 }
 
+static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	dmaengine_terminate_sync(mas->tx);
+	dmaengine_terminate_sync(mas->rx);
+}
+
+static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	switch (mas->cur_xfer_mode) {
+	case GENI_SE_FIFO:
+		handle_fifo_timeout(spi, msg);
+		break;
+	case GENI_GPI_DMA:
+		handle_gpi_timeout(spi, msg);
+		break;
+	default:
+		dev_err(mas->dev, "Abort on Mode:%d not supported", mas->cur_xfer_mode);
+	}
+}
+
 static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
 {
 	struct geni_se *se = &mas->se;
@@ -921,7 +945,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->can_dma = geni_can_dma;
 	spi->dma_map_dev = dev->parent;
 	spi->auto_runtime_pm = true;
-	spi->handle_err = handle_fifo_timeout;
+	spi->handle_err = spi_geni_handle_err;
 	spi->use_gpio_descriptors = true;
 
 	init_completion(&mas->cs_done);
-- 
2.31.1

