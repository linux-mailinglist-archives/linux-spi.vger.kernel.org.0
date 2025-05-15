Return-Path: <linux-spi+bounces-8142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E166AB8F8E
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD84F189FB20
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E89298C28;
	Thu, 15 May 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc/7XNPO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774628AAE1;
	Thu, 15 May 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335511; cv=none; b=vEL2wlNWMovyqrUQGpSWm0qQ8uDI/iCygJrD0ucCEEv62DoA8R2oVKsM+V5hqtnFi/LiypmsnhGeeSpGU9w0GjM7fvqv3BwB4x1qtk2iBo4vIZB+1QF7FMAnT63cgDhkBeeyV3eA4qAnCRSuVxVyC8bCjEUO3JoNVxBmlI6dSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335511; c=relaxed/simple;
	bh=QhQGb2DW+k4qcx3WHDeffB52u7s0YSmQKid0jbHEx2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feNUhDA1FUaCt9Pz1/RnrJKHhT0PpUT9CvkCfSAfrddtpaHR261W/U1W71+b+oL7ZJuXIfpIBzbgEVgJpkufX/rrhTkrqI5GYseYWH41PnmZS8DZhuMgtIoXFMbLgEhmeWE/NCYPokjwJ8fsOO1ggWP2BRuxCfwYq7TfJACJCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc/7XNPO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so1091683f8f.0;
        Thu, 15 May 2025 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335507; x=1747940307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN4zS8Ov4vOND0MqD7gEwYhjgQ4bApUSGr8+gPK0fio=;
        b=Pc/7XNPOe8vpVC6beSVkJxEYHwKBNDG7lCx1TqYanv4HVg2TpvEa5jmWUSzbkyAjph
         kPM0uNT6OWvxCX8RuRc+T94uDzE57wNOG+/V59m6svGw2Kp/eOEk77FyXhaEdDmlzVwQ
         1GoiEPyKb9BYVOcCzqCdbwC0avNaYdMHUgJ/u2GH5lBybhgDSJpXgH2yI+QYJJud9ZsD
         olQKcSAxWc3LkrczJ+igCk56YCwHhaM5y2r5DK0xK0unCFEFxsu6l/eXsQf50NZx8bIn
         AyMlFCfbgrYrHp8Sl6diJq9+qK6u7MLS5E+p6Tlm2pNBJOasa7rxyNvSvGOAPwnjGsS5
         Y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335507; x=1747940307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN4zS8Ov4vOND0MqD7gEwYhjgQ4bApUSGr8+gPK0fio=;
        b=RfDIQ2CWG/Gfm9fA1FPThCQlPUL6gTrO1f7wB1z3phjIZ2kU/k/0vU3yVGUrXPabit
         51kV6xo+MSmeCKQJ2FbROO+xgYOmqXYujT5qmW0QQNM/BEakq234xiJcB6R1WIkufgtg
         ONLx6dodC//0kXjm5fa2k/W+SBl2vGn8f4hxyS17tiI2rKm6WXQSgrkPrWCjIXasFNYS
         pcppo9CObODuA5bTvpWOySc9qiuBzZ5QKgTu9iC3j9wFVc/kBKkk4rkoEIi3pYj/988b
         czPrW8Z4nbyRFhAR1BQM9uuYtbwNRxI5pCTpckg9QSOZPlKIed8dAbNO3R+kG405CCbc
         P5zg==
X-Forwarded-Encrypted: i=1; AJvYcCViyCnNaNwQv5lHdyB/fKlXYaaDLByxWPTf0yKq47WzFcNBatj1fhpuors6tu+2Kh/L8MTN2/wkjxUdjwE2@vger.kernel.org, AJvYcCVkYe5efJbH2VeaQTSIhgi/ineGhE2VG0gAOgCyYMdNMtjpl43XYuy2y2JwEAs969IQESQlebj+x2MDU10u@vger.kernel.org, AJvYcCWV5IzbLoeOqFk+QqsDeFtLBeLiPHcDsUkoPmOr9NhJCgCRK4ZE+XqN/BH0Ubx/TEspasqPbgF4nQKo@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGKYxeEocXMkxzkGQYByV3TIE+Om/3T5emnx8P6YPfP8D0iKa
	C+7bOrdrd60Yd8bdl93dwXg7WGPFqVrdYF4kAtauR0FJmcbSyQh47rDBsWJAsg==
