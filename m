Return-Path: <linux-spi+bounces-8991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B46AF15CA
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD701C24C6E
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB8274669;
	Wed,  2 Jul 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/Tk6B+O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876E24677B;
	Wed,  2 Jul 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459754; cv=none; b=FiLqAoCaQSEKTxuKmrS/hsN9mEPT423c/u6EUtjN3Dx87oYQIzaDnbNcbRa0Sl/ULNK0To1cOmmaESERRyCzWUdxY4AC0Mz9Od62Pm6ibsobAtc2hVHxNTX3pETm7OR9W9A6Z244Uzo4tWKC/DZlt2R3T3VdWR2uvXXT2kDBk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459754; c=relaxed/simple;
	bh=FMuho/e92tIKohJAH1KoTEnDl6WJEkcmt5TuSACeT54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqV2h++q+Z6Eu0ODPBJYGnXxU/iYo24t/xtgxfiZT3gwaNLrA38YenjMaEQlllvaKV+DxyHtyhnIQ3Ga5u+4u5MGYyzyolXUrW9Tx6dvPG1EuwifsyshzUnSgqgv50Sv4UfMH8gEnFO/UGk86BprjSHRp+/V7NSkJuKHkyrWcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/Tk6B+O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a582e09144so3195982f8f.1;
        Wed, 02 Jul 2025 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751459751; x=1752064551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cttIotqovrBsQ31YR3P9K0wovGk5FKC/4AwOXY6ILWA=;
        b=Z/Tk6B+O7rxdMg7HlvLJDMi4ynZ7zYPf8Gl42isPhvI5AxTPwrRlhP5RSG1SKcdqRl
         RgpMqJJiqhKtz3UUmh0dqbCa5PSF5YHhdsSRA5FF6Xa2NhqRcYS4ZXZhRsXWVarYTHX5
         XDF/Jc/BLXhVRH32Vu/kLEGCJzbYkj8py/yK7iwC98EfuH0ea5AT7knIWkYJAXJd+HPg
         9KYTp+YbTtVLEE1E8qj/rGJLQlGBVSMm4z1RW8hxVL5ijtDhXSKQdRIPJHy3Y19LBuF5
         wq1KBfA5+7F6cxEBPajFWnKBc/XibaBNQNVpinmVuOB+rZ36nklusRul5O1vztFIQv/8
         o1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459751; x=1752064551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cttIotqovrBsQ31YR3P9K0wovGk5FKC/4AwOXY6ILWA=;
        b=H8gsXc8m//qs1znn97Ic8YE44q2RVn9PmiPiFYU3llBpKPtYGWNkt7ECu3drTr7kA4
         yfyWlcl0Y6SZ0n2KdRNGwt1NRVHJWJQsg5WKoKHbDFI3LaqIfdIsMT8jcFKRNKaa9Wrt
         WEfhvPjiYZzIz8UCc8HJuVpH16SGmyZL3tBRoStXb5TRg3fPDG6hnsZmTHyKiUeFkmy4
         56NCLpZFyDXvGK/kRd7RWw7KT0GgBkEAgOHrBL+keLV5QUZMV1t8L4Aemo5YlJO9WYrO
         hWMK8l4AyCpU6TKjtAhI7cbAC3z2TVyDZI9+Sq4lagPZoqbnaAW/4ZY563egcs9oaj7A
         y+xg==
X-Forwarded-Encrypted: i=1; AJvYcCVDf882dllGBoYHHOtnxA+7WfM07hl0SOop76d6eCaC6n61/vwz2kFXL35esYDiOVPaWpNpNYJAtY3H@vger.kernel.org, AJvYcCWKIddNe5CPHqriOLaTcQf6n0uSYCPWpwEpURC2sOKivxrl9HqBGb/K3o4v9JMmHwNf68OaPCnJ6aINyfHy@vger.kernel.org, AJvYcCX8yGxx9UGeGxEQu9XIfgaImMhfVQUaK4H7dtu40XU2lL4EBLzYoh9nntmNvnwtd5nqAU2Cyd6amiaQloRf@vger.kernel.org
X-Gm-Message-State: AOJu0YwYP7roHO2VrszCteXqoMy3oZw/UQgMWL6jH81/24Tzvfbj25lU
	VZGHENLo2c9sA6+f2K2Sly/up1knzW+h72a28Otp/Sg2k06OcnaRwVEY
