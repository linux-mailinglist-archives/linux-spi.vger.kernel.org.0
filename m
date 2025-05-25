Return-Path: <linux-spi+bounces-8287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA28AC35CC
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5CE16ED81
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B01FCFEE;
	Sun, 25 May 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+x3qH0e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA31FBCBE;
	Sun, 25 May 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748192756; cv=none; b=g5YyQXkkKjNsq/oLIT9FggMssUju4HQM+4CeuPPTD/iJ2kSWsQ4TRuHDTrXYvJNjT5xTPSUlC7Li7YkOzQalDgxA3SK5A1C7xUZ9feqTHtLqbWDv8nEhIIT7jiEwlf2pbAR9PU2Wi9r3b6nCyomsPbHZ/s6biJLY+OMWna8w09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748192756; c=relaxed/simple;
	bh=ZkeVzT2oWLUk3p4qsxc4ZCo+44mbQOH83UDifRan/rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5yFBzw3GTrwAeCJckxiorX0zYHF3OjsI3IC19+/Y5jtRrlbDgXZLFeaaXEj5+Ma7siQN8/13/KQijoYyiOSSZLA2h4wveeu+dOLgvcPetHbSQJJjWe767iQZVvwoTwA8sXEW8FoRNmENDOqyjg6e0mMxMdCI41a9dsyKPG3QRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+x3qH0e; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a3798794d3so1576874f8f.1;
        Sun, 25 May 2025 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748192753; x=1748797553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AZCHLTSvr+Kp239n4uhMQzByzLdzwvmUgfcsFgbhC4=;
        b=A+x3qH0e+zWKzunfVkOFII8mD/STak/vdpiphjGr5chciMHEGXYNzuln+yq7yZuUkj
         hNTtqnbZprOXxCEU+iDE+1e8nQpmlTv9rYKOen9xNQxYHy70ze5yzG/B/Xuci1RRVitk
         rOifaXN/GdgOJaByaiNIiDXHAwfHT3aZcZ6NLP2KSrEttj2BVlbYfsP4kfoIOnM/aa1l
         dzJ0PmdM8rpWSEABBiMvGDJpnfhcWuIu1Cp3ICE0lakBEIjxHeTJtOQAVgVGJJ0bpiOA
         ZwyO3oe36+3zjV6u+vPsoZLvZLh/m357tJqyDGBHOYhqLTyLklTLxemLM28oYuEAfcNg
         Lbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748192753; x=1748797553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AZCHLTSvr+Kp239n4uhMQzByzLdzwvmUgfcsFgbhC4=;
        b=ZPaYmhDVXsVJwG/fMoQJT2uByIrC+4oLUP6mTYz8FTCjMLsF7uF0ZiYYgirLwNNBoz
         8UGWLbKlyB06xpq0wIZeXJ/iu1DemnBL+V19+Rqhz6v0SuEU4NJzkalvRMQcJZKYZjR5
         Nn/0Nzh4peI0EOO1DTg/I0ftM6dPqBhrxGpZXgm4j9aYv6FCWv/1rYQV1ja1HE+Cnnvr
         mT3tYWnq7NVvPPA7NWdmy2B8Frpj/S3rdH/uahvnFPDu3v9zpokh+226nzxhF/jDV8/D
         WPpZpT2j0YIQbFnnT2OjsTunU+y6ugji1e/dX5T/Aavj3lKNV4T05j7tqVde/PiRT+il
         IX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIGRMkLLer4pub3tsRVzoQQ0C9fhQieQXHZn1/YDWZb3+DMX2+uutr0fFkzwAK+QlNW7zE9Kjb2FGYfreH@vger.kernel.org, AJvYcCVw6v2C585QSv/k4IRJFksd8NL+PNG207XxQKlOcZadOAZfZpgzVLkLSmHUi5IPOuXCkcRbC/NlQKEGPMee@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTqIFg6xAqb4lSQ28ZbMsVwUM1w5og0fIvOJk0zKrYm1mgGEl
	nIZtL5RZ8vuWmpORrV0K8s65DjAOUZevcNjk4140sjESDvmT8zNIScWTy66Q0w==
