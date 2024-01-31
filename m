Return-Path: <linux-spi+bounces-929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0EA8445AF
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDE22957B6
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3460812DD9A;
	Wed, 31 Jan 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlmFQn8e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15F374D4
	for <linux-spi@vger.kernel.org>; Wed, 31 Jan 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720890; cv=none; b=LCoXOb7ihkBmSvRDNPlZz7/WwOFe6R0tzwGqHMdntONoSxnbgWasy+V4yPmpJXxw8cMGX1JgpgBjLO6Kk1IoNyF2Z/JlPXIfzV9gL2vgI8Z+UFYdyZov/pB/udBAfkUnFjFmsBMCHRxtcSGhi0x5m+USnbmhU7R2ocrRq7dJiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720890; c=relaxed/simple;
	bh=FrKnpE9BAaffQIFRBM9a3DlzX2WfYlcOBOsYnXbceHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wo+BsPBSUzYE7hzKvULBOM6OQMDd05rRutug/enw/7taWqQl51ruh2MxuMlfJ5o6VdfWWVCbV8IvmCCQbPLsLOKvaANennGBzErJu/uF62bJ4HQkZR2GxR0H68VATF+5nEyFKNlfTh8ySTj21TR9ul6EeRE8VHCccmjtRWlIxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlmFQn8e; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3beb504c985so10382b6e.0
        for <linux-spi@vger.kernel.org>; Wed, 31 Jan 2024 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706720885; x=1707325685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsWJv1YW4mhJWkcBD7g/IeRgffr84y0Zx7w3aumJlrI=;
        b=mlmFQn8eKwqYWwHOgfHyqQNGsF6Nb0DZpcUZhUhtMq19vxxP/mq0n58F7FfjWeMPat
         ItAMbadSprSDNi9IHfuhNwXfMbqWS7LwNgK1VcYcmeCthOkHuiGenlql+Nlr8/Kv65rD
         bkGc+KmexC05zM5S72iBTsG4h2JLOBmA6B5awZmS/UZT3leEqipKMqg3v5PyVssoDQ5E
         Ynrkz2vOg7eSTUQSg/GfvXvy5rD2sRhs8UTaNCuVOXqAExKZDTowFjsoMQRE3tqtN/Y1
         Keimx4PQVtQp0HOMJvRy7ah/2pbQflXpn5u2Qs4lY1VfsFIigcDE1UcljflsS4A3TUG7
         ydeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720885; x=1707325685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsWJv1YW4mhJWkcBD7g/IeRgffr84y0Zx7w3aumJlrI=;
        b=taHzvOToDMYjPneQGLVXPl1Czgh3cdiDPHusJeiLFLQCB5ShR+FxswJ7Y5eQPjoe4v
         PAxtwRpaRGhqGzyalhkR+USXZdfS3Ok8sbjpnxpyy1w9FHoD2EmQd1NheegJa4b7qb+y
         /LqaZA19y02PKEN5as3/tMnE/Jx6W4Kw/LXFNcGZ2ZEL+N94tryOphBO1WmVsbJNNni7
         hAigslGbgDeOU0V9ckLinIjGK8PNXlRj4FSqScJoPcMBlb+iOtJE4p9xuNK+hQLvrGE6
         cq4xh6oVOrKbFg7PLcfgNdFIC4EY1EUiOAEA9HSRcUEublouygkinQ65NgIVaEx2S/vn
         BgDQ==
X-Gm-Message-State: AOJu0YyMIPsMRL3KercYbLn9i5v65XPfTEs7J60mJwlmisoa/xxJ111U
	bBtc7uqdEsrdCNleWgv275SDVHcnkcuycz94r57R7p1MmqOaA8SS+xZj/6rdm00=
X-Google-Smtp-Source: AGHT+IGO/uoytyRUA2AE8MRtQvDYVfhku+fm9eKfM/V9XqUw6q09uZAef4wU1qdeWNORPLtUfnbkSQ==
X-Received: by 2002:a05:6808:4442:b0:3be:a35b:d08b with SMTP id ep2-20020a056808444200b003bea35bd08bmr2038341oib.53.1706720884989;
        Wed, 31 Jan 2024 09:08:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5pQosX2B3ZPYTxR+xO4xKBgsz9ApnJjaj6SfMCNG8d3wh8LzQSWGpkENbrD5cPpQHIiZQOH7n1FiKuq+zwEKJraNfVwo+hzL3Zsu+jP0tY4tkCl/0UhTZD4tnPywnMDHJ8HIw+pkP
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id fa21-20020a0568082a5500b003bed47158basm48965oib.57.2024.01.31.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:08:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: reorder spi_message struct member doc comments
Date: Wed, 31 Jan 2024 11:07:27 -0600
Message-ID: <20240131170732.1665105-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The members of `struct spi_message` were reordered in commit
ae2ade4ba581 ("spi: Reorder fields in 'struct spi_message'")
but the documentation comments were not updated to match.

This commit updates the comments to match the new order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 979cde8263df..61636b3209fb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1113,16 +1113,16 @@ struct spi_transfer {
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both DMA and CPU virtual
  *	addresses for each transfer buffer
+ * @prepared: spi_prepare_message was called for the this message
+ * @status: zero for success, else negative errno
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
  * @frame_length: the total number of bytes in the message
  * @actual_length: the total number of bytes that were transferred in all
  *	successful segments
- * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
- * @prepared: spi_prepare_message was called for the this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
-- 
2.43.0


