Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40844259973
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgIAQj6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 12:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgIAP2b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Sep 2020 11:28:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A72020BED;
        Tue,  1 Sep 2020 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974108;
        bh=t6xL7+nzs+mrnXa/pS4dInGiF2OBxrYskhX5bGXiGFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnoPmKNKd28LlKy9QcwtnZ1wTrOYtz9newemzZarooh81jBwMIyRhJTmPaNMR8oGQ
         4Go50IxD1/QkxcX3PT4keyZdUiI8B6Zyi/1MBBPNmewdGrNtW/XBTcM1OC7J2R1kDu
         PCEU13qOJ6L6443LtBlXMTT0CPmw/7Xc6eUSnpis=
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
Subject: [PATCH 09/11] spi: synquacer: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:27:11 +0200
Message-Id: <20200901152713.18629-9-krzk@kernel.org>
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
 drivers/spi/spi-synquacer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index ae17c99cce03..42e82dbe3d41 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -640,9 +640,8 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 		}
 
 		if (IS_ERR(sspi->clk)) {
-			if (!(PTR_ERR(sspi->clk) == -EPROBE_DEFER))
-				dev_err(&pdev->dev, "clock not found\n");
-			ret = PTR_ERR(sspi->clk);
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(sspi->clk),
+					    "clock not found\n");
 			goto put_spi;
 		}
 
-- 
2.17.1

