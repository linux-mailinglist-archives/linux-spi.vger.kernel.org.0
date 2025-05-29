Return-Path: <linux-spi+bounces-8334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D15AC81A7
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6600A4A6D08
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339822FE0E;
	Thu, 29 May 2025 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAnlFT7X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5522E3FF;
	Thu, 29 May 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539525; cv=none; b=hDZYvIk+rWWP3zzlmPLJ9hfPupLqD/c7/dTR/S8u+DsparGH5UB23gUHPlwc8HmzLF8C0KzeGtzuEM5BbSXGwzdRy16wfzmgnTwcNnv4FXDXp8IthWRk3T2WhXUa08RbE2IGVrfvA/A0eovjoFTfqAch5c5Rvx+teHNWw23ice8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539525; c=relaxed/simple;
	bh=p/AFBV+anPQgs9p7zBoG39a/vXPwY5Uv3p8J9POWPZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1fbssP0w0vaIAvhFFsUu8y5GOfcCowc4PU4Nq6hKfOLYPLBEcxxlahLtkmI20fSS2Q6M4WR7kVEeYoa44NLiBuILiY6grdY78MLwshfSKhh4+P3c5bdWf8n603as92D0Vmw7iRu7LghsZi+Cum4SyYP8DP5uuL7XGuHw6FevY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAnlFT7X; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89333d603so222824166b.2;
        Thu, 29 May 2025 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539522; x=1749144322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GdNV2oKT/fQvp43ajW0Lkwa3+TyZyp+QXrIA3Ktqto=;
        b=gAnlFT7X+jHsCnUHEk0rZ7lYM3KUHGv4oFqusdRs6QtTLLzgcaIqHlxQ4zpJ0wpyoZ
         jH6ao1yHgTnFjSUqDHjXEmf3aY1AlCUHidvZ3jR6KYX9rDWa4QvVH1z4gGKHP7jQgu1D
         OSOr0tyJEoYKel5PFYLqgB0M7k2uRm+6urKjdDGNc2dGMNOpBd5giWpjNznmEWjXeOpA
         f4v3kBweELFOt1fU08XmxU302cJs52Ctjfq/0UddJa9EK9FgCh1qDdoXo/43vmZVy6+G
         tUDRhIG6GmGN5w/GT6nCzq8dIzQPVYVdHD5oCGeT3CHcjHFt+bTQuvUKU26j32zgkv1t
         BF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539522; x=1749144322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GdNV2oKT/fQvp43ajW0Lkwa3+TyZyp+QXrIA3Ktqto=;
        b=bIeLDrHJprx4AeWwp0sy0CBZxkTXkrOcL6YgyJbQRYYDlqN3Y+B9F+zv38jrGbq5a0
         eCcgroSZRaIGD9i/E0o6/YLLzcxh91jGWplDTNLfXhXpweOMUeiPiU8fbfxGnUOckk5+
         hWKAt7IjKujzzwa7kXL/3pp4YvBD1eYguQduxU0zISG2BoOBcsjX69oCDmdbk++V2d4E
         8FkpOIiaX8M24PG3QY3CMzo8lhU9CQp3NG8Xh7zOZ38V573tAy/jYZkAXB0L2hoXhRtF
         UWU2KCaVci/rWvHzn7NnO76W/Y6paYxS6SOkv1qAN5cMlCtE+InTc0r5SvZbW39OAYSB
         OesA==
X-Forwarded-Encrypted: i=1; AJvYcCWxBAYJRleyrXLDIO+l/lvP/8Wo/tghNg/kmsvM6PLxbtu8SYWAZ4QsHaC3AffdE5LhskywIgGV4x0Sm8mz@vger.kernel.org, AJvYcCXBuINGhO5yD4MHEFeU18pMZhVZ375w35N8H3kyeduzJ+WOOZXb98BJ9PDMbnVjdvm1q1M9tW5f/yciwVS2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7QWrrCHGcEuVG3+vYHxwSQxYCVblFcVlErpuJLpzxKU163BD
	uUbmkLJmYOLlwiSEScI2FfhCLGwd8IDRkDlb355hLB/mItocXTPxzOJU
