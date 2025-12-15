Return-Path: <linux-spi+bounces-11886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFFCBE0B8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B821C301B3B1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7693314AB;
	Mon, 15 Dec 2025 13:24:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70B331A52;
	Mon, 15 Dec 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805073; cv=none; b=mSZXkBBI2w5wgC8zNv353L9eYYGbYb9VR/fXRsSvnB4PSQ2YeyAhsP/uqKGWuy5WNHvgBPat3675I7mwSm83U8Ub+O1b18wuHJdyXtw2CbYXwQvTAXoJt142vEc+IUHxYC0918CyCTkimIOhVpfwi/emOxtUgnh8q7VeF4NzNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805073; c=relaxed/simple;
	bh=dT36iiWpLNn9sqJzfMR2bdVr5vvdXX10afAZCfarpy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEb4oaYyLxg67r2+wzrkUCcniXI7Z7hlRzTgbSFQVPH6Ui9xLSqF8QjC60QO852i6i1is1gYzf3JFZvSI/35oJvoYnCimTaRTxRlhxYQZGFrPJAH2EzRbJKvqTO4oDyeJD6+eIMl8bDA/dH8pzQfVXi2ldU53GS4TdEipA+7kWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BFDO4vA076819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Mon, 15 Dec 2025 21:24:04 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Dec
 2025 21:24:04 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V3 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI controller
Date: Mon, 15 Dec 2025 21:23:47 +0800
Message-ID: <20251215132349.513843-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215132349.513843-1-cl634@andestech.com>
References: <20251215132349.513843-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5BFDO4vA076819

Document devicetree bindings for the Andes ATCSPI200 SPI controller.

Signed-off-by: CL Wang <cl634@andestech.com>
---
Changes for v3:
  - Reworked the DT binding to properly describe the compatible fallback
    relationship, defining "andestech,qilai-spi" as a platform-specific
    compatible that falls back to the generic "andestech,ae350-spi".
  - Renamed the DT binding file from 'andestech,qilai-spi.yaml' to
    'andestech,ae350-spi.yaml' to match the generic fallback compatible.
  - Updated the 'compatible' property to use a 'oneOf' schema, enforcing
    the fallback requirement for the specific compatible string.

Changes for v2:
  - Dropped the "spi_" prefix from dma-names as suggested.
  - Updated the DT binding and documented all compatible strings.
  - Added the "andestech,ae350-spi" compatible string.
 
---
 .../bindings/spi/andestech,ae350-spi.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
new file mode 100644
index 000000000000..78093468dd5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/andestech,ae350-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes ATCSPI200 SPI controller
+
+maintainers:
+  - CL Wang <cl634@andestech.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-spi
+          - const: andestech,ae350-spi
+      - const: andestech,ae350-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  num-cs:
+    description: Number of chip selects supported
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: Transmit FIFO DMA channel
+      - description: Receive FIFO DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      spi-rx-bus-width:
+        enum: [1, 4]
+
+      spi-tx-bus-width:
+        enum: [1, 4]
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@f0b00000 {
+        compatible = "andestech,ae350-spi";
+        reg = <0xf0b00000 0x100>;
+        clocks = <&clk_spi>;
+        dmas = <&dma0 0>, <&dma0 1>;
+        dma-names = "tx", "rx";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-tx-bus-width = <4>;
+            spi-rx-bus-width = <4>;
+            spi-cpol;
+            spi-cpha;
+        };
+    };
-- 
2.34.1


