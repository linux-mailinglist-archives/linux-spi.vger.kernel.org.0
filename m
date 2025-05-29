Return-Path: <linux-spi+bounces-8335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972DAC81AA
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4744A6E72
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D45230BD2;
	Thu, 29 May 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCxO5Ppr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41622FDEC;
	Thu, 29 May 2025 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539527; cv=none; b=bPycR1g0PUgoFqrqSOD+cFlcXOLH5w2fiLdrUeUiBUWlDGpmehz2hio22bbzhxOzdgENl8iJvhHkN+NimOwrZFs44yqbZoi5BOsJESZXDZ+sQ3KiXy5Y4LeOXT37wRf/FpZ/599IdqcV02/j0/HX3QUc6dnJxf+v2wwa8CpOpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539527; c=relaxed/simple;
	bh=cUCOSDkZVKViBX+XB8/cLIW/bIM7FFUfwedr8//UWEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUxAZiFrBsDaYpt0QSiU3w6u25kDfG83h7HPhS+CmpedolwftePuZOIvODz3S26X1yLoerAtbE1ZOPfv2O/+HhffW1w9rqV5DILJzVhkUK2d2fO5ra0Ykzub43EL2kAcxxWRdnnO+OA8hRp50Qs7Ecy2usRTvcvOe3aaQSd6BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCxO5Ppr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad56829fabdso168755066b.1;
        Thu, 29 May 2025 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539524; x=1749144324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV2butVDw2bUeLpVaXq6xRsCyjyAgxB8qAYckam2iV4=;
        b=kCxO5PprU258A60L3f6TunCGE9yoyZXH2flX95r6b0Ek1t4YXCzT2Oe7LzPmn9crph
         ZObesni/faBqWfxqzyjk+FyEpZFpu+yVRaUAlHqXOB6Q45hi8BoTUKHoqrv8L7BSNcWY
         JH40YSHHymEzH1g+3T6L/Xhc8kpYsxp1yQUOrlHzEhoVx19QUv27krf+yUApP41mnTaV
         8Sf4Ud1ZAJD+0FVHrrA2GuJYhogDkLEX42E8wxcVRGgKV0mKXKQWrskx3BA8B7lUtrCp
         5rkM5pApR+956JMBT+mynXXOKnzRe3eo3d1SfyM0ihyGwsbsobmggxCqQMeAaoLbuBhc
         WZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539524; x=1749144324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV2butVDw2bUeLpVaXq6xRsCyjyAgxB8qAYckam2iV4=;
        b=R5XQn508QyagcR9hdj2szy5QBFdrSXVy/qMiYttMqRrchgwbG5YoNB9/IkIVWiyduw
         bnG9A5uHkDQzx7DROaTdwfK6tAPb2+QF6EQn9BdicTt6qHiE0VLdOlLYiXsd6Olmw+TP
         yg/5BiCmkK3YQ1CyqNiJDSjLZP4ldODke3+7L3Ljsd1djDhcVpw4daqPHndwvje9HU1t
         q21SWHc3iDaCFYtPqMwrAH9bhmVvv5NaNI771i/Yik1DbBIq9C3yDcQ2KKR2qAWbmIZp
         5JsV8ukuK8+4h5S2f7meBWYMA98oUOYwII4ryKQaSw/KdN4RBICSJ+p+tsdh92K8SAam
         bk7w==
X-Forwarded-Encrypted: i=1; AJvYcCVfpjvB1rS1HerkgrSBNOe4FUXc8fZ9ipWdVORoB8eUtg3INvG/n804KETSzA0xfoBQgh2xva86gsck1MyJ@vger.kernel.org, AJvYcCXYSSGmwDBtscrmtNX2AM0RAb+EH/Kzjv7hwXP0Xv3Hud021uv8C6mhCau93m2K9N9FYoVw/CvGP4zcskjV@vger.kernel.org
X-Gm-Message-State: AOJu0YyaH9UUKw9dlvDuHr88ChdaCCnfBpEhwXdRC8eYr2ybzS6l59ci
	5ZJgFPzvW8YmlsxnNYC06zX/CP9MLpW/pSU4mLy+izVsY9LMLZRPWg0d
X-Gm-Gg: ASbGnctlNtP2vwRMH66WEk0JWEnHV92goPoW4ekn4vgRBmQqPd4dQgZiZWToPjhYI+T
	7FVWvtZ76GGXNh8EgLNo9zHv4+o4cRKjL9Fn1gJEoA3F/i07v6H6pgBis8sEWDJFvJIRwL82EPt
	Av5NMH4Wc9iEYbzHoSnL/FN8kUP69THnrn7OQ/2wilyf6ZEXHvQhdVHoGRZWcUwZl3U+KfRD8t4
	WlHmgRcC/14IRGk65KRljoKMLlTqTTUTJFrKNyzWFdpBHpbO9iUz99jaZUoS+kb3joMe0kef7DC
	so86rrdCZFz/yE4AbGXQy0iaLRhBpXbnx6N/6LkBRTmc6SLkrIEtqzPquAhuUw+lyVeyc3H9NX1
	jcB0b698CB5nXtxQ=
X-Google-Smtp-Source: AGHT+IEZkkD1K+H0tmuFbouKJ3viSpyOf9KVWq/Uggp+KKsRk/X1ojEXByAsL9hV2hKgOrH6f6eaTQ==
X-Received: by 2002:a17:907:7fa4:b0:ad8:8529:4f9b with SMTP id a640c23a62f3a-adb325838e8mr28059366b.38.1748539523503;
        Thu, 29 May 2025 10:25:23 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ada5d82d95bsm177793366b.57.2025.05.29.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:25:23 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 May 2025 19:25:11 +0200
Subject: [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
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
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
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
index e0ed25b5afea9b289b767cd3d9c2d7572ed52008..30f17d959300cc7448d0c2e9e2516c52655494f0 100644
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
 
@@ -237,6 +238,11 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 	struct bam_cmd_element *bam_ce_buffer;
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
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
index cd7172e6c1bbffeee0363a14044980a72ea17723..3ca4073a496b8fd2a99112a9caefd3f110260568 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -240,6 +240,9 @@
  * @last_data_desc - last DMA desc in data channel (tx/rx).
  * @last_cmd_desc - last DMA desc in command channel.
  * @txn_done - completion for NAND transfer.
+ * @bam_ce_nitems - the number of elements in the @bam_ce array
+ * @cmd_sgl_nitems - the number of elements in the @cmd_sgl array
+ * @data_sgl_nitems - the number of elements in the @data_sgl array
  * @bam_ce_pos - the index in bam_ce which is available for next sgl
  * @bam_ce_start - the index in bam_ce which marks the start position ce
  *		   for current sgl. It will be used for size calculation
@@ -258,6 +261,11 @@ struct bam_transaction {
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


