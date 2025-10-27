Return-Path: <linux-spi+bounces-10849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD0C0DC4B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EB93AFA0D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820226E6FB;
	Mon, 27 Oct 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="exODC324"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFF244691
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569715; cv=none; b=acngwEmsmZdq5FJ4uyaDyh16rd3boehJXjvEOrEy+5nVWUsTBhKGe0DK0Yd/zE/39u0Sr9BuligS5pSVtnh5sQBTxGtw+SOfVNkCQWOA2dF4kw+B+hy3Kn9celoJyIleSuIQAhOYxqm/qBDdZA9rYdWFNYF5KBlncHMGtvm7l/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569715; c=relaxed/simple;
	bh=Kb8uM3f8qILwL0GDllY38o85KB9kJ69KatRC0T8EZTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVf4O/nLufl2BgBfEV44xHCQGwJozfYW19Rk87fhRlytnNL+IOvb+RbfYz0Htt7eiqhZS3OPyn/7zKnBXOHPlaGjGxsbMhzshCqnQxjfgC0Alz9NPRW/7CoomPFlXH5Uc5UaB7Ss7MhXT9vo03qIxiP695zTY6A/a90CTyAHpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=exODC324; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-92790f12293so210983539f.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761569711; x=1762174511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=exODC3241u8WAzsD21msZI35CFcZKgWnLu50wEWERIdbCFC7h74xHfmx+uKH9ocuWF
         BTn1om1WijRmWF3diGHOp2TLBrKk0iaGE5L2swD9V9XAItH2JwRdAOg4bhx2cDkuvYYp
         +yluNoDEFYhuY3mHtt79nvrW5sFviBwFKvr9sX5C8dryAcpiR/VZ9PY76twPiHBtpoI9
         QGLSeRwmTjaUDGgIdmvNXxW8klmDry8DjdyhmWJ0UyqTQ8B3hZKG4+M5oCkDbBnhOfh6
         Gce/qZV1KBuhj5tICzRbP4cUHPOg4u8m3Usk1IULkgiUUnzJfqKg0Phkd24ID9729LiP
         fR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569711; x=1762174511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=YGW1oMQRUmyo9vX3PBou5aKaE1WftPVOxPLdn0pnLAp6006AYImn92DcUD96VEpHHV
         EP9aRahtfM091rsZTsqrUaJ0k6CvzQPa22PXTu323z0QiY2+T/4OTV/SHkUbABjL96UH
         M7RWrM+lgEHl2wRaUS8E5I/Aao70M/9KTE90FJPTmqroGpa0H6BHbcx+lsyUBQ0EN+VC
         Gm4x05AMbs/QXRrgOBhNfjq3rI7A2aIvKkZf1kR8TwmdXMivwHK7SBt3FeFGp0sfrA/U
         5B4GOd7lPlr/El0PW1jhPbKxCRRTpQPH3fK1PzBsK4jih9UF58esYxfc3xMNK7Nzi3AW
         5chg==
X-Forwarded-Encrypted: i=1; AJvYcCVPmOAmrIqhBM2kvoCWDbK11uoUENADK+n/1RRqRKn1z+lhhtLowZMYQ1xtbPNy/705NI/d3K7nb9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGkr4/INJbUzwP4rnAL17FjP6NVi6dPG+ohximZgIRkA2rUAX
	/bxjGWHhvSudZjyoZ9Pb8rptDY9VjJjU0yU2Bg/NyBcUGiiaS+wfpcyeEYI/IYWhTbs=
X-Gm-Gg: ASbGncujltprLqpGqd8FtzpGseqF5LnF8lshemTydoQJ4K5SLJcaCsMrE0LLfz8QNoE
	tNkn3PdZDEclwHxv0wePSL1i/aNEfY+xxq9ov9YY7WaP0AaN/yKeRM8KSBv+9eMSbMEZ9d74+y6
	uVVPlOjYcKb3xtI9cF87WT02Gd2ldh655bRiJTia2u24pKjFZ1WpETcAsfFf4BZZ+Ar0LCPsv5U
	U5d3RgFvRCTNneqDoVO4cyNkh9MMbSAyuMwv86u4sXYmktR69SMYN/kiIMQgTGHDZMWGFm9wt0T
	xAjh7ihp00GBi8hs0kDvru851b1m+hgTG3Q5l5NQQu2/sOr1DW4R/mf0GhmSEr+tVA3qbJdETzO
	CunWCbqX+u6A8HQ3QKo8QHfj38tzMeDCWAbAm1e+m95k4XNvJSz4nvbUsIUSnAMPpIH6uLT27RL
	o4UNavQBK6JMiRKOPIbo/G3+JPlZA+AkzHCp8jWdARKnQfwya5jXHmww==
X-Google-Smtp-Source: AGHT+IEZEkJbHyJsLtQ9RwbUNNRM89do/GpofJnj3gjkHzKLnBs02AOz2LkYBC9YjYewuyvy3xtdnw==
X-Received: by 2002:a05:6602:c85:b0:945:a198:7726 with SMTP id ca18e2360f4ac-945a1988c63mr751875839f.5.1761569710940;
        Mon, 27 Oct 2025 05:55:10 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359e742efsm249121639f.7.2025.10.27.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:55:10 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Mon, 27 Oct 2025 07:55:01 -0500
Message-ID: <20251027125504.297033-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027125504.297033-1-elder@riscstar.com>
References: <20251027125504.297033-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/spi/spacemit,k1-spi.yaml         | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..e82c7f8d0b981
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Alex Elder <elder@kernel.org>
+
+description:
+  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
+  FIFOs, for transmit and receive.  Details are currently available in
+  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
+  K1 Documentation[1].  The controller transfers words using PIO.  DMA
+  transfers are supported as well, if both TX and RX DMA channels are
+  specified,
+
+  [1] https://developer.spacemit.com/documentation
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Bus clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: RX DMA channel
+      - description: TX DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    spi@d401c000 {
+        compatible = "spacemit,k1-spi";
+        reg = <0xd401c000 0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon_apbc CLK_SSP3>,
+                 <&syscon_apbc CLK_SSP3_BUS>;
+        clock-names = "core", "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts = <55>;
+        dmas = <&pdma 20>, <&pdma 19>;
+        dma-names = "rx", "tx";
+    };
-- 
2.48.1


