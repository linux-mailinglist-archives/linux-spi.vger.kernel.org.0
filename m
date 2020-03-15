Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27094185CBE
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgCONoa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:30 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:41785 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCONoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:30 -0400
Received: by mail-lf1-f48.google.com with SMTP id q10so11696024lfo.8;
        Sun, 15 Mar 2020 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPwwnlhMMIh0PTBQBt+zhG5jxK2/FX0CwFDla+6n4b4=;
        b=vVpM3WtxW7Bv58b/xWDrZt+W6fiYfieknedown0NoZQLRU9i0LPm98xnuAeGinSWLL
         VjKB1+JuCA2vnDN+5eP51SpF0d2wYQ9mqNN0RLZPnU8YoIRwXfx2aK/cJySN1OcC+bi6
         G0QgZsJc0apyCjhin2UW//3zsuFgSWeWFwaBdPz2y0LnIOaDQycuuqcWZdznPfd1d8Dd
         MukdpnrvaTeGZDQdvAzZMnr3hyU68a9boDw714BYYGlgbCADDV7s1gbx6TBodfyXZAUT
         92gPveIPeqI2VLPXV/TlBaG8zBRlPgvhhZueyvWsmQMQJX/m3H1PqKoawCf71tyVJm35
         VsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nPwwnlhMMIh0PTBQBt+zhG5jxK2/FX0CwFDla+6n4b4=;
        b=dJg5JhdSlT/SFhrxS/15pMOELafJiULoq0ixr6KGZTHZzFeIfhJc/dYpJCb9gyJ86L
         Aj76MgYjxJbwD+rrASwYmmTJnSu9f9Pl+Lo3cK7KydEyjwUP2tfnc+2FfgNBB2EWBTow
         hcvFahSv1SE0PwbuAgzCUYxsbVeChNt6OYGxdMkB8P4LJGuKlVaVlCAHpmYpuQ+DmxJy
         mkqGEGGkckiuJJXxzeSv4TfmDFZFSitfqMP8LFUCcbFda23bVStv77X8astgXF4cQMD3
         YwHt1D6mXW56J6y98FabZGs6mA+Jz+1Vol+nbTHebNbHhHaJ6NEl5mZ1yFHCk3K9kBmz
         cWeg==
X-Gm-Message-State: ANhLgQ3mmxEqTtAah9hWoBfihHzJEyXwsFRsuoiCaWweJiM+UWuof9WC
        fEd5zEdk0F9GUpVnscYoa88=
X-Google-Smtp-Source: ADFU+vskERbFLLvtJ+qcZQRsrtqi7/ZqSxqGLKc+m1M0Z9QTgShDf90hvnxF/8rEcbwMKp9ywC2QSw==
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr14241929lfa.0.1584279864678;
        Sun, 15 Mar 2020 06:44:24 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:23 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: [PATCH v1 0/36] dt-bindings: display: convert remaning panel bindings to DT Schema
Date:   Sun, 15 Mar 2020 14:43:40 +0100
Message-Id: <20200315134416.16527-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert remaining(*) panel bindings to DT Schema.

To prepare for the migration a few preparations
patches was required:

- te-gpios is now added to panel-common - as this
  property is used by a few bindings.

- The slave part of spi-controller.yaml was migrated to a
  new file spi-slave.yaml.
  This was done so spi slaves in panel/ could include
  this file rather than duplicate property names.
  => Please review this carefully!


The original author of the panel bindings are listed as maintainer
in the DT Schema. In the few cases the panel binding was also
listed in MAINTAINERS I checked that there was a match.
It was done manually so I may have missed someone.

All bindings pass dt_binding_check with no warnings.

- "dt-bindings: display: convert ilitek,ili9322 to DT"
  The .txt file listed some constrains that I did not manage
  to capture in the DT Schema.
  And some properties looks like that could be dropped.
  => Please take a closer look.

- "dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema"  
  The .txt file describes some constrains, as some properties
  are mandatory for the main challen, but not allowed
  for the secondary channel.
  These constraints are not matched in the DT Schema.
  => Any hints how to do this would be appreciated.


Patches made on top of drm-misc-next as of today with no other patches.

