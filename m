Return-Path: <linux-spi+bounces-3698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0291D52B
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD032812C5
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 00:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4D136664;
	Mon,  1 Jul 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHScMyPP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2049131E4B;
	Mon,  1 Jul 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792840; cv=none; b=Ojyi7d9gRmCQ8mjYRgPUbtcSaEWWIn00YywlSyofxr6X3FuxNe4kAb6KvFyV6/Jq5Zb2qeJW81YBCJKrhQN5r2K+j6l24wfrSx8ytVgoxAAanKtKh7vGeBJaqMxl6eSiwRIwzeO7AID05hQU9CQgackGHyeBOrwxVwEkR3GpDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792840; c=relaxed/simple;
	bh=PQF8Aej0yai2vLCMDITBf9kCcjI8/z8VbTXYxx6y9is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9nZUVoL5h06qUDZBgwke1JIsXDUKwMircX7ivuvm+hN3BbIwqGtkxNmYHf8U91fwGpYDL/V/Qk5ESrky29Go2oXrQGPbqmoZf9i5RgSIZSE1x6Hu1Xo8OZSgN20SsYCBVdR2nFTe6PcNuYThBMTpYp49DJI6DAAX3xCcBEMGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHScMyPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CF7C4AF0A;
	Mon,  1 Jul 2024 00:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792840;
	bh=PQF8Aej0yai2vLCMDITBf9kCcjI8/z8VbTXYxx6y9is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHScMyPPMrVv0/Su9BqkQh87SJ19uKnkY8UFOoSmi5/STclgd4cfoLhSNDkIZbixL
	 WrtZG0/zYwsZnAg2d1A7Ki1dPgI1zFcJPQW8rO7iI8zuhRcNy03eUFmzIlio5UTuZi
	 rfFIhW5rSMsIrisS9Lz/0OQB5b35sIWWi62rdyDTdJnSiJb2qp5liTP1wvhyeI2d37
	 mSeplOMPvRgldyqv9fSRM28hgN5vFBBx9GZSDNkKz9w5oEjVw07NOaKSK2uwYuxsjl
	 y0hcIOS/OiBmOLw/TFDVvck89bsXdO8v5cJC55hY7RDmvGlR+z9Gq1Qh9yL5beuodR
	 HV7SmOF+no4jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/12] spi: Fix OCTAL mode support
Date: Sun, 30 Jun 2024 20:13:26 -0400
Message-ID: <20240701001342.2920907-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Patrice Chotard <patrice.chotard@foss.st.com>

[ Upstream commit d6a711a898672dd873aab3844f754a3ca40723a5 ]

Add OCTAL mode support.
Issue detected using "--octal" spidev_test's option.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Link: https://msgid.link/r/20240618132951.2743935-4-patrice.chotard@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c       | 6 ++++--
 include/linux/spi/spi.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index da15c3f388d1f..5c57c7378ee70 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4000,7 +4000,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
-				xfer->tx_nbits != SPI_NBITS_QUAD)
+				xfer->tx_nbits != SPI_NBITS_QUAD &&
+				xfer->tx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
 				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
@@ -4015,7 +4016,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
 				xfer->rx_nbits != SPI_NBITS_DUAL &&
-				xfer->rx_nbits != SPI_NBITS_QUAD)
+				xfer->rx_nbits != SPI_NBITS_QUAD &&
+				xfer->rx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
 				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8cc7a99927f95..e5baf43bcfbb6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1049,12 +1049,13 @@ struct spi_transfer {
 	unsigned	dummy_data:1;
 	unsigned	cs_off:1;
 	unsigned	cs_change:1;
-	unsigned	tx_nbits:3;
-	unsigned	rx_nbits:3;
+	unsigned	tx_nbits:4;
+	unsigned	rx_nbits:4;
 	unsigned	timestamped:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2-bit transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4-bit transfer */
+#define	SPI_NBITS_OCTAL	0x08 /* 8-bit transfer */
 	u8		bits_per_word;
 	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
-- 
2.43.0


