Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF50239BB75
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFDPM6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPM6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:12:58 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA1C061766
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 08:11:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v142so9623746oie.9
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyE+h/cPVeiDZzU3fvDlw6KyVLKd3NiXe8H5PkVg15I=;
        b=vKHxm3nDA3HVgshFrx1/hhHLEgSBLpZ/a8rMX8R/SMFZ/6mb4BWlAyLaPY+8x13FQH
         KZN0fJ54yVLWkLiLB279AhZbFpfqGJ3vsYZ6j21GkwcanpYszEy2S5P1cxzTbqad5uhf
         37BhcVPJg7h1Gi4kGzaUwGjrlG26Cnkls9QrXL3+8FmtxD7Qv14XtGVsx0ggW0ZEkwuk
         Mm1oOt+/BPOKPL23O3IPcenLud2AhUI0/ApeGumZx/AYS65p3b55Lzqi9hmkZ1HVqvl6
         mjuiUQSr1q1XyKNvaHQeoYYWXY3272HQzpb75zzmt/Og9aKpXsc3AbDz1mdDIY8ha/ap
         XpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyE+h/cPVeiDZzU3fvDlw6KyVLKd3NiXe8H5PkVg15I=;
        b=PpMm1cqYUx0V/VWY3bYoqQ3pciPtrYtxijH/3ZLZ1TOPGf484W0JvNc25nJFGcXvxG
         ZchzIWeMkwJsm9FMRz0WZ/KA8H0RLydwfftCb7tPjindi4DdXd5XViVgguUxZWQJN7cm
         zxomD4iyv9Q1TxLns7oUv6URHqcDHZqS05Hd3WO1/m9hQvTmKVWbFH82VA1kiasLgE4H
         9xZDLxNV89nW9XiYBknHFcBFI0p3Z/fHiS0gM1kcEw+RzBUmT79BjaNE6pEqsU3noVcT
         icEhJzDv3QcVJrWGRxa8bvohUG+ixcRRx3UhMfd4hwqJ40MDokDttUZga4cleJ4MQPx1
         sYbQ==
X-Gm-Message-State: AOAM5318VpCyi4s6PYHYERkxvHlAicx6lafjKuPThH8M/BWFAdhyzwWl
        r6CrOaBwEVBTKVwwngBHjwPkligd984=
X-Google-Smtp-Source: ABdhPJzZdxeEirRNyoyGsUZEOKwOCHATO6aDYXZqOvnkcmLmlkJEcZJvjrUuZqPb1nDaLCDEQViN5Q==
X-Received: by 2002:aca:b443:: with SMTP id d64mr3231279oif.68.1622819469820;
        Fri, 04 Jun 2021 08:11:09 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:09 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
Date:   Fri,  4 Jun 2021 10:10:48 -0500
Message-Id: <20210604151055.28636-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add bindings for the Rockchip serial flash controller. New device
specific parameter of rockchip,sfc-no-dma included in documentation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/spi/rockchip-sfc.yaml | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml

diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
new file mode 100644
index 000000000000..05728de52921
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Serial Flash Controller (SFC)
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+  - Chris Morgan <macromorgan@hotmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - rockchip,px30-sfc
+              - rockchip,rk3308-sfc
+              - rockchip,rv1108-sfc
+          - const: rockchip,rk3036-sfc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: sfc
+
+  power-domains:
+    maxItems: 1
+
+  rockchip,sfc-no-dma:
+    description: Disable DMA and utilize FIFO mode only
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/px30-power.h>
+
+    sfc: spi@ff3a0000 {
+        compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
+        reg = <0xff3a0000 0x4000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+        clock-names = "ahb", "sfc";
+        pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
+        pinctrl-names = "default";
+        power-domains = <&power PX30_PD_MMC_NAND>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <108000000>;
+            spi-rx-bus-width = <2>;
+            spi-tx-bus-width = <2>;
+        };
+    };
+
+...
-- 
2.25.1

