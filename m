Return-Path: <linux-spi+bounces-10732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D77BF288D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 440134F455B
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB19331A67;
	Mon, 20 Oct 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="c2UhVWGo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08503314D5
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979127; cv=none; b=c5+dr8mb3AMVfIudGJd3AgA9fKAoLr22E/vGrmSdjHK0clXgKBUuiXF8IEbWWPIhlBNMNUEOeCGdHF23ZaZjauGZAKwob7WlM1XgQNuVGCkB198zHaS7b1D1Thjlmut06v76ojFR5mYf8jNA7LQWOJe1bG5DKuSVOLAc+u9ia9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979127; c=relaxed/simple;
	bh=4nbEQ8HptUqVap6SvzTvdcQnIWSSvjBtVAeIUe9rLpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpCEaQlq1BmhVId8WzV1y87x+e255BMeb87jv6dUpSa6V1c9JWAnqE2A/l6YZeYf+Rh61voi9UKCjAWBRODzRPcfbwMtfJdF2mdpI2/c3NkSW6DmKmtg1cbfesRxW4EIajqPqG06vZWLM16f3gwDN1cmKs/io5xntqdRgg9v+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=c2UhVWGo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42e2c336adcso20370265ab.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979125; x=1761583925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbkGMRUd18xqKrBxXTdlQugMN1AFOTBEWC3fjv7PzZo=;
        b=c2UhVWGoXJeO1ohyW3+XMMmYWx4X3FMe54pOv37HSI7TWAR+xW9eKgYzvcGtQ22B1H
         7dxIerp1bsG7mNeocJqclQPq5d2XQZ7YDbWr8qYftSpDjTShFaiOcfn3b/U32iT/v9kC
         kCrvvZaRIrlh6AkLbxwc3dHsKkI9nrs55btEdP9bu9NJGf1Bc/R+dtASMleoBBaJvGhB
         Bc9vHBdC0MZCC8B38p1QYCA88dy3z4ExvjB+UeZWBqrihfIV10wNTSGrHhu1kvZTN7Pf
         KySJiell1/zT1yc1D5BF5ILJG7s93GMYJlunFEyQ8CKqzOA8SXzXetWg7G/N6TsRaEQT
         SD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979125; x=1761583925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbkGMRUd18xqKrBxXTdlQugMN1AFOTBEWC3fjv7PzZo=;
        b=q7UbY2SiS0a2gyjWwW7DDZ4sgTP2fY4kLhQSwLxNfyCtANqaHSJbGgnNacZ50WxTG+
         d7ewr2hihdSKDGs9QvtLxcwcg4xN27EJh1+2kQWB2/D/ION9lZMtLyRo3FBBuRf3TX8m
         CtbvYIxkB0nHjPdFLMDyWo2JHjvIDnbDk0xa/EAnT4QJg7eMGqm4qtyF4gaKAUKhmW6Z
         1KvwVLKaIq/WegQqBA91/X4VAX5sjMR1WdXJsWbEMLE7+NlVoGjPidrQNQGiEsaf7NCZ
         ps4kTEQtu+Nxch+ICR9/HkImjUlaa0qOAFJZCvzKT7f6p9Qa9tG4M4KZxRaMPwX3FV6Q
         Hkrg==
X-Forwarded-Encrypted: i=1; AJvYcCUr0T0RGpRcBphAn3Pl7duLETh7xX5wx6TUrRL3WC/q9T3i6hbxCL5qKF9smkcKPZv6bHuBSwfZ3kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CwvN8YZLaQemm5q9YqrLCwavwwncIyS13EQawKFnXvzDH61r
	fRBxCptV3ZOY5KmCEeqM8hkYug953QfU0lMNWE+7zjnGKT9tUtRrLZdgy+tBAmqrGb0=
X-Gm-Gg: ASbGnctvPDFSajOKCKRrjsrIOAIni3gUd/qaEpcAKux/AGPkX1hgofOTh8ceHZS20/k
	s6uyvxpo/+WWpe7v86H2u1HCSnuiEUgD/hbR+rdhO5ZkcJ3fhDI2ikLLIAV9LJJoITT6so3SVCb
	QBS7VInEVBpTHITTBdt2jaQSrmdnBFjddk6T7A4ZmAX017E4nRHXc1Q87G0CywdyTfqZdg2W2QK
	mqygGXE7SY+E5o6sa64428ETo4UQc25RHXpEUdC2fWPkr5oerRTXjJdgW1KMRQxVq8xWVZ/5ou8
	h1oYFzpSKbDvUkX8mvrjdaUz1C2CiaFrNeVokszrvbjGRqVQnMgGvoPR6YYN1me4paNZELSrqwz
	MBBv+vbYtY7arsFRS/4mvzXJGmJ4wYckZEYdki/KEGfhkNICwPkDOnJuQGvjrDymUq6QVIPy+kp
	G5XG1z5CKx9aHxkHMZmZXcfrJ4QhG3cSK8/pye1xedaiU=
X-Google-Smtp-Source: AGHT+IHCCXKGX40QH2SOOPyUbP1RmuEfte3N63LZWZHm5ASq68QX+HJbW0W+2yUOmNOCzqkQxIE7PQ==
X-Received: by 2002:a05:6e02:154a:b0:426:e20b:f5d4 with SMTP id e9e14a558f8ab-430c52200admr217203785ab.10.1760979124829;
        Mon, 20 Oct 2025 09:52:04 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:04 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org
Cc: guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Mon, 20 Oct 2025 11:51:49 -0500
Message-ID: <20251020165152.666221-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the SPI_FSL_QUADSPI Kconfig option to be selected if
ARCH_SPACEMIT enabled.

Add support for the SpacemiT K1 SoC in the Freescale QSPI driver
by defining the device type data for its QSPI implementation.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/Kconfig        |  3 ++-
 drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d8f00c850c14..2e3d8bd06ceb2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
 
 config SPI_FSL_QUADSPI
 	tristate "Freescale QSPI controller"
-	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
+			ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 9ecb756b33dba..f4f9cf127d3fe 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -267,6 +267,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
+	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_NO_CLK_DISABLE,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -998,6 +1007,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
 	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
-- 
2.48.1


