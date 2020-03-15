Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6C185CC2
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgCONof (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33613 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgCONof (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so15622071ljp.0;
        Sun, 15 Mar 2020 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X45tw5KJlXhhJ3R6ynp7V7JRLgh1AOjgAQ5sYiJA7gQ=;
        b=Oqq5zZmQwYobC/AnUgTbv+2yNqZC1ysfOc2s7Dq7jJeMNanIhWjon9tWa5pfztJ6Oy
         Pej2RybnxI+89G9uHBa5IkXk6CoAIE/puDgRbN4dc3gybEtjgASgzlhLXnxUkEg0N53g
         jQkIaV4mdCElNhUzuuB1FR8JWCm8miXnIcYViF/mUf+gziC95xg6kXReV9Lx4NYnRMs5
         A6OfsMYAdo36YXPL913Pb/T2v3A1vCVSEDCufLgZM8jA9Lj0wSarOW5f4eT8/GmzkkJ4
         I81/N2rLrQxHi7Ren4MnSl5o1/9CHex0yrqCyUS74kwQsglYxMu2soNbKK/M2VHfol5A
         P5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X45tw5KJlXhhJ3R6ynp7V7JRLgh1AOjgAQ5sYiJA7gQ=;
        b=n21JYe9qLqKc57O0DKIWoqIbfmnD5ZVVsumZkpSuUnrMIfWll/tJ4NyhExECW3CuPJ
         J6KhsBmgz2BnfjSxK2fAHCR4RujOwFaZkUW2kBvwZR4Q0V4YXV3Eh+fnUU/mIZeVFM+0
         I6eJ3powKB/0xAi6iJqzUGlugmmn7VswoS+z2ZdpW/h6UVmeBxBXyd6Q1pD7rIG89Cei
         J04wDugByqaO/PJAMwHZ/j1mb6SyDhxWj1nABInCWmYebqVqtcJP6e2J5d1jAbXC1I+m
         FMC8oJdWB+iDpdEibzXeKiWZ6dR768PKRnsr8INuMSOXIucHpQGpiPRqkQyLffU6mGkc
         cRbA==
X-Gm-Message-State: ANhLgQ2jTvM16DpLkmAPnM2xDUnXw9JqBOzSwsMpAdqadvF5dsXLef+T
        HqWvaOlN49X12Ix70wVymtk=
X-Google-Smtp-Source: ADFU+vvKezVrr5pKhPKFDDiDBtGVr/h70AHssvhC8VNZHgZJoJYzPcWqdWCvDfcTSWr33npk2S7GtA==
X-Received: by 2002:a2e:3002:: with SMTP id w2mr10976729ljw.82.1584279872839;
        Sun, 15 Mar 2020 06:44:32 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:32 -0700 (PDT)
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
Subject: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as SPI slaves
Date:   Sun, 15 Mar 2020 14:43:42 +0100
Message-Id: <20200315134416.16527-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Independent bindings can be SPI slaves which for example is
the case for several panel bindings.

Move SPI slave properties to spi-slave.yaml so the independent
SPI slave bindings can include spi-slave.yaml rather than
duplicating the properties.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 .../bindings/spi/spi-controller.yaml          | 63 +-------------
 .../devicetree/bindings/spi/spi-slave.yaml    | 83 +++++++++++++++++++
 2 files changed, 86 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64b..99531c8d10dd 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -67,71 +67,14 @@ patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
 
+    allOf:
+      - $ref: spi-slave.yaml#
+
     properties:
       compatible:
         description:
           Compatible of the SPI device.
 
-      reg:
-        minimum: 0
-        maximum: 256
-        description:
-          Chip select used by the device.
-
-      spi-3wire:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires 3-wire mode.
-
-      spi-cpha:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires shifted clock phase (CPHA) mode.
-
-      spi-cpol:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires inverse clock polarity (CPOL) mode.
-
-      spi-cs-high:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires the chip select active high.
-
-      spi-lsb-first:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires the LSB first mode.
-
-      spi-max-frequency:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Maximum SPI clocking speed of the device in Hz.
-
-      spi-rx-bus-width:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4, 8 ]
-          - default: 1
-        description:
-          Bus width to the SPI bus used for MISO.
-
-      spi-rx-delay-us:
-        description:
-          Delay, in microseconds, after a read transfer.
-
-      spi-tx-bus-width:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4, 8 ]
-          - default: 1
-        description:
-          Bus width to the SPI bus used for MOSI.
-
-      spi-tx-delay-us:
-        description:
-          Delay, in microseconds, after a write transfer.
-
     required:
       - compatible
       - reg
diff --git a/Documentation/devicetree/bindings/spi/spi-slave.yaml b/Documentation/devicetree/bindings/spi/spi-slave.yaml
new file mode 100644
index 000000000000..fa50d9dfab41
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-slave.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI slave generic binding
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+description: |
+  This document defines device tree properties common to SPI slaves.
+  It doesn't constitue a device tree binding specification by
+  itself but is meant to be referenced by device tree bindings.
+
+  When referenced from device tree bindings the properties defined in this
+  document are defined as follows. The device tree bindings are responsible
+  for defining whether each property is required or optional.
+
+properties:
+
+  reg:
+    minimum: 0
+    maximum: 256
+    description:
+      Chip select used by the device.
+
+  spi-3wire:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires 3-wire mode.
+
+  spi-cpha:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires shifted clock phase (CPHA) mode.
+
+  spi-cpol:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires inverse clock polarity (CPOL) mode.
+
+  spi-cs-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires the chip select active high.
+
+  spi-lsb-first:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires the LSB first mode.
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clocking speed of the device in Hz.
+
+  spi-rx-bus-width:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 1, 2, 4, 8 ]
+      - default: 1
+    description:
+      Bus width to the SPI bus used for MISO.
+
+  spi-rx-delay-us:
+    description:
+      Delay, in microseconds, after a read transfer.
+
+  spi-tx-bus-width:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 1, 2, 4, 8 ]
+      - default: 1
+    description:
+      Bus width to the SPI bus used for MOSI.
+
+  spi-tx-delay-us:
+    description:
+      Delay, in microseconds, after a write transfer.
+
+...
-- 
2.20.1

