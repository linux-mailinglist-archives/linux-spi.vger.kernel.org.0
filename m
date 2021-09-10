Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387AB406FFB
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhIJQxH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 12:53:07 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:46733 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJQxH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 12:53:07 -0400
Received: by mail-oo1-f46.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso798724oov.13;
        Fri, 10 Sep 2021 09:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fjHrC7rWcF9dMNWywAFcF4cWpH6lABHS4xRvn07uCE=;
        b=dNFaDpNMFJNecRWRJQccpVQZqT0iJ55YOZ4EhgDzP6NSeOSENF4ROMh4nR+C7N0cHg
         LdQn6KFFKK6QMjf3rsHimze4elDhCgcCGy/tL51i2MsLV/sYx/9M/z6yF/E7hOfYTYgL
         G229yZgtF6mQ080/svhcmpiBFpanOrnQqDKODCBfzuj26tCE4opjPs5kjDR/bwMuwk9y
         UUDsX5dQggDl6HhS2kxtcqcV8h7MN/T6QTylBfX4Q1884r40vHxIPZ/YChYLpk4hLgxO
         d77nufkOrIflIVy/K0kx/7lHIVdCzPSYXZ+dCrjBZa8K8D0LmhGeKByiTcIGljo2MzUO
         IUdg==
X-Gm-Message-State: AOAM531b6SC+Ont4jEbAduuwwSQKDTnRxd14j4R9k1c4tUdv+fzv38hv
        r9lQLD6a1+GxQUATarJ8cnDDLfhQ/w==
X-Google-Smtp-Source: ABdhPJyUedNY2XQSRkDXYf15LP5DG4AvPSI+WgwkX0ecJs/T2gYdw2UpbTWOv/R1eADi4gUxBwt0FQ==
X-Received: by 2002:a4a:33d6:: with SMTP id q205mr5077583ooq.83.1631292714765;
        Fri, 10 Sep 2021 09:51:54 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id f17sm1347223otl.24.2021.09.10.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:51:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH] dt-bindings: More use 'enum' instead of 'oneOf' plus 'const' entries
Date:   Fri, 10 Sep 2021 11:51:53 -0500
Message-Id: <20210910165153.2843871-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

'enum' is equivalent to 'oneOf' with a list of 'const' entries, but 'enum'
is more concise and yields better error messages.

Fix a couple more cases which have appeared.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Mark Brown <broonie@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-spi@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/msm/dsi-phy-7nm.yaml          |  8 ++++----
 .../devicetree/bindings/spi/omap-spi.yaml          |  6 +++---
 .../bindings/watchdog/maxim,max63xx.yaml           | 14 +++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 4265399bb154..c851770bbdf2 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -14,10 +14,10 @@ allOf:
 
 properties:
   compatible:
-    oneOf:
-      - const: qcom,dsi-phy-7nm
-      - const: qcom,dsi-phy-7nm-8150
-      - const: qcom,sc7280-dsi-phy-7nm
+    enum:
+      - qcom,dsi-phy-7nm
+      - qcom,dsi-phy-7nm-8150
+      - qcom,sc7280-dsi-phy-7nm
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/spi/omap-spi.yaml b/Documentation/devicetree/bindings/spi/omap-spi.yaml
index e55538186cf6..9952199cae11 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
@@ -84,9 +84,9 @@ unevaluatedProperties: false
 if:
   properties:
     compatible:
-      oneOf:
-        - const: ti,omap2-mcspi
-        - const: ti,omap4-mcspi
+      enum:
+        - ti,omap2-mcspi
+        - ti,omap4-mcspi
 
 then:
   properties:
diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index f2105eedac2c..ab9641e845db 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -15,13 +15,13 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: maxim,max6369
-      - const: maxim,max6370
-      - const: maxim,max6371
-      - const: maxim,max6372
-      - const: maxim,max6373
-      - const: maxim,max6374
+    enum:
+      - maxim,max6369
+      - maxim,max6370
+      - maxim,max6371
+      - maxim,max6372
+      - maxim,max6373
+      - maxim,max6374
 
   reg:
     description: This is a 1-byte memory-mapped address
-- 
2.30.2

