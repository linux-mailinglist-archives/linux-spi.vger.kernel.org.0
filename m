Return-Path: <linux-spi+bounces-8266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D5AC218D
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 12:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D13B06A5
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2822CBF3;
	Fri, 23 May 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9uB0jon"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562F14A627;
	Fri, 23 May 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997706; cv=none; b=nfddHgN+FnfmrDigfOAjlhctrpq/8LsylvAPKbpp2VLw7JHFxOx9wmVQ97oFLj94IMbDLoY/tXoa5vpbrzrH1rnLnXP4pq+X2sYnybBXFZN397oVCAJ7iYNsdCnRVI5aUnc71883DiSPgJoYsyt+JD8Z/pN7qAwgDI46NY22ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997706; c=relaxed/simple;
	bh=B1L+ns3J9BEA46JOnVmHJRQ+0e4FHF2prsHtqzS74ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4c2sX2crHWjqZR8LxPIYtTXb1sLBrD06qVd0FV1kNLwt64tgwns8vPyOBlBluE2sO8J0NwJaGihH91OOpKb0ipgZPXVijNcM22b5EJ1okawvzVNNmameaM84X7foV2PbghlSesFYJ7pDQ3efBvGpQdrm7FVm8NUbyzfFRZt4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9uB0jon; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so7922722b3a.1;
        Fri, 23 May 2025 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747997704; x=1748602504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn/O3K1DYv29m3uWPUXSAZ2bq2VSrL80s8QgFG0aSI0=;
        b=N9uB0jonuhHxpSvqCVpIo7D7PtHUtaWFDdRCgj8c8HxwdP3tnP87fzDzsM8kEghi4C
         R80617PQaRlKhGgZVPNI7tOSv+N+Api/SB9P9CFOKODzm85+ZMEksHapGd6wFwGvPvhm
         Oz1e49rhgyWYq6Io4FnOqt3cDXUI0R8Y5OkNX6pRNb0ZAHEZAgLLOZ6xrsP2OJyy2AoZ
         57zpY9wvvjMPULDZjmmaJdrHG1pvbdnQPXiXXberAPTr4bVulCFD3WVI/9oHRTy7bMMn
         KXibdi4fgKy0MzNhtm2NYWjKv8yXXlmNwFTpsEq2zZtjaF+SjNOwAEW696RI8fGX9wfR
         ciUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997704; x=1748602504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn/O3K1DYv29m3uWPUXSAZ2bq2VSrL80s8QgFG0aSI0=;
        b=bMItrC4ETXsuy5wZCfc/Ce20FJYVn0Qj0wJDhI8qepiD5vQcANC1zDTBGkws3Goxpr
         UTqOYCCZoqueIP6NyFIGR78mJvnIPF4A+TlD87NnsUk6UZtuIRnESxdJL5fT/fpj1xJ4
         9tkWuNIgWl/BPukSvZV47AkTOUq7UqM5oaJ9IKYqJBcTXaIdYoYWhHuhFbQqaxgJM5uz
         QGTymem1/D6lekMH5UvJ1vkuJXQjEhjxy97oihCC/K1Z1mLfZg6UUaRbDYovQFBWJPzQ
         B67PxtUFMaiUvRuPyhOw7It9z/LOzmBeESzoRTVfOQtZiehfF8DCV6Gg/hQSGBlb9Dav
         IpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7MfvSMeJ0fARM5Z/rReqOET0g6gvRsq2SeHvAWnd3c95ln0X9AIy5EElBOnJdzJzDIetcTR5O33hENns4@vger.kernel.org, AJvYcCWh4k2yy6x5UiIbjm9eoVBhw9fKOYaf3+5pgS7FvHJWj39/5rEkLWZg7LF6j4bRgHdKp+QQL6NLJPfX@vger.kernel.org, AJvYcCXZKNlDs6n3oQnoeRvg90h1mwZEoP/Jrdmh+bnUwBbCSSjKimV7BM+Q5TdMawo2PTHm27Y5nG9CS8zp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+ITJAgEhW5sKUjUJEdmVVmVoeQghp29SE0T1+vEiRqhIUJyw
	2k0EGV0b3Ngir+jm3Pg4FWg9z73cMgUs4IvbR4uViC2UXsjrcTEauMJw
X-Gm-Gg: ASbGncvP24PcG6bJCHVQ53r+1PK4PIO34tXYf6UvXBTpUTc6ed6IgFP4k91JWpL8PT0
	V2SykYsiIaWO/LIzJ6JR98RhpjLgMZDGgZBZ63tfhG6CukWKvy9aoqIV0Hvzl4Ui8347XjLaIq5
	QaWxmtrfCbt5C4x1LfRi7uGzXS9Usft0tGw/DKECbeDhOx80KTRAt3locQTAKa3tQtr5s+CJ8GF
	PpjA4tnTP4FlUXNDCHjLibxSjuenh11Fsr6hMwKg0dyiaiEqpyr+YpewXZUYkbo781yJA8+pSoN
	mqzW88Wc+lSUJTfFEwDSmxkLeWXvZaKRW7mqUF9QsWQ=
X-Google-Smtp-Source: AGHT+IGb/whdK5OVcrGLs3cyAdkZSpq6Qu930wT4pSb23mGATkPV/R5AcFIK2e65lJrScVQ63J616A==
X-Received: by 2002:a05:6a00:4648:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-745ed842a10mr3899729b3a.3.1747997703789;
        Fri, 23 May 2025 03:55:03 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739cdesm12623687b3a.82.2025.05.23.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:55:03 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 23 May 2025 18:54:49 +0800
Subject: [PATCH 1/3] dt-bindings: spi: Add bindings for SOPHGO SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-sfg-spifmc-v1-1-4cf16cf3fd2a@gmail.com>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
In-Reply-To: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dlan@gentoo.org, ziyao@disroot.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747997691; l=966;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=B1L+ns3J9BEA46JOnVmHJRQ+0e4FHF2prsHtqzS74ao=;
 b=5V4GegDuuILrVGuFqa9Oq5IP1YPnTcqKDhaZEcKM4DPE7MLjCwzBI7L8guAOu8jPUW7VeG0A6
 DYYBa4K4hzZBp+BBJVsdr7nXYCILxF0QkTqDrfu3c77sijBT/HVcNQp
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
which is compatible with SOPHGO SG2044.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
index 948ff7a096433a8c3c64cba13fc1339d18f6c19d..e083362e8f76f7a7582fd7b98c0b7a36f61577cc 100644
--- a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: sophgo,sg2044-spifmc-nor
+    description: Compatible strings for SOPHGO SPI NOR controller
+    items:
+      - enum:
+        - sophgo,sg2042-spifmc-nor
+      - const: sophgo,sg2044-spifmc-nor
 
   reg:
     maxItems: 1

-- 
2.49.0


