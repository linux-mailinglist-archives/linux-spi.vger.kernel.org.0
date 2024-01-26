Return-Path: <linux-spi+bounces-833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667583D0EA
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 00:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4286E1C247FC
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC1C134B2;
	Thu, 25 Jan 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xFmc7W6s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7818125BB
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706226484; cv=none; b=gmrYtN1g0NR8Klo7P0zI/37wlJ8wepFII15oYfBHDYCuPcyfsraemeKwMULQF6vl5ZgVGXPenwQywVP66pe3Q6t3vGtErU+ZiTAcwFWehEnnZxgNMlAyFFkoauvpBgu3+SPFSz5PtIQtJBQRnxJOK3T9JT/ABpjarvxBhZRBvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706226484; c=relaxed/simple;
	bh=h0ukfu7fbpEtm2GmAALyDiKS1mq9P4izDT/xmXmjvjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfMtiz/+1CEI4JfsXqhFML96365EwZXruejXocLz80XY0ss6Q/nFg9S+kWtTrzsBbVCkIGv/4dagrPyxIr5JbTSY95+W6aNmzNuI832mrZNy8JOCEyB6J6oSO61NmR8gIMnkpYu+DiVxYpeIiCsompAZ+37zD4hhSQazn7bm/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xFmc7W6s; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc8b280155so163819a34.0
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706226480; x=1706831280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Od4hU94ybsj7xZ0WbGxgj87ggIn2ak5by+W8Vfq/8K4=;
        b=xFmc7W6shFc+vR0AsS5dUQEyXT1he6IXFnZIzVz4xas4CzJeJh4vW/5/mXdzsb/yVG
         4k9Cymj0fyPbgBPaswa4+Pq9yu7pycoHwHSzsorb0d4D3AKzTxHreyu4jH8lStpt3z7f
         ypFvwL6PW9j990FityYTbIu790pbu5ok582EN/jBqgGInK3PKyw3d82zXJu5ictd1d7F
         hGt7A34brXVV4TejME8HzIVQWZehEMJQ1wPLoIc9bP66bNei+Jsln2GD0JddMy07zLkm
         YZhCNms++88ZSeSnK3gWSEO7ehgdbuIXF/rlxSrp4lBGPDXdPCnSxr1oprJRvbnJ8eXY
         7idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706226480; x=1706831280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od4hU94ybsj7xZ0WbGxgj87ggIn2ak5by+W8Vfq/8K4=;
        b=NDUhrsHzN6QbmiebH4U0laEw7SRhnlPC5xpW0g//qhJaInSr4RdvXwPd90+VEsVs+7
         TsGsmsmBLNIMjpVE2Du9mhvMo5GWpJG2eSGlkl/aDJcpaRYnunXXmdWE47UDdwvLHNtr
         TIr6h8tl7cZvkxp/ze+5+/u/95GHaLq80BB5dMXUIS+jhsszE5kvxsY+u5mtSIFY/85K
         f56XQ+Xxv2W0dq5q6/5r2FsJ0xFpsF0zZ+RFl2wlJLR+ljCSNcluk5yiWHBUeOMBgcVw
         YtAfB27b54Cp/2NIzK8i0/xpZoI4aCS2wZDTanieIBOhCxrwod59VprCOlXttyAPk/PE
         cUPg==
X-Gm-Message-State: AOJu0Ywk2XTxtAgJ+emwwdHK0iMIjsQsQNw97Stwgn5g19GMHShh01K8
	UvjlGmBBAibhHBaozIZabkGSMEZQ3uCSZu9TNFr6cmywIge8OSJmmDZjcKf0S4I=
X-Google-Smtp-Source: AGHT+IFBcA+j2LDvJt1pNeEXPzCsr3T+T/9aXaimRkzS1KxzpY08ZgFRGsxv0b9XtgrDciQPT59Q5g==
X-Received: by 2002:a05:6830:3a09:b0:6e0:cce9:833b with SMTP id di9-20020a0568303a0900b006e0cce9833bmr613639otb.11.1706226479657;
        Thu, 25 Jan 2024 15:47:59 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id d28-20020a056830045c00b006dc0802ddf5sm52466otc.5.2024.01.25.15.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:47:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: avoid double validation in __spi_sync()
Date: Thu, 25 Jan 2024 17:47:31 -0600
Message-ID: <20240125234732.3530278-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __spi_sync() function calls __spi_validate() early in the function.
Later, it can call spi_async_locked() which calls __spi_validate()
again. __spi_validate() is an expensive function, so we can improve
performance measurably by avoiding calling it twice.

Instead of calling spi_async_locked(), we can call __spi_async() with
the spin lock held.

spi_async_locked() is removed since there are no more callers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I tested this using an ADC driver that does a lot of spi_sync() calls to read
samples. I disabled the no-queue fast path by setting ctlr->must_async so that
the modified code always runs.

With this change I was able to increase the sample rate of the ADC about 6%
from 14.5 kHz to 15.4 kHz.

 drivers/spi/spi.c | 58 +++++------------------------------------------
 1 file changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7a70ef47cdf6..6610aeced765 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4278,57 +4278,6 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 }
 EXPORT_SYMBOL_GPL(spi_async);
 
-/**
- * spi_async_locked - version of spi_async with exclusive bus usage
- * @spi: device with which data will be exchanged
- * @message: describes the data transfers, including completion callback
- * Context: any (IRQs may be blocked, etc)
- *
- * This call may be used in_irq and other contexts which can't sleep,
- * as well as from task contexts which can sleep.
- *
- * The completion callback is invoked in a context which can't sleep.
- * Before that invocation, the value of message->status is undefined.
- * When the callback is issued, message->status holds either zero (to
- * indicate complete success) or a negative error code.  After that
- * callback returns, the driver which issued the transfer request may
- * deallocate the associated memory; it's no longer in use by any SPI
- * core or controller driver code.
- *
- * Note that although all messages to a spi_device are handled in
- * FIFO order, messages may go to different devices in other orders.
- * Some device might be higher priority, or have various "hard" access
- * time requirements, for example.
- *
- * On detection of any fault during the transfer, processing of
- * the entire message is aborted, and the device is deselected.
- * Until returning from the associated message completion callback,
- * no other spi_message queued to that device will be processed.
- * (This rule applies equally to all the synchronous transfer calls,
- * which are wrappers around this core asynchronous primitive.)
- *
- * Return: zero on success, else a negative error code.
- */
-static int spi_async_locked(struct spi_device *spi, struct spi_message *message)
-{
-	struct spi_controller *ctlr = spi->controller;
-	int ret;
-	unsigned long flags;
-
-	ret = __spi_validate(spi, message);
-	if (ret != 0)
-		return ret;
-
-	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
-
-	ret = __spi_async(spi, message);
-
-	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
-
-	return ret;
-
-}
-
 static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	bool was_busy;
@@ -4376,6 +4325,7 @@ static void spi_complete(void *arg)
 static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
+	unsigned long flags;
 	int status;
 	struct spi_controller *ctlr = spi->controller;
 
@@ -4419,7 +4369,11 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	 */
 	message->complete = spi_complete;
 	message->context = &done;
-	status = spi_async_locked(spi, message);
+
+	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	status = __spi_async(spi, message);
+	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
+
 	if (status == 0) {
 		wait_for_completion(&done);
 		status = message->status;
-- 
2.43.0


