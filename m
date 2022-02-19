Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E24BC88C
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiBSNV5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiBSNVz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:21:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F663100A;
        Sat, 19 Feb 2022 05:21:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m3so14225626eda.10;
        Sat, 19 Feb 2022 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=fpauG+TRD67lEqkFOUl8ovsHrrNt32JAGPgb9gRTuM8=;
        b=I/9sZ1OlbKLvWG4qtIMulQQCHX0woCYxCWVD+KGU+EVfwIa6zMU8zx4F83avXtbBQ6
         f01FSr/FPuSp8Ipyy5Y+HkHOmsiS4V0DLXhC8YHCBWPvze4MnUs5QoaOpJjKf7FI+o1S
         Vuin6ENVt8OBCEfS0OQpSqoG16g58qzQImmEjAzAqWlz0KGAcwz703LG32JhWzWmbrYp
         d4oXy4FGqOBwOp3yMy4iNHlBk1H4sZ5SvMphtk/XCFCyejKkZVUv/mx5YyYcgo3xCngL
         79z+yRe8gujGZYFXO3uvDaHkREF9m6nxdi3H8ksBjYYU9BZVRS4EjetYRwsdjy5VCtzn
         108w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=fpauG+TRD67lEqkFOUl8ovsHrrNt32JAGPgb9gRTuM8=;
        b=fqmeL5n4lRlgzMEkX3ytWvZbp4eI7DvJxQmdP56Mn9hcKC5zoog5EzWzUmkbvCyMP/
         2xYYclTWVkxVPisNIeJJO2HJEIVNGOTerFYBJi2JK5xqjTrxbO8oCoJ2/ltkl2pa4uzd
         vFRg4L9x5KE7ImsWH7ekjx2qJZ8wy9iNL7edjslOCxkAQ8akNxwdos6pQOzptokkpPBY
         kGerE2DrsTacDJBvTGbSQCwOiPUuow9zqlcwTXojfogGxmhz4lY4RCY0ghD6vL+X4vJf
         Xm68j4PuD+rM/MBuqBL6I2r/ytvo073V4tR1Qt4VSPG0R0K9tY20oxcN8ln8fB+pKLuK
         //jg==
X-Gm-Message-State: AOAM531HylMc4P5M/Unldu31+9esJ4QXeWUmgYWQtwM8t+WVoCMIAjBS
        CP1G6sbuX9u6lKPThsJhuNg=
X-Google-Smtp-Source: ABdhPJyMdwhFMviXX9vaz5IRwMK3brlTzx8iFzc1fr7HKR2rhSXRpPUyZaN8i6BBGVmPmevkmF7BpA==
X-Received: by 2002:a50:8713:0:b0:410:db7a:4b2a with SMTP id i19-20020a508713000000b00410db7a4b2amr12665564edb.140.1645276893863;
        Sat, 19 Feb 2022 05:21:33 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id y23sm3287387ejk.153.2022.02.19.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:21:33 -0800 (PST)
Message-ID: <d8fff247-d3ce-79f0-6d0b-dcce44457681@gmail.com>
Date:   Sat, 19 Feb 2022 14:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH 3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics
 TM1628
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
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

This patch is partially based on previous RFC work from
Andreas Färber <afaerber@suse.de>.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../bindings/auxdisplay/titanmec,tm1628.yaml  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
new file mode 100644
index 000000000..d9cbbc950
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/titanmec,tm1628.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Titan Micro Electronics TM1628 LED controller
+
+properties:
+  compatible:
+    enum:
+    - titanmec,tm1628
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


