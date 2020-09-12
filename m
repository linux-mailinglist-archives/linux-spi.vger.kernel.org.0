Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43318267C83
	for <lists+linux-spi@lfdr.de>; Sat, 12 Sep 2020 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgILVIq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgILVIU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 17:08:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C866BC061757
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 14:08:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so8675037pgo.13
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNyBzqYxhNLfRyzcGYVhpsNYZE01k6vdArIGmMCZyP4=;
        b=HY13hSv3vsmDbVwvsXcGM1uwa9ssg1EaF0jrXqrOxFlN9zlWG928ZYfHs81NzfcTzB
         M2M6AgkZ5clA0Vw+h0s8afCY+On1qQfAcpHnOOz/Kj7rY+9H3WBU996zkr9qy9t/T3T2
         Sb146Z4Fh3WT70BYQuGvrkIzyVAd7UGgJ4rfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNyBzqYxhNLfRyzcGYVhpsNYZE01k6vdArIGmMCZyP4=;
        b=rg7EXyOt+wRpG66fC+TqzMJvOQNtRsjOKhmYGmpLT3oXTCGzG1UDaJ5/gYyiep/+os
         MQ56TZmow7GGvqBPD0s50DbS5RUT9rzKoVFNcD/TIGG2QPOdp1wqmGEFiTqji952Uw0s
         SHbVgwnoO1/SBEQ9JVTZzpMu0L1ZUUG8CFA3l5xg8AmI8Lisq8v/aqo65D5FBTqoRvgJ
         unxz1XdndjA/ko3xZIZV4SgkZm/WRv1Dy4VQ3Zlgn6ipALnmJmsk4hWuRChZKVkM1Kt0
         h0IqBpH9GkWpsxblsbUKpB/JSwHlGv8M7jDOADKh9rt/mgZg2tz7vckPHEqCmoDe8+86
         +ncw==
X-Gm-Message-State: AOAM531FlKyJdARqLbZR0NHrh5llFvoWvzaT/hJFbg9gd2jF1J3gnnw5
        9XImRHIGeDzT6pfUYGTfwe+rEA==
X-Google-Smtp-Source: ABdhPJw7Hcc5QSI5JuRjeZo+HyHcn5RCuI7pIwHNcKnmRxgH6mJMLxHWdY8tE5JD+7KF58ozETdhvA==
X-Received: by 2002:a63:4418:: with SMTP id r24mr5829295pga.8.1599944899358;
        Sat, 12 Sep 2020 14:08:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id e10sm3369020pgb.45.2020.09.12.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 14:08:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Akash Asthana <akashast@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 3/3] spi: spi-geni-qcom: Slightly optimize setup of bidirectional xfters
Date:   Sat, 12 Sep 2020 14:08:01 -0700
Message-Id: <20200912140730.3.Ided778fb4cd078e36c6b240d1b279cd7a534a313@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When setting up a bidirectional transfer we need to program both the
TX and RX lengths.  We don't need a memory barrier between those two
writes.  Factor out the __iowmb() and use writel_relaxed().  This
saves a fraction of a microsecond of setup overhead on bidirectional
transfers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 92d88bf85a90..6c7e12b68bf0 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -376,15 +376,22 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	len &= TRANS_LEN_MSK;
 
 	mas->cur_xfer = xfer;
+
+	/*
+	 * Factor out the __iowmb() so that we can use writel_relaxed() for
+	 * both writes below and thus only incur the overhead once even if
+	 * we execute both of them.
+	 */
+	__iowmb();
+
 	if (xfer->tx_buf) {
 		m_cmd |= SPI_TX_ONLY;
 		mas->tx_rem_bytes = xfer->len;
-		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
+		writel_relaxed(len, se->base + SE_SPI_TX_TRANS_LEN);
 	}
-
 	if (xfer->rx_buf) {
 		m_cmd |= SPI_RX_ONLY;
-		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
+		writel_relaxed(len, se->base + SE_SPI_RX_TRANS_LEN);
 		mas->rx_rem_bytes = xfer->len;
 	}
 
-- 
2.28.0.618.gf4bc123cb7-goog

