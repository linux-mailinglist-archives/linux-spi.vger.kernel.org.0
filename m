Return-Path: <linux-spi+bounces-11084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28915C3B763
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDA5063F1
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E342165EA;
	Thu,  6 Nov 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="lkZevMwj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67B213E89
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436752; cv=none; b=YUQC54ooUi5wyBQtwBeEYrvO4MrD4J2jimGxmRhN0QCp6hvrOmZn3X55QflsPbmxPCzYP5fQQr4VSQp1bb9EenvaKlSkPCqs1L9ScDakXK+/kvP0HDeXtM1OdC11d3gd9GNWlaDHFRgJJfVTZ9vABYIkt7z1dx4uY9oTiaiWjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436752; c=relaxed/simple;
	bh=QLE6Qjb1CUVEZPz39IQKdGZa+elint0plXNfhkgjf1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOIjBd9hl+/4n6BG7v4BK/bugGxH28oZsya9Np3qvMLCivLWrKYHJWdWVpfWu9x+Vame1xzFJkfxJVT3skofjpi41YCUZrVl9PiOXJ94PneA+EqjWL2oQNJsiTF9jwvzPL/i+t1yqjApNkOmSc/6/jpRQyoYMkAM5e4wMZIGT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=lkZevMwj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754b9b050so5484375e9.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1762436748; x=1763041548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NosZxG6nn3q9anOwD7vmUaH8ifv/LF4/3nu6Xc+7pE=;
        b=lkZevMwj6OxuxAnrAacxkOGRZ+3Qo3x3QIftmUXxjBm9uarnvXyduyET0g+qZvVKWE
         qWXfMKetnaQnWbt8YUqEAMtrrzxoyXl0FRVpHm+k9MQO4OmL4IfemGYsDSHbTiEB8muN
         DhKzqwYH63HlQxarkbE4cikpSd5J6ghX7ezmHGMo59UY3JGfNb71o0R7Vscjjno9kzJS
         LkarQEyKYp8eZzHYNKRyPssZGFR6nbnP38TMwSG8/Bnzot2QPZX7nqooEhysJoo3s9Bm
         K9lzQiSaE/kTSfK+uL5a+eO5qcDoIVwM63VRhOwpk9eMai17WQCVp11yDxz9sq7PmkXt
         ZfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436748; x=1763041548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NosZxG6nn3q9anOwD7vmUaH8ifv/LF4/3nu6Xc+7pE=;
        b=cd3J0Ra/ogRTjj4dlhcjgcCvNnVhPMXp0PqN1HqpVrOAc0JcA0DlmeEyBso2v7LZwS
         9vrGzZZBm5qhFG06nzRMIzU0ejts8Qj/8uMLuxOKyczfr6a/SKPiA2/VxG8FvRZbrYyI
         0vV8lwPtIFsmaKVNwTcWNpf+hLyDNmRiHcw7sfUpWmxO0iA1XO2/Vd28s9l2T78dEQ0a
         ttMWoqK/4f1Ogoplubmnxv7157rr8QTobosX+N9BIQY/JVGLv5NvS0ite48GD4bnglTH
         7w02dgclSrTdHATdDNNZwC4Y0VEv8i6USKLdAolf2itO9xoeiJi3k3YGIQkgS/4w5rpi
         fsDA==
X-Gm-Message-State: AOJu0YyLeaDjH/ataAg02aOPL/6DGtwF6wHGXN/Gn2lwNOK5W2QGmigW
	aUX6qq8TDrTIqWRfiSH+KQ2c5hWsmho5iLxTJsYPczPEC4XJqBZ9NxGLUSaPsrgmjXO0a8RK+18
	UwqM=
X-Gm-Gg: ASbGncsZIGfoCbBpt3IZy2JZWihYezvPGp/u9rGhyGtmqcKJnA5oAHHEPeyiGe1Vw/p
	rz8xjbFPxWB9gaewuBu2JHc3M7gZAtIE5jfU1T5+oznkFw2ZrtTUAIHfZnqyLQ/BgYYVxdTqf81
	6PWWflGsHvOcVLJYkJOQR4TgM9r37aira7FnXmcq8zcLJiFZrhegEy4CbsJEhOAPn2NUGeBUOl4
	ta3HU3VIVseLDDP7nGL1YiJmrW+Je8lNJs5igD4kTzgF5SKJ/Kx17Oz2H74YobU12xNfaBenNwi
	tPkUAxm8qLWJ0jdFLaxKnOx3D1hTusSQ8tYHVBJlnoDbN5VOLq+tq/YdZrsUY+BsXnCFmtCw1O1
	TW3S0JEJro63QQMKJ8l7CtJE84MgIUEbzlF8fcHEJdghXYhex3BQtZts8BF1aWoklCKdlJEZO4Q
	SlrRgKYYqWhmKtJA==
X-Google-Smtp-Source: AGHT+IGUOqI7KqVORVTnIFef8KoutDwNNtxYby+bcFmg3CyN9yXwWCrNzCKGi29eGpvIf8VzDp4kVw==
X-Received: by 2002:a05:600c:6219:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-47767cad1a3mr18498135e9.36.1762436748176;
        Thu, 06 Nov 2025 05:45:48 -0800 (PST)
Received: from localhost ([109.227.153.227])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477622f42a5sm84548825e9.1.2025.11.06.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:45:47 -0800 (PST)
From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To: linux-spi@vger.kernel.org,
	Ricardo Ribalda Delgado <ribalda@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>
Cc: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH v2] spi: xilinx: increase number of retries before declaring stall
Date: Thu,  6 Nov 2025 14:45:35 +0100
Message-ID: <20251106134545.31942-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI devices using a (relative) slow frequency need a larger time.

For instance, microblaze running at 83.25MHz and performing a
3 bytes transaction using a 10MHz/16 = 625kHz needed this stall
value increased to at least 20. The SPI device is quite slow, but
also is the microblaze, so set this value to 32 to give it even
more margin.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d59cc8a18484..c86dc56f38b4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -300,7 +300,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		/* Read out all the data from the Rx FIFO */
 		rx_words = n_words;
-		stalled = 10;
+		stalled = 32;
 		while (rx_words) {
 			if (rx_words == n_words && !(stalled--) &&
 			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
-- 
2.49.0


