Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA2185CEA
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgCONpD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 09:45:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33645 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgCONpD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 09:45:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so15622842ljp.0;
        Sun, 15 Mar 2020 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qN/9TVll9OnjC2lIp1h0DvEoxIN84PT8tMaUxK86Nu0=;
        b=pjGBsm8jINEB8YBz2M8v8kWuZJJGJ1/X56U09V6uBb6EcdGyxWjpbfILIGnEPGuM7h
         rRYHkWxaqkowItY3LbShkGPDh89SVXTucFDCpuOdUuhrHX3L0Mk7DXQuvyZcrTrIwRd5
         l6i46gHlGF/EWHDnHS9bhmP39Rd87Qm6NuL7eirKQlCapTr8xJpC/Cdc7Q4iHv3DrptH
         HHy3sd52FkB+8jykczWG2uDxQFKwsNpkEi/geRkH2PDTRRCQLNIaQJG8+pXsipTnjgjS
         sYaVP3WYkDc1Q6JQCmT5e55RJ3w1gZU4SvyiKmRooqnwSQfv9SIvk53drlp93RH53xw2
         p9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qN/9TVll9OnjC2lIp1h0DvEoxIN84PT8tMaUxK86Nu0=;
        b=cQWFvDuzijhJGJU565l/L05CTKqgxND+CRZKrPmNwBN6IaBQ+gmyJxPmwdCj/3wRWX
         o0H8kd6ryAnPHzhH8nH7AHWcl/5Vw/ZzB1BermVOJUr+VpoCCwi8v/+YP4hf4baD0tCm
         zaEmj4Nk06cnu85BdvdIKR/kYzi2tkoAATHJ5t746cpVg/CLrELgU4MrmErCxzvgG2DB
         KUO9Zgn7/dkyIsUuppMw5Ner8zllsO8o58wr3FoQT6Yw3tFAS7cg45u8gZW0BUGtL8v4
         4+ZTe2y+yt5noWbc8Yn1GAnUNkleCOyRVoZ0KAWSl/eoLSnXAp+Pa4nFg5sXxkneQekA
         TB9A==
X-Gm-Message-State: ANhLgQ1u8oiT0ZdZp+BdbkESlGu3ti6ZPrdcpAGE/5tuIXGJYNvO/PXg
        mobPFB0F3VZvpBbuVd+4ghY=
X-Google-Smtp-Source: ADFU+vuiHyiDdXgdytvRxo7AC/xDdcYCpzOFgj091tqpF80M/Pq616xfbTWH0emRYXfcg/fT+l9JWQ==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr10716837ljj.249.1584279900063;
        Sun, 15 Mar 2020 06:45:00 -0700 (PDT)
Received: from saturn.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a9sm23025212lfb.21.2020.03.15.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 06:44:59 -0700 (PDT)
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
Subject: [PATCH v1 15/36] dt-bindings: display: convert simple lg panels to DT Schema
Date:   Sun, 15 Mar 2020 14:43:55 +0100
Message-Id: <20200315134416.16527-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the lg panels that matches the panel-simple binding to
panel-simple.yaml

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../devicetree/bindings/display/panel/lg,acx467akm-7.txt   | 7 -------
 .../devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt | 7 -------
 .../devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt | 7 -------
 .../devicetree/bindings/display/panel/panel-simple.yaml    | 6 ++++++
 4 files changed, 6 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt b/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
deleted file mode 100644
index fc1e1b325e49..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
-
-Required properties:
-- compatible: must be "lg,acx467akm-7"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
deleted file mode 100644
index 5e649cb9aa1a..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3-sl01.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG Corporation 7" WXGA TFT LCD panel
-
-Required properties:
-- compatible: should be "lg,ld070wx3-sl01"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt b/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt
deleted file mode 100644
index a04fd2b2e73d..000000000000
--- a/Documentation/devicetree/bindings/display/panel/lg,lh500wx1-sd03.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-LG Corporation 5" HD TFT LCD panel
-
-Required properties:
-- compatible: should be "lg,lh500wx1-sd03"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5088fe81d025..b1b8d0edadef 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -155,8 +155,14 @@ properties:
       - kyo,tcg121xglp
         # LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
       - lemaker,bl035-rgb-002
+        # LG ACX467AKM-7 4.95" 1080×1920 LCD Panel
+      - lg,acx467akm-7
         # LG 7" (800x480 pixels) TFT LCD panel
       - lg,lb070wv8
+        # LG Corporation 7" WXGA TFT LCD panel
+      - lg,ld070wx3-sl01
+        # LG Corporation 5" HD TFT LCD panel
+      - lg,lh500wx1-sd03
         # LG LP079QX1-SP0V 7.9" (1536x2048 pixels) TFT LCD panel
       - lg,lp079qx1-sp0v
         # LG 9.7" (2048x1536 pixels) TFT LCD panel
-- 
2.20.1

