Return-Path: <linux-spi+bounces-2300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304458A1298
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D991A1F21787
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2314884C;
	Thu, 11 Apr 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOPfx/Ue"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675B1487EC;
	Thu, 11 Apr 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833756; cv=none; b=LN8xlEDuVm197hVZ9jWoEIa6y5HbUjvn/MOooC4SEsUWM/g8pja/RO7a7HKzxunbVSndGZjbsoRKpKTo6eFyrh2IONd4J4dV8kdjVO0r2WPkcQU7QlKSDzirqicHHw2aEYri+ybaO65XdwMeKUS6wP95TrCvUhar1TyuOzMPj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833756; c=relaxed/simple;
	bh=I2H9HefQdlD1cK86w3idrnAOipOEtxFPpl1w1TdFY9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCNOvH/UU2Gjxx/WOqV30gN5k1/H5/20E9Kemquv+QMY492WlJsiWxjP5JCWzd/PWBYcc3kIcl64PsuEo3L/FtOqxjQdPqdcDYJMJ+JD9xOq+af4Bh8KYAXkru0oFgSvg1rbRUHAr3mIVeBPlh9mV+dJeXct6eNlsU0FjvbzJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOPfx/Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2438C433C7;
	Thu, 11 Apr 2024 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833756;
	bh=I2H9HefQdlD1cK86w3idrnAOipOEtxFPpl1w1TdFY9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOPfx/UeyljpwVVK5B01toydAySfy9sgmQIjx6LvwA0ehvat6LabXYDCHQAKUSHr4
	 dsFuJFp3kwzr/UpIkwqUzG4wA9RTVPprwUFqwP68fFGybftxoM2FvOOuvAUjVZ6L5r
	 cJiKCvR85FRy3G3gE2JFUqvIiZgyebMbCMg4Sl+9fLmwhHxGOcAfg+XWuL4Bxc1tCZ
	 2tAZ3HtGwCG8OHqZLb7Qp1xlBmB+tAV6Oc84yBmD+/mdO/mPwtGsLI16+DFab2DwAs
	 29ex2u7xtGJW1LmjZJ+4I80eK6ld0JJHJfBABFBFSbYpmgYRh/+PM6CaDJB0IybfWR
	 feQ8OXKVGVG9w==
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
Subject: [PATCH 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
Date: Thu, 11 Apr 2024 13:08:36 +0200
Message-ID: <bbc03f8d33c538b36e366e289861b90adbe64a37.1712833493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712833493.git.lorenzo@kernel.org>
References: <cover.1712833493.git.lorenzo@kernel.org>
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
 .../bindings/spi/airoha,spi-airoha-snfi.yaml  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
new file mode 100644
index 000000000000..0244f242eff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,spi-airoha-snfi.yaml#
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
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@1fa10000 {
+        compatible = "airoha,en7581-snand";
+        reg = <0x0 0x1fa10000 0x0 0x140>,
+              <0x0 0x1fa11000 0x0 0x160>;
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


