Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1738185D14
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgCONpb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33678 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCONpb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id f13so15623575ljp.0;
        Sun, 15 Mar 2020 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6D6qYDVAoDX49O3pqM7t4Fg8LndWENhGAQHVsmY5Z5o=;
        b=Z3lR7wSu95RLPE8X/9z5nbJdYyfKLoqS9TzFiG+Q+tfPehq1P95WyiAlxeU1Nwapxc
         H9CqELCn6hZRSwR74G/qaLM0VjUFPnUq8J8p59WoRsAxYsp8ucqBBfWJaLvl5gcklSR9
         dkH+IkaqkbPBpk9p7ss3gT5eB0IoTUA53nLbo+dv3ZEidt+wDUquCo64Gpsv21lP8R/H
         Bie6HSoex0YSrJldtxZS1RXWaORFX473B99nyzSRDaEKHTpmeY66phILlVWYBHcDSXTq
         lAq6gk1KpbeBHRuNnxGe++oP5rt9a4sEy3Xt7WUU02by3ECEEEyZtRQnCMunLmvFZzzu
         CUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6D6qYDVAoDX49O3pqM7t4Fg8LndWENhGAQHVsmY5Z5o=;
        b=Uj1csRjkFERjKP/GXoT0YWYvhvm8Ew5HMx7QbSdzQJ5V+EJZsHdg9MiOrAuN6VNlp9
         uLSVeYSu1HCu4rIlk+O7rBlvJI35pg7JyaJ4ddAgZp5/GWcnrgHgcrRRSWk+cbH5L9JT
         spbvgewQbqAiidsawbRgG7MnLwhxDrTsSdbl3cOLiK5V4wxJb7Xof9WV0q6eCN21Fok8
         Xht4UFuC6G+rQMNsbNrIoXKuxkM/nybKHUCj8s9OxEiSgQr+lKIpDFaR2+Hwin2w/xmM
         gbwGBUC7ThTn+9hkoikIxG2PSbxoqprdIviWtwtnZ8cxQyorCYXI60l2+qqg1jY7xIQZ
         hwNw==
X-Gm-Message-State: ANhLgQ3/9Z5yFtz29kkZ8tMpBAWAT3o6qZzJl1hb7DMcRJ8maktVMwsN
        O+9xkUwDtb3cHdzKi7zWtnU=
X-Google-Smtp-Source: ADFU+vtooqsG2bH83FWIuLOJneXqDQ/gelH/BnjWZx7/xYxCAc4rrgoy5QfSuinhYEu3uCPsVtj9nA==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr12528704ljk.167.1584279928664;
        Sun, 15 Mar 2020 06:45:28 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:45:28 -0700 (PDT)
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
Subject: [PATCH v1 29/36] dt-bindings: display: drop unused simple-panel.txt
Date:   Sun, 15 Mar 2020 14:44:09 +0100
Message-Id: <20200315134416.16527-30-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are no more references to simple-panel.txt.
Delete it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/devicetree/bindings/display/panel/simple-panel.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/simple-panel.txt

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
deleted file mode 100644
index e11208fb7da8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ /dev/null
@@ -1 +0,0 @@
-See panel-common.yaml in this directory.
-- 
2.20.1

