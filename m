Return-Path: <linux-spi+bounces-8115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79FAB68A8
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1621C1BA0D76
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA325C70C;
	Wed, 14 May 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecTpoxRF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4072581;
	Wed, 14 May 2025 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217807; cv=none; b=PskoLSfotJKsuwPXeGtdz/atU1w5X0bfMouobMsFgzj9AWkMoMQA9VIiEtlJnXnd624ZH92Dy1cmlkDnHINkqoM8yNpF1WrW3KjGtBebxSd8nidPOFxfOLEPLHGXIL/Bl/lQyslnAhvW5Ah+Gz7qVgv5Mgvy6w05D3Zh/3qBFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217807; c=relaxed/simple;
	bh=xUrXMqnTLFPEX7yU7U+LYrYTOBZ2oDw/xXihZ9FZOZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KZcnV5Hf6nCrceIwui+HPIPUEMuz518dQJN416QgCRcS/d0wlb++HrWBiVSVrOkn6DVBcbOyVhGY1syxHjFV0jRr61evwyfCbe4l+aFnBNNsFVLVjjkJIzseBHxMvUKcbzaNGYadoKrkm67q9rKuONCidR+UDg5JWCrqnKYQjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecTpoxRF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso3093198f8f.3;
        Wed, 14 May 2025 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747217804; x=1747822604; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt5jpPl9R9r3M1DxHFUgl8SbNW1F0avaN7jhoorozrg=;
        b=ecTpoxRFZNaCn3aLlPtKERKJhTFIquFtUUietKO86PAfMmILiMVZB1vs+BxruOdPxs
         dmBH3L0fRkb8lcheeDSV5Su0Bqu7j2uBR2gKDqPJ3dXJBLN15mAxs4aEtQskVm1hvdEi
         ZTa9rc3Xq842PRG+KE9zpqxQsISDcu0A0/NuSredv5xo1J7oO8nNpTk7PgGDHL9HT+hD
         s7FPg0pfi4C+VOlYUvbLCuoyWBrTGdaX4tHHQMgLJyKKxeDjvIKdnZ/nNudp/kuTIApK
         xA3pfWtgkV+yrHi1McPMWx1YosvJkdKrkbA/fpNvnlcCHaAbpzg1hNaWaCvRE8wxeSa8
         hQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217804; x=1747822604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt5jpPl9R9r3M1DxHFUgl8SbNW1F0avaN7jhoorozrg=;
        b=tArKzM0S1jC6anDYbYH+qXz/caiukBnzJgAZMdp9mKqI2WKm4Go/GOwFoz8w4P7HKe
         4lS3LcedSJSPvZHRjzHGVFv3A+5v3GXX1ZIxXVDw64GMLWvfOBjsBmdBq8iEabHlRG3Q
         joqGjvmnfUgBkHRDab3vMaG7zQWV/FLJ0ge6YQebGRQst/6Zf1Vo2aQcWBLCZoXUr3WJ
         8n2jyip8qmVr5YXNmOObcxlaLg2tdvRiXP2omYroSbsnfpTcU8yKh4+OnbyGQfJDstGZ
         sKdfeznLFGuwgj9LxuVvLTn3h9q7A4jZt9VQuaTIMBbi8U8gyQ3aOJMLZM3Zv5Fmgnh2
         MNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPXGnSQyuHF5L6M41mUd1SbfkrUtFCNUIg8j1vvyWp2xj3b1OBbIitfLcxPAUeqeeWWI4057QmObkxrzL3@vger.kernel.org, AJvYcCWNgvAB+Q4ralDrbkuGn26DKyKTSQwsKG7dooYACVNEfda8/GBpWdCdxW2vYoageCAFg2c/vxa2qrbA1ceW@vger.kernel.org, AJvYcCWWERvLskMTE+bivH88Xcuqdoh0tvDcMXLE+U/2TbgAcELQ6GAWev6b+H0OW01ydF8y9smZUKiFCaWO@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOabkzmXfi272C2+4KcZ/42spv+6SsXwgFTAyYiXAuge5MrYE
	o8obNrmsrDLSz05dDXr+Kp97YUBP/hIQsPDJvv0USTcVaAdOhsKv
