Return-Path: <linux-spi+bounces-8222-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBBABE365
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 21:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16EF3A9220
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF37255E32;
	Tue, 20 May 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCBsuHZn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F27C875;
	Tue, 20 May 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768146; cv=none; b=EN6Lc9RIYclpgBIJGTl2pLXyJWgCavNOlS/OkLXwgapttuHJWHxjJp6h2b0kZek13t+or5j1vR39y8NGUPzGt+VFghSlcavDxk9XEPefn0cM+QCpIJWlvgqDCH0c4S2F5KpWOCYh9acB7MTW3MgD6+8HkFWfpRQAELyoUxYgwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768146; c=relaxed/simple;
	bh=HEjDEuN2jlIEAxYT9AqChIu7/aHpR2dzu8+sXaRc8T0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EqeCWYqkO2RIpxsnE8RRFh3sJdTIRA9tEUD+iExeSjjr4KdnC3cpuyppmsj4uhnDHqlSgvgjm31YDRHeag+6Z3vvv4pCxu4u6I/ooNFOV1IV2EROlFSOyz3Aozh9AygScpSsLRZGX1DihIeuQsYCrR5VrevV6ukVrTN1yCaJf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCBsuHZn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so1328013f8f.1;
        Tue, 20 May 2025 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768143; x=1748372943; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2K6MoWsuqULzUu6YkUYRAAATfxs31Smc/0Z0m7qtI8=;
        b=CCBsuHZneLqZ5zc3owU2X+0ep7Fc8uCbNqAsEjQgyPJJawnNA53N0OiJeA3eEk1eBy
         VQmn1Xmo0xtgg7L/vo6+yLQK0QbBGIIf63LnKP1AYNzOPKPsjx43Fud4InEyB2U8tRAe
         9MkvJgXBLrmeH+F4A6LeKiiycEKLx/F0kTj6a2TyIQ09QKO9fLqmnc6rXrZGWTIDtrgF
         UAt/aPjziMW3OUap//be5Swe1iLoJn4EHemHPc8HYW0+A9ZrKKV+ChL0vIdybc9KQFZ1
         9b4wWfwIq44dr1H9yR8L8n6ojbYyjLAFrKm0uB+z1CHP+ByH0V7i76El0TImjaTnAovq
         k06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768143; x=1748372943;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2K6MoWsuqULzUu6YkUYRAAATfxs31Smc/0Z0m7qtI8=;
        b=cyet3nFQe1nGYBkFS9LE99fPMjW5ySSEu2ulOltRfC2kPHrJ+9bj5355pDTxs8ibRD
         gmC8qnyhFMhZNQHngE/uQ+05gHVENW4jK88/0LPEdQpjy9oFFxHAUER5sP0Ougwpp0ko
         UEhA+wWfAqBhUsuPz2TGIYU/GSTZ0w7i2ux03wb9QWIH6u6OCgRZdqe1gTtC5As/ouRN
         YKNcybseB2I9hgPmd5LNvu0vcRj8pE/RmOImSlDCG/J3IJfWNfXAZftZCBvo0WI+/UuQ
         9mZ9GsxueYrJjwO139tv+yYQRdmkYJDpVR61qisHi6IXsJVe9IsbY0eyL2mYeHJvDZrd
         IFEA==
X-Forwarded-Encrypted: i=1; AJvYcCWKalPGDFigCWmCH8RMXE7JJH0BaJBWjBj46/uOy6wTmYsDvE1LV3QkDNX2TMt5ZwhNfYOjAfDx+YeieR2C@vger.kernel.org, AJvYcCX40WG81q1J3kgknPAI0BlF1lSm8hfWg1usMDe0va0xLN2ttuIb5lNRStljw+HGsklYoxBDKDNhnhOw@vger.kernel.org, AJvYcCXtNX29QnU1rDW6OCI0x0CXCspzp8mdUOpU0RrTh/ta53tIZcgZNjEF1eF3OZpuVys5l5w8l+Zpt+HjxjIF@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/K+reO1+lIQMhomD6Rzm35qmGpsNI0StTLs12vB9wVlI1/O7
	XryofmyMNHvcuFk6MyqsTGe6wV+RvdeYBsxQ2Oo+0sInE7gJ0BRTSBKIMf65cg==
X-Gm-Gg: ASbGncvK+Vp/0Gi5CNJGqnoLzS68Tw88NI2LR3tkZLIuuRsy0lwIUJhb49bypicnW8M
	86OvcvyLEgtQDVl9IS7az1vh9FAyaaJ3yOUIj5mmRP1PbaLflD7ZCr/XQoWYHp/mSEOPNFRW3mM
	TOnX92w+P4EHJ1Uq/KJ0uiA8/xW48krBMafNtOg5WnzIo8YhUw9I9UIEG+cQulCHAvD6Jp2Z0Nu
	Ru6A8dpJelY5L24W9yX8mPkOpDf7zptrOOlfg5sygLDgtaJzQVQDiwzo23+Bhq5MnZoQJX4XR5m
	CUA8L2m5C/jJ7JpLwhmS0TjnfAHYA+1SwJegyx3EI7RL7mHocJb2ZQIFYtF812S9j6zsXU8JqqK
	tVlpj
