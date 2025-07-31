Return-Path: <linux-spi+bounces-9250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A7B175FE
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006B17A9552
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6728DF33;
	Thu, 31 Jul 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvgsl4Gg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482123C50B;
	Thu, 31 Jul 2025 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985510; cv=none; b=YAkUH58lNbXDST25Pcs4gBSedQxB5Bjwy8kkhhn2CeaxsPJ97K7oPRotB6Hvqpav1Lh2u7jWNNVglUW48o9eV0D8h2Vczk/9WKPhCshzv3BNwnu8TjTId53BC4CqPFiXIq8thDLoRKM8Uh2ILnVO7bwu7L3k+oB5sGVbfmQYa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985510; c=relaxed/simple;
	bh=qFiEbubEXZgiOllFsoFduLiUOWMNjPrepMcv9O25f5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NzNZszk/FRO8PCdCv1T+YlfZbODHx13uU2ZyG1UOMp2KrLK61tKRI4iLvqvwDj8C8W+qo4Rj2NTYhcaiohIta34zUK4fQzQEniWHAjTVDDGKOWS+IuoZcPpKrY/9qMJlNOJ37m4xgC69mlbwhONSj/2gq+1PGV2EsjtNHmuxa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvgsl4Gg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a46eso803791f8f.1;
        Thu, 31 Jul 2025 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753985507; x=1754590307; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz97ueWXiz4b/PbiskTtWUPg9WrFPlFZWDXca6NwBTg=;
        b=Jvgsl4GgW53OcF4Jko83JWgpLKnMrOCDDe0fGxGDwlAiLYfxIbWUx6AdNs8Qwv6pvP
         ehIwwXanJWlpZptRt9jcXE61yuw6NekIHPbC9yUwF6bQhdpwhNx0gXCCP7lkMKiJxPGO
         DlCUAVocJYAl72AdKOlV3XQArJHEg7TVnYkLrx9gIH8Dan5NZ+bhpsnj85Yf2X7AY7NW
         Y3AzRTBU59j9D2c3AyAx7wWXhAKz4fLCayRQtA5MtyC6D1yh2j21M7/3/HyC/0UTDwPp
         WEh/QEpbGErdYoc0v+MMI83FdWi/QpW3wY4tuJPNZSSSapPJ5gjFpy7Y6Y2dL1zbqQ0y
         YmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985507; x=1754590307;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oz97ueWXiz4b/PbiskTtWUPg9WrFPlFZWDXca6NwBTg=;
        b=UaVmT0dAGtSK/idWEVVZAgRWuSYRvPf25d+OaVJ4gJxsaP53pxcBaJCOPj0jDwe+Q3
         8t8OIs2EgdMbVu1aX1iSwxaLikxRhdJqCogaA86klzypoGMhiCvPb8jFsiv7yaMmQf7Q
         NXpRTm36Rx24lR3oil47us2XSdokdfRvzMpZkIzTYZhmpZJq365wzZ3W0EAc5hJTtzIK
         f0wbn6F/aEVtypxhQPtNRbxVEKLDno0sgraC0MidnxKucXq6s+Rtn2nmccV/7cix+opX
         CMVr1JUPFTOJNtHYys1ld405wP4L1qZwQbrbf0BXVIUjlrHtzfJnIJhqtAtYSaxk2U+G
         dWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5gX1u80efUmqsvO8nGibKnW2Pp8iWzlUm9c2wHUKVZtt748eSXBbn41T433WhrgRdfsSv2aEfm9R9TOg3@vger.kernel.org, AJvYcCXl65jK5U1ywGTc2ts1EszeWrscIWy/bsAHtP/JIIqSo4WvfoV1m25/jY5l2xyHx1topEnLkcZ1w2d2bkfb@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBZxBmK+bPP5XnWUC8vzd9KysRtz3v8lrei7YT3xy2ZfUgUi5
	ZaHcfnljeMrqwNZhZsYLjD+5hgYibw4PUHZof0W7c+oa+dRy615UV8d1VvRmjQ==
X-Gm-Gg: ASbGncsva75M0sZlx/aHGc7OhYfbGpEWULQMYb+CyTrbByYlcioN6qOej+0jTNsLL/l
	rLlV5qUb92dPXLnzUwPJ9C6oNw2IgYrx3UDcMY0WkZRqG8ir6UeMHtuXMBAK/Vtcv0S2XdNFO9q
	oT2e6vLbYEgVkDJMutW1Bmy87XutPJ0pBOdkkVLqP+DPRNK4yXHjHGNNsx+Vxx6lFo3Ql3IRyP8
	7lVs0bLWxff2VAJx7GeTqu5aRpWEau6DEtyHhJdMIbR+WOWMJS4aqhePNvWAPHfXcEsLjVgvmCZ
	2DknC6ZnGz/JRCXv+5oL/7zrzT42QXnpvS+Cut3bD9UtBCXL6cEJmE2qc+Mz2aPFgTBOiSuLu5+
	03yZt0FFEO1XOhbGzWuaXxDnc2X5yjDHqxV/KgNkriIr9Ggcu4JTuAXzuHU6TYw==
X-Google-Smtp-Source: AGHT+IHoFq9WeGTsU7QeC5ti5nJJNc+86GuqbQF6LqraQvtG4wJK8mlOFJGJbKAc0bzxUwv9mBUXZQ==
X-Received: by 2002:a05:6000:2dc1:b0:3b6:1948:c763 with SMTP id ffacd0b85a97d-3b794fb707emr6612068f8f.22.1753985507245;
        Thu, 31 Jul 2025 11:11:47 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c469093sm3230086f8f.51.2025.07.31.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:11:46 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 31 Jul 2025 20:11:32 +0200
Subject: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
X-B4-Tracking: v=1; b=H4sIANOxi2gC/x2MQQqAIBAAvxJ7bkGNSvpKdLB1q71oKUQQ/j3pO
 AMzL2ROwhmm5oXEt2SJoYJuG6DDhZ1RfGUwyvRq7DRepxDm4ILHGFdkItzkQes7bxWRHayCGp+
 Jq/7H81LKB/TQWPVoAAAA
X-Change-ID: 20250731-qpic-snand-oob-ecc-fix-8d3d80cc8680
To: Mark Brown <broonie@kernel.org>, 
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
 drivers/spi/spi-qpic-snand.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..37ddc48d2c17264499f821d235835c4ff5982873 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section > 1)
 		return -ERANGE;
 
-	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
-	oobregion->offset = mtd->oobsize - oobregion->length;
+	if (!section) {
+		oobregion->offset = 0;
+		oobregion->length = qecc->bytes * (qecc->steps - 1) +
+				    qecc->bbm_size;
+	} else {
+		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
+				    qecc->bbm_size +
+				    qecc->steps * 4;
+		oobregion->length = mtd->oobsize - oobregion->offset;
+	}
 
 	return 0;
 }

---
base-commit: 926406a85ad895fbe6ee4577cdbc4f55245a0742
change-id: 20250731-qpic-snand-oob-ecc-fix-8d3d80cc8680

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


