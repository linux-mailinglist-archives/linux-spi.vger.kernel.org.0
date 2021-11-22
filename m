Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDE458809
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 03:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhKVCgn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Nov 2021 21:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhKVCgm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 21 Nov 2021 21:36:42 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9816C061574;
        Sun, 21 Nov 2021 18:33:36 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x5so14811174pfr.0;
        Sun, 21 Nov 2021 18:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6Y3UkL0jOnu3RZLect1uIou7kaWIw2ExAw+aME818xE=;
        b=RN3mlej9PggWicSRStx1mdXy8PtB0IgBXwH/RB5kHAZFPnJeBnqkOy1VO1EDjrF0CD
         UNbNihsRAHWvEvqA09c920gRWaY9rTuLo5qArf7OAnO92i0PxzXGV5Ta8ue/oVTKXX8n
         3jupDJB83+AAcNjvylF5IrrOd9bGeWVZO8aBoekgnWrIxWcWDo+oW2RdobclQLmqnV0q
         HpzFRy/nFelVeJKuz4xr3bpRVV/dtBynt3NERwuMZnLTsnFITHI/XpGu1FAd44E6GJ6R
         EJj8eP4MBu43QzoNI6owkLW4dx0BTZ+KY3YxGZbYt9DAG+mWlaLKYOugAUyz/9BK2koq
         f42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6Y3UkL0jOnu3RZLect1uIou7kaWIw2ExAw+aME818xE=;
        b=2KGm04vjA6mQhGDi29oDr8xvxn2gWF5WEx8UeX6mPux0PmPhW8yWk4CSqjaPdWM4Wo
         gZN5k7TZQZEg4qV3ryRY1vSFXikaeRycIfa+yCOFqoV+/t7osW7nlxRJ7Zto8pnC4bbi
         Z1xmNfDcJhW2o/miRZwA5fFEfMtfEzsKG3YRSabJHORk5c2ALuNduDYa91GkHA1PCTJd
         MEodpeWcPfMjY3UTwdL+1exKKoPKPOfvQaMPi6vdWkXUdpnljdvZvV0v7OfXAkTkjoRP
         p+d7ZFC6xT6TC7YWD+nuyaNu6Plv/WTqkHZ67Fwc3DB2DM1qWTUWQmys1zUjbumVmNaZ
         3xJw==
X-Gm-Message-State: AOAM531CrRSFJMEzRnLTgZvADOIMMC4JNwWnbUO40GMkLNlcrmHR9drc
        81rYZcVwx+LhjKbsWt8VQf6SZ69xXnCUYtvd
X-Google-Smtp-Source: ABdhPJzmVMRCVBVQhhqz2GjVI1k+L6SrcDlxffdHxWazU34Y1wDaNQaoWy46/lBAwZEsEF9v7VnQjA==
X-Received: by 2002:a62:884c:0:b0:49f:9947:e5cd with SMTP id l73-20020a62884c000000b0049f9947e5cdmr41232056pfd.45.1637548416126;
        Sun, 21 Nov 2021 18:33:36 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m6sm4673207pgl.2.2021.11.21.18.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 18:33:35 -0800 (PST)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     p.zabel@pengutronix.de, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH v3 2/2] devicetree: bindings SPI Add bindings doc for Sunplus SP7021
Date:   Mon, 22 Nov 2021 10:33:33 +0800
Message-Id: <7b8353666052fc42647fce833485b271df8dbc9f.1637547799.git.lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1637547799.git.lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com>
In-Reply-To: <cover.1637547799.git.lh.kuo@sunplus.com>
References: <cover.1637547799.git.lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
Changes in v3:
 - Addressed all comments from Mr. Mark Brown
 - Addressed all comments from Mr. Philipp Zabel
 - Addressed all comments from Mr. Rob Herring
 - remove spi transfer_one_message

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
index 75fa7d5..88f3747 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18220,6 +18220,7 @@ SUNPLUS SPI CONTROLLER INTERFACE DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
 SUPERH
-- 
2.7.4

