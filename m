Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3302929F7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgJSPDu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgJSPDu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 11:03:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EEC0613CE;
        Mon, 19 Oct 2020 08:03:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c141so14595265lfg.5;
        Mon, 19 Oct 2020 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fPH7CQ4G9R2lqYFhSa3lSQ7unVSPvrV283E5Rfz2G+c=;
        b=NwHarqhTQAshl//hLm4teAywrDUZ/D+WdI/zrBmozgDJPKZQTriM/AFtTPraeDP1UD
         zp5mb7XClNpnGsOvXoA1z6mQkCr5l1LrxC4zdolqpy4TRMopmflRH0DjPIFlNno3bZ6T
         syvNUFF3/YTkIbXTtbjNesUQ0hrYa9eT782eCjwre/Hd8u8vsTBpk9EYo44QxFWtuxZf
         Lbxz19zFoVhamdlq37H7bEFIbtr9vX3k3eDA/K6NKXj1Ya4uBUEGiZOjfFBe/jX6bafP
         O3U+hcTP7owCDU5UyEXA2c9fAkMoco68b/1kAsZ/u0UPYgvasvVngKzWBzvrp7gJb80g
         0Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fPH7CQ4G9R2lqYFhSa3lSQ7unVSPvrV283E5Rfz2G+c=;
        b=BYX+q4UyBOy9MAttySUQA/Y09fNHwBHmvXSbnjDCKVGDKIQe+ByU0AfogsxsuFD19S
         MXwTyAUXrkTfd0Mzbad3vYABybib6jwL+3q5h3ZrnFU/tXG26AXcj1PsZrfZmB33VDVp
         62usyzMrxPSywG1gQlqjBLjGhJXnkksnJYhjenlljk+KLq+ol78x3d6M1EmDSB10IqbJ
         C3bAchE+K7eVoMQ/G4mhti8njB6kac1qGf5eu2BOASWZLDr4hxz4rGZ+1wF77L0zUTQc
         7EXocf0xW7EokrJT/jI5+6ykq2s063E9uILYIaaooLE9TzzqyHn0VBm78+Sx42+eoKad
         VRZA==
X-Gm-Message-State: AOAM533U8jc66TxgZcvE+Gq+uiODny0gSxPY3J07ixQccIVFOJaahGvY
        9tsOWKRFaqW5+2oNRrVU9q4=
X-Google-Smtp-Source: ABdhPJzrrhrlwnzF8epGNUQ+/Zp3xt3luXBSviL5vDbuFR3e+LzxXD3Yh8X1TF4ljD75bY2oyiSGBw==
X-Received: by 2002:a19:c68a:: with SMTP id w132mr42433lff.106.1603119828142;
        Mon, 19 Oct 2020 08:03:48 -0700 (PDT)
Received: from ubuntu-18.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id l9sm13343ljc.86.2020.10.19.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:03:47 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
X-Google-Original-From: Alexander Kochetkov <akochetkov@lintech.ru>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH v2] spi: spi-sun6i: enable autosuspend feature
Date:   Mon, 19 Oct 2020 18:03:43 +0300
Message-Id: <20201019150343.2520-1-akochetkov@lintech.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Alexander Kochetkov <al.kochet@gmail.com>

If SPI is used for periodic polling any sensor, significant delays
sometimes appear. Switching on module clocks during resume lead to delays.
Enabling autosuspend mode causes the controller to not suspend between
SPI transfers and the delays disappear.

The commit also remove unnecessary call to pm_runtime_idle() used
to explicit put device to suspended state. Without pm_runtime_idle() PM
core will put device in the suspended state just after probe() returns.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---

Changes in v2:
- Extend commit description with explanation about removal
  of pm_runtime_idle()


 drivers/spi/spi-sun6i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 29ea1e87ce7e..86f29c3e335a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -22,6 +22,8 @@
 
 #include <linux/spi/spi.h>
 
+#define SUN6I_AUTOSUSPEND_TIMEOUT	2000
+
 #define SUN6I_FIFO_DEPTH		128
 #define SUN8I_FIFO_DEPTH		64
 
@@ -652,9 +654,10 @@ static int sun6i_spi_probe(struct platform_device *pdev)
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