X-Gm-Gg: ASbGnctELEiRkS4u4BnA8DQqube4QKhqVZBldxEyhY9x7PxE2q3EXg39zrPeMkS1oqU
	o2OMkzYW7EwdWS57ZKNvMnJv1RyXWhAF69GywGJwbi+6v7K7rrQlCXpsX/j4pAmIkcRmH8/iLoQ
	ugwkneLk8DWj9NKGkPuJxmKZeyaV6PUJSJG3E4PVyW03XevZbV6LL54siJpMRyW6rvDl2iGRMg7
	pnUf1UwEiUeUV/cIj2LfZlnqDXW1Jy+X8AjagsvnV9GpGMk5QfwY4xQjqq4QzuM0QB0kGLA+I+k
	4/eDzN2q+P4AR4xcfNcKiYAXPA8I4/3y6vscuJPjyJ1D4p27PZPMQOfuDxM3ffy0IByNYNuwxSl
	TF/TrxbTUFM+aHvQ=
X-Google-Smtp-Source: AGHT+IGR/3U2PrV0fZwpL++zLcvwjw8uCr43X0znjDNfx3e1SB2u86cqFDFQ4duQb8GFpcH12OUDaA==
X-Received: by 2002:a5d:5f56:0:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3b20095d1e3mr1845002f8f.36.1751459750630;
        Wed, 02 Jul 2025 05:35:50 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8a0sm16208688f8f.96.2025.07.02.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:35:50 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 02 Jul 2025 14:35:23 +0200
Subject: [PATCH v2 1/2] mtd: nand: qpic-common: add defines for ECC_MODE
 values
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-qpic-snand-8bit-ecc-v2-1-ae2c17a30bb7@gmail.com>
References: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
In-Reply-To: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Add defines for the values of the ECC_MODE field of the NAND_DEV0_ECC_CFG
register and change both the 'qcom-nandc' and 'spi-qpic-snand' drivers to
use those instead of magic numbers.

No functional changes. This is in preparation for adding 8 bit ECC strength
support for the 'spi-qpic-snand' driver.

Reviewed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - rebase on tip of spi/for-6.17
  - add 'Reviewed-by' tag from Alam
---
 drivers/mtd/nand/raw/qcom_nandc.c    | 6 +++---
 drivers/spi/spi-qpic-snand.c         | 2 +-
 include/linux/mtd/nand-qpic-common.h | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 1003cf118c01b8403c9a0f275f7fa1ba2ba597d6..4dd6f1a4e797857471ea57386dfed715f5b3019d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1379,7 +1379,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	int cwperpage, bad_block_byte, ret;
 	bool wide_bus;
-	int ecc_mode = 1;
+	int ecc_mode = ECC_MODE_8BIT;
 
 	/* controller only supports 512 bytes data steps */
 	ecc->size = NANDC_STEP_SIZE;
@@ -1400,7 +1400,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	if (ecc->strength >= 8) {
 		/* 8 bit ECC defaults to BCH ECC on all platforms */
 		host->bch_enabled = true;
-		ecc_mode = 1;
+		ecc_mode = ECC_MODE_8BIT;
 
 		if (wide_bus) {
 			host->ecc_bytes_hw = 14;
@@ -1420,7 +1420,7 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 		if (nandc->props->ecc_modes & ECC_BCH_4BIT) {
 			/* BCH */
 			host->bch_enabled = true;
-			ecc_mode = 0;
+			ecc_mode = ECC_MODE_4BIT;
 
 			if (wide_bus) {
 				host->ecc_bytes_hw = 8;
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index ca55f9bcd17b4556ffd413c11d6d5aa900c67f85..7219bcaf4055aaa46ee1016ca9bc77aaeef191e4 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -343,7 +343,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 			       FIELD_PREP(ECC_SW_RESET, 0) |
 			       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
 			       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
-			       FIELD_PREP(ECC_MODE_MASK, 0) |
+			       FIELD_PREP(ECC_MODE_MASK, ECC_MODE_4BIT) |
 			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
 
 	ecc_cfg->ecc_buf_cfg = FIELD_PREP(NUM_STEPS_MASK, 0x203);
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index e8462deda6dbf61f99bbcb39e7cb12cdf66898fd..0d944db363cd249ad13cabcd6d0e1b4c7bc81d92 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -101,6 +101,8 @@
 #define	ECC_SW_RESET			BIT(1)
 #define	ECC_MODE			4
 #define	ECC_MODE_MASK			GENMASK(5, 4)
+#define	ECC_MODE_4BIT			0
+#define	ECC_MODE_8BIT			1
 #define	ECC_PARITY_SIZE_BYTES_BCH	8
 #define	ECC_PARITY_SIZE_BYTES_BCH_MASK	GENMASK(12, 8)
 #define	ECC_NUM_DATA_BYTES		16

-- 
2.50.0


