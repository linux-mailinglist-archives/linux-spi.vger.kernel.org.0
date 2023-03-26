Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8596C9733
	for <lists+linux-spi@lfdr.de>; Sun, 26 Mar 2023 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCZRf0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Mar 2023 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCZRfZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Mar 2023 13:35:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B149F8
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 10:35:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so6566066ybp.6
        for <linux-spi@vger.kernel.org>; Sun, 26 Mar 2023 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679852123;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RaHSVWTJSnn02Olin7w+pvQXlMrY8VwSVjxsNhW3jw=;
        b=PHZst7jsbRQmhKifgwxo7mStAuo/tpfibTL8fS17ydBfof+K9WnRKB36/a5TOKJ8/t
         v7ppzG+XE+wbInX2Gj2xRtLzQMVyhiEJ8wi8Noeigcl3jn8Bm6yde690czGaxdXdX606
         to18odJKzZiqBdSQOp5yogYYtvELKByEwwgkSZVjwrh2IihvN+d6WCGCa9CrADDbWWuT
         XRTgEeCTAl9XKjDu4mCPE5di5Ia/OZJ6/MshPIzCtGwnZH9Eyp1Mz7IVINGvDhYDr/cV
         5o6DvLaEItsmgWSTnaC9WmxHvtHBparGbDOD1WDLodtn6E3MUZYIs6n8G4e1gN/5BzmR
         kPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679852123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RaHSVWTJSnn02Olin7w+pvQXlMrY8VwSVjxsNhW3jw=;
        b=YHr68eQ/GV8cTegyoPu9s6ptpfaSC/ed9YtRMVyx3FN5y83lCt4yrEzZp2WmqNPdi4
         UdDPg8cf7opfeRoXBJfM/JM5v2lwahdxUPsxS8wu+Jtn8HIKyn0HuZJ/00CmywbyUo0d
         bwnqzbyD9Dcu2ly+QbrvWdTMUNPQNBPMMqOnFyJGqgjRsjqP6vdbEB90zNCdJWEnpQ9r
         qHvugEqjn2PqfElCXmwHGFjE+FOwTkQko6b4mZzT3YvnmTbABpL4A5E0BjoMVRnOtA0n
         bIr5C/scMGI6b/MkCjxzMucbqNJOlCnlKaYZ+qKX3r6buwbHhsBG75U8J5cNh0td4Vp9
         Gt5A==
X-Gm-Message-State: AAQBX9cXPG2vpN/oCAeoYmviJCJQ30Sa3AzdHp6CYj8fS9N/lKhkmNHQ
        4zaoZApxTrAQ3Qlk+T3+EScxEyBUikttDg==
X-Google-Smtp-Source: AKy350YojcWSKkpB3jG6a7FElkGpMoXsRM6pAISAmXcv+NTb/O9Iww2Zv/YDDmhzI3miclD8+ShCBVLT4UXJBQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a742:0:b0:541:a0cc:2a09 with SMTP id
 e63-20020a81a742000000b00541a0cc2a09mr4212382ywh.7.1679852123705; Sun, 26 Mar
 2023 10:35:23 -0700 (PDT)
Date:   Sun, 26 Mar 2023 17:35:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230326173511.710749-1-joychakr@google.com>
Subject: [PATCH v3 0/2] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=4 bytes to support 32bits/word
---
V1->V2 Changes : Add dma capability check to make sure  address widths
are supported
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---

Joy Chakraborty (2):
  spi: dw: Add 32 bpw support to DW DMA Controller
  spi: dw: Add dma controller capability checks

 drivers/spi/spi-dw-dma.c | 67 +++++++++++++++++++++++++++++++---------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

