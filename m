Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C18A1FAE34
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgFPKlb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgFPKlV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 06:41:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57972C08C5C9
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so1063384pje.1
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnbTanlK6vmWDYRWZepA4l+8SpUkNjPIBDmpYRotz+c=;
        b=QpMn2xbYSqizB3W5EgihyPoGHa7zsnzjCRgfXCMifc7/VUP+4ThmvoemTFLohLL71y
         5JZ0Q0dgMtGOZDUGdg1J3B/nyTn0U4uyXNLHnMmhE5az2Q+lu98ih1EAI7g4wZRv/T55
         kuvRNyqbCpQOn4KyyBHAEw92sdEYnuxzHmxIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnbTanlK6vmWDYRWZepA4l+8SpUkNjPIBDmpYRotz+c=;
        b=DMRvB+hYEJU3hD2zo3Dc+kCDM68emCdvmjAfPg1ds+SvdPMHX+EoXUvurVMLqSj/A6
         uJL8DsE+/AZxE5bjf2vfP6GUUnq+Fa9PuDxU0gfqb3pQAtgg7jEKceYCWlv4Mr9BuzEx
         4spWLAzWe83bUs/RyImZjThvMGxsUS6q/z3wr6vzzUw19WBPEl9OwR8frnpiMoCopTn9
         0qFev2AhG0kTz37STAJTzwyXum7hnRXiFy/qFTJKUj54Fl93k45sZE9p4WkJlTo/a3il
         SViFZJRnO8hJTYzU/1ySZWQKUbI2haclPgDqcNxJ3xeKzuOF3f2IKZKQxLeiO/PLUR/Z
         Kpwg==
X-Gm-Message-State: AOAM532gipyQjCgn41QCdOuEODjMDiUxGQdMyJkyYRf3W5tr8iaiTAkG
        D+p6MgEZj+Qmpz/kz+eTnwHqag==
X-Google-Smtp-Source: ABdhPJxcOZtKi9rHF3B2KWjnaAn4f3KL9+GoKE61t5pAbz14hlSOGhr1kijdk3Ef/LVhBV48UWkvxg==
X-Received: by 2002:a17:902:ff06:: with SMTP id f6mr1523980plj.22.1592304080864;
        Tue, 16 Jun 2020 03:41:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 140sm16947400pfz.154.2020.06.16.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:41:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 4/5] spi: spi-geni-qcom: Actually use our FIFO
Date:   Tue, 16 Jun 2020 03:40:49 -0700
Message-Id: <20200616034044.v3.4.I988281f7c6ee0ed00325559bfce7539f403da69e@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200616104050.84764-1-dianders@chromium.org>
References: <20200616104050.84764-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The geni hardware has a FIFO that can hold up to 64 bytes (it has 16
entries that can hold 4 bytes each), at least on the two SoCs I tested
(sdm845 and sc7180).  We configured our RX Watermark to 0, which
basically meant we got an interrupt as soon as the first 4 bytes
showed up in the FIFO.  Tracing the IRQ handler showed that we often
only read 4 or 8 bytes per IRQ handler.

I tried setting the RX Watermark to "fifo size - 2" but that just got
me a bunch of overrun errors reported.  Setting it to "fifo size - 3"
seemed to work great, though.  This made me worried that we'd start
getting overruns if we had long interrupt latency, but that doesn't
appear to be the case and delays inserted in the IRQ handler while
using "fifo size - 3" didn't cause any errors.  Presumably there is
some interaction with the poorly-documented RFR (ready for receive)
level means that "fifo size - 3" is the max.  We are the SPI master,
so it makes sense that there would be no problems with overruns, the
master should just stop clocking.

Despite "fifo size - 3" working, I chose "fifo size / 2" (8 entries =
32 bytes) which gives us a little extra time to get to the interrupt
handler and should reduce dead time on the SPI wires.  With this
setting, I often saw the IRQ handler handle 40 bytes but sometimes up
to 56 if we had bad interrupt latency.

Testing by running "flashrom -p ec -r" on a Chromebook saw interrupts
from the SPI driver cut roughly in half.  Time was roughly the same.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("spi: spi-geni-qcom: Actually use our FIFO") new in v3.

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 56628d45421e..63a62548b078 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -285,7 +285,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	 * Hardware programming guide suggests to configure
 	 * RX FIFO RFR level to fifo_depth-2.
 	 */
-	geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
+	geni_se_init(se, mas->tx_fifo_depth / 2, mas->tx_fifo_depth - 2);
 	/* Transmit an entire FIFO worth of data per IRQ */
 	mas->tx_wm = 1;
 	ver = geni_se_get_qup_hw_version(se);
-- 
2.27.0.290.gba653c62da-goog

