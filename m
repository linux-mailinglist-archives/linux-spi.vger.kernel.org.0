Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A156E22D3
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDNMFk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDNMFi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:05:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74FA27C
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c193-20020a25c0ca000000b00b868826cdfeso37049987ybf.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473936; x=1684065936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65uwjwswhP+aUopNhPv3UiA4NcKEqdUIfoVkzM6bAyo=;
        b=uQubCHw71w6O5XUQutjA0LoDpSL+v+TuXE7SpijzhdY0JXfM0e0pQaW2iEN6icIOIn
         /s75BK6Tjvx1t0KMTqBurrQfuw3f6vYbuyu4tcYmsAXpvsr0nZKk1831iznXGpFKYWYJ
         UcftyaBaMnZ4i2G6zZJTBSS7QWCMH3Al34GMKx8XLeB2UrazIZsFWXpLrzEKvADfMYyX
         nuvtJjH8kJ9QMIgrJ17Rn0gQ+Dy+EVO6Yo8R0ZOaQ9LNL4i/jynn5CGsLzwBkafmpoa4
         r4PdLkG5fgB0AJfp++xDofE0gCar0kFtZRO88adxNRP//ldNAki3n3toqaKsW0p/WsnZ
         fGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473936; x=1684065936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65uwjwswhP+aUopNhPv3UiA4NcKEqdUIfoVkzM6bAyo=;
        b=iBsXOpFZqirCww3isTTE7MXwuEETP8o/n48JBFfMB5C7bX7B0KaBD+o/GMUOtERJlD
         wkIOjLZCi/rZJdVDpR9U0aJLmCPFqAMEneQIfYkLaHRkLacFP7cxTd4O/hqWz9BKfRt2
         c1OIEx9wxNtgGuCeUKCUpP84dBBl+xBf7W8KIWpS8FfCQdPe9lu8figgShp1zBAWTlTF
         z8YdASC2d9e3bR5seM5d3XH6ymbuP70Ign4ffHQwydbKgZ4EGLfOFHfAf/dKFHL0OHhv
         kUdCh+qkyAEg1YE76yUt1d8qYxGodg+51ngtSnadkeVZVgEHQIEwE4vTPd1tPFh93buL
         7R+A==
X-Gm-Message-State: AAQBX9fUG0H6Z/1aOsuXV6WrivsdVxBbII7Q2ROjP51ApWu31g73zamy
        3DsBQR8dW+xIlUNww7I9P3qCBTSipJMbKw==
X-Google-Smtp-Source: AKy350bhmj53MiLlrrVDFOyFrorofDJY+k0jBT6zxQESV24P49jM10JlfoTG44JJfHCDoHSP3Ga+rXN5G+Pt0A==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:b303:0:b0:545:1d7f:abfe with SMTP id
 r3-20020a81b303000000b005451d7fabfemr3555808ywh.7.1681473935975; Fri, 14 Apr
 2023 05:05:35 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:17 +0000
In-Reply-To: <20230414120520.360291-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-3-joychakr@google.com>
Subject: [PATCH v6 2/5] spi: dw: Move "dw_spi_can_dma" function
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

Move "dw_spi_can_dma" function implementation below
"dw_spi_dma_convert_width" function for handing compile dependency in
future patches.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index c1b42cb59965..75e1b11af7c9 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -198,14 +198,6 @@ static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool dw_spi_can_dma(struct spi_controller *master,
-			   struct spi_device *spi, struct spi_transfer *xfer)
-{
-	struct dw_spi *dws = spi_controller_get_devdata(master);
-
-	return xfer->len > dws->fifo_len;
-}
-
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
 	switch (n_bytes) {
@@ -220,6 +212,15 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 	}
 }
 
+static bool dw_spi_can_dma(struct spi_controller *master,
+			   struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(master);
+
+	return xfer->len > dws->fifo_len;
+}
+
+
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
 	unsigned long long ms;
-- 
2.40.0.634.g4ca3ef3211-goog

