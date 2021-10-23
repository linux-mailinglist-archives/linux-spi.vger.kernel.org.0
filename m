Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80C4385DC
	for <lists+linux-spi@lfdr.de>; Sun, 24 Oct 2021 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJWXCl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Oct 2021 19:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJWXCl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Oct 2021 19:02:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DC1C061714;
        Sat, 23 Oct 2021 16:00:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g36so2640847lfv.3;
        Sat, 23 Oct 2021 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWZMWYws+qLbMxadT98BwAMzcAf3eobJXXw6PfAeB+Q=;
        b=hm1iwmgfkAXp0qzrGDCRbvkPGVppB3lOLzpMM9u4fhyS4nZK4Pinx9ax5jKi59oFv5
         cUK3bYL4R/DICDoqjXOr21ER1X3MHrHPCZhn6V1XFSskw72IewXnTqo8D1UELHv8SXrb
         8DqfDvnPgbvBMaNyGA+ZlWWYlbsC9DF4MA8+U6PE1UY6vnzg+we+wO4HEn0c+FvxEBYC
         YCtKKnSHl2BKVARSPX9Elt1ShP6OVvigfguyVCa4s+B0LVt0vK+z+OIMB3cQ7sUR+/XC
         L4HPlKkgibOQ/iII7w5+4jnbqkk+nIfblH8qPG8IggEy+Xr7EGojbhjW44XnGKTeSdk4
         qIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWZMWYws+qLbMxadT98BwAMzcAf3eobJXXw6PfAeB+Q=;
        b=IWDHTs5zUs02JXL4ycWqX4Rxzx1B7CS0plOp8g/GisvbflhIRXCl4V4BheCJGliKx0
         6QPjY6n6x5F/IvIoYDvW8+SH1n9h6fD9IthtK13TOHsu3auKh2RSDqiUm7wNN1B4GBHM
         iI6lCzBWjsyxJthObedFrxQH9f4ldv3QDDqb1OQK7ChgxWICE7K3QqIA+bsOM95MAkGV
         U21DlBf1hOnkn1Fm+mdpOSnheco0fJsUQu63TABSd/0VsNO9C4gS/pQxav4bVrTVuK9N
         3EVGZNEe8Ld+PyJ+WROkpnr2fEw8c8gQtvq42SLCsdv2t0I267QFWkVEGM3/15XvlpID
         Hs8w==
X-Gm-Message-State: AOAM530sLxccSGQ1jHfbEaspEQn7ad6bxHM32l4VbptAcEAY0AwWDpez
        OH2+sWoA0y6qK0DRn1GzB1Nu8Uq3xOU=
X-Google-Smtp-Source: ABdhPJxKcL2gKjlAMa8Jnf8V/mtADt7cZAksbicD8f17xDM6gGOHfXxntEcy21aeesgAhdxb3H2L3w==
X-Received: by 2002:a05:6512:907:: with SMTP id e7mr8360674lft.671.1635030019245;
        Sat, 23 Oct 2021 16:00:19 -0700 (PDT)
Received: from localhost.localdomain (46-138-31-183.dynamic.spd-mgts.ru. [46.138.31.183])
        by smtp.gmail.com with ESMTPSA id z3sm1161020lfh.17.2021.10.23.16.00.18
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
Subject: [PATCH v1 1/2] spi: tegra20-slink: Put device into suspend on driver removal
Date:   Sun, 24 Oct 2021 01:59:50 +0300
Message-Id: <20211023225951.14253-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
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
 drivers/spi/spi-tegra20-slink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 33302f6b42d7..e6b16131edc2 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1124,7 +1124,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 exit_pm_put:
 	pm_runtime_put(&pdev->dev);
 exit_pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	tegra_slink_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
@@ -1143,7 +1143,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 
 	free_irq(tspi->irq, tspi);
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
-- 
2.32.0

