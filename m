Return-Path: <linux-spi+bounces-11444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 604ADC769C2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 00:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC3FA35C377
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7330DEDD;
	Thu, 20 Nov 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eznK7iXE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B5308F23
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681404; cv=none; b=HFzfkuTX2cizylOTtzsufpgS5Oe8n3shl6Lb+GV3Kb9Vc3gALN0L5vyC80lfPiSYle7z6qWVolD3zzGt0Xd1VT+s6W99OQAJ6HeW9f/NGyNadiFS9RMqB5g3X5RZEXxiQHkuxY34r37xiDvS4tL9dUEEacdbGNvxBSTZ4/TpIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681404; c=relaxed/simple;
	bh=hunFSs3zO/FdwbPTBz6ZDIaiUyPsRF5W3LVgIps/huI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUQ97CFTpzyVd0CZrSyLUTe3WOVxA1bO0K2skVbzLCbCvVZtTS2FDqKPY/rLbOtWQRSsiJEUOKH6KbqEHw8PFARRNNdDrDlO7X1vRaVbCYTRWvFYsoxb4mIEywumi99+h9a11LRw+djOigRr3B8x3P9HLVvEIQtVkHVTbEuUW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eznK7iXE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so843466f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681400; x=1764286200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mYsgMrDgS5hUvuSlIrRJpIGUfBKBPSurplnTSPjF4A=;
        b=eznK7iXEpYbWXfjnyW3Np3NsZ6/tpEkqGHwavrZA+/J4g7Zu5FIk3Hy7Bcl5PnQI3m
         EmgdwIv6LKA7F0o/WyAOoOCtF9/AZEfCIq2E6OKQtTSazFk53UKJXAHNSEMxEo/y0X5s
         09wLjQnh70OSDn70DO0YyqjtmwNeVecc0LM1USk8D3qLp9/Gwx2mJZglOdKGAjBnT+sb
         0ugjIE6VxBeD6hbIiJYiMVeL1Jt4UPTO1sSZDvazUeBKskTVX7IxOs6BioiQXqr/lKpB
         qttNg6Q8f7dEt/8ZhNlGLFB3zA8w2Y/x7I8wi77F1/galB3D6kfstoaU6tVXlP3Nh4uu
         upRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681400; x=1764286200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mYsgMrDgS5hUvuSlIrRJpIGUfBKBPSurplnTSPjF4A=;
        b=qLcv1a4ueUMGAKzvxlZC5qjX/k+9fMoA7QgCoX0vi+r8gyNet77qJkkugkOM7n1dol
         ucd2BBZBXScMVRRBzz3Uerx3cciCtxiOOpahix5XHIGNahxMpS74JIwYeMpNdc0Jh6z3
         UwLZ/xMyCVyxfbRS+ecn3m3ny16VijW9HnNihMoESb9gNE+DN/adqjjIHKfG/4tb3G7C
         ioiEkHLIAMHjf14WG27y2YRu4uLlf1XCL2sqkSbvC5UePzuZ9Ql8LSUkEChBL6n9flu8
         gTZjDCaADLZ2i0EmbNJ227TcHS37JKBzrAJdVaRNp9Q4nTezhBOvtiD+kH/16yQ/th5o
         cLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGv5Izu8R60VMHVDdRDp5X8uAVSP4sacfW9s29sC3ghZaXld+Hm2oXCMconDaY0SuWCp5sYmF3w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPiSq//+A5vCe5d4I65D4sH1NgPBRAmEqouSoPGc0oYrvmZ50
	hDRQ1oAEoLfk2CeZLKgkHEHNvouiuwt6L9jFQ/b/h5G6RinGGdPeTj6P
X-Gm-Gg: ASbGncsnWKlmMI+utB2a//SFmobBEI/5cBDFrORemnL5a0gEERK1UpdgkNUP6sE6SmD
	4bx/Qhs4wlRIPp5uUXcJCdNMim8ISxZc+1DtdR2u67W9sWj7ej9KQv7t/+D4qEPBjY3t8WW5PIg
	FzCoz7KPc7N2wIdnZqp1ph3Us54SxIldSW21yEIcRwFzKx/L//OAx72W0Spe/nGO0ImnO9RMVmu
	DnHchmPYE8SGHbJoJO0wPO98XS+B/5wUrCxlGSrDiC30jMSBbdt/Nc7pLW8fCUug1oOywRh4a5s
	jlKqK2YYwBeiaaWKwb6FzrMsuPXS91xxc07NHk2OQOHNcuPLEwJ5ZRYCQsv0ys8ZifPX03xp6Oh
	me3XLbN48m+ru+TSXjDINdxojToU/BE3tUEuIQA34CHnCcl/ZHlH/AawFuxLUiBIkk2oRrOJ2YE
	QJgyNySgft6eO6cbESkI0cHZtgOhTBOzmZO04UzCgd
X-Google-Smtp-Source: AGHT+IFkcSWktgO2c9cw3ZmsJgiZ5al3O9HH0pDkGB4u/dkR0XIinpd++pYOt4jbYtH4OgfnVILTXw==
X-Received: by 2002:a05:6000:2284:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42cc1cd5d3emr109924f8f.2.1763681400373;
        Thu, 20 Nov 2025 15:30:00 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm7776315f8f.36.2025.11.20.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:30:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cyril Chao <Cyril.Chao@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] ASoC: dt-bindings: Add Airoha AN7581 with WM8960 YAML
Date: Fri, 21 Nov 2025 00:29:10 +0100
Message-ID: <20251120232913.32532-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120232913.32532-1-ansuelsmth@gmail.com>
References: <20251120232913.32532-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Airoha AN7581 with WM8960 i2c codec YAML schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/sound/airoha,an7581-afe.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml

diff --git a/Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml b/Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
new file mode 100644
index 000000000000..80d9e87f1470
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/airoha,an7581-afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AFE PCM controller for AN7581
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,an7581-afe
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    afe@1fbe2200 {
+        compatible = "airoha,an7581-afe";
+        reg = <0x1fbe2200 0x9000>;
+
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
-- 
2.51.0


