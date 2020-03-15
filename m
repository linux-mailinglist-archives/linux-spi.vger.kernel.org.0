Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA7185CC1
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgCONof (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:44:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34781 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCONoe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:44:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so15608847ljm.1;
        Sun, 15 Mar 2020 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6y7w72g+Cq8oT80ntLwf96HEc6G6Y/Vju8nRGzAuEo=;
        b=ANUSW+3u+SuGM9UXV2es/7MT1Uc3BwyOEFlsaTmK0WjPxTWX27uNcG2u+f4p0IMoad
         ByjwGbbn8Ri2aWCgsEhBQWTlDMcEL7ahdpiIhI5b0ts5o+2ZhMFA/H7k173B9CIrmu1n
         1DoTctjSo+exg0MsWYC3JV+kNhoqIqiiN4uwsqw8WnzswkwozsyYtUdnCBdzFpp65c7m
         iL6ip9Ig/XdpcA2YDbdh+mpMNZs8/21j+G7hsYpXbIJDeh6G3Pzy64G9DFUigs/Okxuj
         1zKTH/sYLC9BO2f1nO3OO2puydjXvoSrq3d5UsE5GmGE3S+aZGXj2wu9H7UTbkMdAx3d
         M/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y6y7w72g+Cq8oT80ntLwf96HEc6G6Y/Vju8nRGzAuEo=;
        b=nQRIy26sI0D/ph2CK6TEFbZrBdFPr3AjMEBH6BwnkU/kDw6Da2gx0EVXxgqFWu7U9i
         skJD7BfV4Te3HJm+wucFlhLdrOzkwpsFhqOeMGK/S66tW+CmWKT8Uix0htQfoR/YJpXN
         No6ztbzhrMJ18mkpiXGHS/oCdjrd3KKEHnYxnVX29iY3QRArh/m9JwnoYcH+j23f7xub
         EgjO46Eeg3+WVagqy57H1aEP5AMLe+YnPCxoN0n+ANvv3gmORnFIgIpK5dgrV3Y63iSi
         fV03rDQLdpt+pgMOJMCcPNc3P1F8oiqFXx7uhVOmom28REm54PqXTqXTJhkxiS+r2u4A
         zSvg==
X-Gm-Message-State: ANhLgQ0obPNhtnDd2p4oVBoLzSZAodN4dSVedIZZhXLjltuFHrYOg6Xm
        ViqB9jY+3aaa2lvR5X1xX8U=
X-Google-Smtp-Source: ADFU+vv5S65a34d23EanLaBzQqCrNpHn3Xas3yN5pTWxPkEHw7rVyOFZnlfIzuRStDhvy79YdRAEPA==
X-Received: by 2002:a2e:730b:: with SMTP id o11mr13381783ljc.228.1584279870867;
        Sun, 15 Mar 2020 06:44:30 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:30 -0700 (PDT)
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
Subject: [PATCH v1 01/36] dt-bindings: display: add te-gpios to panel-common
Date:   Sun, 15 Mar 2020 14:43:41 +0100
Message-Id: <20200315134416.16527-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Several bindings specifies a "te-gpios" for tearing effect signal.
Add this to panel-common so we have a shared definition.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../devicetree/bindings/display/panel/panel-common.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index ed051ba12084..463bc06bd538 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -124,6 +124,13 @@ properties:
       while active. Active high reset signals can be supported by inverting the
       GPIO specifier polarity flag.
 
+  te-gpios:
+    maxItems: 1
+    description:
+      GPIO spec for the tearing effect synchronization signal.
+      The tearing effect signal is active high. Active low signals can be
+      supported by inverting the GPIO specifier polarity flag.
+
   # Power
   power-supply:
     description:
-- 
2.20.1

