Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD57607872
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJUNbp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJUNbm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:31:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52632639F5
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w18so4839483wro.7
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoI1kmxKiCSvzrZsjQ9wHdmyYSYZCsE9cQztwvc2mq4=;
        b=QUdSggw5HJ3x/21fCA3VdACtz+Zu9LZs/XA6elyv5wXmHRAZeOvrqBz0Uznlx9pjbk
         Mb3zQOPwzpHpLqIFstvXZqXO+hGxwApE6qzu7m4zVOz8XuewHllKIjsV/Y31V08gpZO6
         zj6Ek3OfXF6oHDMuhEgtjD1inlrUsO0bM8hmX9w/bFAOFKdWb6WGvB5X88lK6CshMjUy
         0ircy1XXcquXrwhOzYIA7pg9l692xBxj6lZ4DQrPwMoOj988POwjvUyXZX+j9OTOw3lu
         JGJRn3dxEJvT5SzY1TZ/h8Mc7d3BUqsD2vD49mtd9/jzs9YVCja3yPximUNryWjNrOK/
         qSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoI1kmxKiCSvzrZsjQ9wHdmyYSYZCsE9cQztwvc2mq4=;
        b=gYuuPeXxL9ZK4GVtcIBMBXM/ZejdCCqk9aoOysEYjWF5ZkXPG7OnNSwwZUgw4+SLZi
         nfy2GTUBE0zgZIGad4kjPcJGhZ1fKeblATuy3psBU+0F0miydbr6OFV9OriPP8Rk3A8V
         QzNOg6AtTeQzc9PzY6slJ+sCut9akCEh3JRidaSA9tnG0kXS+NUEBXrCCi4fRwG7FUJP
         ZwavYTIklyXrNxNBU4QUwGdQVoyjjzmtpZGaLejAfwxZ0TY9INm+Cja9IHnDtKSz+LcW
         Y0Sth8kKxIEMWUUr5V67cNm3tVaWcMisd/aLd4XjfoEmEjZLBnrJKoUCo6m/rt7Bvig9
         itRA==
X-Gm-Message-State: ACrzQf2wVFn8bdlJI/SF9W/kWze4wX/1N6pB5SOaRvc++7Z9yOqbwDAL
        IHwkrDgHzMkn4IYr3oG+Gywirg==
X-Google-Smtp-Source: AMsMyM4IOU41jEZl1kaH25EzaO3Tl6/9Oba6qNk5NEBn3vVq/JVKjVSFxwxiDCNcpjB4w0X919Wejg==
X-Received: by 2002:a5d:58ca:0:b0:236:2324:3f0f with SMTP id o10-20020a5d58ca000000b0023623243f0fmr5464669wrf.325.1666359097401;
        Fri, 21 Oct 2022 06:31:37 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10325280wms.0.2022.10.21.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:31:37 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 21 Oct 2022 15:31:25 +0200
Subject: [PATCH v4 1/4] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names
 for SPI signal states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v4-1-0342d8e10c49@baylibre.com>
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666359095; l=2772;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=YwA+sHh1oNU0ILalfPfygNyaqm+7p3kzynT8plbgjZM=;
 b=BGhgpQ4vXKhBYPR0FF4G20VfKU5D9cT5w4SDni58JwcnXH6N8b1jaWuf4JYT7enm+p4gwNRkiAwA
 fSJpzhrjDBdl8xybmq0EbFia14LmXlQqgMte20+x0ClV0q2aHZsR
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
pin biais when idle. Therefore define three pinctrl names:
- default: SPI pins are controlled by spi function.
- idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
by spi function.
- idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
by spi function.

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 75 ++++++++++++++--------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 0c10f7678178..53eb6562b979 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -10,9 +10,6 @@ title: Amlogic Meson SPI Communication Controller
 maintainers:
   - Neil Armstrong <neil.armstrong@linaro.org>
 
-allOf:
-  - $ref: "spi-controller.yaml#"
-
 description: |
   The Meson SPICC is a generic SPI controller for general purpose Full-Duplex
   communications with dedicated 16 words RX/TX PIO FIFOs.
@@ -43,31 +40,53 @@ properties:
     minItems: 1
     maxItems: 2
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - amlogic,meson-g12a-spicc
-
-then:
-  properties:
-    clocks:
-      minItems: 2
-
-    clock-names:
-      items:
-        - const: core
-        - const: pclk
-
-else:
-  properties:
-    clocks:
-      maxItems: 1
-
-    clock-names:
-      items:
-        - const: core
+allOf:
+  - $ref: "spi-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-g12a-spicc
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          items:
+            - const: core
+            - const: pclk
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-gx-spicc
+
+    then:
+      properties:
+        pinctrl-0: true
+        pinctrl-1: true
+        pinctrl-2: true
+
+        pinctrl-names:
+          minItems: 1
+          items:
+            - const: default
+            - const: idle-high
+            - const: idle-low
 
 required:
   - compatible

-- 
b4 0.10.1
