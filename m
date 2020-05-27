Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDCF1E3A55
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE0H1l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgE0H1l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:27:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450AC061A0F;
        Wed, 27 May 2020 00:27:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c75so11386662pga.3;
        Wed, 27 May 2020 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/pnqpOF5kxfkVhRDe0RiihBA49v54di4gIOur7X7TI=;
        b=LLxklYnNzudxPlgcrT/fJNH2MPem+uGxJgHfy7oOISPLHa6ikpirtHb4EbdRGht7SY
         WvJUMfY8ftB39R8dNXZmU0Tsi2+8gVyzbQCdw8JVrCCtOYOTkA4VPmul/BxC4cxSn7b2
         pJcm00a/TAQ3Hkvjqm+ckwrHB8AcyPl9jNbg/EnnpbvIKqDkgcQMjJZnehn3ZjSV+LbB
         YopiG1L1bRkwjA1To3JPFquX6uVMApyoXGMGTYtvF5qp8ill3bfFy8od9hHGwd+ADjFS
         C4AH+ZC+zqbKPpKFcdUQ4GzSfrAoHBsQ5Drwozv/8sGHx5h3hzJvvdBCpRm14Hg22v5Q
         a5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/pnqpOF5kxfkVhRDe0RiihBA49v54di4gIOur7X7TI=;
        b=ltujOWTqbkJ7aXCuOVgK85f1s86baCew6Yxyjx2tmJCKanpIObHvMaA6YX9rVclbp/
         G67Uekb3uXqtp+7sSEDHKZ9t71y3i21YrV2Ki/BPUMrWWBY4D/5KVlOaqmo5u2FwdpvB
         nTzPwDTR/bLDEmnqUVPlutnRM6CLhnoKzMt/cr4Ug1BIwXidFK7poUS030DGAwKHuRqZ
         mnmW3opoaDvHmgerxa4xQGS/Pte9mq3oQFER8ZkXYUDplrJW2akBRNtnamywJ1a0tS3h
         W9AG4ynFvRPXzqN6Jry/p7qYN8qt1/acl5h1q0kg4fxSO0sfdiOR3+m/0Ptz+5ZwJeoW
         Gheg==
X-Gm-Message-State: AOAM531bwlbnxzrzTrWaXdYEHAJbOI0yxYLkEKxjnCZcf51EqYbSOAWt
        jOe99hWulse+3RBnjIjlg6Q=
X-Google-Smtp-Source: ABdhPJxTLPr+jP/ArwpWxHxmn/pRT0kb8dD0HedLtdqVNcsMKzf6roH/kNinnVypb58H7dXiI1M8vg==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr2859284pgj.325.1590564460640;
        Wed, 27 May 2020 00:27:40 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:27:40 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 0/9] Enable ili9341 and l3gd20 on stm32f429-disco
Date:   Wed, 27 May 2020 15:27:24 +0800
Message-Id: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

V6:
1 separate '[PATCH v5 5/8]' patchs to two, each one has a Fixes tags according
  to Stephen Boyd's suggestion
2 fix panel-ilitek-ili9341 compile warning 'warning: Function parameter or
  member xxx not described in xxx' with W=1

V5's update based on Mark Brown's suggestion, use 'SPI_MASTER_MUST_RX'
for SPI_SIMPLEX_RX mode on stm32 spi controller.

V5:
1 instead of add send dummy data out under SIMPLEX_RX mode,
  add flags 'SPI_CONTROLLER_MUST_TX' for stm32 spi driver
2 bypass 'SPI_CONTROLLER_MUST_TX' and 'SPI_CONTROLLER_MUST_RX' under
  'SPI_3WIRE' mode

V4:
  According to alexandre torgue's suggestion, combine ili9341 and
  l3gd20's modification on stm32f429-disco board to one patchset.

Changes:

ili9341:

1 update ili9341 panel driver according to Linus's suggestion
2 drop V1's No.5 patch, sumbit new changes for clk-stm32f4
3 merge l3gd20's change to this patchset

V3:
1 merge original tiny/ili9341.c driver to panel/panel-ilitek-ili9341.c
  to support serial spi & parallel rgb interface in one driver.
2 update ilitek,ili9341.yaml dts binding documentation.
3 update stm32f429-disco dts binding

V2:
1 verify ilitek,ili9341.yaml with make O=../linux-stm32
  dt_binding_check
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/
  ilitek,ili9341.yaml

V1:
1 add ili9341 drm panel driver
2 add ltdc, spi5 controller for stm32f429-disco
3 add ltdc, spi5 pin map for stm32f429-disco
4 add docs about ili9341
5 fix ltdc driver loading hang in clk set rate bug


L3gd20:

V3:
1 merge stm32f429-disco dtbs binding with ili9341 part

V2:
1 insert blank line at stm32f420-disco.dts line 143
2 add more description for l3gd20 in commit message

V1:
1 enable spi5 controller on stm32f429-disco (dts)
2 add spi5 pinmap for stm32f429-disco  (dts)
3 add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4


dillon min (9):
  ARM: dts: stm32: Add dma config for spi5
  ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
  ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on    
    stm32429-disco board
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate
  clk: stm32: Fix ltdc's clock turn off by clk_disable_unused() after
    kernel     startup
  drm/panel: Add ilitek ili9341 panel driver
  spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
  spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't
    be     coexit with 'SPI_3WIRE' mode

 .../bindings/display/panel/ilitek,ili9341.yaml     |   69 ++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   67 +
 arch/arm/boot/dts/stm32f429-disco.dts              |   48 +
 arch/arm/boot/dts/stm32f429.dtsi                   |    3 +
 drivers/clk/clk-stm32f4.c                          |    7 +-
 drivers/gpu/drm/panel/Kconfig                      |   12 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 1288 ++++++++++++++++++++
 drivers/spi/spi-stm32.c                            |   19 +-
 drivers/spi/spi.c                                  |    3 +-
 10 files changed, 1508 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

