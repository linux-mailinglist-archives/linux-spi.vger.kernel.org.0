Return-Path: <linux-spi+bounces-939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63584545D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86F6288079
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724694D9FC;
	Thu,  1 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS0Sfa9h"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49434DA05
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780645; cv=none; b=HcVczEYhDtRVgbM7jXMExLyP0Phddlu0C+FO/LthTuuQQ4x06QH9hH3+Gpn7iOCWGtXGYeZsb1dxlN4YkK1UAqGe5IsQmoU5X+R0WqKu+xE+pfyyCbJ9gD+gjw7/8D0ztpXdrHI8ZndQYnYSp8HE3z/Y44Buoc2Bu6osAgcGGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780645; c=relaxed/simple;
	bh=vuSzmKOJJMzx/KtiiD3uq3/xTi1m2rFaY2J1WULr0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boOTNaMeYr88VNrNSGPsyN1Qj45Bt8BCn8dL2w3AaUKaT19aV1ODvw68yc2nfBMIQR8b0nLAJe9+g65Q+uvnbO7a1CUyih7BPWG+lOIHIT6w5nvLS84wU2JNsBEfXbZ9Z9K1prIeBlntWQwvAAlaebPR9nFiVW/A6Yg2z8LMnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS0Sfa9h; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-295a7fd8eecso491808a91.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780643; x=1707385443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p1hqFhpwmyezDAylCyO9ijrtnaGApEBAjXs9d1j9j8=;
        b=DS0Sfa9hihFJAzOs8fTR1swomxe2BAL/SN91ebELuWD+lELXr7WLOTCXgKIWt8r4ur
         8TS/ILhEMsCqbZwsbEP9uFrrQF3WMXT33ZjP3Fgjm1ovZIxVbe8K5UvSwYO/y6NJ+B+b
         tEaJ3qEJpltHU4kh+4+CwTYb8Z+zk0SzRyVJaGJKJ3/ADY193A+XZta9BVv7kkAVS4lg
         72UL5/la4L8JOHfEHaZJEyEvkXKgV5cf8ofHPRcigwPcUzb892IM3nJAl21IjWA4hBFf
         IXmw6NkGd9LU25SxA3AdRAfW1CJ7MBx7wvOD87m/0U3SHrAkykoKgjd/dVULb2dQK46T
         +XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780643; x=1707385443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p1hqFhpwmyezDAylCyO9ijrtnaGApEBAjXs9d1j9j8=;
        b=JxYzllZtzdZGO7ThihtxYRNhAOxvsqmmTfCbNDQ1lSSlh464ZOqWEd+Xh7bEuWLeTe
         O43QXe1yiEF4VnZFICHVXMy/6SI0+xJzYx8z2nUdFO0Gyu0/bGaD0IwX8zgbUUIo5NFY
         fHB3NFeM+qaWIKM25C1U0G0oUImPCASlZC1ZRtBqTzgSC2zsaMTsaxFFigLaK1AH9eWi
         BNcdhhWBXVcVxgSIAgGDHpmYnWIdD5X7w5n2d8R8imP7mdoaSwqx5YEXXK3rzD6xkyLi
         9qDZMd+H6QB8cNUW5HGBpXxh4duhnIJvjAoWw5UGr5D/DiCkgGzZ6mUUIS5B52RugFX7
         eW/w==
X-Gm-Message-State: AOJu0Yw58OGvz5RytT6F+Z9mLBbd/GhCZfVqaAwauIrYQbF/prXu5JAo
	n7Una61KPMhEurLJlwg4sJoMnEle92gZvdhT5qwwSHo/DTh5vV5/
