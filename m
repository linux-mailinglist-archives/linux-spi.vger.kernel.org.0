Return-Path: <linux-spi+bounces-9109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F7B07258
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 11:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427934A0C6C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB328DB78;
	Wed, 16 Jul 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6eOOVhf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A329E0EE;
	Wed, 16 Jul 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659955; cv=none; b=ebnLCG5rSBKfOmuIGxvwXhBeYf40j+1wMs/8md2qawIbhAKK29XGkRlOuAn+8xpsTRL83vgPgQtUYYWe/D2gCxWVfqB3teURdpRShe8tgLBOO0lUAShQ1sJXjRp9MEp0RBin4pAr1/sBqQuiFk0Cg+bZh+cDLBAPseeKOXwB6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659955; c=relaxed/simple;
	bh=djcwL+X9PYB03VpCmeTJWaXAQYaLtdeU266jimpq1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbIcsYLVKprBJQx3WJbclvpOF7mIzxZu/Vgkhz7gv209iLjTYNtfTks86mz5BfdOdMpdxkaulapvCR+9e8+lZYxBhm3SVlwpHGqNZlcScBkcoNwyVNBMvZKa1a2vhB77MYWOWQnkMdfgyFmJ27doYrrPL1qsfWRpNRSHZF7W+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6eOOVhf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235a3dd4f0dso41215735ad.0;
        Wed, 16 Jul 2025 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659953; x=1753264753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFj6XZ2c5rs96bYRtv3scugNswvMFNERjyKgF+4s9wQ=;
        b=l6eOOVhfSb/doXYR8NMDHqYZyMLpTwgpdaSqYoNYwA9IQ+WAPSDife6dT7VAp2y4qc
         7mHojwxnTUkaEBixP3b0u88wiuclfce1HXT9Iwl4xFCSKsemkkGiTeRDSPXbG23UIX2H
         38Hf6YNbwPvasGL/WM+UNFdrJmKnLKXT5/NzlGcR+I7AoNj5MENLtdkrUtz/oo8TY/Cd
         7GjU2QycEx8w/wM1iLcYFyx7siMhsx9lw93zylJNYFsS4cXH5ARLT28fQmkeH4ppnNAC
         PD+/+jbMTM+0LKA4dyGphTtyuOzG8xmspSH7PRlIDogTWuTapM9B7YV0QgMN2Igvpgkf
         GMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659953; x=1753264753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFj6XZ2c5rs96bYRtv3scugNswvMFNERjyKgF+4s9wQ=;
        b=nbeqVDJmMzb5kSaMmXuOoYv2cSac0rA3WKhdnt/bXKO6ggtZxCwCdx6FFr+RXkuvi2
         VvDPZAVK7YvQbb2VYZr7PYGRsk+AvaY7jI+piS0dk2TKIfqgdOoYR+S91YUhY4wKQ5rK
         wvasVf6RyfLb8Te/rKFhIMl/luJwm9bQy/ENDogwI73RchFTMQsn9+XStPenv10TuE+R
         6Lo0s7CqSQHLRnyp07kJVp+4tP2uYygo6GO2NxgGPtSkr7IOur9yAreBmJ444L7UU/v9
         hSF3Qd9zgmjvjADc40/5uIT0IqKlu5lsPbfRm9qESn9oe5Uf/w5Nkcss1246xPuEVxi5
         mUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqibgc7zlZUamaYMSe36duLYuhj+poEdi90ArwKTMooUfsO0OBhZ8petJX2QyqzsPS1uyQxmGVV8RF@vger.kernel.org, AJvYcCWDconNCriFL6i4I3lrqDrErGtl5oL/Sr5VI6HM1M8sV7x+CCiL0Z0UxL4FwPwDCINmuO+HfCFdJ1b2UqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0oxznZxaNVY1XgEQFc0UIdo98N7bFEcZuUeutU9x+Mlxv0kC5
	FT7vxhhXdUcN7nIlnuhc7X/P1dWGceIDIG9VVWuZDmXiKD94n+KUXeUMZRA1YDuT
X-Gm-Gg: ASbGncuDriMAscMZutqgjTiyh6ByTkXE5Jf8Ulm5GssvJabhhFVLVUb12KCw9Z287at
	aeqYNBZP8Xfwldv6ph+4iSCZUQxCptN+ARCLEyxeXJUd0iw4RDmt82FAK+wkS/wVu92Lq9hOS+a
	/NQ6fPK6YvSqszLwA3yHcvAvuCyy3GLnWEm+FO2oDD8lNLxmARonGNiP/AuyLZy0abVUdPGqRRq
	DvfCn17V0bAi936MXZb9MAup3WypgS0S3QBfMD6VztO7DPhDx3SjGo6JVb4dZQpcFyBv8FE2d8j
	HUilxF/+UtKm1z5ewr85jqF7odG3HrV8H/7Y4CdQD60F/22MU3pLBr1NKep/S+6lK6AvRaTMWt4
	LB45zhYBZ1/RQTUP4adDwXSbNQ0KHCu4ZiMjszJp8hO7gk5E7BaTxC8e7FnAayR4XD8dvh2bFaO
	REgH/F/DVEJA==
X-Google-Smtp-Source: AGHT+IHgm+LieBEXCswlX35Rjp5ohW4EdPz+fIxP6lLyYMboldRA1mxeyryBvE2MS3zYYWc3DGLlXg==
X-Received: by 2002:a17:903:15cc:b0:236:93cb:48b with SMTP id d9443c01a7336-23e24f59db4mr37734195ad.44.1752659953121;
        Wed, 16 Jul 2025 02:59:13 -0700 (PDT)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([27.57.176.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428b06bsm120854375ad.41.2025.07.16.02.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:59:12 -0700 (PDT)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] spi: gpio: Use explicit 'unsigned int' for parameter types
Date: Wed, 16 Jul 2025 09:59:05 +0000
Message-ID: <20250716095906.21812-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C standard allows 'unsigned' as a shorthand for 'unsigned int'.
For improved code clarity and consistency with the prevailing kernel coding
style, replace the shorthand with the more explicit 'unsigned int' type
for function parameters.

This is a purely stylistic cleanup and has no functional impact on the
generated code.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/spi/spi-gpio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ea5f1b10b79e..c8dadb532c40 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -104,7 +104,7 @@ static inline int getmiso(const struct spi_device *spi)
  */
 
 static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
@@ -113,7 +113,7 @@ static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
 }
 
 static u32 spi_gpio_txrx_word_mode1(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha1(spi, nsecs, 0, flags, word, bits);
@@ -122,7 +122,7 @@ static u32 spi_gpio_txrx_word_mode1(struct spi_device *spi,
 }
 
 static u32 spi_gpio_txrx_word_mode2(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha0(spi, nsecs, 1, flags, word, bits);
@@ -131,7 +131,7 @@ static u32 spi_gpio_txrx_word_mode2(struct spi_device *spi,
 }
 
 static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
 		return bitbang_txrx_le_cpha1(spi, nsecs, 1, flags, word, bits);
@@ -150,7 +150,7 @@ static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
  */
 
 static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
@@ -160,7 +160,7 @@ static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
 }
 
 static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
@@ -170,7 +170,7 @@ static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
 }
 
 static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
@@ -180,7 +180,7 @@ static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
 }
 
 static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
-		unsigned nsecs, u32 word, u8 bits, unsigned flags)
+		unsigned int nsecs, u32 word, u8 bits, unsigned int flags)
 {
 	flags = spi->controller->flags;
 	if (unlikely(spi->mode & SPI_LSB_FIRST))
-- 
2.43.0


