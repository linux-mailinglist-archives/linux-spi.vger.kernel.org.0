Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1DF2EB640
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAEX3U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAEX3T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 18:29:19 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F5C061793
        for <linux-spi@vger.kernel.org>; Tue,  5 Jan 2021 15:28:39 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwvkj-00Br0R-Np
        for linux-spi@vger.kernel.org; Wed, 06 Jan 2021 00:28:37 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwvkZ-00Bqyw-AW; Wed, 06 Jan 2021 00:28:27 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwvkY-00DVB7-RM; Wed, 06 Jan 2021 00:28:26 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v4 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
Date:   Wed,  6 Jan 2021 00:28:14 +0100
Message-Id: <20210105232815.3218063-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105232815.3218063-1-bert@biot.com>
References: <20210105232815.3218063-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../bindings/spi/realtek,rtl-spi.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
new file mode 100644
index 000000000000..c600e85b819b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,rtl-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL838x/RTL839x SPI controller
+
+maintainers:
+  - Bert Vermeulen <bert@biot.com>
+  - Birger Koblitz <mail@birger-koblitz.de>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: realtek,rtl838x-spi
+      - const: realtek,rtl839x-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi: spi@1200 {
+        compatible = "realtek,rtl838x-spi";
+        reg = <0x1200 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.25.1

