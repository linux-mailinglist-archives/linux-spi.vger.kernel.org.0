Return-Path: <linux-spi+bounces-5002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD01987591
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9DB288A7B
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA0157476;
	Thu, 26 Sep 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWiENl6s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67496155C8C;
	Thu, 26 Sep 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360718; cv=none; b=QTgW93ZmSFJGcgZq2UhQfIvMEzm05gUHSnKIhdyXbS0+Nmj3au/nXR7S3HonyNayAW9Ym5UgUFzmQ7O/O6yD2uBZ7osL3ngJgMgLhRj8UvxNGt1exJ6lEfB15LhIOzNwM6PeKQ5XY+9JmoDbL5p7ojnxCW+x/9AJEwUFVNLjdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360718; c=relaxed/simple;
	bh=FB8lJSrIvtTDu7eS9ofoy2BP+FCNh6wGaexjg4HGIHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gX5BCDo+2NGQ//TXsw0jN1D8cZcizF1mQb2qVQ8Q6+A8T+sUahrqMXrVkdah5iTbROgdHyzH6cI4qMusJ8+BaKR3ebho0FBZ7TbmWWzP4slpX4BkZuVHebEEn6lDcXq0fsAUDeZI656q7DcBovBEEFA35lF5OX+zculizicflzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWiENl6s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20551eeba95so9741055ad.2;
        Thu, 26 Sep 2024 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360716; x=1727965516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMuWBEdI2HIbFrXrh9xxcobW8DMR1fI820uWrVQpyfU=;
        b=MWiENl6sGnRDIYu2+1J5ax7QNo88FrYzio8ClTKIaVbrO5L7fjWVOZa16bE7/pi6Q0
         yfqeYRZlivj3HZCAu9O4C6kbmSB6M3OJXaGtUTvLlZrEND1P9sBc/PM7ZtY36gUXsBM+
         y/37t53v+9aZZy4rkQkwcy2DlpZYvs1xjqmDmgop4RO2ySxcvPrQzd1bMFiNNximpLAJ
         bXdY1VceQT4A9+P70sbGVrK/edOivLUST9gGeQHZZvQdIompi0xmbjl/9VO1P19YRF2C
         mMsVzA9ij+ZuXZfJ3IzL+QVxxepFIEh9en2Ms5WxKVQHxCZt981FRjYW1mDe3+g8Az0B
         fhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360716; x=1727965516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMuWBEdI2HIbFrXrh9xxcobW8DMR1fI820uWrVQpyfU=;
        b=JQg54Zdm+diAiF6tFl5u3YaRSRJ0IiXXZCJQm0j/6Es2ZiGZXucmks/FaQizsGNUeH
         72dV0vap8FrePlCWZaSDMZKO7uMgjw+QcRvMF1Kf3Et++qXLFlW7UUhFlto0pmqlc8yE
         t1SgUQawVyzNNpp52BUPx/uCVlujX0SbOav7AZvWVh8ZXepc7aLbqwZ1IImMwsLoWd7I
         oetBI6aJqO6CZOrIiX0p82c4xprhd6qaoupilNm0z4+7dUydVGKtgXZmT9sV7EPeNtwr
         XqVEGZ1S3K5o7nPpPIbZJRbPllqqXoaRYg00Yox28rDCvTomE3Z7nWgpiqY+pRl5lVEy
         MM0g==
X-Forwarded-Encrypted: i=1; AJvYcCUacVddRWX/mz/ufbst/4+StOeBDuqaHVpRU/7FMGmf4UZoRxRUYjlCgHx+t97r2HAalG+bqR5sYaBZ8jk=@vger.kernel.org, AJvYcCWTR7LKsJRfKRqu2hSPKHy68aq6SGEM/VgIVPZBCBFAOyUeCYtUw3Qpfx4fxL2iZrDmJ04BTXa5Og7W@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPtIWjFza/QGl1+gVRhOmZ3N22O5A8zvuwrsticdLzKcTFL/r
	0FhyjPNvl5VmrTwZWJeHJUF33ZlxHFHAWl2vfwY8eNbUzR7xAPSw1ouZ1A==
X-Google-Smtp-Source: AGHT+IGEtc58T5kAWxd3ejQeAnShG9qd/qn85zhZjLVapG+1Ibu8ePMvELjY8JENDMiHASpawvBTgw==
X-Received: by 2002:a17:902:cf4a:b0:207:3a46:345 with SMTP id d9443c01a7336-20afc5f2830mr75735065ad.51.1727360716485;
        Thu, 26 Sep 2024 07:25:16 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1856f27sm39332645ad.262.2024.09.26.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:16 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id BA021802C9;
	Thu, 26 Sep 2024 22:33:03 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: [PATCH v10 4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
Date: Thu, 26 Sep 2024 22:19:54 +0800
Message-Id: <20240926141956.2386374-5-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Parse BFPT in order to retrieve the byte order in 8D-8D-8D mode.

This info flag will be used as a basis to determine whether
there is byte swapping of data for SPI NOR flash in octal
DTR mode.

The controller driver will check whether byte swapping is supported
to determine whether the corresponding operation are supported,
thus avoiding the generation of unexpected data order.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 drivers/mtd/spi-nor/sfdp.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 5b1117265bd2..21727f9a4ac6 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -671,6 +671,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EOPNOTSUPP;
 	}
 
+	/* Byte order in 8D-8D-8D mode */
+	if (bfpt.dwords[SFDP_DWORD(18)] & BFPT_DWORD18_BYTE_ORDER_SWAPPED)
+		nor->flags |= SNOR_F_SWAP16;
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index da0fe5aa9bb0..d90cbd7331f7 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -130,6 +130,7 @@ struct sfdp_bfpt {
 #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
 #define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
 #define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31)	/* Byte sawp of 16-bit in 8D-8D-8D mode */
 
 struct sfdp_parameter_header {
 	u8		id_lsb;
-- 
2.25.1


