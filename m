Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA562599A3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgIAP2B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 11:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgIAP17 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD7C2100A;
        Tue,  1 Sep 2020 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974078;
        bh=lQCnpE+h3F7ldlhOlP/LmTgLkwRbrAWwyY8D9fia1fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9ezrBcITeM03VLnUcB2yHSUbMGl07t9SG4iL8L9fX6fmWiJrm1m6eDlk21/simjC
         0r3hzUvihtAn8zL1j8ci9rCw7Wu/SLrupJCv41/pUe0YYviRov8xg1VHyDzvQ1J2Ug
         amglPELe1Gp4Zcjic1dsxW/C4IcJs/RIpR3/V0iQ=
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
Subject: [PATCH 05/11] spi: cadence-quadspi: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:07 +0200
Message-Id: <20200901152713.18629-5-krzk@kernel.org>
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
 drivers/spi/spi-cadence-quadspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 508b219eabf8..cec4e89ab9b2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1117,11 +1117,8 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
 	if (IS_ERR(cqspi->rx_chan)) {
 		int ret = PTR_ERR(cqspi->rx_chan);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
 		cqspi->rx_chan = NULL;
-		return ret;
+		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);
 
-- 
2.17.1

