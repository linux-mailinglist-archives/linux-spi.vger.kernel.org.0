Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED95F3C5FC2
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhGLPxa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhGLPx3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Jul 2021 11:53:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB45C0613DD
        for <linux-spi@vger.kernel.org>; Mon, 12 Jul 2021 08:50:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a14so9426738pls.4
        for <linux-spi@vger.kernel.org>; Mon, 12 Jul 2021 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XITR/kwZy//PlpcIAsFK/jAVgSCAdwr/J1KWtmSxoRU=;
        b=NmIpqyWgbVpP8SrdaAQTFC7pf8nGBDa5ujmPMZwL+IEvLMUQO1XdnMqnvc4rZQ4WIc
         8bcGM0vtpHFoMVNbpewcP2u55iRVmD5fLe41pbi9xLXa/Wa+UrtLyt7u81QuFJm+t3IQ
         fpLm7+zrNSlwsTi1+lUxSuSDNuvfNM+VJMFz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XITR/kwZy//PlpcIAsFK/jAVgSCAdwr/J1KWtmSxoRU=;
        b=U4+Z7dIUEp36Di/VNXwiElw2QqpOxcrDZxfDQntxhaAWZ1qPFKcFsPK7QdZOSiNMh5
         3WSd5j+QmFIfOpWxfrQSiz39ElzcQGtrycU/C0J+AbR3PGZtyVYCRBYzwQf7BrGTmyZo
         aV7eS7NPVE8PlUARqsH3uv4ZNAEYAakKf74gID6RdU3cmk/mp1kG9D9OIUv/+eErmd5y
         QS/L8rXqkU7t8kvZYCjW3kewEyF85jULcWnldbkM09P1NWxnQLQoKO3awLejwjI041LR
         ozKA+qjZz1NtsG5gHaPFAFuVzNFU+8b9lt+6y9aTJdlgpAQ/36hIECHiT5D5Z27FzNXj
         9ajg==
X-Gm-Message-State: AOAM5313D2IzXeTMF8bSux/Toj0z6+qvxEXW+ITxM0SsGIgQsfS7X5wk
        xMxHd5x9Psf8I2pSajAE2PKhKA==
X-Google-Smtp-Source: ABdhPJwqh/PO/r75ZVxPjCtHmUaaMELknvcWs207dTZChUH9u3XbcJZFzJ1thLq5Qqg7tTzacp+TNw==
X-Received: by 2002:a17:902:a9c7:b029:12b:349:b318 with SMTP id b7-20020a170902a9c7b029012b0349b318mr7287990plr.13.1626105039398;
        Mon, 12 Jul 2021 08:50:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:da04:fb7:6001:b6d1])
        by smtp.gmail.com with ESMTPSA id n33sm17772436pgm.55.2021.07.12.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:50:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     akashast@codeaurora.org, vkoul@kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Remove confusing comment about setting the watermark
Date:   Mon, 12 Jul 2021 08:50:17 -0700
Message-Id: <20210712085010.1.Ie3bb9f9d30d6475bb75251d32635194c1c72b9ee@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The comment in setup_fifo_xfer() about setting the watermark wasn't
quite proper grammar and also stopped making sense around commit
6d66507d9b55 ("spi: spi-geni-qcom: Don't wait to start 1st transfer if
transmitting"). After that commit we actually start the transfer
_before_ the watermark interrupt comes.

I don't think the comment really has any value anymore. We've already
got a comment when we grab the spinlock saying that our interrupt can
come any time as a result of the things in the locked section. Let's
just remove it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b3861fb88711..2f51421e2a71 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -549,12 +549,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 */
 	spin_lock_irq(&mas->lock);
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
-
-	/*
-	 * TX_WATERMARK_REG should be set after SPI configuration and
-	 * setting up GENI SE engine, as driver starts data transfer
-	 * for the watermark interrupt.
-	 */
 	if (m_cmd & SPI_TX_ONLY) {
 		if (geni_spi_handle_tx(mas))
 			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
-- 
2.32.0.93.g670b81a890-goog

