Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F225995F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgIAQjE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 12:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbgIAP2m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB7D214D8;
        Tue,  1 Sep 2020 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974117;
        bh=NaQTcz4Nx7tejgYOZkje1gbrDOO+iWUUqbxrXjzVwak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysl+WcfJY4JrmGMlfKduw86YoqyKEsHDVyFgGTtIScPzzBT8pfyFC3CEd0TkFQwCU
         SLGsGIXMQSRI4a7MxNOyzQRog+SMTTGwNq3wLLPq18fHesHTWrj0k5lKNQ4reIlUCZ
         cn1+8VuKHP+mw5xjf3WYuTg45e33rJenTaZhTKR8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 10/11] spi: tegra114: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:12 +0200
Message-Id: <20200901152713.18629-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901152713.18629-1-krzk@kernel.org>
References: <20200901152713.18629-1-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-tegra114.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index c2c58871a947..ca6886aaa519 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -664,16 +664,11 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	struct dma_chan *dma_chan;
 	u32 *dma_buf;
 	dma_addr_t dma_phys;
-	int ret;
 
 	dma_chan = dma_request_chan(tspi->dev, dma_to_memory ? "rx" : "tx");
-	if (IS_ERR(dma_chan)) {
-		ret = PTR_ERR(dma_chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(tspi->dev,
-				"Dma channel is not available: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dma_chan))
+		return dev_err_probe(tspi->dev, PTR_ERR(dma_chan),
+				     "Dma channel is not available\n");
 
 	dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
 				&dma_phys, GFP_KERNEL);
-- 
2.17.1

