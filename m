Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFF6F05D4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Apr 2023 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbjD0MdX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Apr 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbjD0MdW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Apr 2023 08:33:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55C420A
        for <linux-spi@vger.kernel.org>; Thu, 27 Apr 2023 05:33:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso683721276.1
        for <linux-spi@vger.kernel.org>; Thu, 27 Apr 2023 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598800; x=1685190800;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCcqnfxouwoiDswqAajWA4urOkAKuA44YgC+Tktp544=;
        b=3KGaMF9mrtJ0d4l78cukq0C5LMKpgS2XhpTcB1wXE8fSquZXHLudJlb1nMx14VIr+y
         bXgagFXM0Rzz/hODdXMyk9Vu1Qyqez2fj22KHHuL8ZivYVGSPAN/BzDycQequQVtu9+r
         u+YyloxqFCKHBiRG+MfQmjZMQHra70t5pVYB01OWJ+H6L43DKfCmCV4QljH374IjOd2t
         oWuNKaAr7A8vp0+m8LAyUrfDAu1VXPyb2YKQFenM6j/d8Q5s911Ennh7CwXFjHdQ9hMr
         zPuT9vL53taAE9oemtvl+ntgX7mTGO6VYQbRyWSnLYtVFT0BSwUk906i6CoElPjdIb/A
         71OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598800; x=1685190800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCcqnfxouwoiDswqAajWA4urOkAKuA44YgC+Tktp544=;
        b=CfBBHdeEvBlY7fJatBgi8liUZ0SdQtPJpER9zy2jRHz5yB9UBZu7+lemRbl/LQVzFV
         R48YLas+2zL6eKX/GRm2WtDTqnNhmCm5KE5TbXZWXkRRBRPiZZbiG0bD459KmL0dMwMC
         6IbvMwjNx4sjKXcDlzQu7W5Qvyvi4VWQjURC9v6edtyWtKdffVlYHLhu8P03jpXJEnRE
         jDIQWOxgrIqWxaziwH2nQcZn3o8Sbcx3WmDEtmhA5/Pxw5i6VxMwJSEv7qhIG3304yTz
         v5zZxJmQU6lgNriBXoFHQq4nVp/YGEJzrtGUagpLltjS8/TAVUUQWKGhX8QJ+vkyHBgM
         06ag==
X-Gm-Message-State: AC+VfDzSsTFB3fZI8kTOgLyxufD758TvUQoRbPkYXceuQXR1NSeNcnl/
        IDrRDEQ8RVoRRQKiFqROo1SdP7dRTtvEWA==
X-Google-Smtp-Source: ACHHUZ6VGEA8UqyHEXqSEHVtuSavKR86WSAguD4vhAU2jlNWJZn2nC3qLkYSr/unfwYUfJOxQNhC2lTMn0cgjg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:100e:b0:b8b:f584:6b73 with SMTP
 id w14-20020a056902100e00b00b8bf5846b73mr479350ybt.10.1682598800223; Thu, 27
 Apr 2023 05:33:20 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-1-joychakr@google.com>
Subject: [PATCH v9 0/5] spi: dw: DW SPI DMA Driver updates
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
V7->V8 Changes : Minor commment updates in patch 4/5
---
V8->V9 Changes : Minor formatting changes in patch 5/5
---

Joy Chakraborty (5):
  spi: dw: Add 32 bpw support to SPI DW DMA driver
  spi: dw: Move dw_spi_can_dma()
  spi: dw: Add DMA directional capability check
  spi: dw: Add DMA address widths capability check
  spi: dw: Round of n_bytes to power of 2

 drivers/spi/spi-dw-core.c |  5 ++-
 drivers/spi/spi-dw-dma.c  | 76 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 63 insertions(+), 19 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

