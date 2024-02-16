Return-Path: <linux-spi+bounces-1387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE0857666
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A8B1C219F3
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7914A8B;
	Fri, 16 Feb 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPS2SDTF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D214294
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067165; cv=none; b=fqS5MtohVtQxnFaPJs9tSXP7j2QnH/DbSeIthRKG4ffVKNvQJXkEYZlc9vxCeg9OW25kn5GiPnZe+dCI/I521cqD+zmvZFzkUMgxeym3AZG28b+Iif1yI4UFcizI5dZlCcE4xik/RXt1U9Y+8uEW9yW9Wkrx1fRaT5HQEMs+x04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067165; c=relaxed/simple;
	bh=F3yQsq2MS2bkjotNZ+laXHazoBfJq/kHzLHG+U6tCvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwS84JvzZdcPkPqDmZBj3BwQc6YRsLsXscHKjfWglkTVy3Qm43BaXhp0YVu2jIKlVjPZW9QjBICS02qYj+m1jN0cQCAtgd+fnaLil31xFJX3WcOLf7UEjY9dxAebT2cSbsl/1tosm8nR8aq5N18xC93DZQQH15a7IsCKBT3tgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPS2SDTF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4124d8f9915so767755e9.2
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 23:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067160; x=1708671960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D7ZEx/LF+mDksAYVmzVu5K6Rxew4tV88XlD+DBkpGU=;
        b=MPS2SDTFiv3uSdXsveGVKrMvih9bWjyNLhoebluADbHI0vmIxjD2ErWWhexTBKWMW+
         TQ3ZuQELoiMYN9BalhVZryV2gKEd/yOXJnrrSuq8fObfKhLmZMWzK3Csbx3zZ55AgjLD
         BTWBM2sCZXkrCOhWWxeVEosNAP32NaMSChiyGhAI6aah2yfp4qyDeXUZu5JheYuICbma
         O889Yt3P/FGpVEMPoKQUZyGpRsYXYGMOdJMALD+hBFRYcloiKS7ePxbRSdYbWDFzEq7j
         Fn/Qb1+QfjX7gtNTOGWLzmCyoX21MuLPue59V3ZlCi9XGdowaimrpjCiYbDRrRNvV0Do
         KZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067160; x=1708671960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D7ZEx/LF+mDksAYVmzVu5K6Rxew4tV88XlD+DBkpGU=;
        b=xUBglhFkq4effDjK1AILAu7mSi+eFmuBXZxJNbkoqQJXD3ee//eWt/S4assEoMr05R
         cM7wbEAZQOJ2B1y+g17ZGeRWw40r93LFK1dgHEUCZsKItqAIzFQDApZyzlHM8JHLZ6G+
         LOaA/Dp0g4sl/o4Dn3XQYnKdhRxzSqOOINtWStMo3m2nigD/NJ+KoFuKO8R8p5cfbh9i
         Od3fdGV7Igtt/H2sJR2JkuECpxx9EKA1hzIyIT61tdz7VeN7aNrCj0McCxFqq8K1r21/
         gtAz9y6BtZKOo3lBh3sVBAGKvnc5Bq8x2Jxe/hzgQ+pUScTfiLZn3cxRX3xKAZ+qPr7S
         fkyw==
X-Forwarded-Encrypted: i=1; AJvYcCUNuOfywxRYOUmFhTPpjxF4nyqq7yeGU3msf9LcJf3I7f9NoHSRWVfj6UuYYTokqdXRdnwxSyc0BSlWdNljiJCoPLdHPfM0VpMl
X-Gm-Message-State: AOJu0Yzvo4gL4/0ttSf83nEGMEg9P0gaYpRZU3kEESRYlrpD6gfMYS+Q
	PTSjbOWzJP7osVqw9pe1aioH7/g/EaQkQcy8amaCSHPaJt4uhNKFfTkBeQhA4+A=
X-Google-Smtp-Source: AGHT+IEaVVo8epQKUlxIIvLhi2Q03wenfAIfbN8GFZX4RL21UNSksOlgMTjHKy944oORUJuiWp4u+Q==
X-Received: by 2002:a5d:5387:0:b0:33d:13b6:1dd6 with SMTP id d7-20020a5d5387000000b0033d13b61dd6mr1938422wrv.39.1708067160583;
        Thu, 15 Feb 2024 23:06:00 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:05:59 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 01/12] spi: dt-bindings: introduce FIFO depth properties
Date: Fri, 16 Feb 2024 07:05:44 +0000
Message-ID: <20240216070555.2483977-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are SPI IPs that can be configured by the integrator with a
specific FIFO depth depending on the system's capabilities. For example,
the samsung USI SPI IP can be configured by the integrator with a TX/RX
FIFO from 8 byte to 256 bytes.

Introduce the ``fifo-depth`` property for such instances of IPs where the
same FIFO depth is used for both RX and TX. Introduce ``rx-fifo-depth``
and ``tx-fifo-depth`` properties for cases where the RX FIFO depth is
different from the TX FIFO depth.

Make the dedicated RX/TX properties dependent on each other and mutual
exclusive with the other.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 524f6fe8c27b..093150c0cb87 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -69,6 +69,21 @@ properties:
          Should be generally avoided and be replaced by
          spi-cs-high + ACTIVE_HIGH.
 
+  fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the RX and TX data FIFOs in bytes.
+
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the RX data FIFO in bytes.
+
+  tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the TX data FIFO in bytes.
+
   num-cs:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -116,6 +131,10 @@ patternProperties:
       - compatible
       - reg
 
+dependencies:
+  rx-fifo-depth: [ tx-fifo-depth ]
+  tx-fifo-depth: [ rx-fifo-depth ]
+
 allOf:
   - if:
       not:
@@ -129,6 +148,14 @@ allOf:
       properties:
         "#address-cells":
           const: 0
+  - not:
+      required:
+        - fifo-depth
+        - rx-fifo-depth
+  - not:
+      required:
+        - fifo-depth
+        - tx-fifo-depth
 
 additionalProperties: true
 
-- 
2.44.0.rc0.258.g7320e95886-goog


