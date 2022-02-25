Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A454C50A0
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiBYVYb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbiBYVY0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661F18DA9C;
        Fri, 25 Feb 2022 13:23:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm8so9172339edb.3;
        Fri, 25 Feb 2022 13:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=QFvRzvIdRv3xplrJSGk7DMQfwafyCoO+jIxn5A7f+Mo=;
        b=geFvYOtYlAzZW5zPxS0omthKPQef/gERvsIFmb0VHNW6XMnc+Z5ob5eozbesva5yPr
         72J4JMaInvqxY2jqPbpaI1UkEjzb4uzUPFcZXW48EeYT4cbfennd8+ZOH2vQF4LExoOo
         xt8I0sW+fKIPcboP/lp6KEpt5b8ve0SgyvFiel7TFGIRpGvz+lY7qejjkxbkDq7hkQcG
         CtOCaK2tSj4Qeg+kYGLwwMgfzrbNVPnX+UK4yVGcxhtPNHoOKuAl15GkXT04mzr2VAgl
         nBsMcjStzMttlCxfjct7DaL5VmhC+r7JnzZrLhHRxLZzOo8I2TyC3NsS0mSkEZ8rU8cb
         gEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=QFvRzvIdRv3xplrJSGk7DMQfwafyCoO+jIxn5A7f+Mo=;
        b=RmHRJNmK6mLZdTHxXjFWX++0A0BZSKU0cI2DF+nhGvE+VBkavg6uesNP76FLlDkjUU
         aU+mcy4mgIHOrM7xUJSwP0AYnHxta45MvP9TuYZ/qGlp+woe5VURT0ZuOa/MkaT8oXPG
         St0N6YA71cQXgdjTibXXpYLqYMbP+H8G2hsioXJuV9zPiT+xUJV+MbSZOZ0CSb0eM1Pf
         3x1JqR6O1F2KSMUyWy0ZMees8aLbmwjQU85wc0yi96kj3B1d6PS+uR9RqvXyemVmqqxn
         WVjcEpr3fL/i/6Pz1QtZbK4eFDkkpGBjpWrpN+zBxql8kP0h7DwojsQKg4GCfDKm3xMf
         RHOg==
X-Gm-Message-State: AOAM531zivMMHLLS3fmUaAH2/HDd++CBKcOvzhXDmKtkiMe8pXxAGr1o
        PtCdtO5TAjj0ylPg0MVS71c=
X-Google-Smtp-Source: ABdhPJybxPWcIY7zb9JmvYjISMMVpmpNYRzrKQ7c/vcl+xvi88vo5XSX1q9NnfQSZTQIWu8iqUMpJA==
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr9055727edy.332.1645824228405;
        Fri, 25 Feb 2022 13:23:48 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id c17-20020a05640227d100b00410ece2072dsm1999591ede.95.2022.02.25.13.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:47 -0800 (PST)
Message-ID: <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
Date:   Fri, 25 Feb 2022 22:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro Electronics
 TM1628
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
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
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

Co-developed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v5:
- add vendor prefix to driver-specific properties
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
+  titanmec,grid:
+    description:
+      Mapping of display digit position to grid number.
+      This implicitly defines the display size.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 7
+
+  titanmec,segment-mapping:
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
+            titanmec,grid = /bits/ 8 <4 3 2 1>;
+            titanmec,segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            alarm@5,4 {
+                reg = <5 4>;
+                function = LED_FUNCTION_ALARM;
+            };
+        };
+    };
+...
-- 
2.35.1



