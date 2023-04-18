Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69B6E5890
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDRF3c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDRF30 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 01:29:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF985B87
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552e3233b26so35353707b3.9
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795762; x=1684387762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Suw/5ECmRYhQu6IA1gmyYkwu6OL87LNt9wtEORwfKxU=;
        b=Evar251cw7DqRlp2ye27lHI+fpqOTsgpuJ5EmMqcMu6vFnAQvjd8vRQPafVAuV+pUU
         J2gDRGws2FhQtxwmAVgYn/+yz1oYsqfNDJkIvo8HwMnXZb/FI9EHTNAaWP8Z8/rQtuOk
         lfNDeAL1EX8aW9Q2we5U0Xq6YapVOgmzdX+K9NyirqsdwN3Lk6JCcx+XZdS8sFZwOs11
         HVjrLfYUJxIi8RF4yEGYVZtdXt2oOFdFfzSPudGkt0cd/XJeymVQv87HCSQpMfIOlU3q
         DPXh2lQc59Pukf8ZWzFSKjV9pwyTrVRGas2/uFK2oPt1c2M9dAxBiBiTJcOmj4CGViVX
         AVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795762; x=1684387762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Suw/5ECmRYhQu6IA1gmyYkwu6OL87LNt9wtEORwfKxU=;
        b=JEwa09yVrS+wvmUOVevPLIeYu7F5ExCkf02n7sOPJxX/wfKxvZaKq0SbeELWNWTmSP
         3E1aWe7qhLvR2/OaAVGcYc2y33GxKMOPtmIveULXY+Q8URTpIcPwAXKm+4mSdX6Sq3iO
         4TwnVFDSqVyJm+QIJjc3ruTyWqtdi2XADmuohnhJcwPiE20ZmlpV4tAELcVnIrCan/Lb
         ZV4kZlEv/xR2lYJ0cOd46tKCRXOg9+pgxaT3Qbj5F1keh6Z/TgWdun6gIZEflws2JGT4
         yWVcG3R2Wu7QHwtYYH/CVyD8+oSJzgoixwuvqjGS/L/zTbZm1j/1SKlQ4Q2yyRik5OQO
         yCrQ==
X-Gm-Message-State: AAQBX9dfqc2iOnp09g9sNXSLGD/2bbsaMb9K7wHg7OHf3sxu4PmbCYSm
        frLPHg06BlpwMOXUw3mBORVpDnQqj7pZzA==
X-Google-Smtp-Source: AKy350bH0/6RH6j68nyH9pouJam17JSPS/6e2cVsz2aNQasER4QvJhzUVKi/6oopvSdF9py+yX+KCHNJr48LxA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:4524:0:b0:54f:aa4b:100c with SMTP id
 s36-20020a814524000000b0054faa4b100cmr10637678ywa.8.1681795761848; Mon, 17
 Apr 2023 22:29:21 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:29:00 +0000
In-Reply-To: <20230418052902.1336866-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-4-joychakr@google.com>
Subject: [PATCH v7 3/5] spi: dw: Add DMA directional capability check
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check capabilities of DMA controller during init to make sure it is
capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel.

Current DW DMA driver requires both tx and rx channel to be configured
and functional for any kind of transfers to take effect including
half duplex. Hence, check for both tx and rx direction and fail on
unavailbility of either.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f19c092920a1..22d0727a3789 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -72,12 +72,22 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 }
 
-static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
+static int dw_spi_dma_caps_init(struct dw_spi *dws)
 {
-	struct dma_slave_caps tx = {0}, rx = {0};
+	struct dma_slave_caps tx, rx;
+	int ret;
+
+	ret = dma_get_slave_caps(dws->txchan, &tx);
+	if (ret)
+		return ret;
+
+	ret = dma_get_slave_caps(dws->rxchan, &rx);
+	if (ret)
+		return ret;
 
-	dma_get_slave_caps(dws->txchan, &tx);
-	dma_get_slave_caps(dws->rxchan, &rx);
+	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
+	      rx.directions & BIT(DMA_DEV_TO_MEM)))
+		return -ENXIO;
 
 	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
 		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
@@ -95,6 +105,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
+	int ret = -EBUSY;
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
@@ -124,20 +135,25 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	pci_dev_put(dma_dev);
 
 	return 0;
 
+free_txchan:
+	dma_release_channel(dws->txchan);
+	dws->txchan = NULL;
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
 err_exit:
 	pci_dev_put(dma_dev);
-	return -EBUSY;
+	return ret;
 }
 
 static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
@@ -163,12 +179,17 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	return 0;
 
+free_txchan:
+	dma_release_channel(dws->txchan);
+	dws->txchan = NULL;
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
-- 
2.40.0.634.g4ca3ef3211-goog

