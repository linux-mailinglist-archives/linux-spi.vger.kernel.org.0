Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A896E89CE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Apr 2023 07:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjDTFxC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Apr 2023 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjDTFw7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Apr 2023 01:52:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03040D5
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 22:52:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54fba72c1adso14356537b3.18
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969976; x=1684561976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=GYjayEHTH0DTFM7kLY9bVfMA2J7m/p62X4TtHqIrE81LrGEdzUtYqYo+3PqkGKe/PP
         xFKTLUmHAalIQMGpb5k7bntgsjNGP0pZPo4Na5+8sawig3szQDTNnx25Aq31dRhf41we
         m7XlLrEnhZfXFcS1Rwj1lnrvIoGm+j9yPTsQLQjZmDtx6mRbmAxSM2Pr+g3zYCQYPp2X
         MktbbEevw9lhMaNqnpy0Q4NgotUlEfww8ij7NuvbU2VHsEwHYKFhdpL/nipcBOvMGYwq
         SsQZO0hFLViLjndPQObcqY7+eZq9kXkjCRunkR5OxygH+N2I7Y9DYlohfTWdLtcRcvqx
         fcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969976; x=1684561976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=A9NDnvGE9FNE7cyBosY/0zjzKT0+cP8I8SKc2H7HZvT8/gCohdbdTMaRRZRNoMw1j+
         pjbfjv9PbSFZ165/m5+VIhSStBSC6qKoN4/j/bGIrQkuCfVTQUoVaDKlX7JSKnCQyISB
         J2DDW3OlN6PoA0+qZU3wo/T0VCTNUiw65SAYBTB6FTKZZ9o1taE2txD9JzxQkd6chMVc
         hQxTJZLptV/Q/D8d3fR2za43DTnWJldgLu54zja4n2PnyGL90y7cYd7BiKsCwGBHbqHV
         cFdOqw6VOFURdTWMgPVD1mXFvBQ7zSVeC8NVctAc2PGMq0nJQeFn+bceSgMXPcs5y85K
         cvwQ==
X-Gm-Message-State: AAQBX9eXCsHh8t9u1SmL1QZ18u1N1HoZ8F3LH7Hn72GoBDyRV4J07DmT
        OJaDbdvSY6+v3u3ivJpBi0kdgnCEWxqwMA==
X-Google-Smtp-Source: AKy350ZPZBC7QCtpkWz4OAE8WRsC3sGRYmMChEsbN7/Q4y6a0qg4jQR8PY1s4trNZJzA5KgED/0yImjC1Fzf3w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1241:b0:b92:238b:574a with SMTP
 id t1-20020a056902124100b00b92238b574amr1547530ybu.0.1681969976120; Wed, 19
 Apr 2023 22:52:56 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:28 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-3-joychakr@google.com>
Subject: [PATCH v8 2/5] spi: dw: Move dw_spi_can_dma()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Move dw_spi_can_dma() implementation below dw_spi_dma_convert_width()
for handing compile dependency in future patches.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index c1b42cb59965..f19c092920a1 100644
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
@@ -220,6 +212,14 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
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
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
 	unsigned long long ms;
-- 
2.40.0.634.g4ca3ef3211-goog

