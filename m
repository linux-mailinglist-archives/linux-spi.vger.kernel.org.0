Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EA2E7538
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 00:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL2XY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 18:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL2XY6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Dec 2020 18:24:58 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590FC06179B
        for <linux-spi@vger.kernel.org>; Tue, 29 Dec 2020 15:24:18 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGq-00Acex-9h
        for linux-spi@vger.kernel.org; Wed, 30 Dec 2020 00:19:16 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGg-00Acdi-5b; Wed, 30 Dec 2020 00:19:06 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kuOGf-00Ajhn-Nc; Wed, 30 Dec 2020 00:19:05 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH RESEND v2 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
Date:   Wed, 30 Dec 2020 00:19:03 +0100
Message-Id: <20201229231904.2558916-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
(resent due to mail trouble)

 .../devicetree/bindings/spi/realtek,spi.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,spi.yaml b/Documentation/devicetree/bindings/spi/realtek,spi.yaml
new file mode 100644
index 000000000000..9831df6dc40d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,spi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,spi.yaml#
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
+    const: realtek,spi
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
+        compatible = "realtek,spi";
+        reg = <0x1200 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.25.1