X-Gm-Gg: ASbGnctKwlGjl+A3Eptees7QRrik9gihz1dhO1gOwF4JG1QlHXKTZtsMJKBNTZyvTAZ
	KECbZDKHX7VunUiSgXI6pl92YYUsWiTXQq7E1x63OrGfXUqLKad0cwED5qk34RjZ8fStDsYdmup
	HQIEPo8PLDGPFWjIbaiHvAbiFmyJph5wHoanOmvDMOQxYif+q6Q31TiPUOJHeZDeA8YV9NACgvf
	H8O5IvoF/SQtm2+zV3XHlYGVqt2+E+IMXh/M6YMO9dUOJYPsExi6S9u3c3C2QFyKFBgTunKJ5dc
	4wI8J2P87sZceRPAV/5tM6JU8LDvz0ycxBzmCuuhp2ok9Ohi0grSz1G/5VchpBozrtqInOizxz0
	j/wRE
X-Google-Smtp-Source: AGHT+IEaRE4F9pvTdKaRd61scHIFmk2f/nr9A2Sw3iKW5xW4aZumYhVm+RP64fWFLbqMq3dXkvXwaQ==
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682c with SMTP id ffacd0b85a97d-3a4d2386cfbmr2382498f8f.53.1748192753014;
        Sun, 25 May 2025 10:05:53 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a03fsm32317405f8f.22.2025.05.25.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 10:05:52 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 25 May 2025 19:05:36 +0200
Subject: [PATCH 2/2] mtd: nand: qpic_common: prevent out of bounds access
 of BAM arrays
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-qpic-snand-avoid-mem-corruption-v1-2-5fe528def7fb@gmail.com>
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
In-Reply-To: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
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

Tested with the 'spi-qpic-snand' driver only.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Preferably, this should go in via the SPI tree along with the previous
patch. It is not a strict requirement though, in the case it gets
included separately through the mtd tree it reveals the bug fixed in
the first patch.
---
 drivers/mtd/nand/qpic_common.c       | 28 ++++++++++++++++++++++++----
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
index e0ed25b5afea9b289b767cd3d9c2d7572ed52008..fb1f81e4bdacaa3e81660a20e164926c64633513 100644
--- a/drivers/mtd/nand/qpic_common.c
+++ b/drivers/mtd/nand/qpic_common.c
@@ -15,6 +15,13 @@
 #include <linux/slab.h>
 #include <linux/mtd/nand-qpic-common.h>
 
+static inline int qcom_err_bam_array_full(struct qcom_nand_controller *nandc,
+					  const char *name)
+{
+	dev_err(nandc->dev, "BAM %s array is full\n", name);
+	return -EINVAL;
+}
+
 /**
  * qcom_free_bam_transaction() - Frees the BAM transaction memory
  * @nandc: qpic nand controller
@@ -57,14 +64,15 @@ qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc)
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
 
@@ -237,6 +245,9 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 	struct bam_cmd_element *bam_ce_buffer;
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
+	if (bam_txn->bam_ce_pos + size > bam_txn->bam_ce_nitems)
+		return qcom_err_bam_array_full(nandc, "CE");
+
 	bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_pos];
 
 	/* fill the command desc */
@@ -258,6 +269,9 @@ int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
 
 	/* use the separate sgl after this command */
 	if (flags & NAND_BAM_NEXT_SGL) {
+		if (bam_txn->cmd_sgl_pos >= bam_txn->cmd_sgl_nitems)
+			return qcom_err_bam_array_full(nandc, "CMD sgl");
+
 		bam_ce_buffer = &bam_txn->bam_ce[bam_txn->bam_ce_start];
 		bam_ce_size = (bam_txn->bam_ce_pos -
 				bam_txn->bam_ce_start) *
@@ -297,10 +311,16 @@ int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
 	struct bam_transaction *bam_txn = nandc->bam_txn;
 
 	if (read) {
+		if (bam_txn->rx_sgl_pos >= bam_txn->data_sgl_nitems)
+			return qcom_err_bam_array_full(nandc, "RX sgl");
+
 		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
 			   vaddr, size);
 		bam_txn->rx_sgl_pos++;
 	} else {
+		if (bam_txn->tx_sgl_pos >= bam_txn->data_sgl_nitems)
+			return qcom_err_bam_array_full(nandc, "TX sgl");
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


