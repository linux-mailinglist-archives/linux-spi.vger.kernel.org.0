Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429758ECD6
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiHJNNR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiHJNNR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 09:13:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2013CD9
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:13:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by6so7653825ljb.11
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nngQRZGnds/Y7NmNdfaLwTyh7fHDxPDaXz0krm4HOo0=;
        b=c6lQknkbXfNFPzpsmuorNmQebcNwoxTJb5dqCpryz0rtLMsD6hVHC672kC8f2fgrS2
         q5oagdpE+I2lafw4k7bIG6SfeDn8Xfm3w54Wo3dOIMLOHEK+qcifgMx5UJbM7Z7IpNXR
         Hem9/Ds96oeqm1vCMXqn/WxKy2tOpuuZSdpPVJQdWZW9zFz1cf0X2PystESFqo90yJok
         BBxFJIOMGlrqeapimi+HyQ6kr9w/Y5XFR9yVKa5Zqr0wp54HTiSH6lnmzu+eQi8BzT/m
         RMAud1swZybbuuKJH2XnkpisuJxIs5oiY/xdyskyN8hav0vv8XPsGEGq5d5tXe4DFyxs
         eGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nngQRZGnds/Y7NmNdfaLwTyh7fHDxPDaXz0krm4HOo0=;
        b=wKWpC1RjjVb1birIiPuRqtcGO6fyFbKIXa9zyGFhoViw/+Z8X/KpDNZik+375pKKjL
         HGEwSrE2mT9zLTSAVwX16VG56loLsOPPpBKdtpF9nMtEmucIBFaTGvlCNhXX1Ls223RE
         TKiySjQKGmz7N6m46zE0uA2ZWXCle4R+zP68yzBzQXc2zYGZpVgPNyG9P9SdVuCITfwK
         fomYcclVLp6sy6kItCt4eZ71rn4XsJNkLOgLuWF4bk861sH2hBmI/8hKaz69ZlmHkaLp
         6ymD7Ailts+N4gKFgeWuG41SK0xV/i3lKu3LKwlEKxsUqtcHQMiJ8Y/PrGaZVvtqx7fD
         RDvw==
X-Gm-Message-State: ACgBeo0syjWCrQZ5RrRt0U4wW8fa7FisqoRZaDXFPw5pZLFACcjvW2mF
        ZSZUsC+NS4R9MtVpRW/fVdWjQg==
X-Google-Smtp-Source: AA6agR63AjRSD7TVUqQA6Z/Rd87jj+EvZtoRkDO5XZs7B2qRb+FhFcfdmxgxqZklv/4j2aNTOcmxqQ==
X-Received: by 2002:a05:651c:546:b0:25f:dd42:5d08 with SMTP id q6-20020a05651c054600b0025fdd425d08mr4690192ljp.239.1660137193840;
        Wed, 10 Aug 2022 06:13:13 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h11-20020a19700b000000b0048b08f0c4e9sm337349lfc.176.2022.08.10.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:13:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi/panel: dt-bindings: drop 3-wire from common properties
Date:   Wed, 10 Aug 2022 16:13:11 +0300
Message-Id: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-3wire property is device specific and should be accepted only if
device really needs them.  Drop it from common spi-peripheral-props.yaml
schema, mention in few panel drivers which use it and include instead in
the SPI controller bindings.  The controller bindings will provide
spi-3wire type validation and one place for description.  Each device
schema must list the property if it is applicable.

The Samsung S6E63M0 panel uses also spi-cpha/cpol properties on at least
one board (ste-ux500-samsung-janice/dts), so add also these to the
panel's bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/kingdisplay,kd035g6-54nt.yaml     | 2 ++
 .../bindings/display/panel/leadtek,ltk035c5444t.yaml         | 2 ++
 .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml   | 4 ++++
 Documentation/devicetree/bindings/spi/spi-controller.yaml    | 5 +++++
 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 5 -----
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
index 2a2756d19681..b4be9bd8ddde 100644
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
@@ -23,6 +23,8 @@ properties:
   reg: true
   reset-gpios: true
 
+  spi-3wire: true
+
 required:
   - compatible
   - power-supply
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
index 817a9bed7d5a..ebdca5f5a001 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
@@ -24,6 +24,8 @@ properties:
   reg: true
   reset-gpios: true
 
+  spi-3wire: true
+
 required:
   - compatible
   - power-supply
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
index 940f7f88526f..6f1fc7469f07 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
@@ -24,6 +24,10 @@ properties:
   default-brightness: true
   max-brightness: true
 
+  spi-3wire: true
+  spi-cpha: true
+  spi-cpol: true
+
   vdd3-supply:
     description: VDD regulator
 
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 655713fba7e2..01042a7f382e 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -96,6 +96,11 @@ patternProperties:
     $ref: spi-peripheral-props.yaml
 
     properties:
+      spi-3wire:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires 3-wire mode.
+
       spi-cpha:
         $ref: /schemas/types.yaml#/definitions/flag
         description:
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index ce048e782e80..4beeb9e17694 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -29,11 +29,6 @@ properties:
     description:
       Chip select used by the device.
 
-  spi-3wire:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The device requires 3-wire mode.
-
   spi-cs-high:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.34.1

