Return-Path: <linux-spi+bounces-680-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650BE839B6D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 22:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AAC1C23A05
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE573B78E;
	Tue, 23 Jan 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ZO0/zTn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8E3B2A6
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046638; cv=none; b=MX8LuxnpBVFvPQPmznZiJcLTxeQpB9s88bHcM0jcJWx06SoWulkNVZz7Q5RzFG4A1CL3fZK26O0LxOsImiZ+dyYdzfONcm2seX3jh5OqbKHwUj40yRrLPnZ7pCBrDWeBqtETsFcT1EsaRL+012ejfJTxAQloruuayBijPyQgYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046638; c=relaxed/simple;
	bh=qjSzwxfvEw8P0/KSwYPerGQtyn2kLF/crHyHSJzwEIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZse/J4itMZ3Y6WgWkSlJyO4J55sck8rfYw4TQGUAoO0VZmI9NstbXesbHI+3xyBuBq6LatB/iI7FtDTl7+iRkCYTf44Or+MfEyLkx270XksMKX0TW+QPoOWoBFDzqRQD8GHhTJPq6Io+t/KE9IsRQHdbUryKEWD6+g2JH8enkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ZO0/zTn; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bdb42da0e0so2130830b6e.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706046635; x=1706651435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KeetDUGZXNfbQyMYC9x9HpMR6XYRC4AqSuY7y18XGE=;
        b=0ZO0/zTnoiUqti6H++caZPk2HudH5pLUulXRCkqzyccnnI/erSJOFdO8FN1YwSz85J
         JE+M6Tu+v4LWqY3qgzdtXoZazPGKlS4Mj6YUhLHLZE9/YTD/2kMc939R4+Zlhd5nfCly
         2y6VpifJa7BrctggaqyKhKhWqDgZZIUw295X5gk5a0lsmQ4tvYfk44XQxnZtMhzSqW/h
         Zoc7HV07eFzS0n7OzCKKASdjDPnrmr0CcipMsoeOPyDQdV+M2Z30urz7JCw4rt+i0L4o
         rykLFgeMPECipQBJkt6I3o1bDL2dtbwssN/i8iVNo2G2p81yF0UTlBCI7Mu40DRFEgvR
         60Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046635; x=1706651435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KeetDUGZXNfbQyMYC9x9HpMR6XYRC4AqSuY7y18XGE=;
        b=cSTYRQkBcNCaBoaFezGotSLUVapNBJ240xQHTBjgKY0f1u+Y40Ze5UZJQpa+lLAGlz
         6MkRL/nTL/WXJLeLXGaN8DddsdXxao5K1FsciAMIwMgbhv/7KDkiEwLFqJsYnCy6ezQd
         +dMdNR7U0G6k3+kx95zTmoSw4ufVqJrZY7hThvtjlurhw851hw1QpseM74TuEvCAZFkN
         kc6Fq98FGVUmspy3ePNOiGwTKbY8MF5lT6pFyhpz3MOmqWoH89J/EDQCh1+9uhFr05MW
         opHSIJGyqdcYOCg3zQko3UmXyEYHA69WE1OlrGCTzztgC2Q8BdI1VU7Klco80cMr0kp5
         LAHg==
X-Gm-Message-State: AOJu0YzYwzDj8TTZNyb9sxiQKSBn33al7ZG04JkdQ5BKA6JUiRoSdNoj
	yHyODWw3XffycTUg8jVVsSMPufRvrInaKnVs9X6GklvN0JVCDRaCKt/t8QEZpXAn2IWwo1dzXWj
	5
X-Google-Smtp-Source: AGHT+IH/IBzjbEkOgMNR0RXGP17zvIYmL7mFmyhAdke+NpxILeoqSLlWH9H6Ei2p/Tu6m4bc71o6LA==
X-Received: by 2002:a05:6808:1496:b0:3bd:cdc3:ad4 with SMTP id e22-20020a056808149600b003bdcdc30ad4mr389626oiw.15.1706046635145;
        Tue, 23 Jan 2024 13:50:35 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k10-20020a056808068a00b003bda3125e3csm1956290oig.48.2024.01.23.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:50:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH] spi: consolidate setting message->spi
Date: Tue, 23 Jan 2024 15:49:46 -0600
Message-ID: <20240123214946.2616786-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, __spi_sync() and __spi_async() set message->spi to the spi
device independently after calling __spi_validate(). __spi_validate()
also would conditionally set this if it needed to split the message
since it wasn't set yet.

Since both __spi_sync() and __spi_async() call __spi_validate(), we can
consolidate this into only setting message->spi once (unconditionally)
in __spi_validate(). This will also save any future callers of
__spi_validate() from also needing to set message->spi.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bc3d7c0ce6b4..7a70ef47cdf6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4059,6 +4059,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	message->spi = spi;
+
 	/*
 	 * If an SPI controller does not support toggling the CS line on each
 	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
@@ -4071,9 +4073,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
 		int ret;
 
-		/* spi_split_transfers_maxsize() requires message->spi */
-		message->spi = spi;
-
 		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
 						  GFP_KERNEL);
 		if (ret)
@@ -4210,8 +4209,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	if (!ctlr->transfer)
 		return -ENOTSUPP;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_async);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_async);
 
@@ -4391,8 +4388,6 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status != 0)
 		return status;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
-- 
2.43.0


