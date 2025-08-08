Return-Path: <linux-spi+bounces-9326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33939B1EDAB
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F6C6265A6
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF81C84A0;
	Fri,  8 Aug 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLpBkwhn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8262877E5;
	Fri,  8 Aug 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673309; cv=none; b=ZBksqEkfN63gYrK+WQ0bf7Q6gyfzxkqrsQ8NBb/1vCXgrsJo45r4aqkHzDrL86b72kg8LEfh0Kk3gWYJg4jex7bdgaGkPOYinKp1BcG7HEE03qpw7yggPVKyb8sBxHb6zgbTz2FhkyNc2zU2qOfD5JxM1gjI1J7oTzIVPyfnW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673309; c=relaxed/simple;
	bh=Blelda5nVdG0722h9Q14mFfen2brYbIOdeyb+h0yll4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QhDJCkJ+Asml1NGDqmCy8hX6M6pInK8OpMU1NH3B6ftiiqZDsYAeEkqQ4QyWiX/cKIjP4cBh8W/x5M1YsRu2nDwXsU5c/Hsyh+BoyXLE9m3mfEdp+4lXfEnEkHp4/LXLiqk4DDoFOSH0/pIDect/NINmBWHENDczCgHtRWs4vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLpBkwhn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7920354f9so1944772f8f.2;
        Fri, 08 Aug 2025 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754673306; x=1755278106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPbiefG2OWimN6RVlxfEZ9aDoY/LizcSfvAZkPKTOf4=;
        b=SLpBkwhnxZ7lMnamDFLdR8Ip3YSUeJkHCuTSwAULyrFWcj/G6uKmBmsB5Q8Y6zNnJq
         lufmAojAx3wHDgi0Ea1YckryQnn7UsQ92Ui90bimJaTX3I1fdVNxAwvH+yyGVnrQjpGc
         2ZbVY8jaurPmr/txWiSByg1Cc6OPEqYQ2GDQswWdzT4kypevwemdzCJ+/c1mHsKZW4ui
         HhmDsT+SZGXR3hUSQCwQoxmxAUsgvwIiwzQztsfhtlH2+gBcMraGdXo6rTeepTldEazj
         r6vAgItWID4n5H7iqJTTZK1v1L7qnx0wkbABRz8Hi3FZ0EiBAbeCX6J6pPC9/SO3gxq1
         XTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673306; x=1755278106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPbiefG2OWimN6RVlxfEZ9aDoY/LizcSfvAZkPKTOf4=;
        b=ljvGZKovhOaYXITkO1881uJBFy18Sv7Bq6Pe1ExjBz4DGmDCG3BIiPljEUynnk4Rmw
         nv/VC5O9aavIzaQZlGzOnk8R+JU/U/BWbHzjhqS0y4KIV8wyVaEthoo2jGkdaXEQY6+s
         MspX1BnG0X/eluJbV3s3zu//srfvZ9Yb0AjDVe09D72liGObWJZNlk8H+tEmCtVAoMux
         kFWR/MZ9WFHT4JVePVn7Fpq3EpKogWE1yUuyqY1L6E0cXo7FYwigtwoXtdaPSEX88zKJ
         VLWfhvGysNBW63vbAKZRORVd4g4VkeVfVQQ08ZyFjS1FhOlssl6KduKCmfF2SSv1FtJm
         fu9g==
X-Forwarded-Encrypted: i=1; AJvYcCVGQ3HXe5PpIKdgeZxVUC+SCPc8T7bhmvieHOx5szNQs5fe3euO1GBBRaQpZbPh0t4JbrI1dIBZfCJZWPcI@vger.kernel.org, AJvYcCX6oCWEo3acgwB0dCilpb4LLWENZYQurqAPTvfzExP/fO/VocvndLhc4xOvSucCsi//RrOucuBQfRI9@vger.kernel.org, AJvYcCX7WpxCNt6aIwjCSitoKADcZQK2JZxDMo2GpWyBBP8EfoHodg1qOE6L7kOyEAbkyqom2N/9Uj2UVqkJSlGV@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJpbv2scY/PlyAE40+6GYAv+r2QSuRU7KvLTVTdNm8d+aNQIR
	VGx1MF523NfU5oqg/GzxA5rQLrmkkvBAtwryTGEuAzy+5f+coM0AZ6PfuqfOow==
