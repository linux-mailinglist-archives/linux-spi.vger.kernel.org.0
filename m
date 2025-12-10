Return-Path: <linux-spi+bounces-11844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA0CB282B
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C22DC30052B0
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D43302157;
	Wed, 10 Dec 2025 09:15:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2230FF08;
	Wed, 10 Dec 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358110; cv=none; b=dXmw1urRcrs62AdMWiPw92mqZv7USmsNcSzSocDSQDJm9JC0BNf95HGAUcj90YYtii0GqgfFxm5TFQYVnGEcPFytFPrBzEAwL7pZG6zQjalzWF5f2BbZ9qRcYtdJ9olYfaExjDMUFBrsJZbZoqwQWouk6SRXXhwYGnjdx1bXOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358110; c=relaxed/simple;
	bh=xdosuEtAIx5iwzgPzzbm5ReGdZNgXrbWk8BHacZVMLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYkZGeOhjBVJguj61oflg7E28Tf2yLwO2AMyqCQo7E4um8AkO5V4RBuLO9pSiBQrORg/2Eeqfoy3+l2TdiMWZhToRfLpEExpXdmzJmsbn3aInzkAefN/NBZIPDXyvAIx8Gq9gEJI3RUCnVgTTrdD/otwIIfr3FOluR4llC96JD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 5BA956NU081295;
	Wed, 10 Dec 2025 17:05:06 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BA94kSk080809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 10 Dec 2025 17:04:46 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Dec
 2025 17:04:46 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI controller
Date: Wed, 10 Dec 2025 17:04:28 +0800
Message-ID: <20251210090430.3602380-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210090430.3602380-1-cl634@andestech.com>
References: <20251210090430.3602380-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5BA956NU081295

Document devicetree bindings for the Andes ATCSPI200 SPI controller.

Signed-off-by: CL Wang <cl634@andestech.com>
  - Dropped the "spi_" prefix from dma-names as suggested.
  - Updated the DT binding and documented all compatible strings.
  - Added the "andestech,ae350-spi" compatible string.
    
    AE350 is part of the AndeShape™ platform family and is a commercially
    supported product with a fixed, documented SoC-level architecture (memory
    map, interrupt topology, and peripheral integration). Although AE350 is
    often deployed on FPGA boards, the platform behaves as a stable SoC
    integration rather than a prototype.
    
    Upstream Linux already accepts FPGA-based platform-level compatible strings
    for stable SoC-like integrations. For example, the Tensilica FPGA platform
    uses:
    compatible = "cdns,xtfpga-spi";
   
    Following the same rationale, "andestech,ae350-spi" is proposed as the
    platform-level compatible string for AE350-based devices.

    More information about AE350 can be found at:
    https://www.andestech.com/en/products-solutions/andeshape-platforms/ae350-axi-based-platform-pre-integrated-with-n25f-nx25f-a25-ax25/

---
 .../bindings/spi/andestech,qilai-spi.yaml     | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
new file mode 100644
index 000000000000..e58e6d675d70
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/andestech,qilai-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes ATCSPI200 SPI controller
+
+maintainers:
+  - CL Wang <cl634@andestech.com>
+
+properties:
+  compatible:
+    enum:
+      - andestech,qilai-spi
+      - andestech,ae350-spi
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
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@f0b00000 {
+        compatible = "andestech,qilai-spi";
+        reg = <0x0 0xf0b00000 0x0 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&clk_spi>;
+        dmas = <&dma0 0>, <&dma0 1>;
+        dma-names = "tx", "rx";
+
+        flash@0 {
+          compatible = "jedec,spi-nor";
+          reg = <0x0>;
+          spi-tx-bus-width = <0x4>;
+          spi-rx-bus-width = <0x4>;
+          spi-cpol;
+          spi-cpha;
+        };
+      };
+    };
-- 
2.34.1


