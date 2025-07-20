Return-Path: <linux-spi+bounces-9135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C220B0B441
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699203BDAF3
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C21E0E08;
	Sun, 20 Jul 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl33Bzim"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2E1AAE13;
	Sun, 20 Jul 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000397; cv=none; b=UmU+swFBp8pQStKHO7zLH/C6sIyU+8uFdlTCVpSPNmQWSys0g8ElgcEnhkjasbDoB30j+fxVC1ss+O6yNrdCdwK+Hw/ccJiDrG+t+XSJrlGMxP4AQLmceEmg6iJc8pJ4CKf8JgX9B9Lp0ONqD0/6lMsQx4LrUEW/6h6apFXeJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000397; c=relaxed/simple;
	bh=invs7khMKVNjBA2XGVM7X5zuJ+fCJ3XQUvHieDAkEjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUXLYTW1qa9PViRz6l0iY4RBOIRfEkpRVYnYhLeZbALVkc1UdMHfca/SvkXi/qF8zKloK8muXVgiF5Oa71sLrmxcAlpd/+ZUWbdADuAAdTDEdgDv0fSZAZo8l0VE3sVTzmXrTrMeiC+6frI4cRrL7LTaf+YdyK7rhgjlQVWj45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl33Bzim; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso25980095ad.0;
        Sun, 20 Jul 2025 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753000395; x=1753605195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq9V4nWfYcJsLfYnrUeKCl4BP7Q+oHE4ZTsPuy9Af74=;
        b=Jl33BzimqlcMOetLVwVC/xYJJ8OYhYrjpjAahQLgnaAHbhNCjCgBVOdlMn0fpfix4i
         XvX/yTZTNp5ZZK279XzrsClXW/dlFr/0GnAbozyg8BL4dNSED+ZAEk+nz29lM50ywBsO
         BVGboakCnMHitiFLdPzF64LMeZqBcutwht9qcNxWifNydWB9yOtTHCFndrbxRLdE1XYk
         T6DzgI9Uqb3E48GMKr171DYeu/4bPMxQ6iU88X9mbWAfBRaMvSyh5z7GTfKVlsUAVKNN
         Iyx5DI5PfAUt/DmpeM1xSb1pT/4eJq7aqe4TXjceXpzJPnKTZYSxnfp2mhbju4+zezTF
         H0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753000395; x=1753605195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq9V4nWfYcJsLfYnrUeKCl4BP7Q+oHE4ZTsPuy9Af74=;
        b=HTlGDjMJlTWqs/2Lf39LBtiiZlnnztAryQFdhsIIq4s8HSUbP3haeNcROSXcLTw669
         KlpVsYD1cjQx3C1q5dp1Nn5RdEOWQkxphvZjep0YrjXpsolHLtt4mWrB9ACX2DUAFfqm
         /Oho06KD+H/+NMopgBMiG709ED0XtUaMLVl/oeKqQp5tAvJqCfj7Rx1eOLLU7z0VG91B
         EkJfC8olHO8fVyP+RiTv4+XDj2AoA5Axh92ISO5AYNZP3q8UPbVP+7vN5DYZNvlzhjai
         nT8c5MCkNVHcSX9IUCF2lcjiRyMiLZm7qlO44CqggGbIr4kahSb9frMXx4ijTLGZQrye
         J+9A==
X-Forwarded-Encrypted: i=1; AJvYcCUSGC1NNBmPC+YvYzv4h+HsjdBRtqDdLMEnIC+HVY9S0HU94fcUsjMLe/R2guYvZZ5qJzRla+E15zbG@vger.kernel.org, AJvYcCVGEmAaZlSMINgbu1MheWDLBYPPL/gd3z1abAZTjPCw9cIejoXOA7KCXp3vdQ5j7GhTgyjicyuozU7ZjiT2@vger.kernel.org, AJvYcCWfeUBDrgAQ68AsT7vNBK8BDhH5AYT9tchuvu212Jos6ozMDauqYl8zQSJ1nbRCQ5b28ddxyN9vcRog@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/Y4q49BsSJKGhM/dXbErv9J73nfiejdZjYXwSM1t54uf+w/S
	rEQmf+u+OjVbUnpD9B96drKpyXip8kNjxNa8Du/b/x5a2z45zUUar6/hsCINLBjk/+U=
X-Gm-Gg: ASbGncuolaGZVqfbtatUoRxz9IjdQZnkKq5gjUi6sEdpbQsCJnOfDK45dC0TvQzE4c3
	IbbnUwb7mHQSCnUd3DoQsoNjpXgbdrUuY7cxM/UVEETnwTh8jbrP8oa8TIAoEsnMaAtBPumiYQa
	yHfOrPaGIQb3F/HbIaD3HCp1GPisFGHpeKcjiRnBndIL1o+G8nH2DG+O+kHJsTzpCQvcBJO78NO
	V9/p3+45YwBBg6l5dgRUhPxEMfh/yGTlbwB5P01+onF6zYQVbDlZAUW51qjFlbHm6176FYGx2xi
	+h8GpeFX1QIXIMlSy62cCvdzmZ2uI0NnGegxt1tW/j1v4gMokj/xU6MQDGce9wkXuB57IC5QAYs
	ndevzVlj73iNvtw==
X-Google-Smtp-Source: AGHT+IEpU7ppf8Ier2F7amqI42rtLsgYRSxajHznZeT7Ire18+UMD7933EljvqHA+AOKkjcPgT9mKg==
X-Received: by 2002:a17:902:cf0d:b0:235:7c6:eba2 with SMTP id d9443c01a7336-23e3b84e8fdmr114036045ad.37.1753000394653;
        Sun, 20 Jul 2025 01:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1002::1d55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46b97sm4079721a91.41.2025.07.20.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:33:14 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 20 Jul 2025 16:31:45 +0800
Subject: [PATCH v4 3/4] spi: spi-sg2044-nor: Add SPI-NOR controller for
 SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-sfg-spifmc-v4-3-033188ad801e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753000358; l=1077;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=invs7khMKVNjBA2XGVM7X5zuJ+fCJ3XQUvHieDAkEjI=;
 b=d+ztnvccC+X0a+IaXeQ4YkUZ41YMfOYok04lF94NFY4peKxfthcRHU5Vd3KA1PF3HomUiCxxz
 pvgOE7rHvSkDFItDqH9m2wD99AXpdFdKrdGzn2NdJDgsLUdHxDEmixP
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add support for SOPHGO SG2042 SPI-NOR flash controller.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 drivers/spi/spi-sg2044-nor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 0ef569eb28b7609df1f23d89a6b3e7afc2569c80..af48b1fcda930f3cd0bdd57d80e076918d94010d 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -485,8 +485,14 @@ static const struct sg204x_spifmc_chip_info sg2044_chip_info = {
 	.rd_fifo_int_trigger_level = SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE,
 };
 
+static const struct sg204x_spifmc_chip_info sg2042_chip_info = {
+	.has_opt_reg = false,
+	.rd_fifo_int_trigger_level = SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE,
+};
+
 static const struct of_device_id sg2044_spifmc_match[] = {
 	{ .compatible = "sophgo,sg2044-spifmc-nor", .data = &sg2044_chip_info },
+	{ .compatible = "sophgo,sg2042-spifmc-nor", .data = &sg2042_chip_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sg2044_spifmc_match);

-- 
2.49.0


