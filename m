Return-Path: <linux-spi+bounces-11441-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96710C76581
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AB4E316B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9C305946;
	Thu, 20 Nov 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="ei53bGW3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A729253958
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673231; cv=none; b=iDTSUFhNeBZfIaMuPg73kD4HzxeeFPJOpUDzmULZfBNw+GSNwMLLJ1AvyG33ixtE1wRsKFd1cdgOOMgkqOoxJAsIOwF6vJAugQxSPpJKafAFpgvGyz8MNHwjM+L9saXypexPw9hGIGyQhRWO7Y22CVAjsbESWBHPc9cZSK0hSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673231; c=relaxed/simple;
	bh=Ncr3R3kiVMaRI941uPnNlKBZzB9t5eYETF9gVPClg8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM4YECPEKqJUrfLZjl5r26uiBBinH4B7SuLeBhHjv10oQw2i4OcIxoUXYMGjNfYBb9VaO4b6sZ8dlpmC2zRjPwdTpyh9KORRFGYLGokyOfKGoCNMyCeYi/s5AaoAnRjgeY3nw3d0rsK6kG7k4DcnTTYbTCst74KHpEn9ID6mT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=ei53bGW3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b1f2fbaed7so104159185a.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1763673228; x=1764278028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVTYOQ3QWD4eKEz3wLcBWIsCXGJvwPkc7ixkByGQUus=;
        b=ei53bGW3MAKcEVvmfM3aX8D7MDUaTeulUUesPqgnIpoNCTjhVlA6wD8m2ozCTGdsP5
         7xjBfwJQvYPqw0rwJwaOjByhyem3VbfR//HNsJx2y97sLDyfNqLUfHGwDrPg28oW+Oq4
         wOXtQTczkqEnRoNaSV3xq/IGlUrFeJ9IuSF5FkBJUoB9SzR2Q4DDMpeS5UHr9PpsxeYf
         qW3RTFJF+mp/iY1ROkH0yabOWIlZEwyntrQtXY/KmpxIqp8tVYdfw/R9yMAmidSON0Yy
         UUuSphHwys970kGdeE7E2R74S44elp4o+e9wo3RUWyLFAblflcs2ziWhh9xxcuGutLru
         aNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673228; x=1764278028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVTYOQ3QWD4eKEz3wLcBWIsCXGJvwPkc7ixkByGQUus=;
        b=Xow1Z+awP3HavR3+l8RYJaZkbqdLPlXrApczGhIpkGzDJAL/ICuqD1EYBMgCMUVo2i
         i3XFvRjIBqMn/7jkGy8rt+MkGYg9npxVigJTgsCxYE5p/VzIZAHoys9vErrFdDJ0hYqW
         pe0UatNidWDg5REZA7EVs0tm0nciwWL3e0lk4hoRhPDM+UIjFP2V+0FdA/b+3cbn8npZ
         K0jY+J/QKcmV2q7pPeIVh6htkV12RQO0OuQ6oArwhkUCT7gsZ1fxV9Kinf3kiDaKaqBQ
         ROX3O30n+/4TuU9apWyblN1lFGYZcNbKH4d5wdSuaZZZTsylmS60fgT16SBh8DwVJJRy
         8ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCXZIgAihoZFClmYkcCkI3q2YdSCx6C1mI/Run8TcGQK3yTd9+4EMN03cqVk/Atj8tbnspnk7NsGW2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVwhMxMNQVnn3XJ+dNFqbtvNaUk4fxbLD8O9PRtuQI7F0kZZ6
	Cy2nANISxSbrqCtxjB5vcgp7wo5XgRM61dxjXW2J/cDJbk2pKNOEGGzfo7TTU4L+Fr20DzPkTm/
	g8iY7
X-Gm-Gg: ASbGncvHZUcu7kA5U1hoTZHVyvkD5hCJ1wwbcQFRgSLwvafqjeaEDvv/ERk7+YgkLxN
	Kg6wz8dVWPSlVMMrMVoEtTeLc25/hTlrWQf3hz/Bq+TSoowiIc6K3w7Jff3t11vst7w8kmzcxwo
	Cdba8W9wjAY7Bat9lUsoZV/AwYo6t2yrVSGQRq3HxUKTP3XT6C0bmVNJsLSdfYOH2g01r3Lz8Yu
	9cfQt0f41I+JDAt4rRH1Pr7E+2bDHiFCOGHRd3G0+uoyYVxhQitoTqVJuFi8sE1Cu90iWrlam5i
	OP494tBHUyAF9kOXdMhvLkjgQl0EsHFbVQ7VgFSuyoXf22t+Qbqxe6m/xi7EgZDLeK9RFGRAUUX
	42d5aSlVQ/GeocIxyQ/k9BCo0m5wbgWByqbm+6BLWcX2vQgJS31NB3kz6+5DKajEZiwsk2OMKga
	OqT/aqu1Pgbuoel0/tDnd5yy9Hf9GkNRamY7xbbPg5HLJnSCUdt61ANaSRjxLffoQIEg==
X-Google-Smtp-Source: AGHT+IHhLrKwzSUA1bNd+dPQLHWxvxkUjlw7qu6qycMRLUEdp8icnfz7Y6GJY43AdSETsMFXRXs+JA==
X-Received: by 2002:a05:620a:2a03:b0:8b2:f1f0:5b87 with SMTP id af79cd13be357-8b3272fd01cmr556804485a.3.1763673226952;
        Thu, 20 Nov 2025 13:13:46 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm225958685a.24.2025.11.20.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:13:46 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] spi-geni-qcom: use xfer->bits_per_word for can_dma()
Date: Thu, 20 Nov 2025 16:12:00 -0500
Message-ID: <20251120211204.24078-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120211204.24078-1-jonathan@marek.ca>
References: <20251120211204.24078-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mas->cur_bits_per_word may not reflect the value of xfer->bits_per_word
when can_dma() is called. Use the right value instead.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/spi/spi-geni-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c33d79d9afaf8..575b112d4acb1 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -499,10 +499,10 @@ static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
 {
 	u32 len;
 
-	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
-		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
+	if (!(xfer->bits_per_word % MIN_WORD_LEN))
+		len = xfer->len * BITS_PER_BYTE / xfer->bits_per_word;
 	else
-		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
+		len = xfer->len / (xfer->bits_per_word / BITS_PER_BYTE + 1);
 	len &= TRANS_LEN_MSK;
 
 	return len;
@@ -522,7 +522,7 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 		return true;
 
 	len = get_xfer_len_in_words(xfer, mas);
-	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
+	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / xfer->bits_per_word;
 
 	if (len > fifo_size)
 		return true;
-- 
2.51.0


