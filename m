Return-Path: <linux-spi+bounces-3697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A591D4FD
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 02:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BC1F212C5
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE3433A4;
	Mon,  1 Jul 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNsfDHa6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687643156;
	Mon,  1 Jul 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792758; cv=none; b=O1i9apVOEN2vqL//4ARWV0gM/ISVc8OCkvvr3AGyroki32//v+Qh3BaOvPyiIciTdzekdOLGFhCBL0eAc4lXbBnqj/a2U9pX/wXAUTTUbmT1TrnEhfUKIUF1fN+n0/zGRS+E9LXHTEM+5MIW8p/Jyo+8sAcOCuRClH2qxpUhLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792758; c=relaxed/simple;
	bh=efq6qn8EC6ohOEFT6RtxsYL0AXkBL4+Pvo180IHUyMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPKz8Mefedoo/zC6xiU9kXw6XAFOdzRJqqIWEdPJ7+5Wr4qJTqm6gVQj1Q5bxgw8XB6e0pm/YdCx0z0XG3zDdEL3ZTjJMLi6c/Cqp3kqA81pQxgRNhCiyz1DXGE6Wtc/l6VBFZXNcMxeKPpGTFq3BUIReBA4vIsQH4PtV4+3brM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNsfDHa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3DFC32786;
	Mon,  1 Jul 2024 00:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792758;
	bh=efq6qn8EC6ohOEFT6RtxsYL0AXkBL4+Pvo180IHUyMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNsfDHa68neKzj0xMrDbrmx9IvS522hi5n0AKoQyRk6EEJxLKOx7OH8LDnWlvbJEu
	 Af9F9XkdwVP5Ee6yAcACT+HCC/nTL0ZWT6bGLzeZHtMiBLHVMbiWL1rYHk2xDApWG2
	 owGqi9u85wo3YpvAVxPQXo9DZ5dZtDw5iFe306yYseQPpVGW7czZluDCZSv1zW/ATV
	 c2cg+Vk+z+0cCYyMfx8BZm/fNSNdTFWaumcb05Yq5JcofhwHUZnU44c/ZZqqegZX+h
	 oJcFICt9b4cjnSL3Kncj68z30Xxe+BmJBX1bwqnV4ybw+FIoG2M93jxz+n5YDeAsdp
	 +yzHt/YzzTS4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 11/20] spi: Fix OCTAL mode support
Date: Sun, 30 Jun 2024 20:11:16 -0400
Message-ID: <20240701001209.2920293-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
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
index 2cea7aeb10f95..bfe15d6b881ae 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4149,7 +4149,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
-				xfer->tx_nbits != SPI_NBITS_QUAD)
+				xfer->tx_nbits != SPI_NBITS_QUAD &&
+				xfer->tx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
 				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
@@ -4164,7 +4165,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
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
index c459809efee4f..b0737eb05904e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1085,12 +1085,13 @@ struct spi_transfer {
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