X-Gm-Gg: ASbGncvkIKYq8H0/4gTiwNR2NnpaaR33AjpNlPkWRv8khQy9RQPsiToVu2F6JLgFeLo
	wUEojdz3s08XoNnCWftz3JMgOkTC4acOWNb69OczovuScR0+YYzTzibzZ01E4gldQm+AbPnAOiX
	RP+uuZRc2kjIlzyqdyhn/RcZZES0iY/scpj3wBB6AdpkGQnNVGFY68HWsyaxnyFt76lCAGTvaxC
	+NaV3RG6qVZXYhvmsKaVgcr2K3sDFfsLcmbgobPlyaAXtiffN7RG50KC3iAPu9ow1CsmNS5XP/k
	1rL5ReFg8v/LiwIr3aDdKk4AKO1hGTwy/p70K/HE6ZobF7lXwi3yA/YX4fteLG5Ez9dP03sbESU
	NyAM6
X-Google-Smtp-Source: AGHT+IGTBzXJ8khuka4ANfCsJsFYflJ8G0mPpcLcLGB4Y+fmnHYrjMluF3TVeXvhgi5hMkdHZs1XCQ==
X-Received: by 2002:a05:6000:1a8c:b0:3a2:12a:e637 with SMTP id ffacd0b85a97d-3a34994fee5mr2322746f8f.56.1747217803976;
        Wed, 14 May 2025 03:16:43 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde27sm19596519f8f.17.2025.05.14.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:16:43 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 14 May 2025 12:16:38 +0200
Subject: [PATCH] spi: spi-qpic-snand: reuse
 qcom_spi_check_raw_flash_errors()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-qpic-snand-error-check-v1-1-c0ebd3aae72a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIVtJGgC/x3MSwqAMAwA0auUrA3Y+gOvIi40jRqEWlMQQby7x
 eVbzDyQWIUT9OYB5UuSHCHDFgZom8LKKD4bXOmasrE1nlEIU5iCR1Y9FGlj2tHNbLu2o8qTgxx
 H5UXufzyM7/sBCVK1amgAAAA=
X-Change-ID: 20250514-qpic-snand-error-check-2be1767c3dc2
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_spi_check_raw_flash_errors() function can be used to
verify the flash status after raw operations.

Move the function slightly up in the code and change the
qcom_spi_read_last_cw() function to call it instead of using
an open coded implementation of the same check.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 18a8e572434e81b698332aceeff852e88e1d6b13..3ee891fd5b5e334950a8da58221658b62b8378c2 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -492,6 +492,22 @@ static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *sna
 	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, 0);
 }
 
+static int qcom_spi_check_raw_flash_errors(struct qcom_nand_controller *snandc, int cw_cnt)
+{
+	int i;
+
+	qcom_nandc_dev_to_mem(snandc, true);
+
+	for (i = 0; i < cw_cnt; i++) {
+		u32 flash = le32_to_cpu(snandc->reg_read_buf[i]);
+
+		if (flash & (FS_OP_ERR | FS_MPU_ERR))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 				 const struct spi_mem_op *op)
 {
@@ -537,11 +553,9 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 		return ret;
 	}
 
-	qcom_nandc_dev_to_mem(snandc, true);
-	u32 flash = le32_to_cpu(snandc->reg_read_buf[0]);
-
-	if (flash & (FS_OP_ERR | FS_MPU_ERR))
-		return -EIO;
+	ret = qcom_spi_check_raw_flash_errors(snandc, 1);
+	if (ret)
+		return ret;
 
 	bbpos = mtd->writesize - ecc_cfg->cw_size * (num_cw - 1);
 
@@ -622,22 +636,6 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc, u8 *data_bu
 	return 0;
 }
 
-static int qcom_spi_check_raw_flash_errors(struct qcom_nand_controller *snandc, int cw_cnt)
-{
-	int i;
-
-	qcom_nandc_dev_to_mem(snandc, true);
-
-	for (i = 0; i < cw_cnt; i++) {
-		u32 flash = le32_to_cpu(snandc->reg_read_buf[i]);
-
-		if (flash & (FS_OP_ERR | FS_MPU_ERR))
-			return -EIO;
-	}
-
-	return 0;
-}
-
 static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_buf,
 				u8 *oob_buf, int cw)
 {

---
base-commit: d43eef530946783cb5537ee58bec892253b68648
change-id: 20250514-qpic-snand-error-check-2be1767c3dc2

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


