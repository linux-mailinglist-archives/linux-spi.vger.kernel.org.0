Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74F20BC60
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jun 2020 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZWUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jun 2020 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZWUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jun 2020 18:20:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D985C03E97B
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2020 15:20:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so4748102pgg.10
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2020 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVcpaUniYerIlCyx1vTQeFNCOepnPAPlvIx24HtK4yw=;
        b=Y3vJvMHtv5KZ2rxBZK3vacMhwJm2BUw4M6OpjYw7DFuo+buW2y6YZOxS9VLsWsK3Br
         spHitLO/QOTPyHk30J3sevum2LgoiFO60eyouWi/LhOQ7fVk+Fmdte6Us2I3UjXnXnic
         I2tKu6dMKjjZYxO2a9POgMdGv+hK+y3glrgMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVcpaUniYerIlCyx1vTQeFNCOepnPAPlvIx24HtK4yw=;
        b=uh3bUg/UCf+ACnvt2JPq4uJgopcNVGNtmkH4JL75smWVNA6es+i+ttUPRAUmw4GQpy
         xz0B1/PAkf5FyFT7iMvj2S01yIG745lXip5mPGgtNMYM52SytNjP+eh/v8xd24y0W8Da
         MEJYDaSlcdSjR3jg4vOcwOVXbxQHZo61F5i0Dj0fcUIaL7EGPQ/aNF0h08c+UAHTNHb6
         DJYxofsar6yXAjXFw9o/sT4iA7eSrGFS+xyRhk37jUtumUn2xdTBwGFrhQ0xq/jpqHLy
         9VN9SQtnuieZIz+3vcn2fEmIAeLWGwFC6HH2NyTIN9E1KRCdbqIHhyUEWap5kReZUl4M
         q7oA==
X-Gm-Message-State: AOAM530rdIixXDEhq1Mo4W2HIQwXNgZXc3MBMEiDPzpfIc+4+gRV68L7
        K1ZYucwOIP+lSQazOphDRkx9gg==
X-Google-Smtp-Source: ABdhPJwJjzabhmueOPoNL5/wqZZOUQ+pyL+hA+NLvUlCg08OPdl1PBt92nCnlkxyWWtqpBO1KOiGhA==
X-Received: by 2002:a63:778c:: with SMTP id s134mr767729pgc.273.1593210021506;
        Fri, 26 Jun 2020 15:20:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h9sm9001635pfk.155.2020.06.26.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:20:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already right
Date:   Fri, 26 Jun 2020 15:19:50 -0700
Message-Id: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Setting the chip select on the Qualcomm geni SPI controller isn't
exactly cheap.  Let's cache the current setting and avoid setting the
chip select if it's already right.

Using "flashrom" to read or write the EC firmware on a Chromebook
shows roughly a 25% reduction in interrupts and a 15% speedup.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5b1dca1fff79..e99a9d57449f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -79,6 +79,7 @@ struct spi_geni_master {
 	unsigned int oversampling;
 	spinlock_t lock;
 	int irq;
+	bool cs_flag;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -146,10 +147,15 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
-	pm_runtime_get_sync(mas->dev);
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
 
+	if (set_flag == mas->cs_flag)
+		return;
+
+	mas->cs_flag = set_flag;
+
+	pm_runtime_get_sync(mas->dev);
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
-- 
2.27.0.212.ge8ba1cc988-goog

