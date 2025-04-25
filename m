Return-Path: <linux-spi+bounces-7751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C884CA9BCD6
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3FF923A5A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009E1531D5;
	Fri, 25 Apr 2025 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJqknuNm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402214A0A8;
	Fri, 25 Apr 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548124; cv=none; b=DhqWTR486j3IuqWsDxCgEAYKVNJfJ2OAISM/jJmx+HtLwmDUMscdEV7wwfz6m66/zNq2cRI7HwqHW/VgueM5vXEopgdJAn6PZwVoMXXRTlFutbiwHmFaCFmYJhzpYadLzNZo50jtbvDKIdmqhRp5ZZr5acYZM9hFP4uRRCDoXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548124; c=relaxed/simple;
	bh=pY3vTEVbaS9arUU2DTwNLKkGCYTqxU1iZeoetYpIdvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELwNtwQAbjY9dxHoykmloewT6xlFUFkF2bYoRXJEs4G7UA94/yMj3PorJaOYLwVNCqkbEQaQbW7aGzVU5gkvSJfxMvAwin1YfcK/TbaNYIP/UHXcGn0uRuqK5F3kdvKppZcCwmAtBM2F3U5Tz67QrKWfzrgy9rUe8in527vj5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJqknuNm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so1455321a91.3;
        Thu, 24 Apr 2025 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745548120; x=1746152920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hvb/VP20MUGNozLWEP39Ab8rauqcNP3o7sMaDncZOMw=;
        b=UJqknuNmhK19EYl0MRIhzTKnmRLvsslBKIZN7CHteUHiQgtLjoDIYgebgDV4zVFb7b
         w832xaLs9hcTTUNECh4ohyE6qwAY06flYz09hBIfBu8JtfQQd+2BdjwoyPbwVpqc5pef
         DgZwu56UDU7/LRyHQtblEhWOS0Hia+NGJT/13zeqNQ7q+qUEItBnqq5OJNRQjqqC8yqV
         ibHea2ey5UTd8wEu8GL/hqWyydvrteO+1zgmf1fqp4X8zpgYc/JKFdAEJgFPv+sb7pGI
         UAaqxsSPNi7Ag+VIVvIG0Ne1oSpDNWG3lHjd86wRroOnSO4Uv/pLeIH6CLmrDEN0lzJ+
         uW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745548120; x=1746152920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvb/VP20MUGNozLWEP39Ab8rauqcNP3o7sMaDncZOMw=;
        b=snpsu7rugjim3nfbkf3yVomiyVAOix+3V2sRirr2Su4WYiVHHZDk4UXraaqQt7BMyC
         qO/R/TVB5hJoJIYHZaeRcSXCYjLf3mKgiTbDhNMKk+4gdwuC+1dIqYHMvf8lY+lshYKE
         QpCpCh3jeNvBgov7GEmSNt9GrKbG+NpbKz4NJyYqu7sYAt8otuqkZ5GPvTC2ee3p+ciZ
         wy6d9i52YmQTcjRTWMa/PjLAJqXJizF0xsaIRa1w3MC5XGXA+aKh3BJYVUCLoxr1+wdz
         7PyoU6vSmukBuXKnyYWWcP7ZvJY6jS7oXkm7kElgSSjN3jCucS+q9SMpnordJAsBu00B
         uEMA==
X-Forwarded-Encrypted: i=1; AJvYcCW17HunmdmKQpTCrjNvggPprBn5v33o5+s7OCHK338E2NNI163QKd/Jj5mtDt0unWv10UMQo1A19ckw@vger.kernel.org, AJvYcCWruhIiXtdbrX7EMWn0fnjFQ5aglqxsuLdaPnXFKPtOALeL19ViZwcR12795uHDT8CMeP9iniBf2VKHb4c=@vger.kernel.org, AJvYcCXGzdS388A3n+fGtlPRUAbmcsou9BGpAFovV8Un5HqohehuEo16moIB8XrLB5b8zEs3fw3f2AAIRJTqxkdOY+aLBrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PM8BhqMN1vAv+KvyTrOT3OXQZYcbbJREezcahIqEfAE4EnA+
	5sSihM3xXciHRsFd/OtVxjymb6uiv41jtw109F9UXDgBKvE1cqwvM1b8JE2CyzXJGw==
X-Gm-Gg: ASbGncuaK1PeZ0ux6Bc2XoH7wIe7Q9yVzK39VwaGM8TWSMQQpIbzEGiTMvbM1BVNILp
	NGsdz1cs+TrJVpw7r2x7IJ13hR8gXCC8hf0amBlkOqnkds8R+Kf0yUMOly2W0lNFH0UOa1DklaB
	8NDUTAgwre4dw72PM9BJiPcHEn+KmAm5j1aACFJJNS/O9YID0IN8xHm2OUGotAh8BKUmMBkmF3c
	TF7Lvm7lJ6Ai3r1A/1AkFeyOLpZpd4SVso7PqMvYa3XRSp9hOgo2Rq1yzkjuMLErJ4PU0VXCeav
	nfW9eN4gWS3CILFiMAUmT35jTnos/rqmukZcpoSjsk0wnA==
X-Google-Smtp-Source: AGHT+IHYIaj7CJzLMY6PM8+BoRfshbDXB+G3kScEAt6QCPkf34bKcjCrpt7zX/Lk2ha4MMHwrFVrbw==
X-Received: by 2002:a17:90b:254b:b0:305:5f25:fcf8 with SMTP id 98e67ed59e1d1-309f8d8cd5bmr637136a91.5.1745548120083;
        Thu, 24 Apr 2025 19:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([223.80.110.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4a9sm365455a91.30.2025.04.24.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:28:39 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 25 Apr 2025 10:28:12 +0800
Subject: [PATCH v6 1/3] spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate
 compatible entry
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-sfg-spi-v6-1-2dbe7bb46013@gmail.com>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
In-Reply-To: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
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
 Zixian Zeng <sycamoremoon376@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745548101; l=2218;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=pY3vTEVbaS9arUU2DTwNLKkGCYTqxU1iZeoetYpIdvY=;
 b=JwqDiWAI4yDpO2RC2mJtTDqGMhWrFmg1Fq+7NA1CRh44u3baP6c6Qz8vK0YBRavQ9e6hAKevq
 DLeQoa/Qd4KDxhmlyFIAq1jZxFt9fyLvx+tgQQIRF9k/tRj8wZbc6Ku
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Microsemi Ocelot/Jaguar2, Renesas RZ/N1 and T-HEAD TH1520
SoC-specific compatibles, which eventually fallback to the
generic DW ssi compatible, it's better to combine them in single entry

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


