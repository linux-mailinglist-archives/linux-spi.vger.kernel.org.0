Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97A5E5FE5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiIVKab (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiIVKa1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 06:30:27 -0400
X-Greylist: delayed 1552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 03:30:24 PDT
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF958D0784
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 03:30:24 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4I-00Bx19-Ag
        for linux-spi@vger.kernel.org; Thu, 22 Sep 2022 12:04:30 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4I-00Bx15-6C; Thu, 22 Sep 2022 12:04:30 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obJ4H-004cfJ-JM; Thu, 22 Sep 2022 12:04:29 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: [PATCH 1/3] dt-bindings: arm: airoha: Add documentation for Airoha SPI controller
Date:   Thu, 22 Sep 2022 12:04:08 +0200
Message-Id: <20220922100410.1101874-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922100410.1101874-1-bert@biot.com>
References: <20220922100410.1101874-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create documentation for accessing the Airoha EN7523 SPI controller.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../bindings/spi/airoha,en7523-spi.yaml       | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
new file mode 100644
index 000000000000..e5bc7814424e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,en7523-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7523 SPI controller
+
+maintainers:
+  - Bert Vermeulen <bert@biot.com>
+
+description: |
+  This binding describes the SPI controller on Airoha EN7523 SoCs.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: airoha,en7523-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI clock
+
+  clock-names:
+    items:
+      - const: spi
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+    spi0: spi@1fa10000 {
+      compatible = "airoha,en7523-spi";
+      reg = <0x1fa10000 0x10000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clocks = <&scu EN7523_CLK_SPI>;
+      clock-names = "spi";
+    };
-- 
2.25.1

