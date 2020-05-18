Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A281D7606
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERLJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLJd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:09:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ED2C061A0C;
        Mon, 18 May 2020 04:09:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q24so4883749pjd.1;
        Mon, 18 May 2020 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3zI5HGtvH1cCa06adBLKkRdZTB7qi9iI++h4rVGXoVQ=;
        b=HJY3neypi3+TIsjpyuiDC8hy4/upfiEWcq40/l0Lp9xQGeWVb0iYXXUoiV32a0UfOx
         lu5BLDGjNCw2X/o1YuMG4LS/EfeA2LOjChMyzJnIU0Hfrc4LNCibrT8JnOzEw43O+rVW
         StEU40F1Uk5X9eHlZec6AFvK4eBTxzH7PzPqPJEHpvrLOkKazHs49FgrO8SxREjbBEOp
         YqXWF7Ys0rR4twTJqIsEddUR3FiPqAxHk1P+Kxigo2oMm7v7/0OtHxaRUTpN3GFz2HzB
         lIwoNbmDFav/7RevcdwGKQ2mbFRtM8pn6AARVoPJAXb3pud0ltZ2LVv1mShqbzv8IwFo
         DaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3zI5HGtvH1cCa06adBLKkRdZTB7qi9iI++h4rVGXoVQ=;
        b=q4VYTIu/NtNcUMEoprKYviBcYWPWomWyf1WOxz4iQok0NvEKEFh3ymAmA+FBVdBXrI
         KXv9x1WZrRWcf2L6aVA6Sd79QsFR2WsaMZdG0J8JqFqg5vmOI9hodrbO1e7xLMdh3OCc
         rmHE+xfG0q1Sp4Wdga+rD/DX7UYnqQXEs/wmP+Yw424XEDcB1G2F0yqjPOjt9rgi8cW0
         L29qPxujbm60hLdawPMV0yIlq1E07aqvTKvr4ovj1C9bmqn3lSK5T5ycaQmPA1ZY8tmg
         6m6/H8Zqv4qCSmlqt61+j6UDWljp3qpk5pRv0iMBLs3/7m9cvasAo4L1KZGJ9fQSLlWt
         iCYw==
X-Gm-Message-State: AOAM5318gXvN/3w1qE+3tX82Id4iVdrMLxjML5pd+234/L0ACb/rrv30
        9RilxlJUDGErAR8jFaQ076s=
X-Google-Smtp-Source: ABdhPJwsakR+sWqcKZA6S7nkXZrnKWW5pNyRPRmYvzj0mHY2ZT391adIsBf9mDJWpeyUO1sOeAJMOw==
X-Received: by 2002:a17:902:cb09:: with SMTP id c9mr4315966ply.95.1589800172767;
        Mon, 18 May 2020 04:09:32 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:09:32 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 0/8] Enable ili9341 and l3gd20 on stm32f429-disco
Date:   Mon, 18 May 2020 19:09:17 +0800
Message-Id: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

According to alexandre torgue's suggestion, combine ili9341 and
l3gd20's modification on stm32f429-disco board to one patchset.

Changes:

ili9341:

V4:
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
1, merge stm32f429-disco dtbs binding with ili9341 part

V2:
1, insert blank line at stm32f420-disco.dts line 143
2, add more description for l3gd20 in commit message

V1:
1, enable spi5 controller on stm32f429-disco (dts)
2, add spi5 pinmap for stm32f429-disco  (dts)
3, add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4

dillon min (8):
  ARM: dts: stm32: Add dma config for spi5
  ARM: dts: stm32: enable l3gd20 on stm32429-disco board
  spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
  ARM: dts: stm32: Add pin map for ltdc on stm32f429-disco board
  dt-bindings: display: panel: Add ilitek ili9341 panel bindings
  ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco
    board
  clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate.
  drm/panel: Add ilitek ili9341 panel driver

 .../bindings/display/panel/ilitek,ili9341.yaml     |   69 ++
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   67 +
 arch/arm/boot/dts/stm32f429-disco.dts              |   48 +
 arch/arm/boot/dts/stm32f429.dtsi                   |    3 +
 drivers/clk/clk-stm32f4.c                          |    7 +-
 drivers/gpu/drm/panel/Kconfig                      |   12 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 1301 ++++++++++++++++++++
 drivers/spi/spi-stm32.c                            |   30 +-
 9 files changed, 1530 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

-- 
2.7.4

