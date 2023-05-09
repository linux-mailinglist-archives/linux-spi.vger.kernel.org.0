Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F56FC19C
	for <lists+linux-spi@lfdr.de>; Tue,  9 May 2023 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjEIIWy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 May 2023 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjEIIWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 May 2023 04:22:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CFA10D4
        for <linux-spi@vger.kernel.org>; Tue,  9 May 2023 01:22:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso1280861276.1
        for <linux-spi@vger.kernel.org>; Tue, 09 May 2023 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620571; x=1686212571;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYZzu5uKAv2K3CUFKdV+PnrKtAXzT9zaDvfq92PiXpQ=;
        b=6VaIk8BU1+iBlJ+77HD/FYD7NedD7l/shwrtU1U5jS0VwZtEU7QE4T7XXUhZI17OZ8
         U9JSKU+iOohlvTCS1rn5lBDusZWAPfZkhuoM0UjliXqV/4rqDDaP0aaIMAuf9HDYrwjk
         iB+oxn+z0CTNn27ICs/OOF5Dy5jX+UFGdzSSPMXhlhD5MMBvgPj3uJW/9BeAgOM3mpvK
         HMSxpMuZr0s8KnPlBMQh/eRFhbl0WJweyW3Cb20JKkjSf21qlLA1fxe68Gh5tROIvZod
         HB6Amj6ZBwvjC0m9pe7kU4aIzOibxxk1R6wnnKfdf2+l6N1KYXPGRthT1w9IvEjtj9V8
         f4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620571; x=1686212571;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYZzu5uKAv2K3CUFKdV+PnrKtAXzT9zaDvfq92PiXpQ=;
        b=KkmbBC9P3sAOj6+r4RFb7g6QI2CHu00LaXTiH016CBIhiYj5JXD0+gydlcDvTKaniv
         XjKsdNAR04xWrjm98y3LfR3GSlPNj5JDixWvFn9stH5GA9T0A5F9kiPlIWBX/XWHrxVa
         pkFVf+0rsgeZpK2GFho+Q7WbV/asuT2N5jzfsbNsp0DJ08Lqfwcxw5xXBZ36h8cqVgyU
         SjRKmQH0+BsQ08iGLZw03n1zevvN9zOigsJKIkAkuaDVnEmhR4473dNkKEevJwQOFw9K
         M5mzuLsc08fSeg2LoyAQZXHqy6MqXD5YlujKiZFhHLwdq/CjqsEAbZGTiMk6sPfnCnDg
         qP6A==
X-Gm-Message-State: AC+VfDx5dypL8URtA5g1Wm+vNn6qnZuOE+ss52Rl7GF9UE3TcDE2C4vW
        UDiqcE5PiDC1aiGCIUgA75+Pwy+jGoSfJw==
X-Google-Smtp-Source: ACHHUZ7ePLuqu3tSKvz5oaQ3PDOHFNO4qCTQswBuuJslNkpOXenDmWSbdTpJWIfI7Qau9StIT4VQYh3yTh0l1g==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:c016:0:b0:ba1:ac14:7e1d with SMTP id
 c22-20020a25c016000000b00ba1ac147e1dmr8789084ybf.3.1683620570885; Tue, 09 May
 2023 01:22:50 -0700 (PDT)
Date:   Tue,  9 May 2023 08:22:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509082244.1069623-1-joychakr@google.com>
Subject: [PATCH v10 0/5] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
V1 Changes : Add support for AxSize=3D4 bytes to support 32bits/word.
---
V1->V2 Changes : Add dma capability check to make sure address widths
are supported.
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---
V3->V4 Changes : Fix Sparce Warning
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@int=
el.com/
---
V4->V5 Changes : Preserve reverse xmas Tree order, move direction
check before initalisation of further capabilities, remove zero
initialisations, remove error OR'ing.
---
V5->V6 Changes :
	-Remove case of n_bytes=3D3 using 4_bytes buswidth
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
V9->V10 Changes : Moving "return 0" at the end of dw_spi_dma_caps_init() fr=
om patch
[4/5] to patch [3/5] to solve :
spi-dw-dma.c: In function =E2=80=98dw_spi_dma_caps_init=E2=80=99:
spi-dw-dma.c:100:1: control reaches end of non-void function [-Werror=3Dret=
urn-type]
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

--=20
2.40.1.521.gf1e218fcd8-goog

