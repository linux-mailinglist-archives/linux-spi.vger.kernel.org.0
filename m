Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB09C185CED
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCONpG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42499 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgCONpG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id t21so11694544lfe.9;
        Sun, 15 Mar 2020 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/emWc6W4zftcHfaj2Yi3x1iJjutKkIrJjITu/23MG8=;
        b=soslxIbXlga3HyB3Xw3wJYKYpBXGUY2SyZD4ZKzVIpz/U1tbAfjbUysyQseA7TyOXk
         B5/6Z47V2IY1KxUSXQ59R5/TTFKZ3V10fi+akp9plN/0btYG6qylw4Ur6vaJ+l/w87Qb
         eTOxyGY97JfyCjzJ6t359ubmblf8x2JvVjlO0VJMQ6MJMShO9FvzQl3P7d3Qw4R/9Eyh
         y9Iy+B7MPSNVU0ObeAy4QNfzJFRqRMlzz2kcexsLG7fm6L/pdYv536jwLTDBcpIpNUVd
         D3nu4TkFK3/YG0LuSdsLSpXwawLGCaa7zPi0MrOBdnIIuRL+3KxHwYwHADddMhXrzlrY
         gSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U/emWc6W4zftcHfaj2Yi3x1iJjutKkIrJjITu/23MG8=;
        b=HHVT+mBq6TWQfyXXTWqSIYxV7lJHc7CEP4dGlo3kwV+tE+1zM5liNAiHT3cnlyJNjo
         AV/ilkRZQtYaw2B3rMvH4pXNa2sJhMePHFj/jQdEzzYSU6HUv24Q8qdqz93ZSJ0AB/g7
         Xqkk1dADnWdu4H8AS2I9vsL7sYbEms/47dg8cxZatJanXPYNMaECPDn3m6wFCYQE/wfZ
         mQBMWx6Vo6UYG361I81jxHQ+tcsDc0/aSF8SPgFNSHcnSZq5Qze6zVSh5ztcAkxQHren
         YCk1qE8YoUVSCPmb6PHXhYb+IqLMvMTtTIA751h8P/R477cnp73hbvejV3yZ5Kp0XYNz
         ZAEQ==
X-Gm-Message-State: ANhLgQ3Nn09wuI1ekQqZJ3HArzD2m7BxbEnRO7IFQl9fU/Qml6zIByfZ
        yNSEGh0YcukRX6Br/40vO3E=
X-Google-Smtp-Source: ADFU+vv/YARa9XC2pIUfGZx8c4J67p1hauQnO9uNhe9XhQfB4SmZyKZCgmx7UknwsUdiQJnzDkFIHQ==
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr14706524lfg.142.1584279904157;
        Sun, 15 Mar 2020 06:45:04 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:03 -0700 (PDT)
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
Subject: [PATCH v1 17/36] dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Schema
Date:   Sun, 15 Mar 2020 14:43:57 +0100
Message-Id: <20200315134416.16527-18-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

osddisplays,osd101t2587-53ts is compatible with panel-simple binding,
so list the compatible in the panel-simple binding file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/osddisplays,osd101t2587-53ts.txt | 14 --------------
 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 2 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587-53ts.txt

diff --git a/Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587-53ts.txt b/Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587-53ts.txt
deleted file mode 100644
index 9d88e96003fc..000000000000
--- a/Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587-53ts.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
-
-The panel is similar to OSD101T2045-53TS, but it needs additional
-MIPI_DSI_TURN_ON_PERIPHERAL message from the host.
-
-Required properties:
-- compatible: should be "osddisplays,osd101t2587-53ts"
-- power-supply: as specified in the base binding
-
-Optional properties:
-- backlight: as specified in the base binding
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b1b8d0edadef..70c290f7df30 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -209,6 +209,8 @@ properties:
       - osddisplays,osd070t1718-19ts
         # One Stop Displays OSD101T2045-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2045-53ts
+        # One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
+      - osddisplays,osd101t2587-53ts
         # QiaoDian XianShi Corporation 4"3 TFT LCD panel
       - qiaodian,qd43003c0-40
         # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800
-- 
2.20.1

