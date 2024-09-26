Return-Path: <linux-spi+bounces-5003-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CE987593
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10801B29642
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1515958E;
	Thu, 26 Sep 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJzHFYuK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE0157E61;
	Thu, 26 Sep 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360720; cv=none; b=Nq+ykK2kr8mWQW/qspDtXXMs590jRQled1hs6RJ6X6q/E6RRu6CrWb3INsXsgtUlzx/Xi4wGkPkMRDDllBz9Qf6QHHlblQJgai/Xn20fS/Z65Tj01YdjmPPy+KD0CFwLaEx2V2cmlLGCgmT1XcXa8nZYQ/hU4KDtVEVOBBXm34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360720; c=relaxed/simple;
	bh=TUiKek+gjtKvpO/NQujQUYTDf6GQP/uh8D34q5EQTLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwpMtKww4j/2HhcDFO+IpTgOBRIT6SiyYgOMh6hcZAxyU6W3dXZyGyO0spPcvWMIRcraTLC+Dh1SMtYpbvjHXUMThph4ok/8NMJZeSckent3xRNOrlBaYCitfmVSwnVXzUZEYhPabHJAZ1Dkru9dudgo/mYnSrDbK4txicT4iOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJzHFYuK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2054feabfc3so9257635ad.1;
        Thu, 26 Sep 2024 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360718; x=1727965518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaggZDdeca0MsYHdusDRGfZ6Se8lg/cciHsG3Hst56A=;
        b=iJzHFYuKysjaJauMuO22inn7AlqUKSr5DAoXMWgzyrzYi6JsgF4uP/Ju7tZtI+xtoT
         8a5HU0/Sy0lHgyFm8ySpYia8ZcSRhpH+oBGhIYPabwNzF1oEH6aYMuOYgxe1RVJzOdEV
         HEW6ejrghc2dPeUHfrsh4ImqEKW1qDblKrA2+TK6pl83HEctgH14SA3T4etH5/hfKvap
         NRcCV8hxGHcjz7svu5fnbgXPkt8ieeavOj2NqKfTHrg3iSezK981DlPz4DwKJShRC1IE
         ry7bQqnbgTpLryRdW+CXbt5hjk/2aa0T1FxL1mIAGG6j1lmb45dYeZ5RUl/dBaepYSny
         gILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360718; x=1727965518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaggZDdeca0MsYHdusDRGfZ6Se8lg/cciHsG3Hst56A=;
        b=ssqhZUB4s+ish54gPEZxaw9tUrGzaNTGH90mhOYeapXUFACfbn6sFIJFfPwkBtU5B2
         3rs+tdtB6uE6aOFIPGRKKfrTxL7aBMZx7RQhI5dv/XvXDQRjGeAJsLC7nWA1TPAUH9C5
         wKsUBCUfYR3YUSt+Lzrp3Dk1TKjScqBcqXTJ3dwEkly26hYQWpVCbsU3JuDbQJhY8O6q
         dVRpNoNrO7hZLfFCaqo3KlCuu15HCA/Md4YUr0pMFWQ2YmsPMi5aI43IG3pk1nmU8lsw
         TLPuhjnblJcZxse3UUYaQpzBnA78P5NWFIRzUEiAv1xJojT/WZ4AI3kDs5MXxjvcokiA
         xItQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9AQ7YJBfb5pEqwIMCxNTqvx7YrMpFgxGECsZbdG+W/ZGziHd9JfyPZPn6O0DHO7GjSq+DoWdYdaew@vger.kernel.org, AJvYcCVTmZR0Pfvxvja+JAGFPIDf1dLvW/4dvgDCA6uOVSjxWd9Kp4OYoiLc2CYkoqvsL+WBGZj+p/9gIzr2T7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBvcCNYHhSZtg3LINvp02FIdVsT+LMyhtjKSyGO2XrKCIERbO
	pgL/F0OQX0IJ9qEtp0QjUmvgN9LzF6EhlYPGkQh6PPk+P6xbL4G7
X-Google-Smtp-Source: AGHT+IFflt3eoiy3X+/8w5aFqI4rEO+u5APN62XJUblKYDy3GPC4kjSQk0j2eANYngkz5DwsNxMibg==
X-Received: by 2002:a17:902:ce02:b0:205:56e8:4a4b with SMTP id d9443c01a7336-20afc42ad4fmr88493905ad.2.1727360717974;
        Thu, 26 Sep 2024 07:25:17 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e2db1sm39450795ad.178.2024.09.26.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:17 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 44A7A80529;
	Thu, 26 Sep 2024 22:33:05 +0800 (CST)
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
Subject: [PATCH v10 5/6] spi: mxic: Add support for swapping byte
Date: Thu, 26 Sep 2024 22:19:55 +0800
Message-Id: <20240926141956.2386374-6-alvinzhou.tw@gmail.com>
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

Some SPI-NOR flash swap the bytes on a 16-bit boundary when
configured in Octal DTR mode. It means data format D0 D1 D2 D3
would be swapped to D1 D0 D3 D2. So that whether controller
support swapping bytes should be checked before enable Octal
DTR mode. Add swap byte support on a 16-bit boundary when
configured in Octal DTR mode for Macronix xSPI host controller
driver.

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
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 6156d691630a..a669ffa27b65 100644
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
 
+	if (swap16)
+		flags &= ~HC_CFG_DATA_PASS;
+	else
+		flags |= HC_CFG_DATA_PASS;
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
@@ -573,6 +581,7 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
 	.ecc = true,
+	.swap16 = true,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
-- 
2.25.1


