Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5931520D0
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 20:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBDTML (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 14:12:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36427 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDTMK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 14:12:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so10137654pgc.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 11:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKvmDVxy4kPptOpluOnd5nqz5ne1kgTAiZGcRHMD2xY=;
        b=QmGatZo5AQKdw6iZM42/iQS0txhM5VJ5AYIV8UJ5EbGC9dvfkvXbhi2eVzuLMgzpBs
         CiSfriVsIon2gXxo7M5jGGR4OGCNVjD1GXQblCO/j75M/Y+Ws4N2IgsgHI5YnmMSdMUh
         djgCMpR1gGqYHdAJmsn443KVZ5seHJAqNeIGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKvmDVxy4kPptOpluOnd5nqz5ne1kgTAiZGcRHMD2xY=;
        b=fMlLidTE9BNzwERHOFckQ/hPrA1Ft0qNsUumGmtlG6PMOhfkWmIcUhKt2rk8TtEzHE
         66UhIJUtcVGhQBhmK8GlQH25h/vvpAXKJD2ovM2FGe+PMbz0175LrMpcmmYukYgX3dEy
         uRlNCI+sA8hOJhUaoIgG+SIXLdY3muhPnQfgxOwrRvogU8rQsUhFaa3Ksg2xzgOj9eQq
         cV0drepyQDZjAWZ8FJNm3DB144TjcR/FT9oMkSGVURchFQNsu/MnDUY7HWgXMTQ8BFWl
         p0grpjR/IEgk+WNfjrn1FghNzOiU7rYjgXjF6Bjxp+1LBAdScb2BcL7QlyTP7nXQG/tl
         KX5A==
X-Gm-Message-State: APjAAAULzp4CQyW/KoLPwg1Sv6AMGCkKZ8QXW5ZCPfIFSbhPDwUPKlyu
        6+jAj6LI7+ftUVoiVxKLBdRUYw==
X-Google-Smtp-Source: APXvYqz5B0ISUvpmRlOc0CrD+73NFBAB7FlJ/G8hV7kP45lvHFY/1iFcUNwsOP96zSI3zH6JLNf3oA==
X-Received: by 2002:aa7:8f3d:: with SMTP id y29mr33560076pfr.183.1580843529848;
        Tue, 04 Feb 2020 11:12:09 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm26303229pfc.144.2020.02.04.11.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:12:09 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] spi: spi-geni-qcom: Grow a dev pointer to simplify code
Date:   Tue,  4 Feb 2020 11:12:05 -0800
Message-Id: <20200204191206.97036-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204191206.97036-1-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some lines are long here. Use a struct dev pointer to shorten lines and
simplify code. The clk_get() call can fail because of EPROBE_DEFER
problems too, so just remove the error print message because it isn't
useful.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 46e501fc87f3..f0ca7f5ae714 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_geni_master *mas;
 	void __iomem *base;
 	struct clk *clk;
+	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
-						PTR_ERR(clk));
+	clk = devm_clk_get(dev, "se");
+	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	}
 
-	spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
+	spi = spi_alloc_master(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
-	mas->dev = &pdev->dev;
-	mas->se.dev = &pdev->dev;
-	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+	mas->dev = dev;
+	mas->se.dev = dev;
+	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
 
 	spi->bus_num = -1;
-	spi->dev.of_node = pdev->dev.of_node;
+	spi->dev.of_node = dev->of_node;
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
@@ -579,13 +577,13 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
@@ -597,7 +595,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_free_irq:
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	spi_master_put(spi);
 	return ret;
 }
-- 
Sent by a computer, using git, on the internet

