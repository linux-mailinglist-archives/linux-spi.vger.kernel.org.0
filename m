Return-Path: <linux-spi+bounces-10606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADCBD2FC2
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9048B189E35C
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1B27AC57;
	Mon, 13 Oct 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pc4resdE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341A2571DD
	for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358799; cv=none; b=AGQq7A6jweuMlPh9XvZwpvjtHjk7hxGG91ieaK8MgkxSlMx0V2ev7WuLSE8AAGPSdgVI3ksNrKWKbpnvKC14ANjz1LWONf/3vYljudQbJkAuZJld/hYzPJxX1JSYnys9jP+7rQbpXKYCn6K8n7F5CfmH29BzCyO8pXukEJ7iN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358799; c=relaxed/simple;
	bh=Kb8uM3f8qILwL0GDllY38o85KB9kJ69KatRC0T8EZTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px3aSwS6KoOpY5ma3mA+YpxgjRTMGTUFR5PGWzgI1qmERj+zq7KycNyWfQBYGdng9ce2sBHiWiFPsz43zywViW+7mm8KcQtL/rX77X5oBWN+ulI82AJ2ykiaqfBwtqXKKcckOe/2Cbl/zyKt4MQC/bG/QHHrsP3I39aJrKp6jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pc4resdE; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so44629155ab.0
        for <linux-spi@vger.kernel.org>; Mon, 13 Oct 2025 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760358795; x=1760963595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=pc4resdE78oIC9903AM4VpgjxsYBNGu8XSMyn36UKV8V+e1PZfoqsPRKwKozoovXGU
         sZqHhkMT+1c7XPjRO25RVfEzn/8CJozOb89u6BA4SKJXYQslY0DxNWo9PpXbu6biGlYk
         9g/6fcYnfn4fPzmdD8ECJh8zRw2gROjFuw3eFmOaXBw6RVLCkvlsG2w3Gu8u5fYZ6n2G
         fdL2znQFscpUZQ9tGEiCRN/oAeWfy3jmTKCr9dpxWzCwaK4bSQWS3wYn/WbaDk2FI6Yi
         Fo65LyJlwbJgctMpcFCvwnh9Nx/W4vy1OO3AREAFmmAW+9rMxjOhQutWxv3x/RD/tIt4
         HeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358795; x=1760963595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhpKl/nn+BHTlTr14XOcXWGwJsMuOmqiPlR2ItDHNmo=;
        b=mJYky8jOD1jJkTtpkA5KN13FngvzNYOoarL+PmVC4Q5Mdlc+aksbzzxFvMYNZbhPe+
         eKUB8BQftyI4C92GrFvyazKw7nE3BQ2TuJSBCnLi3J7YK3Jj1UFNbeHOVV5bVpDKs00+
         7/k7DD3LzeC0uzWntq8czxxtsRNrBjHx3gCKc4nWMp7kUMb8l7JyeJ/XJRYUtr6Is+6o
         jh7RCjNDVAQGqS+D1/R8RFNXxkxGsxkZIWFwet+11ynucAV07vTvO7EGFV86qzZC0WHk
         Zu+uAAuAYNc4nWryrqJHpHOXBli9MhO/v2BSNn4WrCXWgOuQVboNtToDvZ7Fvm8BBU2Y
         Jy1A==
X-Forwarded-Encrypted: i=1; AJvYcCX2bOrGeO3usn65UCUHLN1+LHmNSG1n9xUP26yQEfIcr+XcuBIdebmfmn3XlbntiMbdz1pmVLARkio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQS4Khx9fB9pgJh/WzbmbUwfgkpahBcrD78vYIChOE8ElQoxg
	lBLmc81CnbW2czRPVIV4T+jxIBXBMCRptUvhuBMiP3m9lhvxlIMLFnK9VUyqK+nzNbltaql2+qI
	k6e8iGudM0g==
X-Gm-Gg: ASbGncuzfYmkZbnfpEjl9hjFgoT4lrz6c/nHoTjsUv3BhsEceh2XkfjPt+P5uKu2gMU
	fgvkXfSzmRWTF5acvyYYPdPu9P/Io7CPUcOYVBngjX3QsywdHsgCI0clIVYmfjTHUX2fxkesO9V
	qz/MXmCgPP7LxiPODKIit6WhWfgq97NrA4qL8NjGou75wJN7B0dBQ6yDQ2SBZu2Wp5Eni0XEHEJ
	t7mTrIAjZO41R2yBr88n29JoQk5uoz0+RDW1qfUML0ITyE6SXFxBajjlFdEdCEB1XY7h2bzgICG
	/dcW8YDbLxheLKRNqD3UV2b4KpS/W/mGfLgNauSqnbu7dbyDFSoi4/Ul1a89osr3pm9UdpnFFfl
	6BaZz84qf0YTjAF9XYh0hTrATBZXXKULnzs0HW69u43inJrI2ZsAYyfoQTLdTeIJlSpqaO4qvcm
	Rau64B3q6fasNFyV23q/o=
X-Google-Smtp-Source: AGHT+IGJ80l8YVhjRo9dBel9J5Pq3aK8ulue475SHMoRD5VOgdZxLEedWtLm7lvh3HivwJo28VCMmg==
X-Received: by 2002:a05:6e02:248f:b0:42f:8ae3:20c with SMTP id e9e14a558f8ab-42f8ae30b89mr224767205ab.19.1760358795380;
        Mon, 13 Oct 2025 05:33:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9037e344sm51529815ab.34.2025.10.13.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:33:15 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Mon, 13 Oct 2025 07:33:06 -0500
Message-ID: <20251013123309.2252042-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013123309.2252042-1-elder@riscstar.com>
References: <20251013123309.2252042-1-elder@riscstar.com>
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


