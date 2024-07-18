Return-Path: <linux-spi+bounces-3896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3A9346E5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727F51C22362
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052C48CCC;
	Thu, 18 Jul 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8XG4zWw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8842052;
	Thu, 18 Jul 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274470; cv=none; b=LpeS++nGIBP1HhNShENzyhSwgnt8f/XV5YFfDdWLrbxTmfrRwxekXZMeSFhiIIiyqVExOCYh3g76a1Li7qoQz/H7mzsKduokFBjjRR1C3EmsSYAjYHRAH0NhjR+nfqCDJwFb7dKUTRdqs5dNxZLIaB0MnkL3R5u7HISTorbRm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274470; c=relaxed/simple;
	bh=UEoZSelr2KPIegbn/bEtJV87t2Bt8f42OAG2gEzC8vY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8NX4XKBYis6ccrXo7Ojrmhwwt2lCli34NOSnZSw5vHYaWYXxq33v/UGHrutg2M/aPmWlfpHlnVRMRI01n9kCnZj7XaDoOl+Vltah9x7gr5H3mhrKSiTiQqHF2atJBuCTaQnT7CQBE7hARjFWEKWRLOk0ZrCspHccmqO8qb+VPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8XG4zWw; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260e1b5576aso217108fac.1;
        Wed, 17 Jul 2024 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274468; x=1721879268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EhTny12E54Go3rv+a0bpkdQLZomTRFj3isNr2azzvc=;
        b=C8XG4zWwgQoyRWkKBzue11LlN9Y8GPyzKZ/fg1+JLH8Qv18sk7pAuzSudv0LIrIH1B
         fE9YnY5ZZ+dHmfSL2GJiUQIQNd7VNp1yb73iM2xD/cHQredL51/Jxk6HYJs7CdySCkyr
         oFQ2CwutzstVrdREMcgyRalDWaVWOvHnKiVvBCg6qIg6+zu/ruGbjmlfhCBC7ZbriJld
         45PL/ew4igTIPMVtjTstjDbHJrr9ywyVKWBAodenwTCMGi27Hjurp2lSafixwOgeQ1wv
         axXICvljxlrq3XWMF5LlRkanK4RB4eXh9Mpr6ldFAnwRnUw6Byefliyic0pm/WKJXpug
         PEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274468; x=1721879268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EhTny12E54Go3rv+a0bpkdQLZomTRFj3isNr2azzvc=;
        b=gGF9Ygkw0PVnH9txqPwR6QPvGNF2yrb3Vc4QrksLnyC7Cij08LYyHGmWivNIuyYvLz
         OHlj7OcAw7kLR32ZDBeKpLwqrpF2I2L5RjEmYM4E5PRmSCOwFnxq4Im+I5MAdmcQvnpu
         uW8fcx3m5Y/2+6SztpjWTOWnEusELyCmwmr5ElpYTRTbkh0mo2EYcfilM4u3ynKN3ljM
         SFLYQvGl8ocKEiL+xYoTuBOLtYmiRjiUtzQKEBTGcIs06Ukf/FWWaHQRTQmCfvjizeub
         oiRPCRtG1+qQ/Sswle4PvRmX+kAqoQz8mhnlQbMn/gAh2YOK1OSJ2gQK0vVs8I5SbyPU
         dikg==
X-Forwarded-Encrypted: i=1; AJvYcCUKLNP+fY5VhxGaCVnBNAgVc9iJE8TA2TAWvr3hz5yMpZQQwgTmS64N6aZqKP7nNJV7Bhq/UPLYfzoKy2NO9sbsXhym0rmbFJWkNvm4stSekLxiuJEjpmAynF5ZHSE7KwFEYJuaMK4/
X-Gm-Message-State: AOJu0Yye7giFXgd4fC+p9ynNvCZFbKAJMdKOyYqxjUN7jUSztbkS/nlB
	cDReUZX7cQkZcrQ/4eclMEEw1T/niLEYlq4yy+OJbKA0fqaYnB/lEfWpNw==
X-Google-Smtp-Source: AGHT+IHjdPa9dL94vVwe22uz34q6kOz56dIpRCh5BR8NxoERYLhhAaF0RaRLuSjVEwoiIkL7YKkVuQ==
X-Received: by 2002:a05:6870:2312:b0:25e:d90:fe78 with SMTP id 586e51a60fabf-260d913efeemr3304888fac.8.1721274468237;
        Wed, 17 Jul 2024 20:47:48 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecd27f7sm8854360b3a.218.2024.07.17.20.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:47 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 1D11280B09;
	Thu, 18 Jul 2024 11:56:59 +0800 (CST)
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
Subject: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
Date: Thu, 18 Jul 2024 11:46:13 +0800
Message-Id: <20240718034614.484018-6-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
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
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/spi/spi-mxic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 6156d691630a..f4e2f506bb2a 100644
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
@@ -572,6 +580,7 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
+	.swap16 = true,
 	.ecc = true,
 };
 
-- 
2.25.1


