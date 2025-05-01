Return-Path: <linux-spi+bounces-7819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECEAA6147
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5BF4C4B2B
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A520297D;
	Thu,  1 May 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf8pRYB9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E81EA7C6;
	Thu,  1 May 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116422; cv=none; b=nHKWFNxAjaoGeecy0OZOoWmfvR6lTsSCtGNF61Krer6v7hTJC8BSAXc1wwpYu0kEYTUQhSQKmSBJZwoG6iNjbv5httN752sTfSeYUNx8S2yWiH1Z7U2c8fgGmHJW/FEiJ7+GCVr5T4cEHvoYK1Ls63KC5fTv+HwEWx91bcY1iX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116422; c=relaxed/simple;
	bh=0WdEZAHYRN7xKQ7Usp85cXY+ysmZrzFqY+HZd+niGkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sTTL/8/B22SlJbRq8xKgKo0HBREWrBA3zqmIxksbGg39xzVsNFXj+oCV9ymRxJMQVWV3pOnI5Add1OT7mqsmJFUnicr/UvfKjXGCQrzvkCSSiuv1ZmOY4yUQeTw1IUc6pKltx4RcygjaZ2skNqTBffaR2qIb8D6jykRycwH8b2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf8pRYB9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acbb85ce788so237266966b.3;
        Thu, 01 May 2025 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746116419; x=1746721219; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOmy2E0oN5vjJ0You/8n6Z0Pmepb4FK1Hw7LfqptwBg=;
        b=gf8pRYB9FqIeCOtlPLUnFKMJvGhJ6IZ/K3uv8EiYU55vLL962UnryZ/ejUZ0SXBNtm
         rTE6zzlAueQI//R+QwSAUKfZjltGsnlyChfS1/WzO//S9u2wfEQYlAJ8mMa1QS961NdP
         6NeDASfU5MG9LLQd67tW49BwTyaNU8zJUKwrBoc2BBP6kXRHF1ES/UjzQG+HlHy5U+y/
         V4DIliMjF72hzx8+I4aj3W4yORE9pzdeR7pAQXvZ3lfibbJWwS4yok2cxtFjYlR65qTJ
         SHoBXRFP6By4ZVeJ5y2ym8pFbiZy+DedLBrg3u6xnkUeb9TjmE0+8yARaEd1hKP8IDdH
         rknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746116419; x=1746721219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOmy2E0oN5vjJ0You/8n6Z0Pmepb4FK1Hw7LfqptwBg=;
        b=Wh/0Lf9y0PrD8ZYUHLmjJjLSXtIGsgVDcHjA1/toUbEMrmPEWlojzcVJdutCvps4x/
         4ulVV5ve37VjGY83eIXr0GIqdhtHKIrat/oobjT2sQRklD7nU4+PASdtnCo2f2+1cYAh
         NUjrSuQGfM5lfx2d+oiHI+1sjeUF1jKe+2mYVBuma7euTuGbkby6KHsQMD0ZBcsOu6Ru
         bHk+G9zkC7NzRhBUSRWc2eFnjj/yqIYRnRI+bw9H1ffa9wV+n7malRoz5Ve8ptl28lOw
         R7bLEgLIVBRBaZTicJ+8T/FNCYGJBqRjI/Yc88mIrM0JnMVwIODqpJP0ngGowebHKlxY
         QIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUX+BlsVQS1OrZAveFLFFMS/m8yHXFMnpvNE0/p4bu0SIR54oavLBIC5iDjV/jUOZNlVrK5V/ZdLCLHRGr@vger.kernel.org, AJvYcCWBrJ9qZgRtub/BjVLsU6xUAZU6xcJCsk0V73sdVJGxtdASWHPp7q8Q2lFn0bLhVPXn5/Q49zvyQzriA6pg@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZ1Coga+TG6YjQeeYK1sTPcQ6osoKg6CZiBexe/nV2I3Lfu96
	XrakIB5AFYwBd9tQdO+f0W9BAx07ZGi2/vzSp6KL/TGdxCEUnW7W