X-Google-Smtp-Source: AGHT+IGkrMaMhQS/A714VNYlAynO4jYO03jHC3tGb8cTJ2r0pDDba8IGNFekpVwIQnrGhOIWSd6V9A==
X-Received: by 2002:a17:90b:68e:b0:295:64de:c443 with SMTP id m14-20020a17090b068e00b0029564dec443mr4255154pjz.21.1706780643225;
        Thu, 01 Feb 2024 01:44:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsYGDwlXy9duJgSAxMCr3nDRpSKgvWccWjfQUhpuI2Id3cYTuFapX/Y8TexuBGPV7gz6wEJ0JEOXfd/IkwG2vdQUAQUtuJ2ea06tcwlQLkqbuqp7lw2ZaqQgM2jn4aX4FFoUZ1OzfV3j+ewlvXsI3Bb/bsV4UWKB8o6q3k7A7X586WfJEA9ZipdiWIUPPkMtm+U+2JbjQ0l5YaflOQyedMvblqWzr8MNDCRwERXVVwGGpzNaG6F5WCVAeY0ndPTeLFXx9yt7HNwehlKndzfCrZWyWlRJ9xFHmq1O4d/hDAtLcW9KEKiTCKf6c0B2w0OCjWHA==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090b004600b00295c3bb9318sm3181376pjt.54.2024.02.01.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:02 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 19C7080DF8;
	Thu,  1 Feb 2024 17:50:03 +0800 (CST)
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
Subject: [PATCH v8 5/9] spi: mxic: Add support for swapping byte
Date: Thu,  1 Feb 2024 17:43:49 +0800
Message-Id: <20240201094353.33281-6-jaimeliao.tw@gmail.com>
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

Some SPI-NOR flash swap the bytes on a 16-bit boundary when
configured in Octal DTR mode. It means data format D0 D1 D2 D3
would be swapped to D1 D0 D3 D2. So that whether controller
support swapping bytes should be checked before enable Octal
DTR mode. Add swap byte support on a 16-bit boundary when
configured in Octal DTR mode for Macronix xSPI host controller
dirver.

According dtr_swab in operation to enable/disable Macronix
xSPI host controller swap byte feature.

To make sure swap byte feature is working well, program data in
1S-1S-1S mode then read back and compare read data in 8D-8D-8D
mode.

This feature have been validated on byte-swap flash and
non-byte-swap flash.

Macronix xSPI host controller bit "HC_CFG_DATA_PASS" determine
the byte swap feature disabled/enabled and swap byte feature is
working on 8D-8D-8D mode only.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/spi/spi-mxic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 60c9f3048ac9..8ac302e48c9f 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -294,7 +294,8 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
 	       mxic->regs + HC_CFG);
 }
 
-static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags)
+static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags,
+				bool swap16)
 {
 	int nio = 1;
 
@@ -305,6 +306,11 @@ static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags)
 	else if (spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
 		nio = 2;
 
+	if (!swap16)
+		flags |= HC_CFG_DATA_PASS;
+	else
+		flags &= ~HC_CFG_DATA_PASS;
+
 	return flags | HC_CFG_NIO(nio) |
 	       HC_CFG_TYPE(spi_get_chipselect(spi, 0), HC_CFG_TYPE_SPI_NOR) |
 	       HC_CFG_SLV_ACT(spi_get_chipselect(spi, 0)) | HC_CFG_IDLE_SIO_LVL(1);
@@ -397,7 +403,8 @@ static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
 		return -EINVAL;
 
-	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl.data.swap16),
+	       mxic->regs + HC_CFG);
 
 	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
 	       mxic->regs + LRD_CFG);
@@ -441,7 +448,8 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
 		return -EINVAL;
 
-	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl.data.swap16),
+	       mxic->regs + HC_CFG);
 
 	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
 	       mxic->regs + LWR_CFG);
@@ -518,7 +526,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	if (ret)
 		return ret;
 
-	writel(mxic_spi_prep_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN),
+	writel(mxic_spi_prep_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN, op->data.swap16),
 	       mxic->regs + HC_CFG);
 
 	writel(HC_EN_BIT, mxic->regs + HC_EN);
@@ -572,6 +580,7 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
+	.swap16 = true,
 	.ecc = true,
 };
 
-- 
2.25.1


