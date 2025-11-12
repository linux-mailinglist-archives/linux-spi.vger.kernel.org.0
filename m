Return-Path: <linux-spi+bounces-11163-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1BC5076E
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 04:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83333B0C54
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A52C21DA;
	Wed, 12 Nov 2025 03:59:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881352C08AD;
	Wed, 12 Nov 2025 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919974; cv=none; b=jV+h6933OPnv5LRsrR0act/NpVKc9f/gOOOsaw7cxCuELObFU0mBnOn7VTz1eQiGgqHumRBHb1cxxL8WbUU2prm9Gg7m/aylBCbCYFZk2LXmqFwlKxB4tD5JuQ7eKZ2WLbb5nWaKG/S4UESzsdtjv2XNLI9oVHaiQZi1TNDKe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919974; c=relaxed/simple;
	bh=bT0PZCyjbmsjUInR6RNJH4a4PjJEi4eAnmo7qh5EC4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbZW7MNGRfLd5iy5Tmeg4bDbc73ev3hA5rh2Se2tPsCSSrn52DepIJ7v3qR96KaCTJ6GzMyxN4YCdDYJ05zxIx2yAcaDeHVhMIZ4qrfTgPPCfWRJ4vhREdzPJjNFKdr8dXWy2aVFAvZkjTZzqeudJQuVyQuTCuvv3dOGOOwBcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 5AC3me9V061615;
	Wed, 12 Nov 2025 11:48:40 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5AC3lvH9061437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 12 Nov 2025 11:47:57 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 11:47:56 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH 1/2] dt-bindings: spi: Add support for ATCSPI200 SPI controller
Date: Wed, 12 Nov 2025 11:47:23 +0800
Message-ID: <20251112034724.1977630-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112034724.1977630-1-cl634@andestech.com>
References: <20251112034724.1977630-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 5AC3me9V061615

Document devicetree bindings for Andes ATCSPI200 SPI controller.

Signed-off-by: CL Wang <cl634@andestech.com>
---
 .../bindings/spi/andestech,qilai-spi.yaml     | 84 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
new file mode 100644
index 000000000000..db065062a2af
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
@@ -0,0 +1,84 @@
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
+    const: andestech,qilai-spi
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
+      - const: spi_tx
+      - const: spi_rx
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
+        dma-names = "spi_tx", "spi_rx";
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
diff --git a/MAINTAINERS b/MAINTAINERS
index dd99c073a369..55e31996df03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1803,6 +1803,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES ATCSPI200 SPI DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
+F:	drivers/spi/spi-atcspi200.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
-- 
2.34.1


