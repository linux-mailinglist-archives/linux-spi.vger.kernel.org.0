Return-Path: <linux-spi+bounces-10853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DEC0E0BF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27282189C29C
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B75231832;
	Mon, 27 Oct 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EFcmz/0q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAF20A5EB
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571820; cv=none; b=FxiAJyqHMGNS5w8Tp+0qUhZ7iyr+SjwXDVGKLbEggOoyAijJ2FluOM7nWp2MXnUbNtsWqqP5zumVcBoQKo/jqjUZCu3Oh//BDf4jjTyio6+NUGW23JIUAt+xFhf8pjTXOppiXcja+o/ujTcsz5ZGK4PXNOCfD59aAyz84w8a/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571820; c=relaxed/simple;
	bh=dosS9pDdgnVcYrxQ6KebJvE9ghDY6SThkSzJfM3JnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob8alD+7KAOIyfL7atCn+EstixVCeH8r7x6k8cHbhnRhUBXpXfN3zXpdQNUwqi+YdSPsGYPkE9kwOgug00esjxVPf9UM6v6X1vZouWp8eSMt6YRBp9DbljfpEWdCW97y5DKYglGj5uZ6+71IHwPrZxO2ac1rE/PlE6flWQsT4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EFcmz/0q; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93bccd4901aso440230739f.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571817; x=1762176617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8ni6EXakGblNMElr9yGEmr1BYrUDmPrrWLSAOgcMRI=;
        b=EFcmz/0qlDEOl5AyhfQ00T+cm0NRZ6HCB7u0iHA7sUz9RZiddJUjdd7m8OU1BsKILK
         UvIT3eKCaG3VwyQV0ALm90Pxn3rk0l2dlBz64bWkN+0nQakaNbhxNmknufhm28Z0wrEB
         xnXeKc4LM/Bid1AC1IBLRBT8sw905Qbcc1XM+abXTe1LLH7dyXeGB1pU3LM5TAE7nzTd
         cj7k1KwXYf8lUXK9uUlfJpNmwAg/qcQV+fBxnD/VCtsMN9IqxK7Lb5JRBnaS5tRAf3VL
         StmBwWwKWZxzlvsYkPjmSj74GYxYyjn+XSfrFiUUwkCt6wx9uqC1ocvwDFnMkTOLkQlO
         zQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571817; x=1762176617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8ni6EXakGblNMElr9yGEmr1BYrUDmPrrWLSAOgcMRI=;
        b=XRdGG9CAIZiuY6teV0TiClia9zIQLl32ORojQjbMyzDFgoPWqhJIkLaniRemQNB01P
         iYlQMHuyqvP0GVQt97NmmZWIjf1EG6Yac4nLUHcOLMDPZ/xu/xaZTa9TLsSQZVODfh89
         qopqU7To75lzk2sI2bsUFfOLBiHXq4Zh5t+qFlhVHiySv6ygCdOWJgN51m1BEk0tDPMm
         qqFRKlaIcjyKK9evj/cN4v4PYD+uB5X4BCJ6eqeELv9BGgid9QHuzacZI3QAB97FlNF3
         w+2TzWxxKNMvgRk7DhV7QWC4wy4zz1urkXgH3qI9wm+S9ol1T5CC/Rjyb1kuwOohGAmz
         jkDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPWQH/2vsjhLoHhNg4pzZEQ6tR8w+NIkv3op0hqdtMPhd2rfkNZ54rnke8ls1SOB+YI4XIwgJs+kU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mY1aZAk0G32QuJC1aZeXhJGDaetsEwww/NCACDFai+Bgbfys
	HrlmxUWHYkXE+jUXX+zoKzLeJa3JPpPJQi3wg5hKf1ZvRCkUiDFXb9UtAY4BqrFCuR0=
X-Gm-Gg: ASbGncs+PEkeGkVhwXYMEZzLtQ+PDHcstFX1DJDdk49gI/0uecJfaVmi16pG5VZLUXK
	+dFrJpmmxDd6806fVEFuUCKVCmD6RJmZu10q/AcFnGpl6Yk6hF8WtQENjuLhYf+OyXbpZxwlq8B
	eVmR13R2dt+MbB+O79qPk0WDg9ZOqS590Fbg52nFBJxFnqexJ0kV8XMuiJ5ZHqNrb3YckxVjiex
	hsKk3V+22gqGjQqsjAYS0jYT8rQxsmgmQbjAfZQ0gXe/OZ05uCyo7e83+M8OVkt5tSbL3cpwylq
	asDoliYc4mAHBUHi0iIH1UKfcPfBQkLykZRYhA340u/Gf5xFohHljHg4DAGWqGbPegkiZ6cmx3i
	mjq1URgKs6n65lwJnhCw0NU2PJSrag77RtbPfeuip91d/qipaNvP3lFZrEoPfDbVEQt0wbdF2Z3
	+RGS2iEwCFFPjRDC97AN1DuMd1EISTvJ+bDm5XNj0UlX0=
X-Google-Smtp-Source: AGHT+IF2HAyYtoY7tqjtENmVwo8nugPI2UtLxqpWE0EI0lLCgNJiG2I5oXemQ3pGAy09KPpQQnNXJw==
X-Received: by 2002:a05:6e02:12e1:b0:430:ca90:d0b with SMTP id e9e14a558f8ab-4320f7a8964mr1116135ab.26.1761571817075;
        Mon, 27 Oct 2025 06:30:17 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:16 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Mon, 27 Oct 2025 08:30:00 -0500
Message-ID: <20251027133008.360237-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
Move the allOf block down, below the required section.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Moved the allOf block below the required section
    - Added Frank Li's Reviewed-by

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..1d10cfbad86c7 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -9,9 +9,6 @@ title: Freescale Quad Serial Peripheral Interface (QuadSPI)
 maintainers:
   - Han Xu <han.xu@nxp.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -55,6 +52,11 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
 required:
   - compatible
   - reg
@@ -63,6 +65,18 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: spacemit,k1-qspi
+    then:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.48.1


