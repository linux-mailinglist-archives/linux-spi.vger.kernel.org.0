Return-Path: <linux-spi+bounces-7857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C9AA7A43
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51E24C7B0C
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438D1F4CA0;
	Fri,  2 May 2025 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnzKYdH1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA061DB125;
	Fri,  2 May 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214299; cv=none; b=DBJQlJ4KGzOET/giyYFpW3QCYbgFVH0KUXxsqtTZ2eeDoTVoZK2cr3ck2zVJBq0QYjRy1ddSFnj12VPlZm/VwhOZ+xeuftXOx6d6JtNbGKdT5wguvPRXWxWVL9LeXpXfp99qCr9SADiW3nvRk/j5duxhmuGy8BRqKtA/MQ/sSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214299; c=relaxed/simple;
	bh=bbDs/UYh+nkmCWHZGm/LBTS/UbFEV4hw5cvNhhW6Qz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATSAXooHVM93H19ueiyt+RqpjDsi+est4qDbTdOK25mIL4lD34YLv6Xdn9gUdPB3HgfUFuchOSZIeniVdeUOxXXlnQnTyz5qmihKUNG3KF/MdztPGYoSIQkCzSVtRDpkkqSU5BtVnVph2i/JZxSqwQqRriuNvbHPFTZQRZiuWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnzKYdH1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so4349326a12.0;
        Fri, 02 May 2025 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746214296; x=1746819096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYru7OZrKrqfltHny9tU6nYbNSpx3ucjTn2eAVnRMu8=;
        b=nnzKYdH1b3u2rWDqnxbunlVXFCHlmt1d/NBiE8hvUsIPMRPkcwN6ycrsEv02ephtay
         x6qR4/jVJ+tdiGhNgjFRxgsU6Mo7iYWo9dAtR93blOa9TpKYqSipdNrX9NQ4W0+7n7xa
         2eJ9c08AvCVt8TWnaSiRhVCLd2gKcCJt1FIhQGOv+ul4I5QWOLQc3r1Sg+8fkB0g5D13
         fmctODbXZbfvPIGP7c8eiP/E6J7QTnLW7u7ZwzOdFg1fVdXYuvSwpzCkIBWlxNYs7riR
         uKhegE4upYc6+HVmPc2X+OYqwdHoMyNXfXuzMEE60dlwp4XSQWzK2L+pNn1GdKP96S0e
         Jfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746214296; x=1746819096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYru7OZrKrqfltHny9tU6nYbNSpx3ucjTn2eAVnRMu8=;
        b=MmPX/d7jvsLzJI8po1XH/sKbDPPI6xAfWjba9pzcEmoOK4XBsjQfu7lRzH73q/NujM
         R/nVo15FPEqF2r0jB8os1Q1asHq620fzEqJ83AEBHx+koD+DqLlqY9ThXWuka0y91KrT
         +sEvYJQg/y7ZQ+Xv7ns5seMksKrgdY/JWkF6neabgkk6PKhDrHgwake/8u36ajZFV7vp
         4oAOugw9IfGS8KU7q1ydKIgXHuL2mSJbxhtMHXUojyu1oIMZtzVPHyROTToy69L2xTTY
         l7WuTluuK9dz3SeMN1u67+oEF+1LgR/lh0LZ5/9GA5Bj13r9o+zwqT3aWky3gnv+sRxP
         SMfw==
X-Forwarded-Encrypted: i=1; AJvYcCW81oF0Z8kkHMoEo2o5EHZPxxKhF2o9yiQ29zGPZjLdvhA0QCt7LU0TBPUUYphZvpXmRGSZNgfQt4Dc@vger.kernel.org, AJvYcCWQFCsGdFGndQZKhmise382pUwJ1slavabSfU1Jb9B/2xmeN9VDNo/DYE6V9EpO6r/c9y5q8gvaJjjv8EDY@vger.kernel.org, AJvYcCXvEWf4qTPP2mXqVQma5iL3FBfduHa80SeqiYv5uYP4w592kyCk3WTxwmwSvsI6c8+crDYa7s4b2vejk0i5@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMgq8nzaNUu52OE+EhofIOx+C8AYegx8HThQUfsQ/PVpzO80C
	NO4AMkCegVms+k5LVks0bcJXs75xYGZhfpXxPhet/hDnbsejGDLW
X-Gm-Gg: ASbGncuCxoIu+f9X6Nqxnrbo5zcCDHXU4VwVfVjU3pFrUgLy3fWXd8itlLTo4OEYUvu
	YA1F2jLiKmVG6XTHg1+AdTRRzfdoBH1b/OetAJnzwuYn201s9XckXqq1Q60t6wIcGYxh8XVT9nu
	pgltLsfYmUSN/O2iW1iOHKkPfzyfG/okwlW3vlyMBhx59v8Di5U36X70voqvWh2ThLlg+vpXAT9
	Uj9Wvovudae1VOuVckigprVXDHOSzfS+D8IUdK9nsQOUQ2mGcQAVgw7h8Mai1iiRChH5gXHnvri
	730ln98VQafCE6YpRme90j164ZzRv/REwTLlCTjHU5ROD1PzIySmJVv3UFXAKxnStvt1Fg==
X-Google-Smtp-Source: AGHT+IEP+FDZGU9hYZfYrSG5ghaZutVUFxUR9ebLBrAfE5499Gp7fnlH3NJSbsc49+MPHKS29brqmg==
X-Received: by 2002:a17:907:3d50:b0:aca:d4d1:37c2 with SMTP id a640c23a62f3a-ad17ad3a8b8mr387683666b.8.1746214295475;
        Fri, 02 May 2025 12:31:35 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad1894c025esm87824266b.114.2025.05.02.12.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:31:35 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 02 May 2025 21:31:16 +0200
Subject: [PATCH next 1/2] mtd: nand: qpic-common: add defines for ECC_MODE
 values
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-qpic-snand-8bit-ecc-v1-1-95f3cd08bbc5@gmail.com>
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
In-Reply-To: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
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

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c    | 6 +++---
 drivers/spi/spi-qpic-snand.c         | 2 +-
 include/linux/mtd/nand-qpic-common.h | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5eaa0be367cdb847d48dbed6f8326a75a5922347..67641ce28bd6435fffda3ffe5e38c777f4708cf8 100644
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
index 88f8fa98687fa292861d46648872135aa7fad80f..dfc8cc5d97624fe741121228b97d2b3562cc5cc4 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -349,7 +349,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 			       FIELD_PREP(ECC_SW_RESET, 0) |
 			       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
 			       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
-			       FIELD_PREP(ECC_MODE_MASK, 0) |
+			       FIELD_PREP(ECC_MODE_MASK, ECC_MODE_4BIT) |
 			       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
 
 	ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index cd7172e6c1bbffeee0363a14044980a72ea17723..a070af4593754384d9df4f6206a24665e2040aad 100644
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
2.49.0


