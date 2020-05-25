Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209AE1E057C
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgEYDpz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgEYDpz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:45:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1698C061A0E;
        Sun, 24 May 2020 20:45:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so8275129pfy.8;
        Sun, 24 May 2020 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V6bHngqzBjjcimyp4HxH/p2UMJo9dJvIc8PwFZSC+CA=;
        b=ujh4cQjvO9LqYulZCLFG/EhC/ysEt3VzB4Cfqrtib0Uv000szrhWNJVAQqhnWwLmQj
         KyI/c1CpyMwKTvIOtzl+DIOxWEqwg1/Ejr1NB2PDWObgdVWnJUKbfXYkj13FVI/OMInD
         VjqW6yrac0hU+ZU6/6hqJLmGIbhEWTSxw8BFl+fksItTEg5jj2ijP9jOzYsgoG1v4d/k
         UTpiVWLknc7v1Iyv2+wPDEa8Wi45AqiSaGZq52tE6dzgVdBFXYZ1BDH8VNbabbRflu6k
         Z6Z7tQhYNL6SQS8PNFc/dVzmOzXvKO7ZaT4fraahv9czQoiNLNo+DODNQR2WolvAWSGw
         Mz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V6bHngqzBjjcimyp4HxH/p2UMJo9dJvIc8PwFZSC+CA=;
        b=ZfqDUDmD8djfHO3Mth4WsAIRyMs8Wjvg8c2MOsUjYrGBkd415oWd2lH4QH4bwj4EKe
         mgU6Cw9mAkOWgyW5+S10jScmm9eZwv7RQrmzH8rw4a0GVuIGXJI6aIOfw/8JknSZtgiC
         nQlR6TAWYSFgLq4PTP/8WKSTMMG0HIMs/nO79DNChpeP4VTvTwNw97nf7Key9qPrvolR
         1qdJeXBvJ1oCBewnGjAz9cN13GfpaMqOEfp/tkul/EFoDYSZX4QwZvrdKFex7SM8NSRi
         SC33lSiJNHnbGSwUnvs4YHnSFIdkXSLcQgbLqKEnkWE2WYh6tRaDcy6HOUnU8UdmgqAt
         oV+A==
X-Gm-Message-State: AOAM531MmFQIuggKvcapA+Hp1XENYCgm0XmigxxOJ8yJ/bR3uybaNhlQ
        YOmw83FAs9xrD/oNi+MnpKQ=
X-Google-Smtp-Source: ABdhPJzHOdNvEM+GtCSQLN0Rj3/3dq/dcwOzljG2N6BH2aAoIYChewg0WdqeD9k9WKyv/7C29tuJrg==
X-Received: by 2002:a63:1a13:: with SMTP id a19mr24649723pga.350.1590378353414;
        Sun, 24 May 2020 20:45:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:45:52 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 0/8] Enable ili9341 and l3gd20 on stm32f429-disco
Date:   Mon, 25 May 2020 11:45:40 +0800
Message-Id: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

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


dillon min (8):
  ARM: dts: stm32: Add dma config for spi5
  ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
  ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on    
    stm32429-disco board
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate,    
    fix duplicated ltdc clock register to 'clk_core' case ltdc's clock  
      turn off by clk_disable_unused()
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
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 1301 ++++++++++++++++++++
 drivers/spi/spi-stm32.c                            |   19 +-
 drivers/spi/spi.c                                  |    3 +-
 10 files changed, 1521 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

