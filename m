Return-Path: <linux-spi+bounces-6716-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FEA2ED7B
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 14:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E63188757D
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C324224AEB;
	Mon, 10 Feb 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HfoEt3h4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68748222579;
	Mon, 10 Feb 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193680; cv=none; b=uLaQfBK5DzBVg9IC38HMOwmKa8a4dyBPQBdgSde8qplPFEBoOalFVQntJP4VL++mJfIigN5JsyyvU3xAwrw9aQTPM4sIG8LP3RKBK9ozJf9G3pmc5LAsOdPA+Q23FCnkek3uSRJgMAV22/vjchU67SSQeaw9JeHLmthcZr+cBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193680; c=relaxed/simple;
	bh=EMtu0FkQ0LwpXYJ063w9gIszbQuKUIDXnA6NiUwwaZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1OUm43WHG4zFHawrwEn8Xq1Sv7ss/T3GlK43mm9DaBN+nOSKuLuxJJtTHZJVq4NMjl6JSVG0y9kHemLrJEOY/yTLFgN/ilBxcf5Vk9UsL5f3/nET+hzg9jmCrtIvGXEdp4VdrJRaxNQUfWydMFTbxELSSMjc91qwcSRpyuLKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HfoEt3h4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ACopkt024316;
	Mon, 10 Feb 2025 14:20:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zi9sWfS4AcvcvOsYJDRFzll/+wt+aEfG/kF8n5iSU4w=; b=HfoEt3h46rPzcq7P
	dWSkCnqrtNwcSN7Bvg7DjEVY7LEQSOKiB9r0lTJo3pCu36VYNlkEmBEkDbga4F6U
	9jtz8lk+KR0ELaKK+3bSM3EproCM9fkk+zpafuA1o60mt7eAhw/UCC9WkI0XLdRl
	/+8deqMq3aCZcbBMOVxMJWkDuITqV8AjLY4/KHMapwwlPUIrp/VbW2/DYc8zufi6
	0zzH1qCDlVEs+Ds5jw9J1zhTTRiwSD2SoJjWZp7UCS2Tq2eN7m6U2HrGLSUFx0IG
	aWwNhjvU9plTIDRg/KFYQ2ea10Gn5+uaY1mb+Q3n4kY/ZwaEYqzSl2OkmBte68U4
	tX+NPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0rhxpdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:20:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A85DB40046;
	Mon, 10 Feb 2025 14:19:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1A1925BCB3;
	Mon, 10 Feb 2025 14:18:32 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 14:18:32 +0100
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
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH v3 1/8] dt-bindings: spi: Add STM32 OSPI controller
Date: Mon, 10 Feb 2025 14:18:19 +0100
Message-ID: <20250210131826.220318-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210131826.220318-1-patrice.chotard@foss.st.com>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01

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


