Return-Path: <linux-spi+bounces-8666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D9ADF79B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 22:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A1B1BC2F52
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C121CA0A;
	Wed, 18 Jun 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDEbT+TT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F821C192;
	Wed, 18 Jun 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278191; cv=none; b=LF/YOjHR9aQzX5p+hNz1C2VLYIByU91KzaldoCyFQQz3LKKJrUDeYtRtPFV5Ebdgis+kndoqvrukTHGnSJRbVKEIQuaj/OEMbMvXchJVal83RwP9ZiQ746TVNwIggZ8jTObdEyOw5M8kGVANE2JU8n3pmZKt6lWNSkCBFsj5/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278191; c=relaxed/simple;
	bh=aFhto7kzCJX5ugYP55TR9S9Sw65qwMEWI0AC5QOXRyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbePUfd/KIT8bJnkBHvEKLub1HsP1/rQeWKboM1/tLPq3X9dUuIL3u2ritH3SRUBvZBL5isdHoJZmoo9ceKXNBmG0LwyUVvA0g5+ztxlyVnGZ25S3tUh+1WrWKHxCbF58QXIis2zY755n/nMZYaPfJ6Qg8+OKEPOc+3PIYu/FQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDEbT+TT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so777845e9.1;
        Wed, 18 Jun 2025 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750278188; x=1750882988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz2TBp0pjY/WMvfYk1bPkXEQytqjKMNtkLb7lT6s4eg=;
        b=BDEbT+TTgJ65GJr23RNtpZCmWyJWZeHylQ4j7ECbKFCuKDtFdL3CdIb/coqd9DQ4Vn
         nyO9gbyFEXK9ah6pfuOYRlrchIaeaT7hpm6PglKv//7SyDV60NGYEytBrT/TZqoOVC/T
         Qc+mDG4FKkfonxeaUu71kGgYfYpNPvCEsIID6S6zlMHizsfMZ3ZbeRSHTHbSfZ6OCv6Y
         pKdgjkSAOR0q7YzdsaFygN1w26+KsXDqudqPs/5lqVjrqfPwPxLYsN2KvCmjD6E/3Dad
         6GzokIYSgLUUvP32MpSYMobmCpwFuooXT0C4zQnL+Pqx5dqkDByUmrsSMntzm+Db9DPI
         ZPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278188; x=1750882988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz2TBp0pjY/WMvfYk1bPkXEQytqjKMNtkLb7lT6s4eg=;
        b=aUVw/AitguN9a/VgXHQIcUC+DHeUeWr9SGG5HOdSN+8Q3FYsVYyDQur1HlPv0zH6Ne
         P6y+qxRXkaNgOR30sinSFXnvbjd1/hAzaWXHX90IGrd1tG/AoFY3os5w6U1S9dklC6Bp
         8cXx7opUmWXHDk44JnZ1uemnTwfM64vs23wp9e4xNdk/YupnJVogIH5Gnvt9o8W7Nyhv
         LQ3sHejqTutxEso6BgmNAd6sdq7OBvDN5b5DnLxmxyQ4s3R7MjcQXN/7L89zdsi4B88T
         44uO9N/BTrxI0+0481lFyLnZpZ+tL+eub+Yks9UIH81z0F/italTG8kyA8nqmMEd/qG4
         LBjA==
X-Forwarded-Encrypted: i=1; AJvYcCW/v47+NgFKerd9a1krdKHJLk3ascJ5tJxEWzodq3KoxpzIbmo9XFkjeuLMfdSGwaZNvO8+LvvL+ot7Kpj3@vger.kernel.org, AJvYcCXKuyhRvzHONI7M6lLJqljhjozoOvJmy70GPeFlYgLSLZk8+5H4ge9VOtu4Z9mAiZ0MOX2bqBu2Bv5rkB7U@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFGa0Uh6O/MrO8OHJaAnb9MN383RJbdVcOBijBoAVZ0mUc2mI
	ao2d21089B5MhOVBKwMzq44u8dopUDExG2r30IEKzi6FA/Sea7oJcVYk
