Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C54385DF
	for <lists+linux-spi@lfdr.de>; Sun, 24 Oct 2021 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJWXCm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Oct 2021 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhJWXCl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Oct 2021 19:02:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477EC061764;
        Sat, 23 Oct 2021 16:00:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p16so3239179lfa.2;
        Sat, 23 Oct 2021 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AS3izAk+IrTfrd3lFD8lmDpmJ4k7Veg8MZT+Nsu6qBo=;
        b=gTpxRIsusbPTuHYzph7krRdBv2pUDW+ps6sSb2DS2eoYF2oEIJh41vK6AnU8qJvjuk
         1EzPGJIGKJrUb+dEvf7A/5vMSD1VCHKmz1ruNqV6Mf1312goKmA6RDZnIaJNuIbLAlVU
         hDQhf5QfZysXKYFRaxCH4iol3Hyk7Z2XSI5LFkwlU+VBE0rl42Xw0NSHULgawzL7DAxZ
         dkv3AowDLfTjABLGbZIsd5tepbCzodrT6RPSRGYqvPF8EZHNPepZ8eLW6SAWI8zgVg+D
         nDiUoJ7JjU5DdGmedBgjM/ca1HL469PIXsLYUVlFu9Na48UD2p/IiO/JXPFaJNTn7oSw
         EumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AS3izAk+IrTfrd3lFD8lmDpmJ4k7Veg8MZT+Nsu6qBo=;
        b=T5qii8UqqOnLh0tyeKiLb4fuGy2yDZyJYZFXy55vxFyuR6Y6E3YnNsdx2ABFHsL5tC
         tl0abtnu0yi0hE2/B+JhYlWJ9EKCt1AL3FIyOGaADQ8z1nOOSzPhJaR8P/RLHCZNpD5U
         7E1kd9sxnGaMShHQ3T7UErvLLoOtc7+16sQXbDrtZkxsnHpA0R3YeB8WB7OSUa8lAlIJ
         0hvzcQicOlf2KiRVP4l5lC4V6CUn7wv/6MndyZNRLNxVwUDGnwqTB57HJX9Aq63+eD3I
         HGzKp9y4nchh4JfJSSj67o1tD/9yi6WOzpmtatzDah49lLh21goI/+XcGsDe0ht0Qh2U
         fLqQ==
X-Gm-Message-State: AOAM533VoRZ5dy1sY03jOLqj5uloOSEj4S5eo7ep8c89rCDKZo1remrQ
        P+/ZE1Q4XVKumzpY/7ZeXEp0wg1gXM0=
X-Google-Smtp-Source: ABdhPJy/+lW4zTys4icBOp1LUKlLx+Kc/KK5ULoO3OeOwS+77vGnO3+7l5B+CG1MLb1bXgeCDZP31w==
X-Received: by 2002:ac2:4a9e:: with SMTP id l30mr544773lfp.131.1635030019863;
        Sat, 23 Oct 2021 16:00:19 -0700 (PDT)
Received: from localhost.localdomain (46-138-31-183.dynamic.spd-mgts.ru. [46.138.31.183])
        by smtp.gmail.com with ESMTPSA id z3sm1161020lfh.17.2021.10.23.16.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 16:00:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/2] spi: tegra210-quad: Put device into suspend on driver removal
Date:   Sun, 24 Oct 2021 01:59:51 +0300
Message-Id: <20211023225951.14253-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211023225951.14253-1-digetx@gmail.com>
References: <20211023225951.14253-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_disable() cancels all pending power requests, while they
should be completed for the Tegra SPI driver. Otherwise SPI clock won't
be disabled ever again because clk refcount will become unbalanced.
Enforce runtime PM suspension to put device into expected state before
driver is unbound and device's RPM state is reset by driver's core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra210-quad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2354ca1e3858..c0f9a75b44b5 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1318,7 +1318,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 exit_free_irq:
 	free_irq(qspi_irq, tqspi);
 exit_pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 	return ret;
 }
@@ -1330,7 +1330,7 @@ static int tegra_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 	free_irq(tqspi->irq, tqspi);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 
 	return 0;
-- 
2.32.0