X-Google-Smtp-Source: AGHT+IH3V6A6ySleXz4Mm/IFzFSTFv6ap6SC5pohNVPeEh9z8mi2hHYoVR4dCF/KVQ7Uv17+2clYrg==
X-Received: by 2002:a05:6000:1449:b0:3a3:7638:d754 with SMTP id ffacd0b85a97d-3a37638d82bmr5517381f8f.21.1747768142935;
        Tue, 20 May 2025 12:09:02 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f6b29619sm44130955e9.7.2025.05.20.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:09:02 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 20 May 2025 21:08:56 +0200
Subject: [PATCH next] spi: spi-qpic-snand: remove superfluous parameters of
 qcom_spi_check_error()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-qpic-snand-superfluous-params-v1-1-86dd4963e90f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEfTLGgC/x3MywrCQAwF0F8pWRvo9OHrV8RFaG81oOk4caRQ+
 u8dXJ7NWcmRFE7XaqWEn7rOVhAOFQ1PsQdYx2Jq6qav+9DyJ+rAbmIje45I0yvP2TlKkrczzp3
 giBancKFyxIRJl/9/I8Pypfu27W52QoF1AAAA
X-Change-ID: 20250513-qpic-snand-superfluous-params-e84ae6e3e719
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_spi_check_error() function determines the errors of a previous
page read operation solely by using the cached register values in the
register read buffer. The data pointed by the 'data_buf' and the 'oob_buf'
parameters are not used for that at all.

Remove the superfluous parameters of the function along with the related
local variables to simplify the code. Also, remove the variables from the
caller functions which became unused due to the change.

Note:
Althought the similar parse_read_errors() function in the 'qcom_nand'
driver has the same parameters, but that function passes down the
pointers to check_for_erased_page() at the end of the function.

It is not clear, that a similar call is missing here, or the superfluous
parameters are simply leftovers of the development process. Nevertheless,
if additional code is needed, the parameters can be added back later.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7207bbb57802ce53dfab4d9689113e7f9ba8f131..b5960df106ffa2eea10890901828b6a730750588 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -587,7 +587,7 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 	return ret;
 }
 
-static int qcom_spi_check_error(struct qcom_nand_controller *snandc, u8 *data_buf, u8 *oob_buf)
+static int qcom_spi_check_error(struct qcom_nand_controller *snandc)
 {
 	struct snandc_read_status *buf;
 	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
@@ -604,15 +604,6 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc, u8 *data_bu
 
 	for (i = 0; i < num_cw; i++, buf++) {
 		u32 flash, buffer, erased_cw;
-		int data_len, oob_len;
-
-		if (i == (num_cw - 1)) {
-			data_len = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
-			oob_len = num_cw << 2;
-		} else {
-			data_len = ecc_cfg->cw_data;
-			oob_len = 0;
-		}
 
 		flash = le32_to_cpu(buf->snandc_flash);
 		buffer = le32_to_cpu(buf->snandc_buffer);
@@ -636,11 +627,6 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc, u8 *data_bu
 			snandc->qspi->ecc_stats.corrected += stat;
 			max_bitflips = max(max_bitflips, stat);
 		}
-
-		if (data_buf)
-			data_buf += data_len;
-		if (oob_buf)
-			oob_buf += oob_len + ecc_cfg->bytes;
 	}
 
 	if (flash_op_err)
@@ -794,15 +780,12 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 				  const struct spi_mem_op *op)
 {
 	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
-	u8 *data_buf = NULL, *data_buf_start, *oob_buf = NULL, *oob_buf_start;
+	u8 *data_buf = NULL, *oob_buf = NULL;
 	int ret, i;
 	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->qspi->num_cw;
 
 	data_buf = op->data.buf.in;
-	data_buf_start = data_buf;
-
 	oob_buf = snandc->qspi->oob_buf;
-	oob_buf_start = oob_buf;
 
 	snandc->buf_count = 0;
 	snandc->buf_start = 0;
@@ -883,21 +866,18 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 		return ret;
 	}
 
-	return qcom_spi_check_error(snandc, data_buf_start, oob_buf_start);
+	return qcom_spi_check_error(snandc);
 }
 
 static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 				  const struct spi_mem_op *op)
 {
 	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
-	u8 *data_buf = NULL, *data_buf_start, *oob_buf = NULL, *oob_buf_start;
+	u8 *oob_buf = NULL;
 	int ret, i;
 	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->qspi->num_cw;
 
 	oob_buf = op->data.buf.in;
-	oob_buf_start = oob_buf;
-
-	data_buf_start = data_buf;
 
 	snandc->buf_count = 0;
 	snandc->buf_start = 0;
@@ -965,7 +945,7 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 		return ret;
 	}
 
-	return qcom_spi_check_error(snandc, data_buf_start, oob_buf_start);
+	return qcom_spi_check_error(snandc);
 }
 
 static int qcom_spi_read_page(struct qcom_nand_controller *snandc,

---
base-commit: 5b31d2d81a4bcdd9915e7b152fb3cdc3dc7f4ecb
change-id: 20250513-qpic-snand-superfluous-params-e84ae6e3e719

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


