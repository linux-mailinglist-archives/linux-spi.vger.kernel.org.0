Return-Path: <linux-spi+bounces-10089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22EB821B9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909F64808AF
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8E730EF7F;
	Wed, 17 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MGksHvMR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291525392A
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146853; cv=none; b=CzAVvXfYBcI0Ef4hrAsupvhVuRBfrftLDxa+/hwP2Z1IrhCbIggiKINTRHNHfkdNtF9915P7GImYbggi28wnBnyaPNkpK26i1vBM8IRG/0roRmtbVd+G1raTVoUZ5W3asybAjWmEUZCiA4aEZG/POhIq5idsCycb2pbQwGe+Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146853; c=relaxed/simple;
	bh=NnqiGgPMZUUR3po+CxEQhyl8uMPY80BcoRfsT7bEz7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ/Z/X+kWsbzFqsQp3adDs+GZ+Ut0FRsGKLGbvQ2tJu667hZ4zkG8vJr2lDP2Ona02Z2sGz4HirgxEBulSD7/gjCdDAbScHZh3lUnoQHkju+tFoQ5zrPRnpHuQt6MWbPRZ/pkpWrPV/pk++vPuLktipo8V8JPLOlcEZ3kkJoZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MGksHvMR; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so13204239f.3
        for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146850; x=1758751650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O00X8I4EestpaFHM5Nwo1tPeldmi7z2kuF+pQ0jsL/o=;
        b=MGksHvMRXYIv+srKqyD2r5ZEgMomkB3OXLt3VLtJ4F6fkq3oFQ4RXbbY0Egud7dp7H
         xjqTUtIngvC6QrIxCD/va9NErx0TaPbDc3AGw/lPTN3EMiqeug7NNrv7ZsF6wTvlOUay
         ObK5cWAjip+y+z4pjIgDffa8BfdsHanJsc8kz5Oc/xvTVXJinUWa3qq+jFNVOXd23MKZ
         C9zfuCxTD6/sO0j9Y7OhRXohKgBxpVbDVUqg+FZlx5fDdIttGf7Qn2/RdQsbWiWHzo27
         TwmqCtakys7u2XuI5ucvea0SqDse3J1BdkrEHOY5RHmSLehmQuid+/0Ze8Xa+b1zECTX
         X5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146850; x=1758751650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O00X8I4EestpaFHM5Nwo1tPeldmi7z2kuF+pQ0jsL/o=;
        b=UejYXDJunXaXrt7s9eB612iK1KQmCD5Tbn3UtoVNPaWcEAf3kBuN8yIawFJwMBkZTz
         X5x84ObYhGfG1Uylb85VvRxSQO6xozP166IiuGTALfktwJn/NPXBlIjn/p7OnU2P8sjJ
         XU9p/IABcDSqlhKzvO/htG6Ec053yOIcBMHHFW54J6a5HsktMzCDFxvyKjPKju3EaYc0
         jfkzbpxj48FqANuqGXPbWMtmObOeh4fPSmwsi27LrYa5h3FimToNKV0xwmmMeumX2PXE
         WnrfpQJ120cTxrE5otflGaXT5PfGYd9VUWBVX6f6q1s2bv7TgC0m+OKG+I0dh5i2O5BA
         E5jw==
X-Gm-Message-State: AOJu0YwQi5whx2mr/wnBv2VFTt8PG8oNNaNHsGs5PMl587wIRJR1Rtk5
	CtNxaGc6dPIM50DF+tQpYSZjAPkx8D9z/5TScojFvdGodR71FeMTKifl+R2lmAkVL0U=
X-Gm-Gg: ASbGncs4US3hQXUwM4xSChRWkt+94Np2ITvpCgdh44TCDBJ4dvyT87UfTqDxKsrKWOc
	+Osh96R4Ds9uTdNlRjA3aF8Q2ZZnFzXHLQ0ZhDpV6kYfOgI6sjzGkIQtPE0Rqny1Fp/p+bekEM0
	JAhL3c2Qbx5B5uJ6RuBAP3ZonZgad76RR11S4NdVWzq1uEezkr+CJP2mBB1WOF0BfXsSXDbGU7+
	vsmiEGHqddU1URs/VqjfyJUGFmq8GA+pBPHvmccCzgUv3AUAH385wRoj+w8vMzraDhUjUcBXdyD
	6oxPXTzJ48hTRJipmzzzEyyJ0106paj9NaCni1VpsPJKstLnFB5jf8ac3sugjjbGMk2cBGSOVqm
	arTUZBBJ9o3QPpKWll3QHgYLxD8e9plAt2CaXn+THZ5wPAxtBG4DamcizD3pXT4nHhRzvBJA52x
	N+02Ik+ijc
X-Google-Smtp-Source: AGHT+IHLVokmCo/lQggG9vmsqXV4YnaHaWdJqCCztWwsUDldvrgs2sfRdEFI4EmXfG+REFOg9/CmjA==
X-Received: by 2002:a05:6e02:218a:b0:3fd:96f6:375c with SMTP id e9e14a558f8ab-4241a54ae45mr48172145ab.28.1758146850031;
        Wed, 17 Sep 2025 15:07:30 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:29 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Date: Wed, 17 Sep 2025 17:07:21 -0500
Message-ID: <20250917220724.288127-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917220724.288127-1-elder@riscstar.com>
References: <20250917220724.288127-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..5abd4fe268da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,94 @@
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
+    enum:
+      - spacemit,k1-spi
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
+  spacemit,k1-ssp-id:
+    description: SPI controller number
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+    spi3: spi@d401c000 {
+        compatible = "spacemit,k1-spi";
+        reg = <0xd401c000 0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon_apbc CLK_SSP3>,
+                 <&syscon_apbc CLK_SSP3_BUS>;
+        clock-names = "core",
+                      "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts-extended = <&plic 55>;
+        spacemit,k1-ssp-id = <3>;
+        dmas = <&pdma 20>,
+               <&pdma 19>;
+        dma-names = "rx",
+                    "tx";
+        status = "disabled";
+    };
-- 
2.48.1


