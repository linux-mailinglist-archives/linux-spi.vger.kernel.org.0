Return-Path: <linux-spi+bounces-1426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1585AE87
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328D51C22CB2
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DBB56774;
	Mon, 19 Feb 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EXC9etBQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC155E60
	for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382101; cv=none; b=UDEZbOMqWy85Hgt6Rd1/MsfyGHPV3wq7BR7u0SUkwij5Azp/Cus09i/T6eK7Hp2tJQrF8BzAYzhsbkrfvjSiB4FSwdR28LRnLaCJrw2PAwrCZjqARUtLcHpQ1MPKyysMAfolSx+rjrFdJSbVP9Qj1BnMwoBz/ytEdIn0rxesRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382101; c=relaxed/simple;
	bh=sSmWV+EMEyVWLEUpEqFePlqyEc61WeEx3NpFQkH6xKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nygDk5Pt8vMTpjzjz9buZ23i68ePO/Ez5Wn+rNg/jDHSgO0PMExQCZbIHnKb8yvfdyi1D8d/hh8D5a7BimnhrtRYHw8eyPfukJRoQmPNGhGx9xwu0c9jZCzYD3kQzJ8bEF/dbHxPAulxvNHH+zrG7Zx2p5GTGZ57hl/kqwv51E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EXC9etBQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2e6b405aaso1947434a34.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708382098; x=1708986898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXFb+RtnzRHPAv3WrnV5x/KjkLxl12244GFTo5rtzY0=;
        b=EXC9etBQKuw9L0LX5Qq5BQ1xKiKBy+qFfdRsxfHU1o+W1NGtdFoNY3kdY9i2AgzpRv
         gyJz3awidTYySxFx2SVXhjEc+HPhy1u4gk+DMdubyd+bCto/pBVlLv6YDiSl0dbo6M/7
         zUVHOAHEnS5yMzF2/eMWuDAhe7NVZqU8gU10JuwO+56DwPJSNU+Z9ZGd+U2riHa6aAYT
         f43C9/mkSw1jmyWT1m7Y+zJ3lGf0KwbLlMEEuKQxcizRETvUAFXlrU6mcMl50oHbxq3E
         ljQPSbRKtRnon/52XAt8bscc7T17HUeYWEes12ilK4xbVq1do4EPY/vivIjNXPdcCPB/
         87Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382098; x=1708986898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXFb+RtnzRHPAv3WrnV5x/KjkLxl12244GFTo5rtzY0=;
        b=VgOv5vPhe5rvmJWOBdjX/W8AqSjNJxtsN5HAVAo1G+bWYJ4YhZ3S8ez5zimlRbYfCI
         nLzwB+NZoh2CoBJCiBAWL7LhyCRB0YbWr45rf5rowd0YqpxMhcsb1pW0X6hoGgbjaXYi
         wIW+UJnSKpP208xFZQNsioX7Q7zJ9gOZ8CP2PhVRdFHIzfdrY5ey2isgPFWkt6JdQE4R
         L/MhQ1sQdb4+ZHTHkLWQb3CpeiiRcdchX9DLhoSc25EtzLt9RqCpB7+M+VJQd2GBjE2H
         i/TK9O346gpmtrn2UYzwTXeBswc8pYYaq7H2OvujsAlHw0i/14jdxVAap8HHmAxZwcPT
         pagQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8KpHzNQOPEPgnykov5CEgN4eU/SMSlm1Vc0o2rjd3E3WnEH1aFQ3lCRz45IzxYKPWjU3TaTgzWyq4cGP1JPFx/VWZSKFDxvFK
X-Gm-Message-State: AOJu0YzRskhcEpSf2OBBsWUD5pmqEzR9Tlryu2u4fSIiw9WYu1ALclMh
	CDcybsi/o+k590rx7eoYzDyKooh/YEV5/7LxZEjE2wM8hfA5u4Z8p13Rm08KNQ8=
X-Google-Smtp-Source: AGHT+IEFkkxLySZnOBcfOYTfpNBs3VIAZU4Mxx2UeYvP3zZ6LpsOgC1Myzlo2DfzDOHPf+MMrMbTmA==
X-Received: by 2002:a05:6830:1355:b0:6e2:dd64:c53e with SMTP id r21-20020a056830135500b006e2dd64c53emr12780325otq.2.1708382098245;
        Mon, 19 Feb 2024 14:34:58 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d6419000000b006e45a5f0a70sm171776otl.49.2024.02.19.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:34:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 2/5] spi: move splitting transfers to spi_optimize_message()
Date: Mon, 19 Feb 2024 16:33:19 -0600
Message-ID: <20240219-mainline-spi-precook-message-v2-2-4a762c6701b9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Splitting transfers is an expensive operation so we can potentially
optimize it by doing it only once per optimization of the message
instead of repeating each time the message is transferred.

The transfer splitting functions are currently the only user of
spi_res_alloc() so spi_res_release() can be safely moved at this time
from spi_finalize_current_message() to spi_unoptimize_message().

