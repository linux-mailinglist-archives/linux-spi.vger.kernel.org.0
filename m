Return-Path: <linux-spi+bounces-885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D075D83E3DD
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 22:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493A11F22961
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A561DFF9;
	Fri, 26 Jan 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0MsTTGuc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166024B21
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304305; cv=none; b=be1uHVEHZ6bXRurqw9AM5Rr5bGfAHDlrX3vXlpm5TybHS1guE+DvJ8K/GVtJxZoDQeadf/cl8uZqMFsrbhmWCMJy4LMXYFaujzp4BFrtgs3Gc6LFBIm6uqkiLm/QLQdqT7KvkC2rfmT/KrZOkBph5aR9X3xGo/GQnqM7Q9ZudsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304305; c=relaxed/simple;
	bh=fAW9q4EkDHFfnVmOK3V3FffGHBBYnTq0r3oDKreuGGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6p9PClyMOadyLAtZRI0mXe9yq9OqPPsvVrE8i+sgBMsnf/iTvxlU64UoxzH+XgneJQpIn9GM7d4YpdlzPIwJ4GKPrMRhnfQWC80jk1lu3n1S1Jf3Wgo2eMmep32A03EZJRVBJQBhKzAD5RUpTmycXHxCxlSsA/TgUqSeULJmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0MsTTGuc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2143a96d185so306798fac.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706304300; x=1706909100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvanse6LjWSfCjsaBajNTZhxwBoWqH9+J1P89qwYxic=;
        b=0MsTTGucs2o00mXlglut6CAjnmfrqnTyoJlJ5+FEDR3n1lHOPzmfc8O2sanaz0wPJ4
         txihaUGVjvcxkiFQiYmR7tRaKy1giP9OplPPMPs5uGiS+5JAhnMIuc1B2L2czP2s07+B
         vi5uVAUHnkouPSE9sQKI/WpSfaKMsNqVGA7b2qqGrOGBOr9/TrGFK5EGJahcoHptTFAJ
         4aZWjsvjP/evHT4VjUdL0yc8aACtReeyxD470fH+PZvjbCNG1p/7NX7Z1MZhaQQGHoQY
         iNu6niNm2nUc8s06cExMf3Ph/A8C4t4dIpvg6jOmBNmkf+tdwQ9rnc7c9OkXWbjdof1e
         2aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304300; x=1706909100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvanse6LjWSfCjsaBajNTZhxwBoWqH9+J1P89qwYxic=;
        b=PkBGLbvlbepHSTWaHBcBQTSHgajfcA8CnuJOjfj650F1ozfA7SSbUrVWJomLwYM/Zq
         Gh/GMJ98kpholYkTJOMMPgQEBJcED+Y4olPY49ctYtSvD42UdCcuOUMySAECirb36qIS
         F8MMpFBXx1LsXKK4his2fLNsxGaTaiaiuJuYLEq6RsQb/yzaRlmXnzzdDRkPFZFn//m3
         QD+4bVTjq3eVbLvVbQkNmmG/mQ1OQ6iFcaQ0WnB/WlpXlhI/NFyVBK+bCsOSOEL34EVP
         6VY0HRYtRdkWIyvYP7//Ob/0ZUtf7j6KwAz/I/KUX6MhePBQQ0qg4DPWfoRvmUqnGBD2
         98Mg==
X-Gm-Message-State: AOJu0YylpknDcQd+D+OAIeNg4qzp/0B3U7NS0C+X1/MzwmJuzYFp6FHo
	v50MKh21upOz/os1AjCi8lCajhtJWKSy0FhNtBWqiPu5qDODhuBnmAZG1csLttg=
X-Google-Smtp-Source: AGHT+IFLj7/DgBt1M2xRzu6g2VPEDSkWoraWV0/G8hOLyAaKFXIPk8opbTM8V38gETJOihr+oD1NAQ==
X-Received: by 2002:a05:6870:1f12:b0:218:4bea:dcf2 with SMTP id pd18-20020a0568701f1200b002184beadcf2mr312517oab.55.1706304300405;
        Fri, 26 Jan 2024 13:25:00 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hf22-20020a0568707a1600b0021451bfd968sm538575oab.50.2024.01.26.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:24:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: move split xfers for CS_WORD emulation
Date: Fri, 26 Jan 2024 15:23:57 -0600
Message-ID: <20240126212358.3916280-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves splitting transfers for CS_WORD software emulation to the
same place where we split transfers for controller-specific reasons.

This fixes a few subtle bugs.

The calculation for maxsize was wrong for bit sizes between 17 and 24.
This is fixed by making use of spi_split_transfers_maxwords() which
already has the correct calculation.

Also, since this indirectly calls spi_res_alloc(), to avoid leaking
resources, spi_finalize_current_message() would need to be called
on all error paths in __spi_validate() and callers of __spi_validate()
would need to do the same. This is fixed by moving the call to
__spi_pump_transfer_message() where it is already splitting transfers
for other reasons and correctly releases resources in the subsequent
error paths.

Fixes: cbaa62e0094a ("spi: add software implementation for SPI_CS_WORD")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 63 +++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 53c25a351dab..a8b8474abc74 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1747,13 +1747,37 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 
 	trace_spi_message_start(msg);
 
-	ret = spi_split_transfers_maxsize(ctlr, msg,
-					  spi_max_transfer_size(msg->spi),
-					  GFP_KERNEL | GFP_DMA);
-	if (ret) {
-		msg->status = ret;
-		spi_finalize_current_message(ctlr);
-		return ret;
+	/*
+	 * If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					       spi_is_csgpiod(msg->spi))) {
+		ret = spi_split_transfers_maxwords(ctlr, msg, 1, GFP_KERNEL);
+		if (ret) {
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+			return ret;
+		}
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			/* Don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &msg->transfers))
+				break;
+			xfer->cs_change = 1;
+		}
+	} else {
+		ret = spi_split_transfers_maxsize(ctlr, msg,
+						  spi_max_transfer_size(msg->spi),
+						  GFP_KERNEL | GFP_DMA);
+		if (ret) {
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+			return ret;
+		}
 	}
 
 	if (ctlr->prepare_message) {
@@ -4065,31 +4089,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
-	/*
-	 * If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
-	 * for the CS line, we can emulate the CS-per-word hardware function by
-	 * splitting transfers into one-word transfers and ensuring that
-	 * cs_change is set for each transfer.
-	 */
-	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi_is_csgpiod(spi))) {
-		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
-		int ret;
-
-		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
-						  GFP_KERNEL);
-		if (ret)
-			return ret;
-
-		list_for_each_entry(xfer, &message->transfers, transfer_list) {
-			/* Don't change cs_change on the last entry in the list */
-			if (list_is_last(&xfer->transfer_list, &message->transfers))
-				break;
-			xfer->cs_change = 1;
-		}
-	}
-
 	/*
 	 * Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
-- 
2.43.0


