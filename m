Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26B01CFFCA
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgELUpz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:45:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37888 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgELUpu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:45:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id r66so19482390oie.5;
        Tue, 12 May 2020 13:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CmdYdYec1rQhzzC/CQmIUigvR0RXVGe0AhkcyhVUQc=;
        b=umzFtOtRdHL55DFwi7O4QRvOP14GQoTDcjcGfb3kwzw/uahccF8ndl3+7kVlGbzFJK
         SQyrfGDkUbOS9hyh3XUulYmj/zR7TPljJPsd8S13T16pwS5vWDN4YmwCJ746oZVmj1nP
         ZMBo+GiFJSgnwvDNosjA+EhSyq/I1licSKNFZjBtUl4tUPubeU9SyXpKK1IeKQ6sJ5BX
         eNhhpv0WZr5j87vL1E60ePvUKAdvypu4oHeNNNCjqbqyiGdoMsxI/WGDyEf8Hz45ciIg
         1C0oJtKlwoevog3oa0oLzU+mXngfHa7n4A8RUO7AXl97XolxSJkWup38eP9WAlUaMF+2
         GWrQ==
X-Gm-Message-State: AGi0PuZOBsDMBoia4C/CPmSGf5K7qPc8a7luXvUz4LASOpxQhkeSyNsq
        O+JCXdB2MrDi9lUphF90/Sgaqns=
X-Google-Smtp-Source: APiQypKaCowSSCmSiYsr3sbFUCH1scVUF6kLbsI/9cGr7DfFXVIHt7LPGzSirz02jmkJo/42xDgaBw==
X-Received: by 2002:aca:aac2:: with SMTP id t185mr24324925oie.53.1589316347616;
        Tue, 12 May 2020 13:45:47 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k8sm3943792ood.24.2020.05.12.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:45:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 3/5] dt-bindings: ufs: ti: Fix address properties handling
Date:   Tue, 12 May 2020 15:45:41 -0500
Message-Id: <20200512204543.22090-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ti,j721e-ufs schema and example have a couple of problems related to
address properties. First, the default #size-cells and #address-cells
are 1 for examples, so they need to be overriden with a bus node.
Second, address translation for the child ufs node is broken because
'ranges', '#address-cells', and '#size-cells' are missing from the
schema.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack, dependency for patch 5.

 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml | 57 ++++++++++++-------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
index c8a2a92074df..b503b1a918a5 100644
--- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
@@ -25,6 +25,14 @@ properties:
   power-domains:
     maxItems: 1
 
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
 required:
   - compatible
   - reg
@@ -44,25 +52,32 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    ufs_wrapper: ufs-wrapper@4e80000 {
-       compatible = "ti,j721e-ufs";
-       reg = <0x0 0x4e80000 0x0 0x100>;
-       power-domains = <&k3_pds 277>;
-       clocks = <&k3_clks 277 1>;
-       assigned-clocks = <&k3_clks 277 1>;
-       assigned-clock-parents = <&k3_clks 277 4>;
-       #address-cells = <2>;
-       #size-cells = <2>;
-
-       ufs@4e84000 {
-          compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
-          reg = <0x0 0x4e84000 0x0 0x10000>;
-          interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-          freq-table-hz = <19200000 19200000>;
-          power-domains = <&k3_pds 277>;
-          clocks = <&k3_clks 277 1>;
-          assigned-clocks = <&k3_clks 277 1>;
-          assigned-clock-parents = <&k3_clks 277 4>;
-          clock-names = "core_clk";
-       };
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ufs-wrapper@4e80000 {
+            compatible = "ti,j721e-ufs";
+            reg = <0x0 0x4e80000 0x0 0x100>;
+            power-domains = <&k3_pds 277>;
+            clocks = <&k3_clks 277 1>;
+            assigned-clocks = <&k3_clks 277 1>;
+            assigned-clock-parents = <&k3_clks 277 4>;
+
+            ranges = <0x0 0x0 0x0 0x4e80000 0x0 0x14000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            ufs@4000 {
+                compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
+                reg = <0x0 0x4000 0x0 0x10000>;
+                interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+                freq-table-hz = <19200000 19200000>;
+                power-domains = <&k3_pds 277>;
+                clocks = <&k3_clks 277 1>;
+                assigned-clocks = <&k3_clks 277 1>;
+                assigned-clock-parents = <&k3_clks 277 4>;
+                clock-names = "core_clk";
+            };
+        };
     };
-- 
2.20.1

