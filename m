Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F26E588A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 07:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjDRF3K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 01:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDRF3J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 01:29:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF8524D
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f89e7de94so165964087b3.17
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 22:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795748; x=1684387748;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=475zu7r4GSDH4bCdvfnE1q0yMJCUwMj3yvNxH13Y90Y=;
        b=LH+/MVHL3qc9T+wa3AcuoBK6tNVaKlilULvXtbRsdiDzi10/aS7aVqKhogaYBgdytt
         9GwMhv7FHHLcXm9BqRGCnlasI51mvlHXKbdP0mJGdD6XPRBFrF80K5KzZjd1Z9qqseim
         da5PDhfiijeetDA+z50L7z1bbLpEcXc7S2pVPLZfT2/JDoae1BdqpKXlFbaiNSvwJQWE
         x1f/rGWpZzmuXQwxZDiXzBqdb5HsE6YIsYmt3oRzX1uqcg8M6g+GqvXOGCQ8M9d/6ELx
         EXM1j4HTROynYC3bKVBZAS74cQUerCEMuHUBSCg2jBy1zdJqnOqZtLlBa238iFwMu+qW
         2Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795748; x=1684387748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=475zu7r4GSDH4bCdvfnE1q0yMJCUwMj3yvNxH13Y90Y=;
        b=JjpzjBYAzu+RnJHA0W+uvseW25s9DxYWWXBZZAE8oLxWPC+OguzORvuGhpIfTwclMg
         ItDHlNkDFJwQUrL+iq500mzzqdk/CV4vVcixsg5NVeIlw80HD9kUI4KirefYXhzk1KPZ
         h3Qiz+Aa+n0mFFVPUqvfOQMaal+nu5Exc1Am4PcM43FBvJViidID9GPLVSqg4ZyePnKS
         dd+ASekqVBgt9ezY/cV1ox0hwmZnxBwE0lEiskbiP156d8BNuGYglsjoHhcAuTHWV9YC
         RWesHTgDdBkny5OSH7Nyl+mnaVnEC0MnQY+Q+0SmnoJSDrwt9AXBX8WZna9J2FG/4W/s
         LAjw==
X-Gm-Message-State: AAQBX9e1yHmC8rRZYBDa3JKYwbPndNHn11G919Bs+0Q8KjmnbIzd8cqB
        k1z8zFxZD9GCUTYeNbaUTdm/gkknIO9G+A==
X-Google-Smtp-Source: AKy350Yx0snAfdYbBuh4bnriGEJl9PzuzvZ4vlMH12lk1ae2eli45QHDhwN5XY4aPePNhwBmD4fCEYqsft+yyw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:748b:0:b0:b8f:567f:4352 with SMTP id
 p133-20020a25748b000000b00b8f567f4352mr10863386ybc.3.1681795748077; Mon, 17
 Apr 2023 22:29:08 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:28:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-1-joychakr@google.com>
Subject: [PATCH v7 0/5] spi: dw: DW SPI DMA Driver updates
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

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
---
V1->V2 Changes : Add dma capability check to make sure address widths
are supported.
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---
V3->V4 Changes : Fix Sparce Warning
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
---
V4->V5 Changes : Preserve reverse xmas Tree order, move direction
check before initalisation of further capabilities, remove zero
initialisations, remove error OR'ing.
---
V5->V6 Changes :
	-Remove case of n_bytes=3 using 4_bytes buswidth
	-Avoid forward decaration
	-Break capability check patch into 2
	-round n_bytes to power of 2 ( Bug Fix)
	-Add more explanation in commit text.
---
V6->V7 Changes : Remove extra spaces, refer to functions in commit as
func()
---

Joy Chakraborty (5):
  spi: dw: Add 32 bpw support to SPI DW DMA driver
  spi: dw: Move dw_spi_can_dma()
  spi: dw: Add DMA directional capability check
  spi: dw: Add DMA address widths capability check
  spi: dw: Round of n_bytes to power of 2

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi-dw-dma.c  | 75 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

