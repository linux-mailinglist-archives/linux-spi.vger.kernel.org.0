Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB154BEBC9
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiBUU1V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiBUU1U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D48237C8;
        Mon, 21 Feb 2022 12:26:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x5so31641076edd.11;
        Mon, 21 Feb 2022 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=dd134NjBkl8fhO5WBxxq3dG4rqJRhX37CWmAE2Aj2VI=;
        b=WXhkfQHfRShc/s+qx4BbtexHkKdRaIoWOy/LMlFZ42d8AksTRQ17IKdh+0pvehhVlY
         6MjmHpx0Z8Z8OBfHTF+TZ9MsoYsc6al6WUxse2drDxzKgXLtT64O2NWuA4nBlHXB3VWq
         PJJsxBQZLrzZg+wQ3gaQ9Csd/Z9OBS+hEsaEUTU82vuRcguAdNBEOZrUxy0JNL71H0iH
         OrKE6yHXGN9CpHkNtjQdpNdPruSrNeJOq/0pZ9tmB+KIFVr2tpy648wW3xIJOcQLkPoD
         JjZFClQ32xFW7MWj6oQJvI//ly9H/IEdsKTXhOc5oPAAcNfOJy+WS0fJyT2KEbkR21/i
         iyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=dd134NjBkl8fhO5WBxxq3dG4rqJRhX37CWmAE2Aj2VI=;
        b=WxP61LYqO3jpy/M4jmPcauQXqr3taTL+Z5jrX7YRGKltujPXOq5iwvi9oYXbujvk+Z
         ylMfMi/X2V4sxWtjF1YnARVM1w+k7HMnjiHV38qizQyUmBQQvye3mLm9zJxmVyabbD0F
         q6qHkuk0sKTIEFtnlAiUKI5t7U0SInsdL4AamFJUcHmlkcXh4kLIf5PQEZeYBJmisVpN
         3lgNQdMiu1zfNpGA4BsIZ3Jqrh+Ik7XubVuYvL/Z4WY6xXC2+b0UCOdUKzzbkiUTTNQZ
         v4wKyZxzaC1gqLGkKY3cSBcVZnqqjC75x11pAYv32zlGLHKhSo0hzXZQoJ/XsPdyjNhb
         uV1A==
X-Gm-Message-State: AOAM530WhITAXEg9zApQ31YeEoVpXI+jfKJFLbscuyLxo5pejGiw+SpE
        TZ2pSJXdqm+zow4vArzTGKQ=
X-Google-Smtp-Source: ABdhPJzaqueRJw3KgqhuWsxjs3QEClMbOXRm7JpJl1xJ3fl/7oVyk2YsuGp5uqbgdO+DWhTs9d6gEA==
X-Received: by 2002:aa7:c612:0:b0:40f:2a41:bddb with SMTP id h18-20020aa7c612000000b0040f2a41bddbmr23081017edq.291.1645475214128;
        Mon, 21 Feb 2022 12:26:54 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id v1sm5565278ejk.11.2022.02.21.12.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:53 -0800 (PST)
Message-ID: <39d61ddb-4b54-4a13-fbb2-c0f88d9bf017@gmail.com>
Date:   Mon, 21 Feb 2022 21:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics
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
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
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

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- (re-)add Andreas' SoB
- fix YAML errors reported by Rob
---
 .../bindings/auxdisplay/titanmec,tm1628.yaml  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
new file mode 100644
index 000000000..da7cc16e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
@@ -0,0 +1,88 @@
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
+properties:
+  compatible:
+    enum:
+      - titanmec,tm1628
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
+additionalProperties: false
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


