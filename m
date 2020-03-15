Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA73185D07
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgCONpW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45358 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCONpW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id b13so11701722lfb.12;
        Sun, 15 Mar 2020 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLNfyRlmaYQ3/Tah2cpzN27telonR8g89G9XuIdJiRY=;
        b=CwLZsI5V+/tWZaCIqyvhB2rMVWfYqvhbJbU51g16X5DRfUvt4JNVbm6UH0ZICJDzSc
         v1p671MHR5UtUzPn3UMdqiAAHsr35BikS8qmyQmXxDVifFVSF8CXvk2MWYSCXMsVFGhE
         N1vjzG3Bszvh7UrWOM6I9QvkUMGIJq44jS9viZmhBkt99IiHJnkMOkw9xXdk/7oJNovn
         hF4IX3As5FIYlx6psGT9vyrvwIEEzlqaIi4tg5LNz9G9VHhTufg7f2pdiBz56Y5uQpYG
         dtn87nGGFu5xwWlmp4UUQCjfp6iB2rvGqfnwn5O7LtRTzOVmgqlVqsYxSV9mUDMZRY3R
         NBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VLNfyRlmaYQ3/Tah2cpzN27telonR8g89G9XuIdJiRY=;
        b=e1q9MkDFkReRKa52flSjm/gXVpGgd4hMxlXhn2YhwAXtEW6kVCirxWORgMCkjKoJ3R
         iwqOVRe2tx6zqexeI8RNzNb8bv5m6WS+yBz75PD4haZvyMWU+aq7IGJogFyvo9eBLeVy
         SkZ6WPhrThek6R7lfsCPrv2LlztCm2u5Mwdq+zSW6ZrJ51wHoksHYHS5Bp8NNgtDAIjU
         S/smzjHsoZw9Qcx9Qws4gEVds8wqtbrjcRYOJl67q5YvvgT4VIOVDu861BR7/QxAJMOk
         hVSoRqxKHDv8J01/tICtm5uYLuWm1Krs8tvFfFIRIWdvRZaZUrFOVOMowQZfkuZ5cc6p
         cfQQ==
X-Gm-Message-State: ANhLgQ0O9MVCNfIQyHA8rWWOUoTKcmKMiCzvtDjkJVDE5x6RMqIl0puC
        e4CvoJZdnyyHsKfOntg7tAs=
X-Google-Smtp-Source: ADFU+vvHd3dqdQPhoUbbx/LB8y1V8lfjkv/qzbJjy6O+eaWkY6R8Mah3BL7Aqm9us/62AsJajCnVEw==
X-Received: by 2002:a19:6144:: with SMTP id m4mr13722652lfk.192.1584279920519;
        Sun, 15 Mar 2020 06:45:20 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:20 -0700 (PDT)
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
Subject: [PATCH v1 25/36] dt-bindings: display: convert startek,startek-kd050c to DT Schema
Date:   Sun, 15 Mar 2020 14:44:05 +0100
Message-Id: <20200315134416.16527-26-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Marek Belisko <marek@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/startek,startek-kd050c.txt  |  4 ---
 .../display/panel/startek,startek-kd050c.yaml | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
deleted file mode 100644
index 70cd8d18d841..000000000000
--- a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-Startek Electronic Technology Co. KD050C 5.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "startek,startek-kd050c"
diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
new file mode 100644
index 000000000000..fd668640afd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/startek,startek-kd050c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Startek Electronic Technology Co. KD050C 5.0" WVGA TFT LCD panel
+
+maintainers:
+  - Nikita Kiryanov <nikita@compulab.co.il>
+
+allOf:
+  - $ref: panel-dpi.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: startek,startek-kd050c
+      - {} # panel-dpi, but not listed here to avoid false select
+
+  backlight: true
+  enable-gpios: true
+  height-mm: true
+  label: true
+  panel-timing: true
+  port: true
+  power-supply: true
+  reset-gpios: true
+  width-mm: true
+
+additionalProperties: false
+
+...
-- 
2.20.1

