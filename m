Return-Path: <linux-spi+bounces-10293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5CFB9F31D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ABE18861F6
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26E30B502;
	Thu, 25 Sep 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NR7zA5Zx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FBA3093D2
	for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802644; cv=none; b=HdehBZIAHgJ8V5ZpUwEWgF7rzl1UcHsKfuk7osq4Q6x834WendZgyd5wdYJ7XriOsYaLdNhuce/VxI079dSOFhDg2XLAs2rUFc4a9/b0F9Zq0VGpBFm0MvaRVwrREBVIvxP2/o5BiB1MDtiL9ltbgmzIjxMmwQny5MIjnCGan00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802644; c=relaxed/simple;
	bh=43Z/8NqB+lImfs4U/BepJjVu6mfJNgbmQiSwlgjFlEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9IQeieBDl+t3l16WLXEfNMYqc6LW5IkuQ7l0kISnwUnDVWSEhXLMIiNuvHuBm3YWF+LqsSvdO0fgwFZ4pp1REOmd687B+oFuuBL5eF0bVTmm0Jj7LkK/S2lgxuxx0eC9bDHtrkR/vrFpQ8SYQVnjuj0efRFjtpB4wMcxMMuttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NR7zA5Zx; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-887764c2868so86327839f.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802641; x=1759407441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR2b9ECnFflIMj/TuPVkfctyOHxTY8RYfTiR0F4tDBs=;
        b=NR7zA5Zxk7iP4QgWrYKFJ3ugo6lhCFastaoApdbYDI/qVg4bH0cFIXe/IWIBdYcU1w
         8QEsjR77wEKp4MYXBTERRoZG8Ia3yxb1kJOQQO24I8DB/4Pf3CLpYZ5T+wuyAj4arRiG
         KhPMp+OKsm+VmPMe4YNm+oJ2t7xRM0DP7mwYJYRKktiFLLbd//hj6m2CQaC/Mnx7zFPE
         hbTFEHDYdCSnm+2qGt8JgViUPGwvwAKWZeeHuGU1KJGDXDMWY7quMmIBnwemEJ5/gW1W
         KN/KuB9MGHFWZLMGdpNAjaHGrkO5IFi7t7qLIXO+DOpJPmIw84uyujFXnjLSDld1KcX1
         s7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802641; x=1759407441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR2b9ECnFflIMj/TuPVkfctyOHxTY8RYfTiR0F4tDBs=;
        b=C7zVEflhve2ggq8RVPyyhveWepXPP/yLn7CTx7LngCcf9Quc946UM9rxQs3VPXGK8o
         H1WkbPA4rs6P55IL5Vn3VA5aUoih5EzwRHmirG1N5MMmfpL+tMMPMrWMCa9sFlcCxP8x
         CWlxl5HQE8iSCoHXvUfHJnuRNbCGapNJgtxNyArs+pA4nlQUZv/EUag4faQwIZhgZFE7
         Xgv/sRHsy5IceI7tDYELB9GioiQZfkTPcbYXhQlRXA5mRhoBpRkOh5daBN8CvYg7qNeN
         luMwC7jzf/Mj+w/Aw3phwLoQ00aljbUoFNP5dqP6LajKXX96nltycShNHsxfS0qnkBKa
         /Frw==
X-Forwarded-Encrypted: i=1; AJvYcCXzFU/PWgKKLtVG4HguTaLJ1nfkFggDjJaA8dzKTVAJxTHsi/fgjQP2hnjg8sbdxC15svMgZx3sOsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFdr7HCvPvMEfqvctKji0GY19fR35qGaf0qqfJy/Y1Q/gkW2w
	K2lm8JwMx0oLYLoKCaRYqJOepbS/M6FwlMTzDgQmGiO4lxyK2+3E5H2McoHpgsApO64=
X-Gm-Gg: ASbGncuifPeem9H2vG72NWT8ZdqnbMb0HIeFzSOz7i9oswg/VF6iX+4ERxnW8y7Zfdc
	8U1cwx0c4m4oYHzbW2BHflbatJkFUjnH5r6phnpRG557WaTNiJgGTyHHJKyzKDLwyVHhzcMtIhF
	a0F8dfcgZ72Lu/A/BQjkPK5E64rEMt2gAf6zYT3w50hci2UYePinXIJ4vjCU6YYrPcXRKA/ohV3
	7uTYHebV4Zy9kFYKtpaPAWf7LbIsvoJ1C+J0inL3apSpzABwr1WBJ2Dk8Dw7UVP1yp+nmKkQFVk
	rz+NcLE8lc3GTTqE7J8GE9SQJR09W3leygx4mbLZGUbd7FrYwX6YO7xjrByvLhxM6L3zd8ZahKw
	Bivk7xT1QsuJcT/m1ciefuBga28H6L4NwcXpmzEY+M+PGUgOrWU08ps9C+4jkYgXq2w==
X-Google-Smtp-Source: AGHT+IG4wPSqwPahvB80HGI0vgDXc7ga/ScqHe+FN+6P+4lK9aExGKMJr/7vetRH34Lx70dFVQXPBQ==
X-Received: by 2002:a05:6602:2dc5:b0:88e:3632:ca4a with SMTP id ca18e2360f4ac-90152604880mr472882939f.3.1758802641154;
        Thu, 25 Sep 2025 05:17:21 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9040c57fa59sm66918439f.16.2025.09.25.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:17:20 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	junhui.liu@pigmoral.tech,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Thu, 25 Sep 2025 07:17:11 -0500
Message-ID: <20250925121714.2514932-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925121714.2514932-1-elder@riscstar.com>
References: <20250925121714.2514932-1-elder@riscstar.com>
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
v4: - Formatted dmas and dma-names properties on one line in example

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


