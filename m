Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C464413B6
	for <lists+linux-spi@lfdr.de>; Mon,  1 Nov 2021 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhKAGV2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhKAGVY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Nov 2021 02:21:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3493C061767;
        Sun, 31 Oct 2021 23:18:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so7595337plf.13;
        Sun, 31 Oct 2021 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aoZWszvMAHAqQtnVrMSSjXiwhw6YyOcutSzl/43vGE=;
        b=C5fpXKXlD7rsWBBNaCDa1DPWu9Zx4H5pM9QeQGBZUPG6CpCDiOwaSnwtxJn0rRx4Cr
         i/P2DkpOLC9tSURHfxY1QN8K2/sh7ijUsYADffrxevHB/MYIxHud8ziGPPqjA7cwLm1l
         velFQ9H4icA51g9vvkMDj8NnbIfag+DpKByZqlfVFP+rq+B5n4XRIqJdJBSG31hOQSVT
         XiBRa7zK7Jf62J1qJvBL8lD9KWqzEH/liYelzLXRc0BGBQP4KJjPoqHbOozbMVFoaWBv
         dQLO3PnEku7+4uyNOhJdtNKbWXhrntAgHFSBfrk8gVo8OPYiU6fEeSXAKDFM6fTZ39pI
         tQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0aoZWszvMAHAqQtnVrMSSjXiwhw6YyOcutSzl/43vGE=;
        b=kWIwmhDnuZkeopGSBYVpUHCFcDCxcDAZVnptTuTS/eyXcvNehOIW9w6bQ94YCwx8Bu
         75/3NqeVYmafq0GJFqymN/zCI5ITNvLBlEQhzmZYAgf3d+8e9xr1g85WnRB3Hxzrl6Dc
         oyJ4kBQmjURWDWsSZV4utSxx+qaTRlXga3QTgsNkk/PASXH1v2CjsyASMFVvhcEY8S+y
         pqfmXDMEVGlBcewjZVHSpd+X50mFdW70fxWgN8+i2tSnj8mgFuRD6raB7cvsBdEi+jOe
         n/6gZQl9HoDSnntw03Cn3CtqwKKu1o2zOWfHsX8y20E0dK0Ira0dliwyBTxkmpJn5YqN
         JW2w==
X-Gm-Message-State: AOAM531FhLkSJh6c/JwIlegqNRwqvE988uO7yCuE1rZ/BbCQS1gFJToQ
        8aufFs1nbMwmur7U2s63h7U=
X-Google-Smtp-Source: ABdhPJwyLCMLlqHDy2gwN2sje8kpDGfwEV5ClTwJKzofAi4EnO15DBACFq8ZNCvH6r/+JnGiXXTFsA==
X-Received: by 2002:a17:90b:3811:: with SMTP id mq17mr35753794pjb.97.1635747531209;
        Sun, 31 Oct 2021 23:18:51 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h6sm13773731pfi.174.2021.10.31.23.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 23:18:51 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 2/2] devicetree bindings SPI Add bindings doc for Sunplus SP7021
Date:   Mon,  1 Nov 2021 14:18:45 +0800
Message-Id: <1635747525-31243-3-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
 .../bindings/spi/spi-sunplus-sp7021.yaml           | 95 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
new file mode 100644
index 0000000..3ce90db
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sunplus-sp7021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus sp7021 SPI controller
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - lh.kuo <lh.kuo@sunplus.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-spi-controller
+
+  reg:
+    items:
+      - description: Base address and length of the SPI master registers
+      - description: Base address and length of the SPI slave registers
+
+  reg-names:
+    items:
+      - const: spi_master
+      - const: spi_slave
+
+  interrupt-names:
+    items:
+      - const: dma_w_intr
+      - const: mas_risc_intr
+      - const: slave_risc_intr
+
+  interrupts:
+    minItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clocks-names:
+    items:
+      - const: sys_pll
+
+  resets:
+    maxItems: 1
+
+  pinctrl-names:
+    description:
+      A pinctrl state named "default" must be defined.
+    const: default
+
+  pinctrl-0:
+    description:
+      A phandle to the default pinctrl state.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clocks-names
+  - resets
+  - pinctrl-names
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi_controller0: spi@9C002D80 {
+        compatible = "sunplus,sp7021-spi-controller";
+        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
+        reg-names = "spi_master", "spi_slave";
+        interrupt-parent = <&intc>;
+        interrupt-names = "dma_w_intr",
+                          "mas_risc_intr",
+                          "slave_risc_intr";
+        interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
+                     <146 IRQ_TYPE_LEVEL_HIGH>,
+                     <145 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc SPI_COMBO_0>;
+        clocks-names = "sys_pll";
+        resets = <&rstc RST_SPI_COMBO_0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pins_spi0>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f00c466..f6cf9d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