The doc comments of the public functions for splitting transfers are
also updated so that callers will know when it is safe to call them
to ensure proper resource management.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- Changed line break for multiline if condition
- Removed kernel doc inclusion (/** -> /*) from static members
- Picked up Jonathan's Reviewed-by

 drivers/spi/spi.c | 110 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f68d92b57543..ba4d3fde2054 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1747,38 +1747,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 
 	trace_spi_message_start(msg);
 
-	/*
-	 * If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
-	 * for the CS line, we can emulate the CS-per-word hardware function by
-	 * splitting transfers into one-word transfers and ensuring that
-	 * cs_change is set for each transfer.
-	 */
-	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					       spi_is_csgpiod(msg->spi))) {
-		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
-		if (ret) {
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-			return ret;
-		}
-
-		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-			/* Don't change cs_change on the last entry in the list */
-			if (list_is_last(&xfer->transfer_list, &msg->transfers))
-				break;
-			xfer->cs_change = 1;
-		}
-	} else {
-		ret = spi_split_transfers_maxsize(ctlr, msg,
-						  spi_max_transfer_size(msg->spi));
-		if (ret) {
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-			return ret;
-		}
-	}
-
 	if (ctlr->prepare_message) {
 		ret = ctlr->prepare_message(ctlr, msg);
 		if (ret) {
@@ -2124,6 +2092,8 @@ static void __spi_unoptimize_message(struct spi_message *msg)
 	if (ctlr->unoptimize_message)
 		ctlr->unoptimize_message(msg);
 
+	spi_res_release(ctlr, msg);
+
 	msg->optimized = false;
 	msg->opt_state = NULL;
 }
@@ -2169,15 +2139,6 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	spi_unmap_msg(ctlr, mesg);
 
-	/*
-	 * In the prepare_messages callback the SPI bus has the opportunity
-	 * to split a transfer to smaller chunks.
-	 *
-	 * Release the split transfers here since spi_map_msg() is done on
-	 * the split transfers.
-	 */
-	spi_res_release(ctlr, mesg);
-
 	if (mesg->prepared && ctlr->unprepare_message) {
 		ret = ctlr->unprepare_message(ctlr, mesg);
 		if (ret) {
@@ -3819,6 +3780,10 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
  *
+ * This function allocates resources that are automatically freed during the
+ * spi message unoptimize phase so this function should only be called from
+ * optimize_message callbacks.
+ *
  * Return: status of transformation
  */
 int spi_split_transfers_maxsize(struct spi_controller *ctlr,
@@ -3857,6 +3822,10 @@ EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
  * @msg:      the @spi_message to transform
  * @maxwords: the number of words to limit each transfer to
  *
+ * This function allocates resources that are automatically freed during the
+ * spi message unoptimize phase so this function should only be called from
+ * optimize_message callbacks.
+ *
  * Return: status of transformation
  */
 int spi_split_transfers_maxwords(struct spi_controller *ctlr,
@@ -4231,6 +4200,57 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	return 0;
 }
 
+/*
+ * spi_split_transfers - generic handling of transfer splitting
+ * @msg: the message to split
+ *
+ * Under certain conditions, a SPI controller may not support arbitrary
+ * transfer sizes or other features required by a peripheral. This function
+ * will split the transfers in the message into smaller transfers that are
+ * supported by the controller.
+ *
+ * Controllers with special requirements not covered here can also split
+ * transfers in the optimize_message() callback.
+ *
+ * Context: can sleep
+ * Return: zero on success, else a negative error code
+ */
+static int spi_split_transfers(struct spi_message *msg)
+{
+	struct spi_controller *ctlr = msg->spi->controller;
+	struct spi_transfer *xfer;
+	int ret;
+
+	/*
+	 * If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((msg->spi->mode & SPI_CS_WORD) &&
+	    (!(ctlr->mode_bits & SPI_CS_WORD) || spi_is_csgpiod(msg->spi))) {
+		ret = spi_split_transfers_maxwords(ctlr, msg, 1);
+		if (ret)
+			return ret;
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			/* Don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &msg->transfers))
+				break;
+
+			xfer->cs_change = 1;
+		}
+	} else {
+		ret = spi_split_transfers_maxsize(ctlr, msg,
+						  spi_max_transfer_size(msg->spi));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * __spi_optimize_message - shared implementation for spi_optimize_message()
  *                          and spi_maybe_optimize_message()
@@ -4254,10 +4274,16 @@ static int __spi_optimize_message(struct spi_device *spi,
 	if (ret)
 		return ret;
 
+	ret = spi_split_transfers(msg);
+	if (ret)
+		return ret;
+
 	if (ctlr->optimize_message) {
 		ret = ctlr->optimize_message(msg);
-		if (ret)
+		if (ret) {
+			spi_res_release(ctlr, msg);
 			return ret;
+		}
 	}
 
 	msg->optimized = true;

-- 
2.43.2


