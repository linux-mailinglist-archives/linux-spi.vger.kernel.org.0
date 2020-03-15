Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7177185CD8
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgCONou (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36188 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgCONou (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so11708064lfd.3;
        Sun, 15 Mar 2020 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmqWqwwj9+Xd7JsaiFF8KfpTIci7pCIkgyUayONmZn8=;
        b=fYhyZxUYQQ4A31HUuS/1vlTKGroCvMGAaME+rIRviZhTzcS1G9swkC/Oi6BHB/TI0B
         FKdFZ3ly/tUmoq+rbdyse9zm8zvRtWD+7kQ9rfqVCaczOIVl1M+eUArrMnF6YeBDteuj
         Lt4v6PuR1tYDi5hOfi27m+4Jr9YFAyhNdSYn0MxFg3vgXlw5GjG5oYefwvKc4zsfEXm2
         Biy3pNzfHO/kph+2Mp1NsVC+8R0HcEz7fJ+EoZNFIvnmtgQfgO/DYDrDWlTk7Dhlm4OR
         ZBI04cMncsOyAMc2tXQTJrSNgzL/9uXPJozsC/Drc3WSl5Q5qlAvu9gLTBoyc7w48aY5
         KhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zmqWqwwj9+Xd7JsaiFF8KfpTIci7pCIkgyUayONmZn8=;
        b=hb8RlNpTkjpYNOVa+TBT0XK6mNeURMDQYHaubhkQpVQmrdj4yTV8RIaf8JsJu5HHEr
         kjZblgFc0YvhTHi4UPcwAgOpxyhg5YwMdkiCPcckzUCSiUFr8hXQ4eOH93RgzFbhX4WH
         0Uru/vVI4nGRPXy08p+tClr1PmQy/YlQdrryAPEi6aBjTq5uoJHgtnu13rtyl0l1i5oJ
         6tCh8o+ccVve9Mv4Swfl8oU/rlx8diC8BTJ6MrYSP6xTSOOhN4VeP9V4aCSvG/gFxeaK
         fdsKGrrpuhUbbKsgWij8ZNNalF/3wKgc/JPMcgK73Q6Kjo4mrHnODtnHMfWcg/dgTgo3
         ZYhA==
X-Gm-Message-State: ANhLgQ0jLmeCzrU/bxJhj55eNCe4wJkFzcQzOoYB/4z0nqCuiT1HBe2Y
        qsi7uKrDja42CWkhF3xlRb0=
X-Google-Smtp-Source: ADFU+vu8mDyzwYKm+GWNx575bjhBRZT6xdr6t6LXfxJ16I5/GZF3rwPg85UQQpBvN2KubxQa5A2lXQ==
X-Received: by 2002:a19:6e0f:: with SMTP id j15mr13943660lfc.76.1584279887761;
        Sun, 15 Mar 2020 06:44:47 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:47 -0700 (PDT)
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
Subject: [PATCH v1 09/36] dt-bindings: display: convert innolux,p079zca to DT Schema
Date:   Sun, 15 Mar 2020 14:43:49 +0100
Message-Id: <20200315134416.16527-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As the binding matches panel-simple, added the compatible to the
panel-simple list.
With this change enable-gpios is now optional.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/innolux,p079zca.txt         | 22 -------------------
 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 2 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
deleted file mode 100644
index 3ab8c7412cf6..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
-
-Required properties:
-- compatible: should be "innolux,p079zca"
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
-			compatible = "innolux,p079zca";
-			reg = <0>;
-			power-supply = <...>;
-			backlight = <&backlight>;
-			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 393ffc6acbba..5088fe81d025 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -143,6 +143,8 @@ properties:
       - innolux,n116bge
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
+        # Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
+      - innolux,p079zca
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.20.1

