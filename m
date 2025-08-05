Return-Path: <linux-spi+bounces-9296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DDB1B7EC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D3218994EB
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547DE291C08;
	Tue,  5 Aug 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ4BhrGW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74192918F0;
	Tue,  5 Aug 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409960; cv=none; b=lZzhgCtwXkEMoFz9JpMecAG60H0XRs9+XjvDGKAXoSVuIQW9lp8BJ4L/UzoCogaxXJ6jJV7mtlRPMkFEVjaVp7308f5XTFfHBoix+JFeGmdVYqhjfFTuD8+2LEShFA84tJcFHK9Ju8mSXsh1luOJF9MN7BnNPnIPg4WLEpVZIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409960; c=relaxed/simple;
	bh=p0DSV3SFONWnFSvTaUKPaPfXnVZcLpHcwrYCG3YT0Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lvQ7Y0hHzd3mLASPluT5zZ/3u8hkGuKVM2w3AvOKsuyqdQ+vDdYoFWBik5xDPwMhK1cYdsn6dwLhzinnXT/djj36moDtsMpLeP09TKkwfsGslpdiKRvIAaGG5mfHf1KnlgsqyX9wvVoPNRz+ubHvSpTBAVOO1uDQXJK9e53plfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ4BhrGW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b783d851e6so4884635f8f.0;
        Tue, 05 Aug 2025 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754409957; x=1755014757; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTznWYpI8gKk1kphD2wAHrnft5gKOpMBilNRiI/5gM8=;
        b=QJ4BhrGWr7VezCOwGR8K/pUIqQjulCap8xaPCSkfYyYzZBG0/40a8YHDYC4wc9v/vY
         1sv9uAeFLsDyQjtSjuogSIHOMExU+AiFnpFoWXx9hEsSWA1LH2mprvgiiprpDcGpF+SP
         H3Fq0vJ80R1ErqEY8CtEYQxt+GO/ucgL5l8JvgU+hwhqCX77gVwiCM9L5F8USCkiEr70
         HecHd2UhZjnhknk2hEXqcUD1HO9+XIK+eg9H1rAppxUg5iD3x/7849xEDiNXC9sTu+HX
         6WYF4wc0/aC9kNXKqTeqBk5g4W21a27de5xTfxWpyXXGjnvlngJnk4XSmNQj9rkavNup
         mAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409957; x=1755014757;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTznWYpI8gKk1kphD2wAHrnft5gKOpMBilNRiI/5gM8=;
        b=uuGLmNHCSHf01GurBWls9QQR5mf1pakXFBfV3kQeHcRE1zSvGVik/D9vD2Ynd52cGx
         eUt3eXDL/cZHGN4S8hTRr7SrY9DmQUl7yHhoWHQponNDv4kqqGYk4Fa34eOFXEKrIhv1
         0vx82OVqhxqNj8Fnz7uv1iJTUR/TRKDh2q+M3IymNR/ZyK+QYv+OWs8GhW5rH0YeiBuy
         +4N3TYRlhH819/rWNtPoO5y8Tn+kS/mPZjwW2c5J4QG5RnYeTFc7p//My8PdEE5AhkZ2
         xZ3gm5PeaOlwBiDwOUxgLIGrr0c9GY3kpY50VybUq59BTsI7w2904BSOqOdo47YF7TJF
         jTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Bg1qxUl/12aEq81fIP0vriFSQ3HAMaHbdXb4g0fMeECNRh5enVx1MYHZCge1o1yc/Xf0u05VThVx2Gl/@vger.kernel.org, AJvYcCWEdSLeyl07thWv7OkRnpOULdIpMfJ28koD1GLtV458Cvhb49cVpeilYJrsayMCV/cXB2+hSb4d9gr/ozoj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Hup5ETbIxu4CwNz10s/I7vbb6GK+OfDac8ErjTQPh09k8To8
	DQ1a3fjTWwVyzZN7AQ4/S6YI4TOL8BGH8Um5b20Lv9PEAYwlujYFKOud
