Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089CB185CE7
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgCONpA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33642 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so15622795ljp.0;
        Sun, 15 Mar 2020 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaICPVhWGMzYWehtRVbV/jO9Up7YjJ7XLHT6tmeYB5E=;
        b=ZibC4+UNeg34TbeI3ckGQczgn386Wu/l22ZpAODVcHe97It6VtfBqDTxm9uSyl+BHi
         I5tn/NFGl7HJch+m5eUoaDpspYTPwNi6MdPdoGihz4s55YeyepzrkpjT937R9vxg1bQ5
         vu7sTooKxHv/mJIQ1d5m1uLOCfZtRtq8qSAhNGo2e9pCU2TvsB3IQMju3ozIjdP21PpO
         l/HYXypAtNp6nAHWMkrKndi4YT2Rs/6lk4xSJh047DXuoIvtAV7ty2xsFGsuw/YkbMu6
         SCStaJXWS/xOq75AvYwPMzxTAThl8wP2u9bXtUxSc/huAdJAoLf51x0cTidgbeTzdRYV
         FaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DaICPVhWGMzYWehtRVbV/jO9Up7YjJ7XLHT6tmeYB5E=;
        b=mmO7eyoxDTK3rwW05IbW9L+48eOKnX5KZx0piLKLPRRMHe943tASPhgDjWmhxW7AOm
         0cwyguyENE4p++FObiKu9C+lTQIyiF/JQ98mgLpdZ7S7L2zGYsGIuGE10khtGnkOI45/
         OPcUvH3PcOrf3lby4oTW4+Q7gNoyYuzPLU37IQYrUJXN3G0V8nILO0NQoewKpa0HjCgr
         1sunQQPwBv4+2nd/13p2wKXI9tUCvBgnuPG3hOGB65KWSRELI/I3K3Fh9lyb1/Hml+lU
         jBhatv1emo+lKnI3ebr+tEB8f3wK7Ir+RmkjCY5Db07u9fkW/prQR7NllPB6h3U5oULH
         lHUw==
X-Gm-Message-State: ANhLgQ2JztxzZEHLWQH7w2M2VubqfAreD7RkJFFXIuM8CYLZqDxC5YGL
        jegN5iH9HAtRZkUz8LjMivo=
X-Google-Smtp-Source: ADFU+vtiYR/8jOKEOpXLo77qW2MSVX/PdJNmFiXhUMdYwaEx+J8Z4srFOMItI4TWNSXjVwVgstJAug==
X-Received: by 2002:a2e:b5a5:: with SMTP id f5mr13517595ljn.162.1584279898083;
        Sun, 15 Mar 2020 06:44:58 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:57 -0700 (PDT)
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
Subject: [PATCH v1 14/36] dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
Date:   Sun, 15 Mar 2020 14:43:54 +0100
Message-Id: <20200315134416.16527-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

kingdisplay,kd097d04 matches the panel-simple-dsi binding.
The only difference is that enable-gpios is now an optional
property.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Nickey Yang <nickey.yang@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/kingdisplay,kd097d04.txt    | 22 -------------------
 .../display/panel/panel-simple-dsi.yaml       |  2 ++
 2 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
deleted file mode 100644
index cfefff688614..000000000000
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
-
-Required properties:
-- compatible: should be "kingdisplay,kd097d04"
-- reg: DSI virtual channel of the peripheral
-- power-supply: phandle of the regulator that provides the supply voltage
-- enable-gpios: panel enable gpio
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Example:
-
-	&mipi_dsi {
-		panel@0 {
-			compatible = "kingdisplay,kd097d04";
-			reg = <0>;
-			power-supply = <...>;
-			backlight = <&backlight>;
-			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index b2e8742fd6af..949371db0a16 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -29,6 +29,8 @@ properties:
       # compatible must be listed in alphabetical order, ordered by compatible.
       # The description in the comment is mandatory for each compatible.
 
+        # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
+      - kingdisplay,kd097d04
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
 
-- 
2.20.1

