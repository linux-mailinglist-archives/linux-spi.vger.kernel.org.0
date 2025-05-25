Return-Path: <linux-spi+bounces-8281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FBAC3547
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B06F3B44A5
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F8F1F4C8B;
	Sun, 25 May 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9gccAs+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B71F4CA9;
	Sun, 25 May 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748185180; cv=none; b=cEZ6a7IF84DNWJZvShZ06St1R4DcMSOjy6ThziGvbMszvjVxIXK5/CdrtIVtVpoya/XNjusxQ9wnHBtCErgRyNLg5Cl+Ldfz50y9BV6S+ANA1v8j+PcA8ZVxsRWWvg0p1fUEoOGLgf+r0oxtWl7LPaMtvnxbF4lLmdw4r+xQdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748185180; c=relaxed/simple;
	bh=ilUYEgJmQyNUKpmFci8Kk389OiK2lk6BxrCD1iEtz9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8oARIVOzVn8VShEEU1LKa2L1hhLBKdodGyPSetP3rF0mZ+7umEMZoe80in1+FF8M5ZJnnAfDh2v/zsE7YAvP9/tXoVXsYL6SzsEuQG8KiqWp2DAu7E0VIMgMo2zaCo3uhvrsCJ2jKw4iSQIm1cTlhUiucxWIMOg5uliAI3OCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9gccAs+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23428770e1fso5524655ad.0;
        Sun, 25 May 2025 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748185179; x=1748789979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2v8T6KWNdY86EGnTj0qWjYV1Oss6TPbGlyKa00x9/Y=;
        b=K9gccAs+Jy/nvD9OQ6c+kfUBOWoMObtkQi2CfXGscMsJXvFzH72PJQoU2f/b1Z02UE
         klVNNYY0r545KACx3jTc96EIqFeywjeoxFIHCwAHBh00VyOADVAlnJpTQ0FwdLxaeaOu
         WlRqVgvoz8yB4l/2rO4AmBBNr1q9IAWjzgbF63Db3sSXaALV8HpRACS8t1R6C3oJ/PiS
         oXVzE6excbCKhJH67Yg/vVWz3DVkw9662xmWClmdOc8BzeL+CBRZihVMxrB24YuGKm+O
         +SkOvZwZh6y1fXlY2dpW0wmc3dbwDs2C2MKvQX+YurrSV4/fHttCo7v+RxlNejPGrJGr
         JSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748185179; x=1748789979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2v8T6KWNdY86EGnTj0qWjYV1Oss6TPbGlyKa00x9/Y=;
        b=h+CkdUSrMWLSq2IRs7vEK+efWJtFl+A4/0jHyXw0yGu3sqm5nBJRu/zUXMogwMd3Dm
         e9dtDigR9sD7GM6BByFBv5Q2Y/pkuKMq8/8KRbrEnH2x4DKjtqaTdwYFsv9nHri6Kotm
         1cvhkqu3KEWrI4FoH/ybvhQl4UE6P5OK8zkxTmWA8ZUGnCBYFuREoCwPzjbuDgZ3MFuj
         yQEuOX/83WD4qBT2iw+BZX+0Exd2e+Tk+Y5dcvuzfW4xnujnZlbPyEjNW0navWD5F86l
         67zAtHzp9Qv0iCApvNloF5HFJyuRiomqcqulEJsMv/novWJ5xEYo1D7Bs01BkcG/4gSV
         3GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5XoS2EFhfMTXWxawPy81Z3KCkMdSdESyfQDQCMvTAEaI5/T0bkFx2WZQny01jPwRu+nMkb2q7V5bg@vger.kernel.org, AJvYcCUpPFwbn4fdTGCg/Dek/5MPHHUmNIUTizgiH4GIoiM6WtPfhzEGsQu5EtZlVKz5069UWSb2cT21HMwB@vger.kernel.org, AJvYcCWmEZEkpQ60oJiRWZ8VmI5XHioQ5tg1NLgI2FKybnjDOJXi8uGFNRaqnqYGW2pI9OEgL93B9tngXH85ktrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YytiPB3//JxiPo5EsaPaeTAOqn559bmm8g2A9H0yoWn8v9MUPs0
	RbuFbIuBUgq3FV8A5YDSAd6c4784/c8bwuMFpQUG2YcdioOt5/fBFrFF
X-Gm-Gg: ASbGncuviTT0nxUnV6d7wKi6FzUY+/2b2nfnNzPHNyOSp1JrITVHrrTD19QgTUl25EU
	mQDp63OQe9cC/jgIZ6c2w1gyZ4vvkguWxNleK64Gyb2ZV6DdiXsrYktswvME6hICMKMtl7JDgBx
	tJ0AxlCVO1RHat9TBaUQ3zWC+3Wdka/oyriR43yztK9/x1GMWVCSEah/vPsd1AyCqbUpoHfFvJs
	Z53Vm67PrqitdHG4/gMUtGK2EVUg1vSVpYxoBttjXUYCM7yq1KbY1Bj9eciR+T2s76jCQMoBG6x
	5g1+EPHvS24ZpICMKiviAXhse2HctWH5sYUomdW9GPY=
X-Google-Smtp-Source: AGHT+IF3VxyOXCOt5MifU2/DGUUb39EyyEwfytGdkDvdcnGlAfj/NomQNLMDPNZlESfRl5TpLDFVyw==
X-Received: by 2002:a17:902:cf4b:b0:224:1579:5e8e with SMTP id d9443c01a7336-23414f490d3mr103435265ad.1.1748185178225;
        Sun, 25 May 2025 07:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2343f8e2fbesm12204845ad.250.2025.05.25.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:59:37 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 25 May 2025 22:58:41 +0800
Subject: [PATCH v2 1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-sfg-spifmc-v2-1-a3732b6f5ab4@gmail.com>
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
In-Reply-To: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
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
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748185167; l=972;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=ilUYEgJmQyNUKpmFci8Kk389OiK2lk6BxrCD1iEtz9k=;
 b=/S/3KAGCz8dlqvZlnfhD+8hHniV19KAKuwt34rdhKH1UkljaAUHveB9PC4zxaS9vpti1qMKYN
 o7xr0qeiF8WDgiC+YscypYvEUghQVx83m8v2rb1Nf2MCcchHL7XlOLh
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
which is compatible with SOPHGO SG2044.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
index 948ff7a096433a8c3c64cba13fc1339d18f6c19d..66e54dedab140a167ad84c43f312f93af2bfa06a 100644
--- a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
@@ -14,7 +14,12 @@ allOf:
 
 properties:
   compatible:
-    const: sophgo,sg2044-spifmc-nor
+    oneOf:
+      - const: sophgo,sg2044-spifmc-nor
+      - items:
+          - enum:
+              - sophgo,sg2042-spifmc-nor
+          - const: sophgo,sg2044-spifmc-nor
 
   reg:
     maxItems: 1

-- 
2.49.0


