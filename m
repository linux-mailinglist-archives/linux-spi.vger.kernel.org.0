Return-Path: <linux-spi+bounces-9133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD4B0B439
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E4F1894A67
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A81DED77;
	Sun, 20 Jul 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QndH2Yth"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86751D79A5;
	Sun, 20 Jul 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000379; cv=none; b=Gj4pylIH0AaL6LBf/1cI8mpxWLCUBlEJaQBcPcyXxhHg3C/HbRk1P69EsDRNgtsRLRyG2sRd4P6F9jiiUNmnPAKYmci0jCvtqVQq5oleXIGDwtB5Yfxy9kk62nmGsVJn7Unk0X09SwfHnLOTVp6vsQ/rG1IuHVrwlq15TaM1Aik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000379; c=relaxed/simple;
	bh=vXVFaJbRIh2MrD1GhRV05+9e2Sip1lBqq2iHYXA3CvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEaa0cQ5MogHc5P7hMEg8snFKTvyzlyhVcgoVTT27MQt+UTvApS/bO3LjeSCZpPXvvJ49qcWh42DyIvsAmJOUSKvSiJfUva5cEwJKdZYPIIAI9lbDdJPiO6mbeNS6CX3S67r25fFzPMQU4T7+jH1nBpajF7SCRMv+UPLfzB9bAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QndH2Yth; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3122a63201bso2507686a91.0;
        Sun, 20 Jul 2025 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753000377; x=1753605177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4FB/4XgRToAosI3f28efm3RMFKFbeCd/sui2PSXsGM=;
        b=QndH2YthNzWRql5WaJbAA24uW7IFoSrM/+GSIKh46hUMTr04jzQr9ua4hNoTePB55Y
         ZGDym1NDCswie+8IP8c9xiRRaRi1oO/oWZuD9paSQIaeS29AEUhJFf/hfYP/QSKF2vUf
         e3gNRoF+QHQMJn03166pCIToOlAdE53lfROrvA6IEMZl4KWnR+w2795WhK3sqmHXeQzo
         5+6JWOLrvDPNsslcmSTFRfoqC4FGfmGQ7/FeuQzfdbYsUlYaLMlWiES93FhKDFsSAKEJ
         jrksUInvwTlIgyrhpOjhFWg2tGatbBi32mei6Ea/lT9+YjC6DJcLUwEc5knOwr7LMp1L
         ZBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753000377; x=1753605177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4FB/4XgRToAosI3f28efm3RMFKFbeCd/sui2PSXsGM=;
        b=K5xcFVVJk4037X3bMD2P2xsmXXU/oTes2JTqNvtctwqEGG8imXT+vfvkWdfY7UO3vV
         zOpkx58ozbKkiof5/LK7tV+geZaQO/qSswBgy2NcwJSx+lh/qdxDaa41UYhkp7C8he1x
         IT4iLT1aU/+fT2Ly8rHDIa8Yy9C8YHNQPmMYxwmaHwMvyKeUOENW8F4Rd5BoFMycbWnp
         gt4L0niDoywbEdLN4u4Y6dYbWZRSxIyZdmS8JMgr8CwnEeH+xqSKoWRnVP03zzwv8mEq
         TV8frjJdSBWoELDbzGSA+3ezR5YUX1v22aqrXy/jElD0K2H9GgKP2A+8tIVagVq15cfV
         th9g==
X-Forwarded-Encrypted: i=1; AJvYcCUTNu5NzoRKPGRh0GZNQBSY3fU9DZ4lFZJq2uzwTG9CnC2ERM9BMoVdEGGYgD4vnlJN7lij7a3CGZoX@vger.kernel.org, AJvYcCWW45gwUde/6kbpuNEaqPwysDLUQWtItsOYTZJ4NLWNExkcOU5zzwN8EMJ7yOaMlGsW95aUpLe6w8Q8@vger.kernel.org, AJvYcCXjWiTV+c0k+Zz7koB8RYbTtHrAJaibFtRMqZ6J0G8TM2R0XwX18QRxN7ot0cy0QEAMnXF0AW/dy2i+IYJS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6qrDRDTmRjY3rVkvMtDna7N1LWAjvHO6Eyw5ULqqAe6jtFLi
	ceoB+pIrplLD/ee/Bw/gJ0mW2QpIZV8pxqVBZ0foI1pZjlBYhb7JFe2bOaRBkrvlPzI=
X-Gm-Gg: ASbGncsaQOOG6l/BN9t4b9bgeEWVHDS08KKzuukW9DWaZV9LHmgDZbtm6KPzV8i+ZpG
	Ez7HvcHlltxPuJc785ZDn9qewTWjcKxXbVTXD6VBytdqT73S5X+tki3392EIuEPayncGzIgYKnG
	M2jSgL7t/k6HPG+tlCw98Dm0/qJEpTGRvJm2t8/7GwXkzp9vaXvZck4yVHUogzVBCiiS52wIt/k
	hz1oRKrONYHv52KBrSe5VpJExiz5n/ydQRDBlkjs2tjbwkx8eFJ0DAZTSXGQ2wCrZonDX4YZ5iQ
	14/e7l9hAoEPOmmAFW1jKATZFAMXSzFB2zUXoOXBCLwLAduu6s3QhVe72H6weq8KS/MGRNzEOXk
	O/uR986X/NhEojQ==
X-Google-Smtp-Source: AGHT+IGc2/z5P087dO/qIeMpZJTqXF9gedh8hHC8SAN7DoJxqGInUWHeRnUabLfomatBcIrBDZkwDw==
X-Received: by 2002:a17:90b:3b90:b0:311:e358:c4af with SMTP id 98e67ed59e1d1-31c9f4c4604mr24803623a91.16.1753000376153;
        Sun, 20 Jul 2025 01:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1002::1d55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46b97sm4079721a91.41.2025.07.20.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:32:55 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 20 Jul 2025 16:31:43 +0800
Subject: [PATCH v4 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-sfg-spifmc-v4-1-033188ad801e@gmail.com>
References: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
In-Reply-To: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753000358; l=1309;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=vXVFaJbRIh2MrD1GhRV05+9e2Sip1lBqq2iHYXA3CvA=;
 b=3o2MOgX78qIjiz9F1HO7Wk7wo7kw8ovqc2mY18T8AXZYgNczjEjwHyyr+V7WsmvJ027qnTQcb
 S/Q02IqrdGZBWMqDtI+mbWQYu+cRWtZQ3o2yDzWGKWUJ9L8qO50qZte
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

With further testing, directly using the spi-sg2044-nor driver on SG2042
does not work. SG2042 is found to lack full compatibility with SG2044.
SG2044 has OPT register and it's necessary to write but SG2042 does not.
Due to other possible hardware detail differences, it is better
to bind SG2042 independently.

Fixes: 8450f1e0d3d0 ("spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042")
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
index 66e54dedab140a167ad84c43f312f93af2bfa06a..0e7ead7637052a008c64b82477d060d180c43acf 100644
--- a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
@@ -14,12 +14,9 @@ allOf:
 
 properties:
   compatible:
-    oneOf:
-      - const: sophgo,sg2044-spifmc-nor
-      - items:
-          - enum:
-              - sophgo,sg2042-spifmc-nor
-          - const: sophgo,sg2044-spifmc-nor
+    enum:
+      - sophgo,sg2042-spifmc-nor
+      - sophgo,sg2044-spifmc-nor
 
   reg:
     maxItems: 1

-- 
2.49.0


