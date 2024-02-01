Return-Path: <linux-spi+bounces-938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE984545C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977DE1F23E95
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736C4DA0D;
	Thu,  1 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beBvFR7J"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193354D9F8
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780644; cv=none; b=mJj3h8ucKAMumxpBEZS5PU4x/rpdO1TLkT7ajYp/2y8yxDSurWS8dtWk2DWPQF3rAjQXcqkcPoxzwOebpbFtt0Kk1UkmY+EuMenfm2AM2dWyZD0gntncJMyj07zHcC2guoxrRRdxsrZspai3iEGjt/nyOT/iqAp4jbYTDxBhqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780644; c=relaxed/simple;
	bh=9RNIlnEkOBhflYZ07dWhTvg2B/3ATQKvM10lh6zKwUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxiMul5njbHmMFkR7r0GdZS1ckcBCzzuNuIiqINnc4NLHV96Jz1siIcsPeRTFspqWnKJ2GMmYT8iUVvrfBanNumU48uLoqrwkfm9lH3MuuG67mYaJ8K50aI4JNvVyZ68xR4qxD2pLyiTwTX7O8A9KN6YiGxmvm3vOErwlgtQ1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beBvFR7J; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso594627a12.2
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780642; x=1707385442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX3qCR87ShJzSFEO09hnM6Dt1AniELSDas/gjVmTSx4=;
        b=beBvFR7JkPRNV4BIjXj1xIRTVZ49bDdv345OhowIvS2q0bZm1ZgcJ/lB5//tX0lYA+
         fEK9LGyrmhd/PRNKywIg6MfT4BU9EYqTdzmUGe4LR0NgAWoZh02yh3QaaE7DzD6OizJk
         rFuUpkSijF9mD4LUK875bc4OAr7XduVibMUTerw9DPGVgxScTBSOu73w+LZ8ZyanFb1I
         d/L3dWSzUm2KRtF0idUUBZLKmW5W0EtUNs1lmJmkVFPaSFwV+/cfy2hEPJJ2Nu4KEjoh
         8L4h2CerhuHbAAp2BFKz8KRWAdjD+YcI0MCdlS8MPCyFm60Iim5flrn4CJMiKi+pYAo/
         NAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780642; x=1707385442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX3qCR87ShJzSFEO09hnM6Dt1AniELSDas/gjVmTSx4=;
        b=JRT/B/C9Jd8AfK+A1WPIQjc9+4G5VWpu/p613HyAM42t4LzZDyar+3O6vkdFJ5vJ0L
         KuElpj4Hlj+2ldgPi2s8cN34g1gwtcnG0F7SrMYuimxoptr2ojGC0kOlMLVr1jfjggZu
         3ofrhMjj1BS8F6wq2Il8FW3TXUny8+Vlh5mqKe7T+MfSUMN3vJ9vJCNF0GiyIpxZ6bTw
         tcbvNU86rLIvzgW1u1SibvKGa0nFklZXeBeKtZl8eWw4SILdQ/s6aDM029W96nYIQy1t
         PSST3Ii/pzIn1fRmpAYa0+kwbkDJA73cJy2OMGAQhsufCQ9UiAK/uzJJgOLXR5ZrE3ZF
         eIbw==
X-Gm-Message-State: AOJu0YyIa/sgwWnD+IO7CJPxNoQYvR3Fs0eHeHzZl6E7647A6WuPLfvx
	BEGxpVr+CN+xbaffVhF9mIrreMF/Q6V9F5YFBICuHUDJUu4NJGZd
X-Google-Smtp-Source: AGHT+IHn1cT1IA4UY+ilMQdMTmlRHMLizfmhuyhI8NCRHCr1Z7VCKuSQs1oa+Laz4dcyQiIuwm4+tw==
X-Received: by 2002:a05:6a20:2e14:b0:19c:a2ef:c45e with SMTP id be20-20020a056a202e1400b0019ca2efc45emr3561671pzb.37.1706780642211;
        Thu, 01 Feb 2024 01:44:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUAqFSeWY9NRe8ii0n+H9c4ZKRI+H1HS/lD5djRBbkC75t3m0xksOCzLlj5Kiq5G7G5AMVteyMqI5qge3Vko1CH9YPTmqc/gINAxJ7oxGqYddXNapeYOaACvt+B/vuLQAEMOgjE5P8PFo2EA05LxNMsDtSebMEL8TRMWOnipAI26oz+QL8PPLO3P7O8Sq4kKhcrGxCUojYPyBv1tU256jJ37qW0WZYa42NaTdDOcofvZi0pTa5s/RHoF2X8v9chPGCacJufAN8Ri9Hyw7kPqdstHZAzVWqBE1kwd8NlTFWQCTjfkQSjCr4P/IEzbsDM9P40Cw==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d705b43724sm2471110ple.169.2024.02.01.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id B405380DCE;
	Thu,  1 Feb 2024 17:50:02 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 4/9] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
Date: Thu,  1 Feb 2024 17:43:48 +0800
Message-Id: <20240201094353.33281-5-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Parse BFPT in order to retrieve the byte order in 8D-8D-8D mode.

This info flag will be used as a basis to determine whether
there is byte swapping of data for SPI NOR flash in octal
DTR mode.

The controller driver will check whether byte swapping is supported
to determin whether the corresponding operation are supported, thus
avoiding the generation of unexpected data order.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 drivers/mtd/spi-nor/sfdp.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 57713de32832..1bdb82c1328c 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -677,6 +677,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EOPNOTSUPP;
 	}
 
+	/* Byte order in 8D-8D-8D mode */
+	if (bfpt.dwords[SFDP_DWORD(18)] & BFPT_DWORD18_BYTE_ORDER_SWAPPED)
+		nor->flags |= SNOR_F_SWAP16;
+
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
 }
 
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index da0fe5aa9bb0..6089d5bc1e4f 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -130,6 +130,7 @@ struct sfdp_bfpt {
 #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
 #define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
 #define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31) /* Byte order of 16-bit words in 8D-8D-8D mode */
 
 struct sfdp_parameter_header {
 	u8		id_lsb;
-- 
2.25.1


