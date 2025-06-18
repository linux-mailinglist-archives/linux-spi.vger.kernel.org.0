Return-Path: <linux-spi+bounces-8665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DEADF79C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F60816DB7E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530BC21C167;
	Wed, 18 Jun 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb8FSbjh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F01E49F;
	Wed, 18 Jun 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278189; cv=none; b=HLqrZ4NjtrRV7Cx9YMj0X7AXv0M3j3lZizsxTAz55gGrJWDn+l//c8dlhOWL5t5iygkPFfNpdfthXomMxH5BmRnpcOeFyldKao5zUV7TygEPcgKuxK6K8q62aNdvCuvESlRUWl8Np3kVb0HgWlWfIHgr4aTFqzDCaT2TAKxFSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278189; c=relaxed/simple;
	bh=poaOcsEerYNYyyuyP49MF1JzBh5iKLseAtiNSFznFqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajU5d35zy9RqMz+dDrXG16SH9nZHyWbQs0SGFKCknzAApTxycCC2yyUURzEVUq8AX353x3iNtepkqBcccBxwy9qQpzNcT1vU3X4zfghV0tVnARNowjoyvV6lUfulbE93ECeWkNwhyfSZExyllvUA5921F4oUiKWTEsqg4GNkO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb8FSbjh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54690d369so106922f8f.3;
        Wed, 18 Jun 2025 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750278185; x=1750882985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4oRSqP7dY+WE1W0lXhOBXepJSbajb4/5a0aRiQRgmg=;
        b=Wb8FSbjhUExjDHvfIrkTWI/vciJEiDudLV7TBW0a3YQdBl8N8JMAWqNuzdWfDy3WSJ
         td1OsiFhgfJUHdiVtLJXDyNffSy8vT/suLPe6auxuPZ6HjqrOW5E7wzdD22paPWLUrX1
         Tz2qdW7JoEsnvu5VFE2a12WSr6nib3Mx3aHbveyd6x71MzeQ88wauEojJePG7t0ZEhnf
         UBQeMlCziiV4ykISsjnVbgmSMpVnJ2uETsIGjvln5NJEuYUS1hKG/8ESDt/RP7wxuSIk
         oF1elEpRVarp9x/vounsxyMN9/PuPdBKFmxX43LaMZoCkzNBbByhPR3/36YAh1F60UOX
         NfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278185; x=1750882985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4oRSqP7dY+WE1W0lXhOBXepJSbajb4/5a0aRiQRgmg=;
        b=WgrfBa7pwExsGneui7LisFhH30nu5DFECrvzpX+yQ5T8+KhowTXZoKtZ43CR/7b/9U
         zMrA0VLCU16V1Rfa1Vuj4Z/sBXuDlyF5QxPVcp+yUywWhWuiRRa2dmVUDEDQwUUofA1/
         7ERH/L2yByWSUUvMP1LA8/+rQbUkWffUpDSURlvyMTDlZ1wAA9pDMYc59w8kcmrtmM7k
         L7c0VA4VzZGXY1LK8ymd8pHfD2pf7XQNBb+8gUiYN4Llgx0eeJPBe8Xg0RpjW/wCkB5Q
         +HvI0k3xOcopKOphSE+nu6a20EXOm3eqTpHPINBM4SXYM49hg0tXcNxCVOr/r088R1j8
         EhtA==
X-Forwarded-Encrypted: i=1; AJvYcCUObBZj5u0pRbom7LwX/rC8+aaoJT1LpOPYoq0bLtxVn5DrUf3i4DZb4UMmxoO+48Oehkk7Z4rtteKUQp7X@vger.kernel.org, AJvYcCW9ImgJDXKKMf0SQPp+4JYSy8s+t759rMyYSkWemOxALl/iG3ds5q/VsAPSL8QMsBwYOXQFKu768bZbVqEF@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLUPwrw6ZpROgM8ayX+Zd+KWELcxkP7+4zirUQp4JWrGWN54n
	9quVWVlYShOx5by6VzQpO4Nnu5W8P77mcmU7Mtu6ApcRJLV1psbl6kX+
X-Gm-Gg: ASbGncsdqWW0uFHYeknVMc4THJax+LxeMKnJoxDXa9WAbEzDREDJdW9M5fDhjk19Z7c
	rQc8Z6JQ6KDOu5uSsB+RRrZdNTtjjNR4iHp1yseboYjJfRCwmzWSytl3HZkMehaRP3MVM8ElXG2
	FUSTRH9pfjvSRr/zzBY3d8Qouhoala3b8c/lmZ5y1dI6R7WdnekxmuulICTh+SxQk6Cm3cV0Mtn
	+FfxQJNTZrPRjINCZ9lJcFWpSX+iltZpzv4da722g4w5YC1Rl29pTmqKVW4S4LK9FC+CDDh3jeg
	oSInIcwzcaBxmneEO5Sm9/zv0OhtTVdBvBkR8wSNAmFqcfogil22btusJlGJwI3Dg1BPA+e7DaI
	F/25BWm1fzWk0XuI=
X-Google-Smtp-Source: AGHT+IF2Yt5Qr66WFJjZ3nAxSDDAh6K93FuxUaCHHH3uM6Wtjr8nP1UL4rf0BHUdcEdxOWb9HzdFng==
X-Received: by 2002:a05:6000:2582:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a5723a3b64mr13525613f8f.30.1750278185178;
        Wed, 18 Jun 2025 13:23:05 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm17617951f8f.26.2025.06.18.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:23:04 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 18 Jun 2025 22:22:49 +0200
Subject: [PATCH v3 1/2] spi: spi-qpic-snand: reallocate BAM transactions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-qpic-snand-avoid-mem-corruption-v3-1-319c71296cda@gmail.com>
References: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
In-Reply-To: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
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
Changes in v3:
  - rebase on top of current spi/for-6.16

Changes in v2:
  - add 'Reviewed-by' tag from Alam
  - reduce kernel log spam in the commit message
---
 drivers/spi/spi-qpic-snand.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 77d9cc65477ad35a3da795d8f6d34d533b65bcc4..f2e1a27b410ddb98d1dfca52898cd5fe38308a2c 100644
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