X-Gm-Gg: ASbGnctt0CLidh9BjhV5MRGYEZWm6K7GxJGQOMwiIGSdeai/pJYkzjULMCh0vO2SIMw
	OEJkgp3mrZKA58+jO7YTwJnguvp44ULYYV28vywFmT0ticB+6C50QP/QktM5+J5oG8mJAGq8VKM
	xgh9lcADs1mPQu0wWyfmJu4eMtQei2svMf0HJ7nEZK9L477fT9c48u92G5bcQHy3fUwEG02wIB1
	tASLK0CvGtSKM5+of4OxKtzgXLSZ7kJ4CfKDRdohXaRb+KHpLr1wrL0zOWD9+5zLCvgH3v9wnB8
	Eh9EMReUYzM0qX3Hk8/xR4ccRlmlxpK5K/U2/fvVG7k+NCCLu1X1bjsBtbKJ082hWDRFzkakBPz
	UyuhnYowuqLMX8UL8KjPfmeJmkW/gYYaNKL0VgwqRObMYDtjEvLJ1WPvooOedpw==
X-Google-Smtp-Source: AGHT+IHr2LVmYrP8y88MwtQsopBm0qhYmXUyUQcFF43HBCPAiZE/3OaipPy+JWDrsbyZXlsy6D9/WQ==
X-Received: by 2002:a05:6000:2406:b0:3b7:95fa:ac4 with SMTP id ffacd0b85a97d-3b900b7aed8mr3106389f8f.32.1754673306175;
        Fri, 08 Aug 2025 10:15:06 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b8fc6ef28esm6308907f8f.60.2025.08.08.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:15:05 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 08 Aug 2025 19:15:01 +0200
Subject: [PATCH] spi: spi-qpic-snand: handle 'use_ecc' parameter of
 qcom_spi_config_cw_read()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-qpic-snand-handle-use_ecc-v1-1-67289fbb5e2f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJQwlmgC/x2MUQqDMBAFryL77UKaElt7FRHR7Gu7UFKbRSmId
 zf4OQwzGxmywuhRbZSxquk3FbjUFcX3mF5glcLknQ/u7gL/Zo1saUzCxcsHvBgGxMiC1rfXWyP
 BTVT6OeOp//Pd9ft+AMSK76hrAAAA
X-Change-ID: 20250805-qpic-snand-handle-use_ecc-de929376d50b
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

During raw read, neither the status of the ECC correction nor the erased
state of the codeword gets checked by the qcom_spi_read_cw_raw() function,
so in case of raw access reading the corresponding registers via DMA is
superfluous.

Extend the qcom_spi_config_cw_read() function to evaluate the existing
(but actually unused) 'use_ecc' parameter, and configure reading only
the flash status register when ECC is not used.

With the change, the code gets in line with the corresponding part of
the config_nand_cw_read() function in the qcom_nandc driver.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7b76d2c82a5287df13ee6fcebc4abbe58ca861ee..119003c4784890458a41c67fa8bc17d721030b0d 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -494,9 +494,14 @@ qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int c
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
-	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-			  NAND_BAM_NEXT_SGL);
+	if (use_ecc) {
+		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
+		qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
+	} else {
+		qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1,
+				  NAND_BAM_NEXT_SGL);
+	}
 }
 
 static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)

---
base-commit: 13d0fe84a214658254a7412b2b46ec1507dc51f0
change-id: 20250805-qpic-snand-handle-use_ecc-de929376d50b

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