X-Gm-Gg: ASbGnctrEZcIAYQq81jk9fqDhGozovgSWIrvkJQjoX6NWJg9nepQOCeiaduw2T3zkUA
	V+ef7cDRRdHr6XlbCAJtlazWuDpcqP0n/fEnT7gTMHe5pBayb2jt6Lutqun6ayxRHFbYcQNz2IC
	XRQp9c0bBvRL60RoTuw4zCxoPcAgPKgsobY8e6kKr7dwTV/Rj99/5srK21zcEyeMpMptvyT/r8/
	QuM5ROv8WSmN+DpfqaL/IxuowMnoggM4ZR/HqBiHFiIC0vl6jNsclijSvoYddlENtGdhaTophVO
	7cBMcrYpIwSJXG1FoVyLuG9dTcnqq19bLYCxwf3So5HF91SMijTzPD9fZHBSoZdooJmYyjOYv6i
	wqqg6
X-Google-Smtp-Source: AGHT+IE8AVp2q1GaO5YsqzyrmEI1XXn/yvdzwiz5FsB8zf7Ac5exZX28gfdjzaS4/cLtOgXfHqmbsA==
X-Received: by 2002:a17:907:7245:b0:ad8:e4ab:7715 with SMTP id a640c23a62f3a-adb32305342mr28684366b.37.1748539522213;
        Thu, 29 May 2025 10:25:22 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ada5d82d95bsm177793366b.57.2025.05.29.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:25:21 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 May 2025 19:25:10 +0200
Subject: [PATCH v2 1/2] spi: spi-qpic-snand: reallocate BAM transactions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-qpic-snand-avoid-mem-corruption-v2-1-2f0d13afc7d2@gmail.com>
References: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
In-Reply-To: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Using the mtd_nandbiterrs module for testing the driver occasionally
results in weird things like below.

1. swiotlb mapping fails with the following message:

  [   85.926216] qcom_snand 79b0000.spi: swiotlb buffer is full (sz: 4294967294 bytes), total 512 (slots), used 0 (slots)
  [   85.932937] qcom_snand 79b0000.spi: failure in mapping desc
  [   87.999314] qcom_snand 79b0000.spi: failure to write raw page
  [   87.999352] mtd_nandbiterrs: error: write_oob failed (-110)

  Rebooting the board after this causes a panic due to a NULL pointer
  dereference.

2. If the swiotlb mapping does not fail, rebooting the board may result
   in a different panic due to a bad spinlock magic:

  [  256.104459] BUG: spinlock bad magic on CPU#3, procd/2241
  [  256.104488] Unable to handle kernel paging request at virtual address ffffffff0000049b
  ...

Investigating the issue revealed that these symptoms are results of
memory corruption which is caused by out of bounds access within the
driver.

The driver uses a dynamically allocated structure for BAM transactions,
which structure must have enough space for all possible variations of
different flash operations initiated by the driver. The required space
heavily depends on the actual number of 'codewords' which is calculated
from the pagesize of the actual NAND chip.

Although the qcom_nandc_alloc() function allocates memory for the BAM
transactions during probe, but since the actual number of 'codewords'
is not yet know the allocation is done for one 'codeword' only.

Because of this, whenever the driver does a flash operation, and the
number of the required transactions exceeds the size of the allocated
arrays the driver accesses memory out of the allocated range.

To avoid this, change the code to free the initially allocated BAM
transactions memory, and allocate a new one once the actual number of
'codewords' required for a given NAND chip is known.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - add 'Reviewed-by' tag from Alam
  - reduce kernel log spam in the commit message
---
 drivers/spi/spi-qpic-snand.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fd129650434f0129e24d3bdac7e7c4d5542627e6..c552cb7aa80e368e193d71e1826b2cc005571a9c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -315,6 +315,22 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 
 	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
 
+	/*
+	 * Free the temporary BAM transaction allocated initially by
+	 * qcom_nandc_alloc(), and allocate a new one based on the
+	 * updated max_cwperpage value.
+	 */
+	qcom_free_bam_transaction(snandc);
+
+	snandc->max_cwperpage = cwperpage;
+
+	snandc->bam_txn = qcom_alloc_bam_transaction(snandc);
+	if (!snandc->bam_txn) {
+		dev_err(snandc->dev, "failed to allocate BAM transaction\n");
+		ret = -ENOMEM;
+		goto err_free_ecc_cfg;
+	}
+
 	ecc_cfg->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
 			FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_data) |
 			FIELD_PREP(DISABLE_STATUS_AFTER_WRITE, 1) |

-- 
2.49.0