X-Gm-Gg: ASbGncsQHfnhcWcU6DdME+U189fkBnGIpxhziMGEQCw50gwQejtLZQPjpTLeJPZlIX6
	MWJa7wHtV0bHL2fTPvltzj6ydZyAsWj26+QbdzaXoN2j5NImIZoLSBQn3+DbnClcG+SDzhrszNV
	32IBZ6YS/n5a3YiKkUZCHQGE4V7A2fa7EVeXmDlYRCNgr0Yhbw3nDUq8577LP5a+rGKZid+63Eh
	zSTzWSmW9BIg64Zv2rI7iQgh2fhIagSdkIZUXek8ViiNwfzbYEuVrCpqZaz+1sY5IByiUrzHpYO
	9GTBqV3YHiwFCsbd3zkidz7tBONWcOww5Purpjf6r0kx85s4sutdnTle/eKMc8MHlNK2pw==
X-Google-Smtp-Source: AGHT+IHzfi4VSpxpv+pztKx4Lp0PesbOchWTJcGKA3qJLKG6pRrja2Nh+1nKve5gcaP5v06HJrjpXg==
X-Received: by 2002:a17:907:6d28:b0:abf:7453:1f1a with SMTP id a640c23a62f3a-acef450d143mr416290066b.36.1746116418313;
        Thu, 01 May 2025 09:20:18 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad0c70d3a7bsm60970066b.25.2025.05.01.09.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:20:17 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 01 May 2025 18:19:16 +0200
Subject: [PATCH next] spi: spi-qpic-snand: validate user/chip specific ECC
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-qpic-snand-validate-ecc-v1-1-532776581a66@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAOfE2gC/x3MQQqDMBBG4avIrDsQMwjiVaSLNPmrAzLaREQQ7
 27o8lu8d1FBVhQamosyDi26WkX7aijOwSawpmryzneucy3/No1cLFjiIyyawg5GjCy9fAQi8NJ
 TrbeMr57/80iGc6f3fT9cPBVCbwAAAA==
X-Change-ID: 20250501-qpic-snand-validate-ecc-383b3e33e238
To: Mark Brown <broonie@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The driver only supports 512 bytes ECC step size and 4 bit ECC strength
at the moment, however it does not reject unsupported step/strength
configurations. Due to this, whenever the driver is used with a flash
chip which needs stronger ECC protection, the following warning is shown
in the kernel log:

  [    0.574648] spi-nand spi0.0: GigaDevice SPI NAND was found.
  [    0.635748] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
  [    0.649079] nand: WARNING: (null): the ECC used on your system is too weak compared to the one required by the NAND chip

Although the message indicates that something is wrong, but it often gets
unnoticed, which can cause serious problems. For example when the user
writes something into the flash chip despite the warning, the written data
may won't be readable by the bootloader or by the boot ROM. In the worst
case, when the attached SPI NAND chip is the boot device, the board may not
be able to boot anymore.

