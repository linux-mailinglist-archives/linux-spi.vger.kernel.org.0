Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151084C1A88
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiBWSDF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 13:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiBWSDF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 13:03:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F035856;
        Wed, 23 Feb 2022 10:02:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h15so28484321edv.7;
        Wed, 23 Feb 2022 10:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=hoJN2xiYRR/AiZH+KyClQAfus1beCOFyquBC28PraRo=;
        b=BK5rJXWHEtAUExxO90vanXAuMqoIbonOIR0Fe500A/Wi0GoWYYxgDa3IWghcxGlaCA
         lEgtpUVFe1Rh9cz0ZD1iV9nCsIgHde2IGE5bixRcP61Y89haI6IOO8DkycQarHveeWH6
         zoO3+sC4X9et6j+eOY6kKCYiBEGFm0fuIxTDXhvXgphq60t6uYdTp9AhwZJhx3h0xLan
         Wo5KUbwhFKOaofDSP+O2GHPq/mxIhr6jVquB19CMuwkjV3N2/K1EMR0rmFcywDHZzfQo
         7keaLYTqABYT6W83aGQtWFaZtw6g1U7sbT5Iovo/atgRM+3Ui/f7wq36fXhOVfNrQHV9
         hYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=hoJN2xiYRR/AiZH+KyClQAfus1beCOFyquBC28PraRo=;
        b=J4gHLQkS6t28Cf3IA1/E2zw/YUCo+EBTUETHjjc9NZ15mMD1ki3RDPY7gHry5cTgWC
         pBlwjexL/GwgdMuodbg8QCOKGgEwkRHq/VjvCP1e+vmqj5mr65wjkWDY4C+8H2HmXyGU
         eyB8XFITm2KWABrGLEBps9pnToq7ge2LXMjnDWAV1W46Ab4NNQLW9WbfjEPBcCDTy7WM
         +JFbN8IRY781iIF/bg8Vc3y5flHOGjDV6sWbcim8D3sx7IuLZjtjy4nO2RecqC8dTFB0
         mag9Re5zWzvuNqvUWjkU3p7qQ0PLT3IiBoKTiK/HZ+tSPKXgq96FgJgaf979+Ujyh17q
         ctTw==
X-Gm-Message-State: AOAM5339InrnjFMM8JCMWrWkFFrIvRicap4/wnQvSZG3eLCudfE4c/t3
        RwItoNaQeBTB/NsF5Dihar4=
X-Google-Smtp-Source: ABdhPJycAljqrBPqD8wJMoiV0mKJVPvgLcNKwwPiK/7ua7Ct9CK5DDDW+9+DjFMwrvIt2BR8BIn/XQ==
X-Received: by 2002:a05:6402:849:b0:412:8cf5:73db with SMTP id b9-20020a056402084900b004128cf573dbmr581155edz.237.1645639355841;
        Wed, 23 Feb 2022 10:02:35 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:d12c:c0a:f603:b44d? (p200300ea8f4d2b00d12c0c0af603b44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:d12c:c0a:f603:b44d])
        by smtp.googlemail.com with ESMTPSA id k9sm138295eje.202.2022.02.23.10.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:02:35 -0800 (PST)
Message-ID: <2b7f0011-8872-70fa-b9b7-50b7817e7084@gmail.com>
Date:   Wed, 23 Feb 2022 18:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
Subject: [PATCH v3 2/5] dt-bindings: auxdisplay: Add Titan Micro Electronics
 TM1628
In-Reply-To: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a YAML schema binding for TM1628 auxdisplay
(7/11-segment LED) controller.

This patch is partially based on previous work from
Andreas Färber <afaerber@suse.de>.

Co-Developed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- fix remaining YAML issues
- use Co-Developed-by
---
 .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
new file mode 100644
index 000000000..2a1ef692c
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Titan Micro Electronics TM1628 LED controller
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: titanmec,tm1628
+
+  reg:
+    maxItems: 1
+
+  grid:
+    description:
+      Mapping of display digit position to grid number.
+      This implicitly defines the display size.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 7
+
+  segment-mapping:
+    description:
+      Mapping of 7 segment display segments A-G to bit numbers 1-12.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 7
+    maxItems: 7
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^.*@[1-7],([1-9]|1[0-6])$":
+    type: object
+    $ref: /schemas/leds/common.yaml#
+    unevaluatedProperties: false
+    description: |
+      Properties for a single LED.
+
+    properties:
+      reg:
+        description: |
+          1-based grid number, followed by 1-based segment bit number.
+        maxItems: 1
+
+    required:
+      - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@0 {
+            compatible = "titanmec,tm1628";
+            reg = <0>;
+            spi-3-wire;
+            spi-lsb-first;
+            spi-max-frequency = <500000>;
+            grid = /bits/ 8 <4 3 2 1>;
+            segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            alarmn@5,4 {
+                reg = <5 4>;
+                function = LED_FUNCTION_ALARM;
+            };
+        };
+    };
+...
-- 
2.35.1