X-Gm-Gg: ASbGncsok/iy+3YqbIfnGk6zHbcccClHaW2xj5hCipmH1C2+zw9+vMerFvagOlIAWi5
	menzYDvOceU5ZIKNR/8YA+Y8+89C6Ofr+HGxXJ6K+nP2UP66PYsldBnqJSjAkc7PhOzfo3uoUVk
	4FABligtkwHejxumU13O4zIzVmTLyKIVGYWPHp8Fz1GpNeQKDOwOnLRrUpsYsYeB5DpP+ai1u7P
	WJM+1gMWquWFqhQ6isK+HNKi88TJV4Rurbra/l4G6PlU7TxV3AZzBEmD3+nxuVjPz/g3k61nInG
	//j03mKC4J7sRqTKdlhPPxzgiQl3Ct1mNk8rCM6Vwo8pTV21h+Pi1K89+DTx989XL2wdNOpFCfR
	ZR2rzW+TU2gNcieQlgYG2Nw4dq8/vBlw0qupxxnhCEqEfzZAc/DA=
X-Google-Smtp-Source: AGHT+IEuAmY2hBCqfJhKsYJ4UaGLmKzibXtdG11M9cj+JUXZxQVLIU+zZH6KGP+B1ZvtubgSN9I7wg==
X-Received: by 2002:a05:6000:2f82:b0:3b7:8dd7:55ad with SMTP id ffacd0b85a97d-3b8d94c477dmr11899577f8f.39.1754409956882;
        Tue, 05 Aug 2025 09:05:56 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm19813177f8f.64.2025.08.05.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:05:56 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 05 Aug 2025 18:05:42 +0200
Subject: [PATCH v2] spi: spi-qpic-snand: fix calculating of ECC OOB
 regions' properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-qpic-snand-oob-ecc-fix-v2-1-e6f811c70d6f@gmail.com>
X-B4-Tracking: v=1; b=H4sIANYrkmgC/4WNQQ6CMBBFr0Jm7Zi2CBZW3sOwKNMCk0iLrSEaw
 t2tXMDle8l/f4PkIrsEbbFBdCsnDj6DOhVAk/GjQ7aZQQlViWsp8bkwYfLGWwyhR0eEA79R29J
 qQaRrLSCPl+iyPsL3LvPE6RXi5/hZ5c/+Ta4SJaqmN5Lqobm46jbOhh9nCjN0+75/AYPiDUy8A
 AAA
X-Change-ID: 20250731-qpic-snand-oob-ecc-fix-8d3d80cc8680
To: Mark Brown <broonie@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The OOB layout used by the driver has two distinct regions which contains
hardware specific ECC data, yet the qcom_spi_ooblayout_ecc() function sets
the same offset and length values for both regions which is clearly wrong.

Change the code to calculate the correct values for both regions.

For reference, the following table shows the computed offset and length
values for various OOB size/ECC strength configurations:

                              +-----------------+-----------------+
                              |before the change| after the change|
  +-------+----------+--------+--------+--------+--------+--------+
  |  OOB  |   ECC    | region | region | region | region | region |
  |  size | strength | index  | offset | length | offset | length |
  +-------+----------+--------+--------+--------+--------+--------+
  |  128  |     8    |    0   |   113  |   15   |    0   |   49   |
  |       |          |    1   |   113  |   15   |   65   |   63   |
  +-------+----------+--------+--------+--------+--------+--------+
  |  128  |     4    |    0   |   117  |   11   |    0   |   37   |
  |       |          |    1   |   117  |   11   |   53   |   75   |
  +-------+----------+--------+--------+--------+--------+--------+
  |   64  |     4    |    0   |    53  |   11   |    0   |   37   |
  |       |          |    1   |    53  |   11   |   53   |   11   |
  +-------+----------+--------+--------+--------+--------+--------+

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - use switch statement to handle section numbers
  - reject negative section numbers as out-of-range
  - Link to v1: https://lore.kernel.org/r/20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com
---
 drivers/spi/spi-qpic-snand.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..53205d5037dc4fd58a69063532b20ab10c652694 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -210,13 +210,21 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
 	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
 	struct qpic_ecc *qecc = snandc->qspi->ecc;
 
-	if (section > 1)
-		return -ERANGE;
-
-	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
-	oobregion->offset = mtd->oobsize - oobregion->length;
+	switch (section) {
+	case 0:
+		oobregion->offset = 0;
+		oobregion->length = qecc->bytes * (qecc->steps - 1) +
+				    qecc->bbm_size;
+		return 0;
+	case 1:
+		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
+				    qecc->bbm_size +
+				    qecc->steps * 4;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+		return 0;
+	}
 
-	return 0;
+	return -ERANGE;
 }
 
 static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,

---
base-commit: 926406a85ad895fbe6ee4577cdbc4f55245a0742
change-id: 20250731-qpic-snand-oob-ecc-fix-8d3d80cc8680

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


