Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551542593A0
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgIAP2W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 11:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbgIAP2V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:21 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B17B20684;
        Tue,  1 Sep 2020 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974100;
        bh=ZWHMnQM/CURbA1JIRAEZIvphDU5D8wae4PWN5Vo15i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSGtfZeZCm3TiMylfkCI5P8pCwDKJys94RBEilJ2Sih8/T9FzFNb6CP+fOzBgYWO7
         5P6A9z0uDBLqmNUh0iBzomdRI7o7WhsTuXSz9O2Ld9mB9RTBh3yZU3wq9cQ03ouo9i
         M2bAn5PBFZm4gbj8jQc+xWxqa/6K9c/qXY6AuULU=
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
Subject: [PATCH 08/11] spi: stm32: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:10 +0200
Message-Id: <20200901152713.18629-8-krzk@kernel.org>
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
 drivers/spi/spi-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index d4b33b358a31..f0e594b2fee4 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1857,9 +1857,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
-		ret = spi->irq;
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
+		ret = dev_err_probe(&pdev->dev, spi->irq, "failed to get irq\n");
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
-- 
2.17.1

