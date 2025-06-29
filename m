Return-Path: <linux-spi+bounces-8860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79196AECBB5
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EDB188D2BC
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B420102C;
	Sun, 29 Jun 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVmHtLvG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F41E51E0;
	Sun, 29 Jun 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185433; cv=none; b=oLwdAyVUKGJoKo5vtM6Evbkdk3wV3LLOkJQK1OyKsOD9W4ETdFFELMCxSatWnSgLsJfgrQ5i8hkNVSZyaIKF3u7dEDr3VHGVK2deqzI7hho3Rp6AuSheLNikOcW04jtP69jEqm4bdtK7cEdU1ybPvp4iPpiF7gPZj7t3oO7jDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185433; c=relaxed/simple;
	bh=vKeGv92LbibVttyHcTTbUTC0hNnYenpRL/AwLj3xchI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtapEf0DdYyXUxxDG2w1SqVFZSy44q41pY5/mpzA67UFNwQuTNtLZqXAP2dRVGYGLe9doL9U2shrDSMVSqKHEJA0ChH/B2sOZ0kyoorX1gL7Q1qJR91nNJ2FE9O7m3WLEAdCPaAgQglflE1EfRN6Tce+r8hoa+J60kXuLZ4mUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVmHtLvG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2867845a12.1;
        Sun, 29 Jun 2025 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185430; x=1751790230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbDY7+jLzrL1PT5ycGxldl2xKFdQgH0cPkLNWX9XASE=;
        b=hVmHtLvGoyzIPN5ia8LPH2qYG2kzFu/xf7np27C2Ez7txfHmUbPDGeQdzD5C39L20L
         Od6ETAhUCHaTJxD1NP9/q5Vt+BcCYdKA7oUlSUwT1LY5K+9Xf6o2FJf06hMVHkYMBKHC
         XVe2q1OM+Q2mESaC/DUQaI6OP8NViaKWxkRhhzXp9N+yOiTphw89NhZ4n8MMpK7Tf7wd
         HUtldBmpSSlRvzDJYjilS7wMscUydh/4NifBUotkyIoZN6gz7S8yURgd31GKp+c/hXb/
         XxrFfzvpMiO0EddVuqsF3FHlpkKn1Rqa9ThIu3LOuPwtrzwDkn0z5HBZdrL1K9FDZU4V
         q4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185430; x=1751790230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbDY7+jLzrL1PT5ycGxldl2xKFdQgH0cPkLNWX9XASE=;
        b=nX7TA3aeh5RSdOcSVWXphumpp+Cnvw82FpluYdTzXN8Ra3T4RdPOoZhZgEF258rYK7
         OgZ8HTIX4l6ys5ed8YaETfCDwnQbdcu8rpG0Y17lR7Bi9KkdTgjf25mrn44vBJk7yGQZ
         3VkcXUn9b1nH14O/6vWTNYUXbCcGoUAbwtiVFGfmq7S4U9fWtKNhojCH/i+1nqTE9e6U
         0yRy+ux5n0pjikfZS/oy4d2lLZl8ywKvMLLO5HYHkIe92hgbH0pHVY4SZk/8ELuIzyVq
         /ry5rKXA6OjL2MoP5M5GjPVex80PGkQzJ6n8fOs+CdiwocFRZkx8R87HxwNY9Iqr5KXG
         R3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmmP3c7ZDWghbBzJcI1M7sVSLpcORlW6VI3MYpqFyQGAQ4eQ0kzBtJoI/ciurbLdNsDmLqJB3G/IWMhFjT@vger.kernel.org, AJvYcCVC24V+ekdTS/GH83D7GsrzZ50z+QbH1UqVMIpSbVax2lB91u9LMWu6jwy7EDcufXMNPEhLEw500yBQ@vger.kernel.org, AJvYcCXFX7s5ScO/daYmf4VYm+fMKwbvVzaBBo42iIJ0ZIgDTeO6SAWNbdOc3AbNWaIWajY0xjFi65/P00Kx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7xFpkV2BOkJ1cyyJHaLE3Om/mxDzFKqZTTFsthA23QCRz5C+
	CV68g3oE1fX/xiSXrTsABekQxcZUwO1dRxeIzNArMKR7ah/+eFwY9V7z7mYVSnPXYU0=
