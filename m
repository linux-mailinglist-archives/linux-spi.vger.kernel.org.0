Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008601E058C
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbgEYDqH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbgEYDqG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:46:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D84C061A0E;
        Sun, 24 May 2020 20:46:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so7984046pjm.2;
        Sun, 24 May 2020 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MtXq2QWDOoN0CBKSeH60c2tJASyOu/uu0I8Lzq6RPtM=;
        b=t69eC63CQ3k49aGU3xG+GnDCSEwR8kciBL/7nzuvl4/Hr4BNqc0Xp/LycSexKIk+8E
         PEAfeaojlOH40hTE2AyxHJHR2M3OnFED1+0JZout9ewf5RUKoWTX/t2x53xyYrcW5mEQ
         L7hYdHMpqxAZ1wKEQu/hbdvy6yMjlHrujxhr2y0Kb++fp7OvXNYOhTDFYlglDHSWulbB
         uPRrUm5v8woAFi/QV5azhaf5iSzN/xF/CXzSucTIFbjpTxrua6a433t5smWG3+L9IlRV
         ZkNlLTvAt20pTLM7XvA+JchlbYc5lJUB0OlDcGbQKbqcKTxVjeCFHux0CTzXhxjgjF6Y
         6SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MtXq2QWDOoN0CBKSeH60c2tJASyOu/uu0I8Lzq6RPtM=;
        b=Hozoxk0kV9H3hAbRY50tG4yBXcNDZZfUuVX4RESHND4nJneHpxwHuuB1eguiLAhk+x
         QMIQybZ6UT62F9tCkDoCFGauf1EWlJppNWeoRKFTp7KqIm1tcyy+I2/L1aP49h/9uzpT
         8BRgBziKRnwA0VfRNYYy17QEizIUxDZxtjsEhk/4SNYXUslGv1vm2cYMnwkI7ubP2Pr9
         9Hj7aLC/N7gQkKFFh9E7+jivmcdv1js37djGjATPbckY94JPNMjGp9605OIJhhN7bCkf
         XDvU9V0JEdYVNrqCi9vuE2eGQ90miFbbnDpf7SmBSX/NMn6hCuGo/1K4/7iczWSW107R
         FhNg==
X-Gm-Message-State: AOAM532MrVqesKdpQVoeY745iagmc7/nFXNwYAPmDMbhLJSdOLEYDUfd
        eKKzwNURKC+brpk26FObKI8=
X-Google-Smtp-Source: ABdhPJwrhZdi0No4rbZQHie06zCoV3F1MKhumkDGsoHpu8RyD5ewUfXxcEcGR091fQ5c1lz2G7uDpA==
X-Received: by 2002:a17:902:262:: with SMTP id 89mr24238893plc.251.1590378365956;
        Sun, 24 May 2020 20:46:05 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:46:05 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 4/8] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Mon, 25 May 2020 11:45:44 +0800
Message-Id: <1590378348-8115-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 0000000..2172f88
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams with 16 bits or 18 bits.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ili9341 240*320 Color on stm32f429-disco board
+        - st,sf-tc240t-9370-t
+      - const: ilitek,ili9341
+
+  reg: true
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - port
+
+examples:
+  - |+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel: display@0 {
+                 compatible = "st,sf-tc240t-9370-t",
+                              "ilitek,ili9341";
+                 reg = <0>;
+                 spi-3wire;
+                 spi-max-frequency = <10000000>;
+                 dc-gpios = <&gpiod 13 0>;
+                 port {
+                         panel_in: endpoint {
+                           remote-endpoint = <&display_out>;
+                      };
+                 };
+             };
+        };
+...
+
-- 
2.7.4

