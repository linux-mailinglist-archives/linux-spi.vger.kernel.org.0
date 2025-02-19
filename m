Return-Path: <linux-spi+bounces-6875-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CFA3B321
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 09:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339CC3AC21A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A231A1CAA85;
	Wed, 19 Feb 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VRLkQ2Qp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF851C9B62;
	Wed, 19 Feb 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952238; cv=none; b=iXna6rxceZn+3mIH9mBMzJ6IOHus0/U6jmDq/qgmu0qf8Iat7wGyarrUlr+9VoIRFu9S0RTeEdVgXyxsiNXZ9hZLtdRp8Ruvr8hgV5KHLfTBLG7cbTkVAG0ajWQ31FG+mO/3VydHIUulq/8O23kxyPTrRp1tCE+RAcJS6nyyUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952238; c=relaxed/simple;
	bh=XNs1qX7okH6VZNCKxUxnV8Chyz8FxpHv8PlcW7Ck40E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXFUa0ZDFz87H7i/Ybo2djRuIiAk2WWXpQM++FGpfKvFOZgN2tpYQjwzxvhyAb+4e6eJTnDOqWlI3tSXKh2rikOAfE7QNGQW2uHlQhy/25VvmGX+mD6N30PNu4XUVbbq1N/ma+O+S6mhehrr2oxGhTCxXzIxJuEZVv3096PERgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VRLkQ2Qp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J4sxfG027076;
	Wed, 19 Feb 2025 09:03:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KZ+/BGErvkGjXMrXE43CO+5oKVL7s9ZoG9/n9+xAIPk=; b=VRLkQ2QpjrN4pSAw
	uX7uOKNLAiBhHKQqd8vuqDYHdfxpamzSR9yIJNVe/U/lqnuiDIYfvqlGqi+/0C1p
	gwEx6T+nxNuQd1vRCF39EQnG3imk3VsvydyTNE9nkj49LMFdqgpnTtcyS8a57gNi
	zfVDMv/ZibZI0adusyQ6KBkm0ed1crDY4Z8RvNheJSdHEISz+jy67dqjavfg5K6D
	HWy+dJS+NzG4h8Xe4n7kX3ED7dkfLZe9l/ji5w42CTp5YJSRkxhza0peikGOVB+F
	ZWlh4wkr+Ta0JE1gnzqDK6Ab6pyWl2l6sHNhiAHm5jtHAw6uNx32JD7yRKKm5zr2
	pp+tIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44vyyna8rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:03:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AB85D4004A;
	Wed, 19 Feb 2025 09:02:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62FA743E474;
	Wed, 19 Feb 2025 09:01:13 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 09:01:13 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/8] dt-bindings: spi: Add STM32 OSPI controller
Date: Wed, 19 Feb 2025 09:00:52 +0100
Message-ID: <20250219080059.367045-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219080059.367045-1-patrice.chotard@foss.st.com>
References: <20250219080059.367045-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add device tree bindings for the STM32 OSPI controller.

Main features of the Octo-SPI controller :
  - support sNOR / sNAND / HyperRAM™ and HyperFlash™ devices.
  - Three functional modes: indirect, automatic-status polling,
    memory-mapped.
  - Up to 4 Gbytes of external memory can be addressed in indirect
    mode (per physical port and per CS), and up to 256 Mbytes in
    memory-mapped mode (combined for both physical ports and per CS).
  - Single-, dual-, quad-, and octal-SPI communication.
  - Dual-quad communication.
  - Single data rate (SDR) and double transfer rate (DTR).
  - Maximum target frequency is 133 MHz for SDR and 133 MHz for DTR.
  - Data strobe support.
  - DMA channel for indirect mode.
  - Double CS mapping that allows two external flash devices to be
    addressed with a single OCTOSPI controller mapped on a single
    OCTOSPI port.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/st,stm32mp25-ospi.yaml       | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml

diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
new file mode 100644
index 000000000000..5f276f27dc4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,stm32mp25-ospi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Octal Serial Peripheral Interface (OSPI)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp25-ospi
+
+  reg:
+    maxItems: 1
+
+  memory-region:
+    description:
+      Memory region to be used for memory-map read access.
+      In memory-mapped mode, read access are performed from the memory
+      device using the direct mapping.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: phandle to OSPI block reset
+      - description: phandle to delay block reset
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  st,syscfg-dlyb:
+    description: configure OCTOSPI delay block.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: phandle to syscfg
+      - description: register offset within syscfg
+
+  access-controllers:
+    description: phandle to the rifsc device to check access right
+      and in some cases, an additional phandle to the rcc device for
+      secure clock control.
+    items:
+      - description: phandle to bus controller
+      - description: phandle to clock controller
+    minItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - st,syscfg-dlyb
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    spi@40430000 {
+      compatible = "st,stm32mp25-ospi";
+      reg = <0x40430000 0x400>;
+      memory-region = <&mm_ospi1>;
+      interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+      dmas = <&hpdma 2 0x62 0x00003121 0x0>,
+             <&hpdma 2 0x42 0x00003112 0x0>;
+      dma-names = "tx", "rx";
+      clocks = <&scmi_clk CK_SCMI_OSPI1>;
+      resets = <&scmi_reset RST_SCMI_OSPI1>, <&scmi_reset RST_SCMI_OSPI1DLL>;
+      access-controllers = <&rifsc 74>;
+      power-domains = <&CLUSTER_PD>;
+      st,syscfg-dlyb = <&syscfg 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-rx-bus-width = <4>;
+        spi-max-frequency = <108000000>;
+      };
+    };
-- 
2.25.1


