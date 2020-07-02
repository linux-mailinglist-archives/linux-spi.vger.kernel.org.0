Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BA21175B
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGBApn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgGBApg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Jul 2020 20:45:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCEC08C5C1
        for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2020 17:45:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so832ple.0
        for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2020 17:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0ar211YP+36NHOe0RGdo5xX/ajG/sfFSQ8f60VejD0=;
        b=K8dryPtevEWJdF6SRZtGa+5PKQFaWzwvHBySR6u2HjiruZ2Nj2GDh3biDtq0WsOzqS
         pEtk2XCHBg+9pAZYqGRL3g2nGdU6WPHoQ/sX4dI4/0W1+LpIuTUyIIH9/CdxbxVSEzwf
         ZaU54QAtbJBTg/Td+Fqip/FVCLcj9oyQ7SnuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0ar211YP+36NHOe0RGdo5xX/ajG/sfFSQ8f60VejD0=;
        b=mq6K/M0+ZL8RnKawv4HR32ewU7tdckzzo9qW9uAJ6QIe7ld9EW1AjMegE7k1rHu7ck
         +2UxRRTXUlAsJenQ0wQuDt9crCn2G6YLBhzdAjCwh/6mtMG99z5MpAzT8Kba3E68S9gj
         RebPu03/EX80bMip1YjHiBO/MeVlfwK2jAqzQAeSxAxlAWZcd9FPq7OWuQrMgLe/UAAZ
         pbJIsFWXNj8o8L5k6hcJUmldaBtxUf7tGoUl0F+9duobkJhVASLl5IsiEzp3mUUYAPcE
         wot+WC4CJHJyRKcA+pZP7s+B8+05UIsWPYgzIAcHEH2EEVOqKuMEhS/1r0tzB+LUzGKP
         3vVw==
X-Gm-Message-State: AOAM530PnpRcCBNbSr7EyJUKSaOVTgsdi0ku3OAlzL1Dh1rB9sKOypuO
        xE/K5v9l5kmuYVCjZ8KLrI+/cQ==
X-Google-Smtp-Source: ABdhPJwhyy/qWqaGb8JH1N+a/tD9m0LydHWyYXMgG+Not2qxrJ+qYYncwwDbkuIMPoZEPcSqyStrCg==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15mr24662170pls.248.1593650736141;
        Wed, 01 Jul 2020 17:45:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id w4sm6966212pfd.39.2020.07.01.17.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:45:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 3/3] spi: spi-geni-qcom: Get rid of most overhead in prepare_message()
Date:   Wed,  1 Jul 2020 17:45:09 -0700
Message-Id: <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200702004509.2333554-1-dianders@chromium.org>
References: <20200702004509.2333554-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There's a bunch of overhead in spi-geni-qcom's prepare_message.  Get
rid of it.  Before this change spi_geni_prepare_message() took around
14.5 us.  After this change, spi_geni_prepare_message() takes about
1.75 us (as measured by ftrace).

What's here:
* We're always in FIFO mode, so no need to call it for every transfer.
  This avoids a whole ton of readl/writel calls.
* We don't need to write a whole pile of config registers if the mode
  isn't changing.  Cache the last mode and only do the work if needed.
* For several registers we were trying to do read/modify/write, but
  there was no reason.  The registers only have one thing in them, so
  just write them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 54 +++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f51279608fc7..97fac5ea6afd 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -77,6 +77,7 @@ struct spi_geni_master {
 	u32 tx_fifo_depth;
 	u32 fifo_width_bits;
 	u32 tx_wm;
+	u32 last_mode;
 	unsigned long cur_speed_hz;
 	unsigned int cur_bits_per_word;
 	unsigned int tx_rem_bytes;
@@ -177,8 +178,6 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 	struct geni_se *se = &mas->se;
 	u32 word_len;
 
-	word_len = readl(se->base + SE_SPI_WORD_LEN);
-
 	/*
 	 * If bits_per_word isn't a byte aligned value, set the packing to be
 	 * 1 SPI word per FIFO word.
@@ -187,10 +186,9 @@ static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 		pack_words = mas->fifo_width_bits / bits_per_word;
 	else
 		pack_words = 1;
-	word_len &= ~WORD_LEN_MSK;
-	word_len |= ((bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK);
 	geni_se_config_packing(&mas->se, bits_per_word, pack_words, msb_first,
 								true, true);
+	word_len = (bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK;
 	writel(word_len, se->base + SE_SPI_WORD_LEN);
 }
 
@@ -238,38 +236,34 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 	struct geni_se *se = &mas->se;
-	u32 loopback_cfg, cpol, cpha, demux_output_inv;
+	u32 loopback_cfg = 0, cpol = 0, cpha = 0, demux_output_inv = 0;
 	u32 demux_sel;
 
-	loopback_cfg = readl(se->base + SE_SPI_LOOPBACK);
-	cpol = readl(se->base + SE_SPI_CPOL);
-	cpha = readl(se->base + SE_SPI_CPHA);
-	demux_output_inv = 0;
-	loopback_cfg &= ~LOOPBACK_MSK;
-	cpol &= ~CPOL;
-	cpha &= ~CPHA;
+	if (mas->last_mode != spi_slv->mode) {
+		if (spi_slv->mode & SPI_LOOP)
+			loopback_cfg = LOOPBACK_ENABLE;
 
-	if (spi_slv->mode & SPI_LOOP)
-		loopback_cfg |= LOOPBACK_ENABLE;
+		if (spi_slv->mode & SPI_CPOL)
+			cpol = CPOL;
 
-	if (spi_slv->mode & SPI_CPOL)
-		cpol |= CPOL;
+		if (spi_slv->mode & SPI_CPHA)
+			cpha = CPHA;
 
-	if (spi_slv->mode & SPI_CPHA)
-		cpha |= CPHA;
+		if (spi_slv->mode & SPI_CS_HIGH)
+			demux_output_inv = BIT(spi_slv->chip_select);
 
-	if (spi_slv->mode & SPI_CS_HIGH)
-		demux_output_inv = BIT(spi_slv->chip_select);
+		demux_sel = spi_slv->chip_select;
+		mas->cur_bits_per_word = spi_slv->bits_per_word;
 
-	demux_sel = spi_slv->chip_select;
-	mas->cur_bits_per_word = spi_slv->bits_per_word;
+		spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
+		writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
+		writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
+		writel(cpha, se->base + SE_SPI_CPHA);
+		writel(cpol, se->base + SE_SPI_CPOL);
+		writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 
-	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
-	writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
-	writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
-	writel(cpha, se->base + SE_SPI_CPHA);
-	writel(cpol, se->base + SE_SPI_CPOL);
-	writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
+		mas->last_mode = spi_slv->mode;
+	}
 
 	return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
 }
@@ -279,9 +273,7 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 {
 	int ret;
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
-	struct geni_se *se = &mas->se;
 
-	geni_se_select_mode(se, GENI_SE_FIFO);
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
 		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
@@ -322,6 +314,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	else
 		mas->oversampling = 1;
 
+	geni_se_select_mode(se, GENI_SE_FIFO);
+
 	pm_runtime_put(mas->dev);
 	return 0;
 }
-- 
2.27.0.383.g050319c2ae-goog

