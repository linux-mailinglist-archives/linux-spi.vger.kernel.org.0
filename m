Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FD397B01
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhFAUMQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFAUMP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 16:12:15 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A37C06174A
        for <linux-spi@vger.kernel.org>; Tue,  1 Jun 2021 13:10:31 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so84953oot.0
        for <linux-spi@vger.kernel.org>; Tue, 01 Jun 2021 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcUUMExtnu0Erc+KV6ZLS5k3H19BD2zY2/L6Th+LVvs=;
        b=HYrYh1I8tDUYUIrssrpdcJcKrijkLQvDplLmwbrnKEolJDbNUacH0VTBj7j0+iK9ZR
         0iqS2Pfr/gQmDjBIyokiAchJiyicRqeWhbna9R0TZM6Ne2G4mYxIUHW5isEyuOfzBmAv
         6/vrPBowiFxMhcieAa0tO5HIWEeRGPmvt2WYlk4vuzbMV0YX4muMq4g1dvJcxpHdg1Xm
         OX4rHlEIru0aL9KjhJ76RbUF8m2An45FTkVNln8cs//jeUiirRVsZ/8gyXuJHFbP6JaB
         yVVRl/J6OY3N1wg/5ujle+Pptdw87jDeNzvgzaigWVy9sKocS5QmkDNOlAPdLUM8X4fv
         v7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcUUMExtnu0Erc+KV6ZLS5k3H19BD2zY2/L6Th+LVvs=;
        b=qP2ZzB2gchYEtj5X+jICJIhXP1rulGR++OAGnfEotnfsXyjYSDM3QlhGOStSLY08t2
         zM/QnpbOr2zHKKQVR9FMmg5VRQ4YLyBxmeGKKUITlpiyL4C8Gki5SfoMYPfzBlk6sgqr
         9GpY8zUv8EunU/XNJYX2tZd/UiINiR95rKoQLmVIRpjSeeulD1s/ncVm3uwMJpfqnU57
         8FF+zTmapht9NUNyMMF5YBwJNOe9zPlG8i7GgNHszSAEFvw1hvyT+0QS9bGbK5agXSPJ
         BL6k4zTVen0CX3TRMIpUgns/zjkBu0zN2ACLWlknhDgz+KnMJuTFbEctrxsrH0SXXNeg
         hMmQ==
X-Gm-Message-State: AOAM5305jS1zal3lu1Bk4DCGZ+7zqKsrdoG9rCqTBdx9b92IM19hXS/H
        u+4S08mVTtD+jkFrJMjNlN3liK6pBbI=
X-Google-Smtp-Source: ABdhPJyfYNvCuMl5zFmhxki/Kb1XoDS0IsWbq1QMPdOCAgCmGmZJWjuBvTeJiTPly57HWh9iMUewXw==
X-Received: by 2002:a4a:d809:: with SMTP id f9mr15514840oov.71.1622578230370;
        Tue, 01 Jun 2021 13:10:30 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p25sm468118ood.4.2021.06.01.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:10:29 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 1/4] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
Date:   Tue,  1 Jun 2021 15:10:18 -0500
Message-Id: <20210601201021.4406-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601201021.4406-1-macroalpha82@gmail.com>
References: <20210601201021.4406-1-macroalpha82@gmail.com>
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
 .../devicetree/bindings/spi/rockchip,sfc.yaml | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip,sfc.yaml

diff --git a/Documentation/devicetree/bindings/spi/rockchip,sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip,sfc.yaml
new file mode 100644
index 000000000000..d5f8edd621ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/rockchip,sfc.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/rockchip,sfc.yaml#
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
+      - const: rockchip,px30-sfc
+      - const: rockchip,rk1806-sfc
+      - const: rockchip,rk1808-sfc
+      - const: rockchip,rk312x-sfc
+      - const: rockchip,rk3308-sfc
+      - const: rockchip,rv1108-sfc
+      - items:
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
+    vendor,bool-property:
+      descrption: Boolean value for disabling DMA
+      type: boolean
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
+
+    sfc: spi@ff3a0000 {
+        compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
+        reg = <0x0 0xff3a0000 0x0 0x4000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+        clock-names = "sfc", "ahb";
+        pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
+        pinctrl-names = "default";
+        power-domains = <&power PX30_PD_MMC_NAND>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <108000000>;
+            reg = <0>;
+            spi-rx-bus-width = <2>;
+            spi-tx-bus-width = <2>;
+        };
+    };
+
+...
-- 
2.25.1

