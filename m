Return-Path: <linux-spi+bounces-2390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71D8A7C7D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 08:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A310F1F24205
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972B657DE;
	Wed, 17 Apr 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDIwunD3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6BB653;
	Wed, 17 Apr 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336412; cv=none; b=Uv+sTKreGFZ36JRdXs6l+QVFIXInPpIbvzvej9x/eyb+y5FDJGcsbECYE1f+2Athb16BxoYPqwcLJdyO0lDnsrMUuJ0Y5yTrxp0oeOxTKVse+ZMoXA7yn8MC9PFgEAAPodK2O7blmIGU562QtJT2bq2k9l+ojIVZxqrQsMSYCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336412; c=relaxed/simple;
	bh=2RBZtDHkLUYtly7w7G26M0FHfBqy3I8JCiYrGw2sT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sslf3+MwDS9BzbyMZLbkH04QIvv+A9AC031TbDM1jP43gyMOUr9LWaacai07Mi7N0ZYRchIzesbKo2gDXwV4Qbesos+i1t4EHK5ZG5BJ2IC18pVds1MTmSUv4dBriA0+xTnOsYe6VYE8Iey/jrGyreAvA4pBZdojyg3eJ1c/3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDIwunD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2818C072AA;
	Wed, 17 Apr 2024 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713336412;
	bh=2RBZtDHkLUYtly7w7G26M0FHfBqy3I8JCiYrGw2sT2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDIwunD3Cu43Ocq7AgYM0TGhJ/xONy810HTr+HmqeOrZRzCQZEz8PrsagCYwlg+/m
	 V71B3xp/4xz9gr5Cr6nVppZOX8s46XAr+SBSHdsTWO7zOZjpzZJTwowJU7B+vRT0Nf
	 BeybDtB0N52LQvj/NG3egmlPbrYqpHwDwl+I1y3fx0lrGT8em4FnIBJhS30CKRHJkz
	 oKN2hrfbkV10BzjtbictLydB36bHLNPv3fv3/2vdQbjj4DcVRYKLq1txnEkC44s3Mc
	 YkT/ndXtggCBSpj/S2VFGz5TZLz8Yrk7LEM/M1VGt22hQczkBCt1rxsW7LYx/rzGll
	 OYo4pDu4+t1og==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v2 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
Date: Wed, 17 Apr 2024 08:45:50 +0200
Message-ID: <361a447b86eb71951af206d4081c2e7985811a57.1713335916.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713335916.git.lorenzo@kernel.org>
References: <cover.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha EN7581 SPI NAND controller binding

Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/spi/airoha,en7581-snand.yaml     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
new file mode 100644
index 000000000000..b449bebba601
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,en7581-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND flash controller for Airoha ARM SoCs
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-snand
+
+  reg:
+    items:
+      - description: spi base address
+      - description: nfi2spi base address
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: spi
+
+  interrupts:
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@1fa10000 {
+        compatible = "airoha,en7581-snand";
+        reg = <0x0 0x1fa10000 0x0 0x140>,
+              <0x0 0x1fa11000 0x0 0x160>;
+
+        clocks = <&scuclk EN7523_CLK_SPI>;
+        clock-names = "spi";
+
+        interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "spi-nand";
+          reg = <0>;
+          spi-tx-bus-width = <1>;
+          spi-rx-bus-width = <2>;
+        };
+      };
+    };
-- 
2.44.0


