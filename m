Return-Path: <linux-spi+bounces-9335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5765B1FA7C
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172071898118
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF526CE36;
	Sun, 10 Aug 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik6Q0UUQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF0A267B02;
	Sun, 10 Aug 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836761; cv=none; b=dhn22PB1IHO7rhXMXoOa6UmHETHDIOztyJVI07g831ngh4KhBSjxxoF0klb3m4y/aFQV3mo9976zZnwWfBMCFPr5I3QPl/wHFUhBbDjGPi9uGlIKAMeZcmZCrBB2GS6pFvy2eqo7BZ5utNPqreUKpnyr2Y/hdd7RQxtMjEKycBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836761; c=relaxed/simple;
	bh=sd116yBRfTrFTiTq7X2NwY8LjAgyVCQApOiIDIKWWPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sin1zLJn2Dc7NvB7ZkFSoTNAxrsa0LOCJwfCxHbc7NGp1SG+IjLCfMop1NgBOh/ElnEEmSRv8rn1dEta44vTOzTMVswTOcrYArUSRKRwKwMAatX47Sk57vateB6aordq+OKl2dKo2LEOcROu4PvpnsAUBuLpCjckrjfeiSYw34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik6Q0UUQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso22547705e9.0;
        Sun, 10 Aug 2025 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754836758; x=1755441558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcmxIpPYdCpfPFBt8uKF7gd7DS2ROw7aJi4hs4RfP1Y=;
        b=ik6Q0UUQFPhsE06SUKW4Sxvw2Iwy3ASeil3LxwBAvB9gF6Ou7VLs3lSEcvKoX3KRtI
         lkeHQO59Ei78+N3h6smXVCl2jL5bH5es61qTdH4yrFwAexq5HLUQ22LfhWY3jQbxKo+0
         dXIsgpXOs9whBMdTM40bNHiDU5e1htVg7etvK//sOVlaHdwpRcLy2AnhTfDKBWWCM41n
         +ll/za3RXcncNerT6WlTnwftSD03ZgtQKn9myJB/QgsfNjCDE7SC+szKOTs0REHVNaSq
         PoKZ5veOiDSZGI7iKmFEFRL6TejB9jXE8Aur6IfnAawat4gfSI/cu+LVldYJOX2R311F
         sWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754836758; x=1755441558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcmxIpPYdCpfPFBt8uKF7gd7DS2ROw7aJi4hs4RfP1Y=;
        b=dHQKfDvyqyF1+FUfN/4ndTCMtfh+USDnBJGUhpDryfKgd/Ea0pYI4PPLY9f0ZQRD3l
         vqgcRA/70EAJT4cUNV9ndlVk5WFn5U1CieiR1d6hd/NFrru2i7VvhiaFlvT4JEmIdkS3
         bBPyTYWg5vIE7inwhcOXtWxLjDH0Bu2HBpy9BJA9ExAHGOzy/zU00Iwv2ScR5zrxsJWF
         Xsuf+SG3VuDpFc0EZ/mQ+9+kpgWjnTu11zE2K93oWRYFyRgY8qv2WHiP8pPdY7WehdrT
         /EFH+q4Ijhugdb30j/N/Htz2yl7KhgGByWUUpZTygEzf0oU17dei9Full9+gP99eRSJf
         AAwA==
X-Forwarded-Encrypted: i=1; AJvYcCUpb6eylQNB9jooY3YQlMUBrfAVO7bsw0Ct7RYs3ZLT8y+OC3HRyPrU3qxTeTaWu3g7k7wPxkbT1dPcmVI5@vger.kernel.org, AJvYcCVgpdXylYKhDBZGS7tPBjU7Ly10h8z1HuCtMuIKl1qHoHsD0DHFk8nxbf/aZjcYhtPQGuE6KD7jrv7ZDeuS@vger.kernel.org, AJvYcCXFUMVvLPloiuWS6e7iSTIGrj1MgYMMM0AECbbCUmjFJVSbaJkMAauUZKWPbGExFb23OVgCoAsulF64@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5ejhmLJcFvwWKGfz5lUn5KacgEdEioIwFYINqXCs4UUKM12E
	p3u1575PtRXgsLTfWTA95ITpQ9UJYhHIxs3aP4xVrsN81vZcXnc/AHISx5Q/Sw==
