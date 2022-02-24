Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283CC4C3698
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiBXUMC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBXUMB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:12:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3CEAD;
        Thu, 24 Feb 2022 12:11:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk11so6725245ejb.2;
        Thu, 24 Feb 2022 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=LZieaA8IQfeUiT55cuSm8XlrpapnhQkbMv4PqrRswQs=;
        b=CaIYE4lGBxmhFUEqszNJ6ZfSr4qMhwZ2Ixf6B5itoz1D70RNdvcxI2uFwJmCMYV/1m
         tYs/RlOVekU9G4cjKo4Ywb0SXBGI9TOAX7q8kIyDnr190DbDGAS67pciIba+8udgjnv1
         9r0fDMQhzZB/YbfDzdCHmYr53kSEDdmTRlvQW6VdNT2QDi29KpjgqKabEQSq5Twkx6Yh
         nZTb5HANbdVx929RxZE6+xekoynBmiTLUfHf7RsZ2s+K5AH1eDAwv0IpHwcqRcL68Qlq
         2uJbk+4C3L0jDjIUG408NlBNM3qy30SuF91Jbhg44Joqs0yiEqnSy8MEkREidPUCNw8o
         kCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LZieaA8IQfeUiT55cuSm8XlrpapnhQkbMv4PqrRswQs=;
        b=zLVnfcJpl8090MdYD0pRqrBHFtUE4lqD0NOBXZvudoMGRhNQPsd8IwXfwSabCIENUq
         k0/jLkVlHXs7Eevn8SXRU1WzbdFxJv+MsNOtM/uXO0fTpM14qCcuWH1b4DPSoLjgYUPk
         szTU9AeeqQHKnlwCncht8XkXkOoY/+BvrM1HQ93nzKeMUYi4+edKDtI4WcxzXMN2oAOC
         vZdbwfVkn/xd3jg4gvyVsOirTRHkd69IGU18IfecTvCEVdz/zPzeKo0MsDeJOmHJ+dvE
         jyRnr6XIDo6dBjcAplRYEk9fSjJYEdu0Oneu+TUtKaouq0sehuyzmyxbqKeHK4KCWtkn
         6CUQ==
X-Gm-Message-State: AOAM532eRxtxyt3fsXTJvu/qy94mKyRS73AWb04Evo/WTsXTAJjwYTd6
        f1AyyLYq+kmkopOb3ngy1Fw=
X-Google-Smtp-Source: ABdhPJx0xxe9oOyj3twkXv1sgWzq1cLG+e4+ameBc800P5R31eA18NyH+o7mjr87HALk7kQXpbMjnw==
X-Received: by 2002:a17:906:6716:b0:6cc:7d95:90af with SMTP id a22-20020a170906671600b006cc7d9590afmr3546734ejp.442.1645733489127;
        Thu, 24 Feb 2022 12:11:29 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id hz20-20020a1709072cf400b006d1b5df5c1fsm140379ejc.17.2022.02.24.12.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:11:28 -0800 (PST)
Message-ID: <ff6197ff-1cb1-9dc1-4efb-c24cb63e29f7@gmail.com>
Date:   Thu, 24 Feb 2022 21:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v4 2/6] dt-bindings: auxdisplay: Add Titan Micro Electronics
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
References: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
In-Reply-To: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
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