Also, it is not even possible to create a backup of the flash, because
reading its content results in bogus data. For example, dumping the first
page of the flash gives this:

  # hexdump -C -n 2048 /dev/mtd0
  00000000  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000040  0f 0f 0f 0f 0f 0f 0f 0d  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  00000050  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  000001c0  0f 0f 0f 0f ff 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  000001d0  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000200  0f 0f 0f 0f f5 5b ff ff  0f 0f 0f 0f 0f 0f 0f 0f  |.....[..........|
  00000210  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  000002f0  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 1f 0f 0f  |................|
  00000300  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  000003c0  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f ff 0f 0f 0f  |................|
  000003d0  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000400  0f 0f 0f 0f 0f 0f 0f 0f  e9 74 c9 06 f5 5b ff ff  |.........t...[..|
  00000410  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  000005d0  0f 0f 0f 0f ff 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  000005e0  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000600  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f c6 be 0f c3  |................|
  00000610  e9 74 c9 06 f5 5b ff ff  0f 0f 0f 0f 0f 0f 0f 0f  |.t...[..........|
  00000620  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000770  0f 0f 0f 0f 8f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  00000780  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000800
  #

Doing the same by using the downstream kernel results in different output:

  # hexdump -C -n 2048 /dev/mtd0
  00000000  0f 0f 0f 0f 0f 0f 0f 0f  0f 0f 0f 0f 0f 0f 0f 0f  |................|
  *
  00000800
  #

This patch adds some sanity checks to the code to prevent using the driver
with unsupported ECC step/strength configurations. After the change, probing
of the driver fails in such cases:

  [    0.655038] spi-nand spi0.0: GigaDevice SPI NAND was found.
  [    0.659159] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
  [    0.669138] qcom_snand 79b0000.spi: only 4 bits ECC strength is supported
  [    0.677476] nand: No suitable ECC configuration
  [    0.689909] spi-nand spi0.0: probe with driver spi-nand failed with error -95

This helps to avoid the aforementioned hassles until support for 8 bit ECC
strength gets implemented.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Marked for next because it depends on commit f48d80503504 ("spi: spi-qpic-snand:
use kmalloc() for OOB buffer allocation").
---
 drivers/spi/spi-qpic-snand.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index d0e4f49cd89b977a64fc529aebbae36409efed0f..88f8fa98687fa292861d46648872135aa7fad80f 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -249,9 +249,11 @@ static const struct mtd_ooblayout_ops qcom_spi_ooblayout = {
 static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 {
 	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct nand_ecc_props *reqs = &nand->ecc.requirements;
+	struct nand_ecc_props *user = &nand->ecc.user_conf;
 	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	int cwperpage, bad_block_byte;
+	int cwperpage, bad_block_byte, ret;
 	struct qpic_ecc *ecc_cfg;
 
 	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
@@ -260,11 +262,39 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
 	if (!ecc_cfg)
 		return -ENOMEM;
+
+	if (user->step_size && user->strength) {
+		ecc_cfg->step_size = user->step_size;
+		ecc_cfg->strength = user->strength;
+	} else if (reqs->step_size && reqs->strength) {
+		ecc_cfg->step_size = reqs->step_size;
+		ecc_cfg->strength = reqs->strength;
+	} else {
+		/* use defaults */
+		ecc_cfg->step_size = NANDC_STEP_SIZE;
+		ecc_cfg->strength = 4;
+	}
+
+	if (ecc_cfg->step_size != NANDC_STEP_SIZE) {
+		dev_err(snandc->dev,
+			"only %u bytes ECC step size is supported\n",
+			NANDC_STEP_SIZE);
+		ret = -EOPNOTSUPP;
+		goto err_free_ecc_cfg;
+	}
+
+	if (ecc_cfg->strength != 4) {
+		dev_err(snandc->dev,
+			"only 4 bits ECC strength is supported\n");
+		ret = -EOPNOTSUPP;
+		goto err_free_ecc_cfg;
+	}
+
 	snandc->qspi->oob_buf = kmalloc(mtd->writesize + mtd->oobsize,
 					GFP_KERNEL);
 	if (!snandc->qspi->oob_buf) {
-		kfree(ecc_cfg);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_free_ecc_cfg;
 	}
 
 	memset(snandc->qspi->oob_buf, 0xff, mtd->writesize + mtd->oobsize);
@@ -279,8 +309,6 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
 
 	ecc_cfg->steps = 4;
-	ecc_cfg->strength = 4;
-	ecc_cfg->step_size = 512;
 	ecc_cfg->cw_data = 516;
 	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
 	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
@@ -338,6 +366,10 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 		ecc_cfg->strength, ecc_cfg->step_size);
 
 	return 0;
+
+err_free_ecc_cfg:
+	kfree(ecc_cfg);
+	return ret;
 }
 
 static void qcom_spi_ecc_cleanup_ctx_pipelined(struct nand_device *nand)

---
base-commit: a7f035c2c72496cf7ac34bfaa8c289e0d4c45836
change-id: 20250501-qpic-snand-validate-ecc-383b3e33e238

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