X-Gm-Gg: ASbGncsoTYpzlIaqxtFQbqrVrMHBlzwRPsZRQanEXiSYSVNc6LdEbj2MnI+7eXUIMvo
	nAo5lGoEEUBki9mGn6B1rKyd5dNVNpU7A1QRrb7ks1+eiGdnBpWuql1EsVZBk7vqGFeWLsUcff/
	pH/qQL1TC8RveKaI2nPQRij0r4CoWIsC6yDQ7UUWV4iYbQyW7WHmP9omsN5oFG/WUNM3Ma/A3e8
	I/8FRqqpU3tKRy9LcxmhQvDHVcoBNM55Dn4uT2g8R1eU7oK93AfuAJwJAEnJBgaXoRmF5b0jU/t
	5fLAgYWDoN1gXNRlz9Cps6fyL65oxzHGf1Npv7E9g35+VN48Ywxt2Idi8jqg6hlwF8iTE9e+XhS
	yaql1DNWax/CVb6U=
X-Google-Smtp-Source: AGHT+IFGCTxhPw+wSP0jPu77VRIxkVUr880h0EnHf+PjeGUKZbP4V/4LgJOa4U95A+YAseeBsivXww==
X-Received: by 2002:a05:600c:1549:b0:441:b076:fce8 with SMTP id 5b1f17b1804b1-4533cab472cmr181785015e9.14.1750278187682;
        Wed, 18 Jun 2025 13:23:07 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm17617951f8f.26.2025.06.18.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:23:07 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 18 Jun 2025 22:22:50 +0200
Subject: [PATCH v3 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-qpic-snand-avoid-mem-corruption-v3-2-319c71296cda@gmail.com>
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
 Gabor Juhos <j4g8y7@gmail.com>, Lakshmi Sowjanya D <quic_laksd@quicinc.com>
X-Mailer: b4 0.14.2

The common QPIC code does not do any boundary checking when it handles
the command elements and scatter gater list arrays of a BAM transaction,
thus it allows to access out of bounds elements in those.

Although it is the responsibility of the given driver to allocate enough
space for all possible BAM transaction variations, however there can be
mistakes in the driver code which can lead to hidden memory corruption
issues which are hard to debug.

This kind of problem has been observed during testing the 'spi-qpic-snand'
driver. Although the driver has been fixed with a preceding patch, but it
still makes sense to reduce the chance of having such errors again later.

In order to prevent such errors, change the qcom_alloc_bam_transaction()
function to store the number of elements of the arrays in the
'bam_transaction' strucutre during allocation. Also, add sanity checks to
the qcom_prep_bam_dma_desc_{cmd,data}() functions to avoid using out of
bounds indices for the arrays.

Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>     # on SDX75
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
  - rebase on top of current spi/for-6.16
  - add 'Acked-by' tag from Miquel

Changes in v2:
  - remove the inline qcom_err_bam_array_full() function and print the error
    messages directly from the respective functions instead
  - add 'Tested-by' tag from Lakshmi Sowjanya D, and remove the
    "Tested with the 'spi-qpic-snand' driver only." line from the
    commit message as SDX75 uses the qcom_nandc driver
  - move the note about of the preferred merging order into the cover letter
---
 drivers/mtd/nand/qpic_common.c       | 30 ++++++++++++++++++++++++++----
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
index 4dc4d65e7d323e2843edecca8e3849a5090b775d..8e604cc22ca310159edf4d8dbc2f6a82d5119eb4 100644
--- a/drivers/mtd/nand/qpic_common.c
+++ b/drivers/mtd/nand/qpic_common.c
@@ -57,14 +57,15 @@ qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc)
 	bam_txn_buf += sizeof(*bam_txn);
 
 	bam_txn->bam_ce = bam_txn_buf;
