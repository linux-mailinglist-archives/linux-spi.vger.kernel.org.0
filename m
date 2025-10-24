Return-Path: <linux-spi+bounces-10835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDCEC07DEF
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC0355ED2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9C36CA6F;
	Fri, 24 Oct 2025 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gDx6Ch5V"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0C36C23A
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333365; cv=none; b=E70M29xO0UrE0IPQSscf3p0m4rlKe28KiKGP+Qo1lKaHhHRbtlm5AQ4vrQfN9yq/zE7Mv9mEfBhU9JI2TpoajYDn1y5U0nGPx1cdae6BNJ6+io53jD2NfFWMD4gbHRg/badXYPefh2Tv5JvJTyBZAN8MIPFgEU3jLfi9KWsVZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333365; c=relaxed/simple;
	bh=fJYpRFRILxdNLkxi4Dero+aiC/WPnQUq9uXWEscfpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHX3PueEwq++/R8YTuyWITB92a0UCKln3PrGGAATynwz8ctnPSA3PAmSl7r5nG1hmSBBBJu9NR70XvWwrFkDakxbeR6nQXvJ45zAtIDRiSZb6TFsL7tAX3OKSNpuxxNdyouEKx6g9Ql8FwoTgywHPUZwyhj5Hx8Xb2MRpkseoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gDx6Ch5V; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-940d9772e28so98363839f.2
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333363; x=1761938163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPf7dJcoXU9s785ZftOfTSEvtOpAo2Z85GYUpq2DxVw=;
        b=gDx6Ch5Vlq4W6EDixMZzR1n/emhpfUIJe/2o1Bnepgx2nIDGGaCfDHdWW2W2Qq5gGY
         nsFGf2jQPOLnCIWAwGqJSHkyuav0vzdXhpjNDFTjkIZvqC/U2Lf/fJfyjHxGnUw5CARA
         /8bWsHjDO2FwdgpNUrTXViTeoNOaAvE72Xx+G3eXC58GBXh0oa9JUrY8Ylw+TFQaZOSb
         N71daahTkkpK1+fnF4zZshICDrfo11Q12YQJ96A3J1G0C93N9/z2eFReks9lu2PHZYgD
         ZEENz/jnAIwKgnCxWAypi/3KglqJKwQhS/hh/vb52OqHscPBMQSz7D3pdB+QrnXJAkQu
         7bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333363; x=1761938163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPf7dJcoXU9s785ZftOfTSEvtOpAo2Z85GYUpq2DxVw=;
        b=Jlb2l63cB+d22vrPFSbFmhtb/K5K72cX+l/ghaotiZIAhVQ3VlFdPqpxRlrT4GaH5Y
         l+kLTyjMtOHSIeoAmXd4LjgPstSYgmylKW2PYQC4UQoKcKn4M6p0Ppmo3zyUe9VFNj0I
         gSyI47z1hSXBsdtI4FMqaR3EbI/GumoVcGfhi8sEQBioN3H8KdFCSfCohQZszfG9oRC2
         hkg9Z+0Qj5bfay8pBT2gnWi+P5elNbGufBaOR4zwyuGBwGMptVv0IRW0U7kekMsDDFFx
         dpVp7wjP8xeQBnOxbnDomj+hJKcvLCJjGOT3aF14Ol+t9P1f34ljBAg+XriQ/gRNzgcz
         ZE+g==
X-Forwarded-Encrypted: i=1; AJvYcCWKSTOtJueKxKWfbmvAHLX3v/lw8YfNs+juSaOI1CROapmoDDSgwnBlwIt/eEsIpIk7cp4FdExehPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZl4ikF+6yUbASfYizxaeueJCjgdfwDb8n4ZDU8tglXwJ/2Ts
	iO15wN8+SGdE9nR5roP7+ePOLQXcUkQbZqJ3Bq0/NVIo1sAbeSKNtnG8fZL5HisiXSqC65lYSk6
	hqrcI+yk=
X-Gm-Gg: ASbGnctSvRO68YHoYHT0jegE7NFU6xayDUL/8YwvOC2L2ydhwyizssfXLfrlChyitvS
	Ri7Nux7KA7Hzpl1gAnpF6BKFeM2BG02pP+DypFBD6vaFG6UYHO6dNwgEWwUtl9/0JOGoa9gbTSe
	lfXipRAZLVP73Ydn4+pSQOh1KQrC6e7rBQu9NyY8tIC8wvkHkt7KgUTNAI1kf4sQJQ4WoUpvquN
	79yuS3EtGnS6+aRna8B8s3P/l1tbDN7GJuZgu3MzhS/4FccD7W3ZkN4SnMRxqYQ7CqUdPiTkx8P
	33Ob9SYxYAVSlE8YOH24k7KrJAw7ydXahwkJ1F30YVMjA1WHV29AP25+J/HrEdKSGM1Ibo92z47
	8isE1boheDEjz0tBLuEUWBHv7eGoH92ST+BsRMPYZDwEUwyLwJ4p9v8zsunkzuAZjbQBULQ2Qer
	YR6VB/Mb31yEx6zJrFkYaPNhCWiiJTeEkolP/Vanch6fIz5r0P7xlT/g==
X-Google-Smtp-Source: AGHT+IE7iOHD5RLmA2kk1MvUlsZ0DBgSjQiI4X5X30Jlm6cwRYZovCXte2pXzgLa3TLg4hmhyFE+dg==
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id e9e14a558f8ab-430c514e290mr430965745ab.0.1761333362623;
        Fri, 24 Oct 2025 12:16:02 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:02 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	han.xu@nxp.com
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Fri, 24 Oct 2025 14:15:47 -0500
Message-ID: <20251024191550.194946-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
enabled.

Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
defining the device type data for its QSPI implementation.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: The sfa_size field in spacemit_k1_data is now assigned to be SZ_1K

 drivers/spi/Kconfig        |  3 ++-
 drivers/spi/spi-fsl-qspi.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d8f00c850c14..592d46c9998bb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
 
 config SPI_FSL_QUADSPI
 	tristate "Freescale QSPI controller"
-	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
+		   ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 46a3187b33548..a223b4bc6e637 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -268,6 +268,16 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_512,
+	.sfa_size = SZ_1K,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
+	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1003,6 +1013,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
 	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
-- 
2.48.1


