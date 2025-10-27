Return-Path: <linux-spi+bounces-10859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2911EC0E122
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3FF189688B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91032304BC1;
	Mon, 27 Oct 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="C+PTq+us"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88F27A461
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571832; cv=none; b=A3j2y2KpzJoltgJY8pXrhDIHZ4nYGbbdKRrQr1eRu1OARYZN9wRjnpTBVPn7Y4b4Gvo09QgPLqNkQdtf4iN8yQQstJPheQkWow7tJO5ymza5NMYRA26QQVbED+oOzwG3ZU9EE70FJZgub2LRtmuCKf5L/aBjt1y0pOZAJ45I43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571832; c=relaxed/simple;
	bh=1A6G+O+DOvefLV+rD2dNTlkz0auSGEUbdA/tj/OiN/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns8gTcE02hIy6A6GcBpgaGcIQrsudzdQhHnfTJ3y1Igqk2GzA8FQ9+f+FL7cbz4+EgUkutvS3KsVNV4Yu86g4XZ1RQ3V8a7YuxT5NAfufWF365Q95QwkZeRZIaqSh9+l7MwSWX6IlPeJlqLS1DQo0L5Y1qdKzwSsZlkGnMtmLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=C+PTq+us; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430ce2c7581so20287465ab.0
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571827; x=1762176627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sro30bK07ZDN2ex4WerPYEtaKK8tB8dVPj/Yht/kY4=;
        b=C+PTq+us33ocZqLc7AiwpYUZwFNkrYzgvW2OZuJijFxG1D+CLgu2CY1awGLSr9z/fH
         tFi+ClITaH9Jhf7TmLio2mqcA0muFh7PH2L4psiZ51Pw3VVwK6c3p//SGoVxBP04ZYyf
         9pxULWt8kWNM/nS2/IkPGJMSz7H4JaZmlTbaaEVJmFqw0XImqb4HyoIzrcjvCx2eCEV6
         0d+P2b/DYHmE77LeBTcbYGzDqDUT5mKjH9LkX0+8OvAoh4lsH4cKItMgCcKXOex+9b23
         NdFUJqMiXD+tEklj5PFuSEgGbcy9O8mQldN8243A8ufv97A11hYmUIwX82nLoGZwUzg+
         EaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571827; x=1762176627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sro30bK07ZDN2ex4WerPYEtaKK8tB8dVPj/Yht/kY4=;
        b=skRbLWIY1SYFaT0xAjLuVHF+fZGkyxNo0/pobkWZcJ0VUIWTdtt2jfmxgLN4vw0Hm8
         KiA7XNNhBl+b3Gf+640WpXDqlf3asPl6RCer++nuQqXeOEiGm1ZU3WbMAJ52HS6N8kcq
         evwgtBhx8C4MKVSdZ6bkWSjh43+0grz5HKeJeQypF1bqE2U8jt1xRpKY3jvz09wAQsXl
         EbLDznI9D9SW3rRht8+4p4Y4idapMaZyow10Lm2Jlp/2B6edH/X+BhWv8SN4iYd0T0qk
         jPoHwFaqCegJBoUgdky8A1gZCeJjzeBSko/aj6hFtXHWtEXT6delwJ3qRRNdJ9dsh4TK
         SN+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZbMc/wxns/QnvIwMxOu71zJKSkCFAtwtuoxbc2E7ErERufJ6OJ8kcYg/NWmn5QDqJ/tfp7iLc3OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+Ncg3R5luo71vPTXjvq1GnFDFaiUOA6rHmLkcGifGJdT/Utj
	oeyKhN2anMQrzaQHnDnaKf3JymuggwDY6lSrDJSMYJvHjuoArWhfV7P0q1EcuBpPdy4=
X-Gm-Gg: ASbGncvcwsQ53RzcaXDeyT/vB1ZSQeZ1wvS7jGOSGvXAezzETvJpU4GS4J+VkR+1mnu
	e3PyvSeCVS5G4h9q7QfcagflWukrKZNf8do6ttqZxgu1jrNr16GykfSDYih7XamZ5/XPBS1hssG
	ySr7wwScUA+QtIfTHJaZOgUyKiipTFDa+upIJibdcKu05JSIg6QU8rAz6SGExjoS/FxmczpQgKc
	R7k6xS/q0IR11ORTfWc3yjxzumTeJIdJcF703joN8GpXCZ/o0w+E2grXc69oiIb8VdW8ejFhs9P
	vH4UqVrfnwXJ1X/vEE6VJ7L03pwlKe5rg6vIyj6vP8oxS6L4AF9UZGhaIWPhYvRo5//Ft3AME8g
	vGoBRozm7XASU0Y/CvEBzy5fgF7hiVTcnafr+hucZF3e3+fyjZReRxMq2uGmJLNoAU/CFeu6vTn
	5aCET7pvhr38X/PwDK5n4HHTh07FZ8cGmwbHF+zb3oOq45TCGLGgmrjQ==
X-Google-Smtp-Source: AGHT+IE/dyb28DRdvs9oMw6bZQwYlyqE3BQFW88FuQ4+GtxGKYPnc6qBw31lrQ++KNgKjicl1u85uw==
X-Received: by 2002:a05:6e02:1c2e:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-4320f778af8mr1256935ab.16.1761571826897;
        Mon, 27 Oct 2025 06:30:26 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Mon, 27 Oct 2025 08:30:05 -0500
Message-ID: <20251027133008.360237-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
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


