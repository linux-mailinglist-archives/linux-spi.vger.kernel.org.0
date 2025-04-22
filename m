Return-Path: <linux-spi+bounces-7702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A4A95C0F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E88E7A35D1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13231C8639;
	Tue, 22 Apr 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYUL9k4l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278B1B393C;
	Tue, 22 Apr 2025 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288849; cv=none; b=T4cC7HM84xs1hlA7DY6RbXB5s511AZwXFLA+TjB2wKmV+4g6gmRd8MLLWFJLCpHNt97MsPn3GtIcfGhnZkEBdl1j6UwfkfLzar845Vp1rGgpMVaXmGfygpUAS8Ew/EKF6H+EpoQwo7ST9aGms/NRVD43Ch82d5/pNcxWedygwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288849; c=relaxed/simple;
	bh=tfDazU3c4sCQTaha2KecC0sDtKELmF14aksargEQ4Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/fXha37T2Qg6JxtqSET6RXrzHONS0Sq2IFPNcv+C4Iim3sBQhfZ0JZQSPk+K0TkvUdFx0+4wftiKEpZpSlK8Gs0myiVoAEBWaNxCYsJ+sC43zHzEvffsiPkVQzix9Sfbblv+Yz0VyLpnthXQFSXLcJNNQPMsk6NR2oRQz5nrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYUL9k4l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227cf12df27so40389105ad.0;
        Mon, 21 Apr 2025 19:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745288847; x=1745893647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/Rkn8NRc4ZG4GduUL35RYohUYa7cO/V2efDHxSNHpQ=;
        b=PYUL9k4lipK7p+r+Wv5FsbCQB77QtQMrxePfUSwBcytWbSG0JrEhaaDiZK5+jXNdAS
         fCZM/aYV76W/osSMLX6dyBy4HCVPVFIQgewUwwxfdok0yX78mV3CE+C/0jxOVB/da1/Z
         wS+x57ym1E/Qqppj6xjAf+swxhSQwL3vtlgRmWpY1zxNNIfIfDHAk+14V6ofD+S9l1mQ
         88DU6bPahdjLig4oi7G5pLK3MPtNZj74w/y+hGMmE1akYN76qtqJTWYyLf+m0zhWdVnJ
         gmCD4/08VexJ2KCPx16kTAGGDU4zKpMTs7wpO2SF8Ihh5cLC8Or1ebAzBywZ4MwVLgY5
         DoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745288847; x=1745893647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/Rkn8NRc4ZG4GduUL35RYohUYa7cO/V2efDHxSNHpQ=;
        b=wDRna5TwbckhvXmjDNs1rySfLlQ+Shi6IqRBbkYkqKnQKqQlTbQJNfwHAfmFnzFlgW
         wYSOFXOnstE/dzd3XlDSLta5wZazt+L0hGpyGFSn++MXV1qMlwjvmAftk+38/ZeMbGlJ
         i2OwlVHTeW1P3GB6oCeUvsYrtQh7/J8RIJurgRXiP3Tli5L7L574fF4ikyLTEeDsdXn1
         o8cUTy60oZEkQ8nUK8tpoX+/lg4AvQH4baKmlT3NbimC5gGDKXgNqwwySIS7jR0UQxjk
         Epf67+WjzUOLbbbA4XhxCb7usY5kg7Dh+bWLMN770Bh7+q2d0kM7Sj21u1LiIU+5hc30
         g2iw==
X-Forwarded-Encrypted: i=1; AJvYcCUpqekzRHCF3QMavtHVq2F3fKUmcGovZcquFkIyPP4fX5Pn/ldUJLvNH6iD+xud0NvpyOxs0VBZ51uS@vger.kernel.org, AJvYcCWHph7AfmgfhM+BRvEzXJx4aVQTy7PpwcCq/JQQfERLEUCVvFz/4axSCLNoZ1dWIq19xg8rCNq3FjO5odoN+Mt/GpA=@vger.kernel.org, AJvYcCXsTr3oVGfYwgqgjPG+7btuQhVhqlMpdYXKBU5uDUTKFqkI/jNSmTCr9Hwo0G2jyMLWfpt+0AiqVKSQC94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwXzGspRC7w4xOqkiMTBLdrV+NcgrpuceTSMbgJNDZPi1jA4l
	DGaBCen/CGAg8bw6W+cCN2UcpLxdImH9+kDjSgWzq5lCnqzJG3OTQVLX7mU82YGgZg==
