Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E51FF649
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgFRPKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbgFRPKr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:10:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28FC0613EE
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so2673977pju.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8mQLD0t+cboPjyUGv/rlRj+Qss5ICQz5LRvfNgouBU=;
        b=ZwfcIPvrNKDx+t692D9K1GQFNEsGQSVfZhEYZVBs7Jl7zFNclXAbZlo4B+E9sEGNkR
         yJD2nhFyKLIesbLDMKCPLNlcnvRLAHoTWKiIkCiADOsroG/2cO6NSnax5G8CAuQ6irue
         2ilzPIcya+GwU1mM2ChbbsDjwvTnSsZ1W5qX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8mQLD0t+cboPjyUGv/rlRj+Qss5ICQz5LRvfNgouBU=;
        b=fov0dXFm0oi19pmpLihr/h/tjUr3Athn1hOwZD/ED6EzlqXvNctqLkbb127mzrpSsO
         494NmGQxQ/lnvWkU/ZQAP/Lup3Q6TejD2vZu8a826OPLDWdbOQ9TwB6h6H85ujJxHhDP
         UnM25dCK5UNXGQEzWH/O+cgP2TNr3viggCSQiZu9TwWi2kRSEE/qbv2RTozm2oaFjqGl
         togE+p+DlbsfCjcrw8Tf/W4QcYFHz1OCjkDekSikTY8yJxLvs1GV7OsfNAnV9q6Pbd/C
         57CR3XEAIv88LMJPaBxyBvP5yH0MCPcotmv39o66QrXMlu8JVryBScpNkoWH9tEov8MQ
         jfPw==
X-Gm-Message-State: AOAM530hTZi59mRYx0kuLlR8rp6Y+HjbmPvdFke8lmg80IDsNGs61Uek
        1DQnJ8ZZzVIWq/q+7SFMBEuQkw==
X-Google-Smtp-Source: ABdhPJwBCiEAsnjvXI94MJ1y3WUY67xCpOx5K26a+YK+FChk55yVpiuoiRfBjWpfMLd0e7JdctVK1g==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr4120640plo.3.1592493046531;
        Thu, 18 Jun 2020 08:10:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 0/5] spi: spi-geni-qcom: Fixes / perf improvements
Date:   Thu, 18 Jun 2020 08:06:21 -0700
Message-Id: <20200618150626.237027-1-dianders@chromium.org>
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

Changes in v4:
- Drop 'controller' in comment.
- Use Stephen's diagram to explain the race better.

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

