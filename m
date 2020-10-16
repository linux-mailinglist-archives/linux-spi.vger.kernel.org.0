Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2920A290007
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394655AbgJPIic (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394641AbgJPIib (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Oct 2020 04:38:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDEC061755;
        Fri, 16 Oct 2020 01:38:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so1843334lfp.11;
        Fri, 16 Oct 2020 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JrC55YtJFDYrn45XFti7KxwVjhoqHpQqb1ddz4w9X2c=;
        b=uLaZ/4iIbz9TSCM0OsbC9qOnEu/FIeHIxcA/0VyIAmh1A8stvCaio02HjswXMttKCk
         6R3C8v/0Std5ifBed6KicTrUO8aMvRCNdTH/ioOGSYCkMv5m46xE32AimkKY+w4Ost9c
         eCuCKOx+kkOSnJorNlMvxTsrDC0J8ACvEgvVh1DKjKrDM6IAeWVbvUvRefR1HzFQuOua
         jE6V8hmKcsS8iYUdxtJj++JhI5Qubr42H/9OHQcCJMZsA+P1P3HbsQup1mHffLgKpWnb
         pCnOmkn65Uf4t4TbK9h1S6vyvPPv2/rBy21+Ql0fUD6NlK0p53nEubrbb30qAKjM6ehH
         ACCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JrC55YtJFDYrn45XFti7KxwVjhoqHpQqb1ddz4w9X2c=;
        b=Eg1M/tmo5zeAKo/uTQD4Fddfk8qe9K3FCFIznoV5MXWTtdR76lwe28LOpqHBFqNrOr
         TvThwkOYnoU1GTYxv8og339BuDA5lDmvjqDbdLajZOI3CMmrWd0Li42JCn7WDI/p5Iu2
         /Vroq1HinCm9xXrKYBqhonvEHBAL3L8tAQOCz9pW9cKFLOz5eK3GloCdc42zkd4LyYhT
         01RI6YdRXCTq3cmzmP0Rj6oyRgHCO0tINRU5ADHxzKuAkvxxR50YCWKcoiXqUeqspgQ6
         T5H20miAitn2Bn+gQYAEsct/OT3PSzGHaiwb+a748nFU/8HXWQClIXlGo1eNsOCy/UNx
         teMA==
X-Gm-Message-State: AOAM530xJEL8MwtoFNMFvHclFZky859zwOYnwCCREHipXLyWQRhTwdtz
        TrT90WFLl/dE01ztpjbBQu4=
X-Google-Smtp-Source: ABdhPJynBDxy+HU3G1YknTMgr9tBL5cUt/WLrT5Cw+x6v0+HB4D5CqTr4OYdueFfjZSmLQTjPMdYOA==
X-Received: by 2002:a19:8654:: with SMTP id i81mr1016041lfd.250.1602837510050;
        Fri, 16 Oct 2020 01:38:30 -0700 (PDT)
Received: from ubuntu-18.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id q25sm596257lfa.234.2020.10.16.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:38:29 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] spi: spi-sun6i: enable autosuspend feature
Date:   Fri, 16 Oct 2020 11:38:26 +0300
Message-Id: <20201016083826.31427-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If SPI is used for periodic polling any sensor, significant delays
sometimes appear. Switching on module clocks during resume lead to delays.
Enabling autosuspend mode causes the controller to not suspend between
SPI transfers and the delays disappear.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/spi/spi-sun6i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 38e5b8af7da6..4cc0280e934c 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -22,6 +22,8 @@
 
 #include <linux/spi/spi.h>
 
+#define SUN6I_AUTOSUSPEND_TIMEOUT	2000
+
 #define SUN6I_FIFO_DEPTH		128
 #define SUN8I_FIFO_DEPTH		64
 
@@ -639,9 +641,10 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_dma_rx;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SUN6I_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_idle(&pdev->dev);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
-- 
2.17.1

