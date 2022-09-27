Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7985EB898
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 05:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiI0DWA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 23:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiI0DVM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 23:21:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC865FAD;
        Mon, 26 Sep 2022 20:19:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so12996159wrm.2;
        Mon, 26 Sep 2022 20:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XWg0li1XY/H2Rw8FIqxf66+PAZ14PG6h91wGgtboRQE=;
        b=itBdD7zZ2CoE4nNRn4MKXsVxBRtiU4bY2lPEGFmZASGozQKL0ptWN07IRk4dah9DlD
         qGxXLMDL9JyE9iY3EMVpeBRw+1vq26NuuKpAymYOKfhcGCIvSDLqRVmkF6xZuk/68cEF
         lKLE30Q0CgcP0xLxrJWkUOii71n3M5eFrNNSYuIYLk/I4F5Em71peGSysKRwohZ/oKi3
         ZMQI9W++2VjutZF27YbY5fUmLnNKUUFmVfAALrMgX+AT8kzVx3jxSRTfvl2OSiUH9X+x
         mNKZ8IeSVJK6FnhSzLxqLFJZC59DE/5kGCS8q/vvmZqUubqxYjrCHVEFeOTwES0aaPuh
         Ve9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XWg0li1XY/H2Rw8FIqxf66+PAZ14PG6h91wGgtboRQE=;
        b=OJQU5CL5/USDa81HCZ+nSplrQ6QABvCdKKOGXCMhIbNdTTOYbofYTUXGP3MviQrbSU
         7gq9uNS6h/EQkri736uod8klWyi9TiYoYeJE23TlvNekGYaOED5q2C1YYrdGGBn14kFq
         L4qqLWaIjWWrMh/o3lc5HkrM7Xl+HZeEapvD5qIpQLVT3eMKXNDL9kncEyZfTdEiej0m
         rWHI4YorwPcNYJxQI6FsljG/tI2LyA5geoMLhWQcD0PhNgaUDxExHYRlKKhT/Md2bykY
         poXuakB79uyBzvpJnEKJJiu8ShbUr+HHBDHf79lagOodtWthaomIgR0uBCo8ydRUCwuA
         td0Q==
X-Gm-Message-State: ACrzQf0k7o3+5RdbFYMLB1S1r3oOca5mkX1XGgbYwjtvmJrUPRBXI25F
        gMZDWZoP4x0H+WVcgW8CkY3BKvhCxPlYgQ==
X-Google-Smtp-Source: AMsMyM4dYKJfkZQ6Y8aaNnI4HdDbePZk7gnKgjrCQ6UWe2p0b6SSIJbJLMRUXIs3xALmFPuw50AXzA==
X-Received: by 2002:a05:6000:1849:b0:228:c87d:2578 with SMTP id c9-20020a056000184900b00228c87d2578mr15318435wri.274.1664248770574;
        Mon, 26 Sep 2022 20:19:30 -0700 (PDT)
Received: from localhost.localdomain (188.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.188])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d528b000000b00228dc37ce2asm470253wrv.57.2022.09.26.20.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:19:30 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings to YAML
Date:   Tue, 27 Sep 2022 05:19:29 +0200
Message-Id: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SoC MT7621 SPI bindings used text format, so migrate them to YAML.
There are some additions to the binding that were not in the original
file. This binding is used in MT7621 and MT7628a Ralink SoCs. To
properly match both dts nodes in tree we need to add to the schema
'clocks', 'clock-names' and 'reset-names'. Both 'clock-names' and
'reset-names' use 'spi' as string so maintain that as const in
the schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v3 resent:
- Send this patch also to linux-spi and Mark B

Changes in v3:
- Add Krzysztof's Reviewed-by tag.

Changes in v2:
- Address review comment from Krzysztof:
- Rebase onto last kernel version.
- Drop address-cells and size-cells.
- Explain deviations from the original file in commit message.
- Drop reset-names as required property.

 .../bindings/spi/ralink,mt7621-spi.yaml       | 61 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mt7621.txt    | 26 --------
 2 files changed, 61 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ralink,mt7621-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt7621.txt

diff --git a/Documentation/devicetree/bindings/spi/ralink,mt7621-spi.yaml b/Documentation/devicetree/bindings/spi/ralink,mt7621-spi.yaml
new file mode 100644
index 000000000000..22879f7dcb77
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ralink,mt7621-spi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ralink,mt7621-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+title: Mediatek MT7621/MT7628 SPI controller
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: ralink,mt7621-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: spi
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: spi
+
+required:
+  - compatible
+  - reg
+  - resets
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt7621-clk.h>
+    #include <dt-bindings/reset/mt7621-reset.h>
+
+    spi@b00 {
+      compatible = "ralink,mt7621-spi";
+      reg = <0xb00 0x100>;
+      clocks = <&sysc MT7621_CLK_SPI>;
+      clock-names = "spi";
+      resets = <&sysc MT7621_RST_SPI>;
+      reset-names = "spi";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pinctrl-names = "default";
+      pinctrl-0 = <&spi_pins>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-mt7621.txt b/Documentation/devicetree/bindings/spi/spi-mt7621.txt
deleted file mode 100644
index d5baec0fa56e..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mt7621.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Binding for MTK SPI controller (MT7621 MIPS)
-
-Required properties:
-- compatible: Should be one of the following:
-  - "ralink,mt7621-spi": for mt7621/mt7628/mt7688 platforms
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-- reg: Address and length of the register set for the device
-- resets: phandle to the reset controller asserting this device in
-          reset
-  See ../reset/reset.txt for details.
-
-Optional properties:
-- cs-gpios: see spi-bus.txt.
-
-Example:
-
-- SoC Specific Portion:
-spi0: spi@b00 {
-	compatible = "ralink,mt7621-spi";
-	reg = <0xb00 0x100>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	resets = <&rstctrl 18>;
-	reset-names = "spi";
-};
-- 
2.25.1

