Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B609E44AA03
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhKIJGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 04:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbhKIJE4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 04:04:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7FC0613B9;
        Tue,  9 Nov 2021 01:01:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y1so19711307plk.10;
        Tue, 09 Nov 2021 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7XySaIcwGaLiWKvvNwh5b44yWNPKd0esBeE+n6hUyE=;
        b=fsnnBTUGrV18dJWymbEqzju8usj3Nl7WZ+9VdiiF0U0l6HCj4oT5YSYH5KGxOHgKrS
         L4CrlApFaKoXuC/SFyTUEaKR4LDEMTDy3W/ebGHUO0oq51V7XUrO0ZVUqUVHLqREyAtB
         LIPoKhLcmz8KXn3cnLYFgXQXqXwFvVS+rrfd2eoCCOLjEN7YkVPaiNor9ruu+5kCo7nR
         bXyjXoipsGNhOkWbCGfpY4y/wPh9CaM+1M0ALUcYUPZaOlgfhmDJ6I/eIujgSMHESyDL
         jnxv29il1UWmluEtKXHbTpoielpdGhDlMJ8tVCC+7blWdK/AbCtCsBWoa5QqYssWin7L
         lgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7XySaIcwGaLiWKvvNwh5b44yWNPKd0esBeE+n6hUyE=;
        b=mybWRiAq3xzTBOb+HQhyF1Vt4uhh6N83pF/kar3pAOhWRmz47R0O7cbRmt2ZpdazBN
         dyMM6bbUf9+0JU4We3t8KtpJnbMtbvTC7SBGUGlkz++TwScbehZN7+csA1mCjIm4toJu
         sAHkAKGUp1tDSkEThJ3zOnBnUsMocWqz4Z0rS8Qsxestxw4wf8xUYKmDNj5If02FgsTn
         LSgNx5zaC3kV7sbcIggl7twMptWmsURdXqElKNhVrV7blE3BU2qjOSZl6gAmXP2GsN/z
         C5xWUtMGWrT1/NjfXm6oHjBA24v6dQOCBKtZHa3Rle553PtZdYyXS403k3TZ/jNfTtF7
         aZbQ==
X-Gm-Message-State: AOAM530kYkpOB4SGIkYamExLqhYngQ5DageibmqAxac1OIWEMKc92rWe
        TalWW2499uEY3HD/YJ6vTBs=
X-Google-Smtp-Source: ABdhPJxlOmrEx48POz04wUPUUHe45o2dHUki5OG0kRmdhWY0DxCfIy8YxPHAKdosddO2AbgHeEiaaQ==
X-Received: by 2002:a17:902:bd44:b0:141:ba1e:cc90 with SMTP id b4-20020a170902bd4400b00141ba1ecc90mr5749822plx.16.1636448492791;
        Tue, 09 Nov 2021 01:01:32 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b7sm19178353pfm.28.2021.11.09.01.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 01:01:32 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v2 2/2] devicetree bindings SPI Add bindings doc for Sunplus SP7021
Date:   Tue,  9 Nov 2021 17:01:28 +0800
Message-Id: <1636448488-14158-3-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
 - Addressed all comments from Mr. Mark Brown
 - Addressed all comments from Mr. Philipp Zabel
 - Modified the structure and register access method.

 .../bindings/spi/spi-sunplus-sp7021.yaml           | 95 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
new file mode 100644
index 0000000..5502f15
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi@9C002D80 {
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
index 34868d0..ef416a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18193,6 +18193,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

