Return-Path: <linux-spi+bounces-5543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E199B5E69
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A131F23EA7
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668F1E22FA;
	Wed, 30 Oct 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX99Vf+g"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328A1E22F1;
	Wed, 30 Oct 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278982; cv=none; b=YE4dEonYhSH+DLhq21nSrqtAV+wvK3ecHQv8Wn5rUYmAsH6ENVNm31EJj9loN0tVhqjVCHgLpPXdk4WECx8nqwWczjh9vp7hIUIrkxx31mkXPPiyfKuy2lcQnNPKoMhXPDsFrmkOg3GswPvuubO72kd2E2AS3QWD/BMGuNsiFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278982; c=relaxed/simple;
	bh=dU6kW0lbJ7W6cNtmtkwRe5AnMDlcFz7ozLB2+3J3sPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SlJu/B/9ltQe03GZjYsQRRZj4Uq2OCeTm9284FdKLtaZorNow62XAemUG9PAkvni868c2UePN5JsAahFgKl3zPiqGp3d4V4GUmwzzQ+WRF9aulBie9aL8HvL8ST14M2vMXJLZcvCRNQsf0qtCNtlCvdQq3EZc+GJMR7tgZquhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX99Vf+g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a156513a1so994958866b.0;
        Wed, 30 Oct 2024 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730278978; x=1730883778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QY3K+LudkfMZKKT+d+izxu3HB5MhAXCFdisfeoz3S0A=;
        b=nX99Vf+gxPst7xomSeoNzjqZR7FxHHbRO4e0X4us6uHKGpzReM9Dn95pTx/3MDHnRe
         9Hf3psPfbxTGWHsucHVuCaN6EFbsUFYND4zxY0dXluv7c6hgrs7qkcftGtn4vwwsbOJh
         yViUInqwir0IiH62xmkkXZENFc+UYQzxIHuJB2YDCh56LD8bZQ5uhYxML3OX/5yfTNtx
         jACZ8ATEWc8wDA1y3iXDUtpiJxyXhSEFgomB9tVzFQ8TsaDip1qJbZb2Fo5bcokyILOG
         qxBqPV9uIg4cAAVesPWIM+BziLPOtiOo/3j4mcCbfKGQuPj0eICodaljuBnQ5roKmg2o
         rPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730278978; x=1730883778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY3K+LudkfMZKKT+d+izxu3HB5MhAXCFdisfeoz3S0A=;
        b=lr48h2N0qFyRYnXsvRxansPWLA2N+c9jQOl4KBd1rTDO95XPqHWFTR7AGZJk4MVF6w
         VngwYCjTxuWMp6ULzoUF2AEl6CkDuMfmgv2vVFQMJtmwS3+5SmzXnad8qh1ttkW367x0
         21DjTjQcH5L05cDgFA/Ft3tv7xB5u9xZaN7j/dNghOMLzlGM6Sl9/kaW+8aGGXyWd/F6
         /4TC0LLKL7OlbPnK6MJCmwp6GhHGAzF3Zr0RMlvhgU4O2z7gaonUKuk7CGN9mWYSnTnZ
         KUEoN/pR5tPieLDkykfoU4FZXxolbMqLtJ+DvgvtTVomaksIQuIIC79hxH4AQRRM3FHh
         F28w==
X-Forwarded-Encrypted: i=1; AJvYcCUPX5reDVq4VLuNN0bfY5FxiDQpSU+n+IHLxJTQHSqIu8z9opb9tDQE9cNRRaRnFaYzS0ObdeO0Mf+F@vger.kernel.org, AJvYcCVDqlekw2jYnUeT6IlsfJLNR/LnyY/Lnu4yxjhDgV/s3vhSE/+9lafsbcjmxU7+wnH+krNHCQV26IoTgV9n@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+b4A2E19lyPqfZTediAO/Orkha0b4hhT1sbV/cF/g18qAPCM
	x/SpprRKVsRgj5jn4/uO449JdOlH2+Eb/IuRDoBizo6HzR9jZpiPcjjjNA==
X-Google-Smtp-Source: AGHT+IGGWqX19OwbV8ViA2xiA+WO9X0yfEipKJJ1R8ew060L1quQ6mJj8dZjmAskUNJI0iXdmToNvQ==
X-Received: by 2002:a17:906:f59b:b0:a99:4780:1af with SMTP id a640c23a62f3a-a9de5f6e2eemr1444336166b.31.1730278977705;
        Wed, 30 Oct 2024 02:02:57 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a084b10sm554906066b.195.2024.10.30.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:02:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:02:55 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: sprd,sc9860-spi: convert to YAML
Message-ID: <ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC9860 SPI controller bindings to DT schema.
Adjust filename to match compatible.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../devicetree/bindings/spi/spi-sprd.txt      | 33 ---------
 .../bindings/spi/sprd,sc9860-spi.yaml         | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
deleted file mode 100644
index 3c7eacce0ee3..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Spreadtrum SPI Controller
-
-Required properties:
-- compatible: Should be "sprd,sc9860-spi".
-- reg: Offset and length of SPI controller register space.
-- interrupts: Should contain SPI interrupt.
-- clock-names: Should contain following entries:
-	"spi" for SPI clock,
-	"source" for SPI source (parent) clock,
-	"enable" for SPI module enable clock.
-- clocks: List of clock input name strings sorted in the same order
-	as the clock-names property.
-- #address-cells: The number of cells required to define a chip select
-	address on the SPI bus. Should be set to 1.
-- #size-cells: Should be set to 0.
-
-Optional properties:
-dma-names: Should contain names of the SPI used DMA channel.
-dmas: Should contain DMA channels and DMA slave ids which the SPI used
-	sorted in the same order as the dma-names property.
-
-Example:
-spi0: spi@70a00000{
-	compatible = "sprd,sc9860-spi";
-	reg = <0 0x70a00000 0 0x1000>;
-	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "spi", "source","enable";
-	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
-	dma-names = "rx_chn", "tx_chn";
-	dmas = <&apdma 11 11>, <&apdma 12 12>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml b/Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml
new file mode 100644
index 000000000000..d55c01e9a038
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/sprd,sc9860-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC9860 SPI Controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,sc9860-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI clock
+      - description: SPI source (parent) clock
+      - description: SPI module enable clock
+
+  clock-names:
+    items:
+      - const: spi
+      - const: source
+      - const: enable
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx_chn
+      - const: tx_chn
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@70a00000 {
+      compatible = "sprd,sc9860-spi";
+      reg = <0x70a00000 0x1000>;
+      interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+      clock-names = "spi", "source", "enable";
+      dmas = <&apdma 11 11>, <&apdma 12 12>;
+      dma-names = "rx_chn", "tx_chn";
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+...
-- 
2.43.0