X-Gm-Gg: ASbGncsJLnhpM49ZDx0AMzvrfgUbTAtIE75fjCt1jVaftxG6U+5PCnzgDMd5w3ABOBd
	/xki7xeLRrrh7X7nAWux6HxYJBaJIdtByRAK3EsZFQ2h2TI7/DfRrxP1gVoRP2MPFNODpTCrYGi
	mAHzLYkfF9iCvsZBeESNjRmLqxzq4Gxei2Fbvw08L1VicDucW6dDlZeB8f1Zr+g+tTdy04egdIw
	ty6GMCPj5a5umYAAS9+zThqDlmubVV9aFCRPwgyRcUn1qsEt7FBXfckDXcqPH/PLLBsWV10ilWy
	9LcGYa7w6d20p9FpEZNvZMzbTUm4jOfhU8mtioEZUIDoCi5EAyN6fQqsRPgs+5UGXFjrfRQPQml
	gHgR+
X-Google-Smtp-Source: AGHT+IF59ZHvQRzBDwGpTzr3onUTfd7fsdZeTn+qh3y2jNptGBAMnHdW0F4KfYB9nYA7aauukxGcGQ==
X-Received: by 2002:a05:6000:3107:b0:3a1:fd60:887 with SMTP id ffacd0b85a97d-3a35c84a6b1mr835097f8f.45.1747335507298;
        Thu, 15 May 2025 11:58:27 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a857sm335778f8f.32.2025.05.15.11.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:58:26 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 15 May 2025 20:58:05 +0200
Subject: [PATCH 1/2] spi: spi-qpic-snand: use CW_PER_PAGE_MASK bitmask
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-qpic-snand-use-bitmasks-v1-1-11729aeae73b@gmail.com>
References: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
In-Reply-To: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Change the code to use the already defined CW_PER_PAGE_MASK
bitmask along with the FIELD_PREP() macro instead of using
magic values.

This makes the code more readable. It also syncs the affected
codes with their counterparts in the 'qcom_nandc' driver, so it
makes it easier to spot the differences between the two
implementations.

No functional changes intended.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7207bbb57802ce53dfab4d9689113e7f9ba8f131..bc45b834fadc5456eda1fe778e5ca8b16177465e 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -483,7 +483,8 @@ static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
 	snandc->regs->cmd = snandc->qspi->cmd;
 	snandc->regs->addr0 = snandc->qspi->addr1;
 	snandc->regs->addr1 = snandc->qspi->addr2;
-	snandc->regs->cfg0 = cpu_to_le32(ecc_cfg->cfg0_raw & ~(7 << CW_PER_PAGE));
+	snandc->regs->cfg0 = cpu_to_le32((ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
+					 FIELD_PREP(CW_PER_PAGE_MASK, 0));
 	snandc->regs->cfg1 = cpu_to_le32(ecc_cfg->cfg1_raw);
 	snandc->regs->exec = cpu_to_le32(1);
 
@@ -544,8 +545,8 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 	snandc->regs->addr0 = (snandc->qspi->addr1 | cpu_to_le32(col));
 	snandc->regs->addr1 = snandc->qspi->addr2;
 
-	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
-		0 << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
 	cfg1 = ecc_cfg->cfg1_raw;
 	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 
@@ -687,8 +688,8 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
 	qcom_clear_bam_transaction(snandc);
 	raw_cw = num_cw - 1;
 
-	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
-				0 << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
 	cfg1 = ecc_cfg->cfg1_raw;
 	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 
@@ -808,8 +809,8 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 	snandc->buf_start = 0;
 	qcom_clear_read_regs(snandc);
 
-	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
-				(num_cw - 1) << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
 	cfg1 = ecc_cfg->cfg1;
 	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
 
@@ -904,8 +905,8 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	qcom_clear_read_regs(snandc);
 	qcom_clear_bam_transaction(snandc);
 
-	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
-				(num_cw - 1) << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
 	cfg1 = ecc_cfg->cfg1;
 	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
 
@@ -1015,8 +1016,8 @@ static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
 	int num_cw = snandc->qspi->num_cw;
 	u32 cfg0, cfg1, ecc_bch_cfg;
 
-	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
-			(num_cw - 1) << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0_raw & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
 	cfg1 = ecc_cfg->cfg1_raw;
 	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 
@@ -1098,8 +1099,8 @@ static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
 	int num_cw = snandc->qspi->num_cw;
 	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
 
-	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
-				(num_cw - 1) << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
 	cfg1 = ecc_cfg->cfg1;
 	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
 	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
@@ -1175,8 +1176,8 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
 	int num_cw = snandc->qspi->num_cw;
 	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
 
-	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
-				(num_cw - 1) << CW_PER_PAGE;
+	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
+	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
 	cfg1 = ecc_cfg->cfg1;
 	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
 	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;

-- 
2.49.0