X-Gm-Gg: ASbGncve5LypMM3d1+qANQpz5QDLJuGcsQodaUn6I3jLpmKwkpuhQ4iymOP0NfilpSP
	rtBpj0c9mhA0fI2qRXhoSTis1UfilX+48boq4Yo1GVWOU8CEadjbDO4r9bYtRWTb4mbjhPY9yVf
	fvTknvBZl4VjRJeryXgaR9CANX4qUgaB7wTlACu7BboF6M1rQkOqspAbMau4c60ufvR7YLY9+dF
	67bpI1mdoYASw+3Y3srJ8FM0fkaB1wc7k1Z4y+GugTRkHUJziiLI2GbnVJ1OnsdKfN8xoasGeSy
	Dp9nSioXU03agP4udw/4L+quC6WYp3ImR1Y8MpVgDxRGILxPFDd6JA==
X-Google-Smtp-Source: AGHT+IELHhhDxgnpw3MWnX1SUdpFfj8qVHJzMWazZcVe7MfSiD187uIdapbtW0jVyzAPN3EEEu1YGA==
X-Received: by 2002:a17:90b:528a:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-318c9225e52mr13102958a91.8.1751185429842;
        Sun, 29 Jun 2025 01:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::168a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm10495839a91.26.2025.06.29.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:23:49 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 29 Jun 2025 16:23:11 +0800
Subject: [PATCH v3 2/4] spi: spi-sg2044-nor: Add configurable chip info
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-sfg-spifmc-v3-2-28db1f27e999@gmail.com>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
In-Reply-To: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751185413; l=2775;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=vKeGv92LbibVttyHcTTbUTC0hNnYenpRL/AwLj3xchI=;
 b=1JEJ0sKTI6zYuq89x/DJJ95DWZmlHfX0cHx0z4Qe0aGYXpNYwXGQGNhVegUI0kLoyOVZ7AlyG
 v3WNK93YDK1B22T1yDK8uuuYFZIup4kI9OB8+ZxQ29TmQLBJHJ0lHxf
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Due to the differences in the SG2042 controller, a new configurable
chip_info structure is added to implement that.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 drivers/spi/spi-sg2044-nor.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index a59aa3fc55d277653d01df9c83b3f0aa08edab46..09a5712822e32c9da818684e7010b70aa94ae347 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -84,12 +84,18 @@
 
 #define SPIFMC_MAX_READ_SIZE			0x10000
 
+struct sg2044_spifmc_chip_info {
+	const u8 has_opt_reg;
+	const u32 rd_fifo_int_trigger_level;
+};
+
 struct sg2044_spifmc {
 	struct spi_controller *ctrl;
 	void __iomem *io_base;
 	struct device *dev;
 	struct mutex lock;
 	struct clk *clk;
+	const struct sg2044_spifmc_chip_info *chip_info;
 };
 
 static int sg2044_spifmc_wait_int(struct sg2044_spifmc *spifmc, u8 int_type)
@@ -139,7 +145,7 @@ static ssize_t sg2044_spifmc_read_64k(struct sg2044_spifmc *spifmc,
 
 	reg = sg2044_spifmc_init_reg(spifmc);
 	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
-	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
+	reg |= spifmc->chip_info->rd_fifo_int_trigger_level;
 	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
 	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
 
@@ -335,7 +341,8 @@ static ssize_t sg2044_spifmc_trans_reg(struct sg2044_spifmc *spifmc,
 		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
 		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
 
-		writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
+		if (spifmc->chip_info->has_opt_reg)
+			writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
 	} else {
 		/*
 		 * If write values to the Status Register,
@@ -457,6 +464,11 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	ret = devm_mutex_init(dev, &spifmc->lock);
 	if (ret)
 		return ret;
+	spifmc->chip_info = device_get_match_data(&pdev->dev);
+	if (!spifmc->chip_info) {
+		dev_err(&pdev->dev, "Failed to get specific chip info\n");
+		return -EINVAL;
+	}
 
 	sg2044_spifmc_init(spifmc);
 	sg2044_spifmc_init_reg(spifmc);
@@ -468,8 +480,13 @@ static int sg2044_spifmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sg2044_spifmc_chip_info sg2044_chip_info = {
+	.has_opt_reg = true,
+	.rd_fifo_int_trigger_level = SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE,
+};
+
 static const struct of_device_id sg2044_spifmc_match[] = {
-	{ .compatible = "sophgo,sg2044-spifmc-nor" },
+	{ .compatible = "sophgo,sg2044-spifmc-nor", .data = &sg2044_chip_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sg2044_spifmc_match);

-- 
2.49.0


