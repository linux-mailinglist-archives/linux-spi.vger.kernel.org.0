Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A01FAE2E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFPKlS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPKlR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 06:41:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B1C08C5C4
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so8200141pll.10
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJs/Oi9Mi3ug6LfaBxjT1n43eYXZ9pUbi6m5LKUVQO4=;
        b=MqZCNAI8Iw6mymDvak+cacoyil8x2xJJaRV2xXtBE1LmLTvA9QTNUGMgkJofNI0NTR
         G6MJdwda5yBx5YFmnJp9/VvyLlqsf6sDlJVGlsEQ5qGnf8DM4QqDdcOc0lKMQZxT1npS
         kiGKOpwws0NtqRvrNQP5cC3i7nyhRs8o5wJic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJs/Oi9Mi3ug6LfaBxjT1n43eYXZ9pUbi6m5LKUVQO4=;
        b=qsRSppjlp3AnhdE8fU1IGCzcaC7s94hFv4ulRRfC4lVBGcmT0hhkgf6Lqn7UaGAo50
         TPPV1t9+qw1aMb38b5blo3C5+wmKwtPf29F8OZaOwdRgFqOcisrlSmUrdlbXAKIOSUUy
         jbGeF4DlQIbRFamSHPBmr2tsc0XepEjiY6nBBlZ++jp8eEzJDOcCrVrRpZErGAUp2V4M
         e3V9p5HtSOcaBcZ4Lb5+oHAURsW9r7+mE7u/rz7XJ0M06NVj840Wgn5pcnz8TX/zQwYq
         eBNYP6RrpPUT6i9rGpPavUAi+bZBMbjNb61N4Jk41TA4QWzZuIMCDz0WLvg3o4U7vUsS
         gLjg==
X-Gm-Message-State: AOAM530HgAvBEh/7QVash5O0AtfhVIS4PCbKplHkmNQT+1YbDmqxJvGW
        gXkUiqn1C0y6h23pD/GYEUJ9Xw==
X-Google-Smtp-Source: ABdhPJy/ZBWBhU43T2L75yqpNFwKNJG2pngiPC9ll3hM2DhsLON7YXCAYNdGbk+8vJLk+Cclr+dp+w==
X-Received: by 2002:a17:902:760d:: with SMTP id k13mr1593556pll.2.1592304076217;
        Tue, 16 Jun 2020 03:41:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 140sm16947400pfz.154.2020.06.16.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:41:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Date:   Tue, 16 Jun 2020 03:40:45 -0700
Message-Id: <20200616104050.84764-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series is a new version of the previous patch posted:
  [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
  https://lore.kernel.org/r/20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid

At this point I've done enough tracing to know that there was a real
race in the old code (not just weakly ordered memory problems) and
that should be fixed with the locking patches.

While looking at this driver, I also noticed we weren't properly
noting error interrupts and also weren't actually using our FIFO
effectively, so I fixed those.

The last patch in the series addresses review feedback about dislike
for the "cur_mcmd" state variable.  It also could possibly make
"abort" work ever-so-slightly more reliably.

Changes in v3:
- ("spi: spi-geni-qcom: No need for irqsave variant...") new for v3
- Split out some lock cleanup to previous patch.
- Don't need to read IRQ status register inside spinlock.
- Don't check for state CMD_NONE; later patch is removing state var.
- Don't hold the lock for all of setup_fifo_xfer().
- Comment about why it's safe to Ack interrupts at the end.
- Subject/desc changed since race is definitely there.
- ("spi: spi-geni-qcom: Check for error IRQs") new in v3.
- ("spi: spi-geni-qcom: Actually use our FIFO") new in v3.
- ("spi: spi-geni-qcom: Don't keep a local state variable") new in v3.

Changes in v2:
- Detect true spurious interrupt.
- Still return IRQ_NONE for state machine mismatch, but print warn.

Douglas Anderson (5):
  spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
  spi: spi-geni-qcom: Mo' betta locking
  spi: spi-geni-qcom: Check for error IRQs
  spi: spi-geni-qcom: Actually use our FIFO
  spi: spi-geni-qcom: Don't keep a local state variable

 drivers/spi/spi-geni-qcom.c | 120 ++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 39 deletions(-)

-- 
2.27.0.290.gba653c62da-goog