-	bam_txn_buf +=
-		sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS * num_cw;
+	bam_txn->bam_ce_nitems = QPIC_PER_CW_CMD_ELEMENTS * num_cw;
+	bam_txn_buf += sizeof(*bam_txn->bam_ce) * bam_txn->bam_ce_nitems;
 
 	bam_txn->cmd_sgl = bam_txn_buf;
-	bam_txn_buf +=
-		sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL * num_cw;
+	bam_txn->cmd_sgl_nitems = QPIC_PER_CW_CMD_SGL * num_cw;
+	bam_txn_buf += sizeof(*bam_txn->cmd_sgl) * bam_txn->cmd_sgl_nitems;
 
 	bam_txn->data_sgl = bam_txn_buf;
+	bam_txn->data_sgl_nitems = QPIC_PER_CW_DATA_SGL * num_cw;
 
 	init_completion(&bam_txn->txn_done);
 
@@ -238,6 +239,11 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 	u32 offset;
 
+	if (bam_txn->bam_ce_pos + size > bam_txn->bam_ce_nitems) {
+		dev_err(nandc->dev, "BAM %s array is full\n", "CE");
+		return -EINVAL;
+	}
+
 	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
 
 	/* fill the command desc */
@@ -258,6 +264,12 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 
 	/* use the separate sgl after this command */
 	if (flags & NAND_BAM_NEXT_SGL) {
+		if (bam_txn->cmd_sgl_pos >= bam_txn->cmd_sgl_nitems) {
+			dev_err(nandc->dev, "BAM %s array is full\n",
+				"CMD sgl");
+			return -EINVAL;
+		}
+
 		bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_start];
 		bam_ce_size = (bam_txn->bam_ce_pos -
 				bam_txn->bam_ce_start) *
@@ -297,10 +309,20 @@ int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
 	if (read) {
+		if (bam_txn->rx_sgl_pos >= bam_txn->data_sgl_nitems) {
+			dev_err(nandc->dev, "BAM %s array is full\n", "RX sgl");
+			return -EINVAL;
+		}
+
 		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
 			   vaddr, size);
 		bam_txn->rx_sgl_pos++;
 	} else {
+		if (bam_txn->tx_sgl_pos >= bam_txn->data_sgl_nitems) {
+			dev_err(nandc->dev, "BAM %s array is full\n", "TX sgl");
+			return -EINVAL;
+		}
+
 		sg_set_buf(&bam_txn->data_sgl[bam_txn->tx_sgl_pos],
 			   vaddr, size);
 		bam_txn->tx_sgl_pos++;
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index e8462deda6dbf61f99bbcb39e7cb12cdf66898fd..f0aa098a395f7140c3c4ad5640f973293f73a1cc 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -237,6 +237,9 @@
  * @last_data_desc - last DMA desc in data channel (tx/rx).
  * @last_cmd_desc - last DMA desc in command channel.
  * @txn_done - completion for NAND transfer.
+ * @bam_ce_nitems - the number of elements in the @bam_ce array
+ * @cmd_sgl_nitems - the number of elements in the @cmd_sgl array
+ * @data_sgl_nitems - the number of elements in the @data_sgl array
  * @bam_ce_pos - the index in bam_ce which is available for next sgl
  * @bam_ce_start - the index in bam_ce which marks the start position ce
  *		   for current sgl. It will be used for size calculation
@@ -255,6 +258,11 @@ struct bam_transaction {
 	struct dma_async_tx_descriptor *last_data_desc;
 	struct dma_async_tx_descriptor *last_cmd_desc;
 	struct completion txn_done;
+
+	unsigned int bam_ce_nitems;
+	unsigned int cmd_sgl_nitems;
+	unsigned int data_sgl_nitems;
+
 	struct_group(bam_positions,
 		u32 bam_ce_pos;
 		u32 bam_ce_start;

-- 
2.49.0