X-Gm-Gg: ASbGncvKMbNfUMUh0tX7z5P+nENyqceE/M7bYNoemGF2Oqy7rqQvKgv2wUB0aOKE9lD
	I2urGKUJCOj8trmo7xBVvysGpptRNqe2hawDo11L44yOHoB9jP72ZduCNwqnP5URI1esjlTTLXm
	kfvB+ocgYqjj7nFORxm/jreYptgidJYQRhzUbLS3Rwjo8o7kx/oJt+ovPfYlkVmzYuDMPcl7wWc
	6HLnclROXUCCVxjISDI+l2ZTSGp/CWE+4vi8omdQ49Sv17T3rsHYwCciIzv2kRQ7YgzQxpw69Ox
	JwpSJn20vPs8WxftkMcYYd23z5/l/QOJu2ML6LtyGakCwMt8NuOb9F09lzvl3ucjvOW/vcuzsT6
	QgaasRGSCdbOo5xZFNx093HfT6IFp6YLepQ2e2uuGL1nXTvFUrJg=
X-Google-Smtp-Source: AGHT+IGnnqxXALeugOVFPoFTxC2pIiR+d5jk8lpEovJ2tb6XVsxkdrVtmSfFxdJSHhTjsHQA9RZzsQ==
X-Received: by 2002:a05:600c:3b87:b0:459:db80:c2d0 with SMTP id 5b1f17b1804b1-45a0a90d9cbmr42735e9.7.1754836758214;
        Sun, 10 Aug 2025 07:39:18 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm287721715e9.2.2025.08.10.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 07:39:17 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 10 Aug 2025 16:38:51 +0200
Subject: [PATCH 2/2] spi: spi-qpic-snand: remove 'clr*status' members of
 struct 'qpic_ecc'
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-qpic-snand-qpic_ecc-cleanup-v1-2-33a6b2bcbc67@gmail.com>
References: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
In-Reply-To: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

In the qcom_spi_ecc_init_ctx_pipelined() function, the 'clrflashstatus'
and the 'clrreadstatus' members of the ECC context gets initialized with
constant values. Then these values are used by several functions to set
the corresponding members in the register cache.

Because the values are never modified, change the code to set the those
directly in the register cache by the qcom_spi_ecc_init_ctx_pipelined()
function, and remove the repetitive code from the other functions to
reduce code duplication.

Also, remove the respective members from the 'qpic_ecc' structure as
those became unused due to the change.

No functional changes intended.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index bc2158e560be3b0ab1b26882e4de524ecf662d14..01f16f49d4cafa608373a176cd1bd88bd00d2a99 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -94,8 +94,6 @@ struct qpic_ecc {
 	u32 cfg1_raw;
 	u32 ecc_buf_cfg;
 	u32 ecc_bch_cfg;
-	u32 clrflashstatus;
-	u32 clrreadstatus;
 	bool bch_enabled;
 };
 
@@ -381,12 +379,12 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
 
 	ecc_cfg->ecc_buf_cfg = FIELD_PREP(NUM_STEPS_MASK, 0x203);
-	ecc_cfg->clrflashstatus = FS_READY_BSY_N;
-	ecc_cfg->clrreadstatus = 0xc0;
 
 	conf->step_size = ecc_cfg->step_size;
 	conf->strength = ecc_cfg->strength;
 
+	snandc->regs->clrflashstatus = cpu_to_le32(FS_READY_BSY_N);
+	snandc->regs->clrreadstatus = cpu_to_le32(0xc0);
 	snandc->regs->erased_cw_detect_cfg_clr = cpu_to_le32(CLR_ERASED_PAGE_DET);
 	snandc->regs->erased_cw_detect_cfg_set = cpu_to_le32(SET_ERASED_PAGE_DET);
 
@@ -598,8 +596,6 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
 	snandc->regs->cfg1 = cpu_to_le32(cfg1);
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
-	snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
-	snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_set_read_loc(snandc, num_cw - 1, 0, 0, ecc_cfg->cw_size, 1);
@@ -733,8 +729,6 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
 	snandc->regs->cfg1 = cpu_to_le32(cfg1);
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
-	snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
-	snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_set_read_loc(snandc, raw_cw, 0, 0, ecc_cfg->cw_size, 1);
@@ -849,8 +843,6 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
 	snandc->regs->cfg1 = cpu_to_le32(cfg1);
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
-	snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
-	snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
@@ -942,8 +934,6 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
 	snandc->regs->cfg1 = cpu_to_le32(cfg1);
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
-	snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
-	snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
@@ -1063,8 +1053,6 @@ static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
 	snandc->regs->cfg1 = cpu_to_le32(cfg1);
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
-	snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
-	snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_config_page_write(snandc);

-- 
2.50.1