(*) Two .txt files reamins:
- display-timing.txt, points to display-timings.yaml
- panel-dsi-cm.txt, conversion is included in another patch-set

	Sam

Sam Ravnborg (36):
      dt-bindings: display: add te-gpios to panel-common
      dt-bindings: spi: support non-spi bindings as SPI slaves
      dt-bindings: display: convert samsung,s6e63m0 to DT Schema
      dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
      dt-bindings: display: convert boe,himax8279d to DT Schema
      dt-bindings: display: convert ilitek,ili9322 to DT Schema
      dt-bindings: display: convert ilitek,ili9881c to DT Schema
      dt-bindings: display: convert feiyang,fy07024di26a30d to DT Schema
      dt-bindings: display: convert innolux,p079zca to DT Schema
      dt-bindings: display: convert innolux,p097pfg to DT Schema
      dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
      dt-bindings: display: convert jdi,lt070me05000 to DT Schema
      dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
      dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
      dt-bindings: display: convert simple lg panels to DT Schema
      dt-bindings: display: convert lg,lg4573 to DT Schema
      dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Schema
      dt-bindings: display: convert raydium,rm67191 to DT Schema
      dt-bindings: display: convert rocktech,jh057n00900 to DT Schema
      dt-bindings: display: convert samsung AMOLED to DT Schema
      dt-bindings: display: convert samsung,s6d16d0 to DT Schema
      dt-bindings: display: convert samsung,ld9040 to DT Schema
      dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
      dt-bindings: display: convert toppoly panels to DT Schema
      dt-bindings: display: convert startek,startek-kd050c to DT Schema
      dt-bindings: display: convert sony,acx565akm to DT Schema
      dt-bindings: display: convert sitronix,st7701 to DT Schema
      dt-bindings: display: convert sitronix,st7789v to DT Schema
      dt-bindings: display: drop unused simple-panel.txt
      dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
      dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema
      dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
      dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
      dt-bindings: display: convert seiko,43wvf1g to DT Schema
      dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
      dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema

 .../display/panel/arm,versatile-tft-panel.txt      |  31 -------
 .../display/panel/arm,versatile-tft-panel.yaml     |  51 +++++++++++
 .../bindings/display/panel/boe,himax8279d.txt      |  24 -----
 .../bindings/display/panel/boe,himax8279d.yaml     |  59 ++++++++++++
 .../display/panel/feiyang,fy07024di26a30d.txt      |  20 -----
 .../display/panel/feiyang,fy07024di26a30d.yaml     |  56 ++++++++++++
 .../bindings/display/panel/ilitek,ili9322.txt      |  49 ----------
 .../bindings/display/panel/ilitek,ili9322.yaml     |  90 +++++++++++++++++++
 .../bindings/display/panel/ilitek,ili9881c.txt     |  20 -----
 .../bindings/display/panel/ilitek,ili9881c.yaml    |  50 +++++++++++
 .../bindings/display/panel/innolux,p079zca.txt     |  22 -----
 .../bindings/display/panel/innolux,p097pfg.txt     |  24 -----
 .../bindings/display/panel/innolux,p097pfg.yaml    |  56 ++++++++++++
 .../bindings/display/panel/innolux,p120zdg-bf1.txt |  22 -----
 .../display/panel/innolux,p120zdg-bf1.yaml         |  43 +++++++++
 .../bindings/display/panel/jdi,lt070me05000.txt    |  31 -------
 .../bindings/display/panel/jdi,lt070me05000.yaml   |  69 ++++++++++++++
 .../display/panel/kingdisplay,kd035g6-54nt.txt     |  42 ---------
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |  60 +++++++++++++
 .../display/panel/kingdisplay,kd097d04.txt         |  22 -----
 .../bindings/display/panel/lg,acx467akm-7.txt      |   7 --
 .../bindings/display/panel/lg,ld070wx3-sl01.txt    |   7 --
 .../bindings/display/panel/lg,lg4573.txt           |  19 ----
 .../bindings/display/panel/lg,lg4573.yaml          |  41 +++++++++
 .../bindings/display/panel/lg,lh500wx1-sd03.txt    |   7 --
 .../bindings/display/panel/lgphilips,lb035q02.txt  |  33 -------
 .../bindings/display/panel/lgphilips,lb035q02.yaml |  54 +++++++++++
 .../display/panel/olimex,lcd-olinuxino.txt         |  42 ---------
 .../display/panel/olimex,lcd-olinuxino.yaml        |  70 +++++++++++++++
 .../display/panel/osddisplays,osd101t2587-53ts.txt |  14 ---
 .../bindings/display/panel/panel-common.yaml       |   7 ++
 .../bindings/display/panel/panel-simple-dsi.yaml   |   2 +
 .../bindings/display/panel/panel-simple.yaml       |  10 +++
 .../bindings/display/panel/raydium,rm67191.txt     |  41 ---------
 .../bindings/display/panel/raydium,rm67191.yaml    |  75 ++++++++++++++++
 .../display/panel/rocktech,jh057n00900.txt         |  23 -----
 .../display/panel/rocktech,jh057n00900.yaml        |  57 ++++++++++++
 .../display/panel/samsung,amoled-mipi-dsi.yaml     |  65 ++++++++++++++
 .../bindings/display/panel/samsung,ld9040.txt      |  66 --------------
 .../bindings/display/panel/samsung,ld9040.yaml     | 100 +++++++++++++++++++++
 .../bindings/display/panel/samsung,s6d16d0.txt     |  30 -------
 .../bindings/display/panel/samsung,s6d16d0.yaml    |  56 ++++++++++++
 .../bindings/display/panel/samsung,s6e3ha2.txt     |  31 -------
 .../bindings/display/panel/samsung,s6e63j0x03.txt  |  24 -----
 .../bindings/display/panel/samsung,s6e63m0.txt     |  33 -------
 .../bindings/display/panel/samsung,s6e63m0.yaml    |  58 ++++++++++++
 .../bindings/display/panel/samsung,s6e8aa0.txt     |  56 ------------
 .../bindings/display/panel/samsung,s6e8aa0.yaml    |  96 ++++++++++++++++++++
 .../bindings/display/panel/seiko,43wvf1g.txt       |  23 -----
 .../bindings/display/panel/seiko,43wvf1g.yaml      |  49 ++++++++++
 .../bindings/display/panel/sharp,lq101r1sx01.txt   |  49 ----------
 .../bindings/display/panel/sharp,lq101r1sx01.yaml  |  78 ++++++++++++++++
 .../bindings/display/panel/sharp,lq150x1lg11.txt   |  36 --------
 .../bindings/display/panel/sharp,lq150x1lg11.yaml  |  58 ++++++++++++
 .../bindings/display/panel/sharp,ls037v7dw01.txt   |  43 ---------
 .../bindings/display/panel/sharp,ls037v7dw01.yaml  |  66 ++++++++++++++
 .../bindings/display/panel/sharp,ls043t1le01.txt   |  22 -----
 .../bindings/display/panel/sharp,ls043t1le01.yaml  |  51 +++++++++++
 .../bindings/display/panel/simple-panel.txt        |   1 -
 .../bindings/display/panel/sitronix,st7701.txt     |  30 -------
 .../bindings/display/panel/sitronix,st7701.yaml    |  68 ++++++++++++++
 .../bindings/display/panel/sitronix,st7789v.txt    |  37 --------
 .../bindings/display/panel/sitronix,st7789v.yaml   |  58 ++++++++++++
 .../bindings/display/panel/sony,acx565akm.txt      |  30 -------
 .../bindings/display/panel/sony,acx565akm.yaml     |  53 +++++++++++
 .../display/panel/startek,startek-kd050c.txt       |   4 -
 .../display/panel/startek,startek-kd050c.yaml      |  33 +++++++
 .../devicetree/bindings/display/panel/tpo,td.yaml  |  60 +++++++++++++
 .../bindings/display/panel/tpo,td028ttec1.txt      |  32 -------
 .../bindings/display/panel/tpo,td043mtea1.txt      |  33 -------
 .../devicetree/bindings/spi/spi-controller.yaml    |  63 +------------
 .../devicetree/bindings/spi/spi-slave.yaml         |  83 +++++++++++++++++
 72 files changed, 1885 insertions(+), 1140 deletions(-)