X-Gm-Gg: ASbGncsTevgJmTF8yXJDMpeCWzfdEtUWHn5djKThSXYYDhS/v04RFkqBD24aHfodgI0
	7EcAZyvfNsHmMLUFLsLqulQNzLnZ773g5IRoBBJKqsZEgiIb/RbXh+9XQY/vHoIx+tDlbRLT109
	4ddejn3Dkldfu4H4w41xuSnNVh2f0g+jsC5MJORseD30vh0jDCvamfQehIz44PR53Ml66e4fiqp
	4OFjz80plDS2TopkwHGeA4LthR3/in6Ry30KrD/4p7rUZ0hnZXwMcGF202T8KF2vy/hB6iIeqz4
	1o7sPmlzyolWgJLxGiIs+eOA6iNRqCeGCR/YL+TG6jvYhBc/GqGSWnuiFio=
X-Google-Smtp-Source: AGHT+IEPAwuuwQrRGZYJq83HctY7QlqrADDz0rh531sa64aWa3MYpM1PtKkX9z1DF5vIkTNuvMowHw==
X-Received: by 2002:a17:903:3205:b0:221:1356:10c5 with SMTP id d9443c01a7336-22c50bf0412mr206415465ad.9.1745288846372;
        Mon, 21 Apr 2025 19:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ae9sm72962905ad.110.2025.04.21.19.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 19:27:26 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 22 Apr 2025 10:27:08 +0800
Subject: [PATCH v5 1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate
 compatible entry
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-sfg-spi-v5-1-c7f6554a94a0@gmail.com>
References: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
In-Reply-To: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745288836; l=2151;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=tfDazU3c4sCQTaha2KecC0sDtKELmF14aksargEQ4Mg=;
 b=tXUv/M8pocPmmvC1U2LatuGZKb4BwdUqCC1TVuXTQS2li6wJWH1xcRg999MU2WaCt+8Aa6xMF
 wsVnNvcfojdCZYREQuLeLz9gUrMc/10m6Qk0kWd3jcxeOpk8eOOqMj6
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Microsemi Ocelot/Jaguar2, Renesas RZ/N1 and T-HEAD TH1520
SoC-specific compatibles, which eventually fallback to the
generic DW ssi compatible, it's better to combine them in single entry

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml       | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index bccd00a1ddd0ad92b437eed5b525a6ea1963db57..a43d2fb9942d85b1482a52782c0a97cd5c6edd99 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -56,19 +56,17 @@ properties:
         enum:
           - snps,dw-apb-ssi
           - snps,dwc-ssi-1.01a
-      - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
-        items:
-          - enum:
-              - mscc,ocelot-spi
-              - mscc,jaguar2-spi
-          - const: snps,dw-apb-ssi
       - description: Microchip Sparx5 SoC SPI Controller
         const: microchip,sparx5-spi
       - description: Amazon Alpine SPI Controller
         const: amazon,alpine-dw-apb-ssi
-      - description: Renesas RZ/N1 SPI Controller
+      - description: Vendor controllers which use snps,dw-apb-ssi as fallback
         items:
-          - const: renesas,rzn1-spi
+          - enum:
+              - mscc,ocelot-spi
+              - mscc,jaguar2-spi
+              - renesas,rzn1-spi
+              - thead,th1520-spi
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
@@ -88,10 +86,6 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
-      - description: T-HEAD TH1520 SoC SPI Controller
-        items:
-          - const: thead,th1520-spi
-          - const: snps,dw-apb-ssi
 
   reg:
     minItems: 1

-- 
2.49.0


