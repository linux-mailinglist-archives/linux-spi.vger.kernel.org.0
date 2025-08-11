Return-Path: <linux-spi+bounces-9337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5EB20872
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A2D18A11F1
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199952D3A71;
	Mon, 11 Aug 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCiWNY4M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4dNiR18"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D72D3A60;
	Mon, 11 Aug 2025 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914227; cv=none; b=jK02NOqUC/BuBCsdn6Ua0jmGHdAlzG8VytKrUbIPrDduJSuTVwJHbz8fQopJKq4rzaBIy50OQRpWPofUCh5eCxDtSm5AG47SKxYqTwFpOu839+obok1D+AddpDoYpDqxcXSWhIa2XQo3OGbWt7oLmlK9ee12mqR3vM5DElji+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914227; c=relaxed/simple;
	bh=eNk975+t84dUazlCfqAPuToMefu6VdTYbHIJrfw8Fr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DfsG5RY8eLVg+o7I4h09F3kD7EDzTRCU0mgnht0RV5ZGPgZgtZ6bIaKeTn0ZqkuFnLG1UDEkaPZS0YtW/8A27zfLcIulg0B7yvNITB4PhcbS2a2FZwzs6JvNStzPim5QfLfb+A+qgv8cseTLoskPyRzmqyyJMTn4Wfsizkray1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCiWNY4M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4dNiR18; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754914224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GedppQXjyXzj3R2rxl9C/tgqRz8TSY2dQ2Ju6YCDxg=;
	b=xCiWNY4MQuk/pXDaN/hj/Rvk1nQsx+gl3Nq3aeC5gFxPls0c8Gt24Nw/nP6EEMKnc4uWo1
	8wdVMLjYx2WaZTLKvJV4Y2MoV24wytQRXJkrVRzVpuAfkef5CuzQwERBJGkHiromcLKihh
	mOIMSfJfJpvmB9tWsQrrK0Sh/XBhVgwzzDmXP9WhiBQ3zJpi3NiF7hGB9CCbJ9kdAuoU6g
	tY/CyTUZ/In9TTIjHbqmFDy6H+lN6Xox2bo6ZIkMwkeBYNrJ37CBdaeXhjCPqRvlHWISjK
	Kg/4OdC24xSj5qpdlZ05vAPKelZiUbUWcAiI1HI4aNeq8OgqFu3M6wZSyaxErw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754914224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GedppQXjyXzj3R2rxl9C/tgqRz8TSY2dQ2Ju6YCDxg=;
	b=r4dNiR189hwVHgcFc5+NCHHqCGM9gJG8fKywKC6K/6XL3IxsMXjhcvPrFwfeQJtxs06Jrt
	7SoMdg5AcQcJjeBw==
Date: Mon, 11 Aug 2025 14:10:21 +0200
Subject: [PATCH] spi: loopback-test: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKzdmWgC/x3MPQqAMAxA4atIZgOt4u9VxEHbqFlqSYoI4t0tj
 t/w3gNKwqQwFg8IXax8hgxbFuCOJeyE7LOhMlVjemtRSJOwS+QxnhwSiaJGxnqovVn7xnXtCrm
 OQhvf/3ma3/cDFgM35mkAAAA=
X-Change-ID: 20250811-restricted-pointers-spi-393d0b85c76b
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754914223; l=3126;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=eNk975+t84dUazlCfqAPuToMefu6VdTYbHIJrfw8Fr8=;
 b=i+8+qs4piHrFEjztOlkXanTBYz9Gm3i952fF01S5q/44V+uO/HrrQ0g4/I3HusC5vU+mylos0
 XuZpCE+Fz1EC0YLhtzo2mwBx9ZR0uG2W/whEKZuBNOaUwMhfYt8Grqh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/spi/spi-loopback-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7dd92deffe3fb1c2254777ce332c2eb52554aecf..e0b131aa29b62e9661be01b551e1260a7b0bbdfa 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -446,7 +446,7 @@ static void spi_test_dump_message(struct spi_device *spi,
 	int i;
 	u8 b;
 
-	dev_info(&spi->dev, "  spi_msg@%pK\n", msg);
+	dev_info(&spi->dev, "  spi_msg@%p\n", msg);
 	if (msg->status)
 		dev_info(&spi->dev, "    status:        %i\n",
 			 msg->status);
@@ -456,15 +456,15 @@ static void spi_test_dump_message(struct spi_device *spi,
 		 msg->actual_length);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_info(&spi->dev, "    spi_transfer@%pK\n", xfer);
+		dev_info(&spi->dev, "    spi_transfer@%p\n", xfer);
 		dev_info(&spi->dev, "      len:    %i\n", xfer->len);
-		dev_info(&spi->dev, "      tx_buf: %pK\n", xfer->tx_buf);
+		dev_info(&spi->dev, "      tx_buf: %p\n", xfer->tx_buf);
 		if (dump_data && xfer->tx_buf)
 			spi_test_print_hex_dump("          TX: ",
 						xfer->tx_buf,
 						xfer->len);
 
-		dev_info(&spi->dev, "      rx_buf: %pK\n", xfer->rx_buf);
+		dev_info(&spi->dev, "      rx_buf: %p\n", xfer->rx_buf);
 		if (dump_data && xfer->rx_buf)
 			spi_test_print_hex_dump("          RX: ",
 						xfer->rx_buf,
@@ -558,7 +558,7 @@ static int spi_check_rx_ranges(struct spi_device *spi,
 		/* if still not found then something has modified too much */
 		/* we could list the "closest" transfer here... */
 		dev_err(&spi->dev,
-			"loopback strangeness - rx changed outside of allowed range at: %pK\n",
+			"loopback strangeness - rx changed outside of allowed range at: %p\n",
 			addr);
 		/* do not return, only set ret,
 		 * so that we list all addresses
@@ -696,7 +696,7 @@ static int spi_test_translate(struct spi_device *spi,
 	}
 
 	dev_err(&spi->dev,
-		"PointerRange [%pK:%pK[ not in range [%pK:%pK[ or [%pK:%pK[\n",
+		"PointerRange [%p:%p[ not in range [%p:%p[ or [%p:%p[\n",
 		*ptr, *ptr + len,
 		RX(0), RX(SPI_TEST_MAX_SIZE),
 		TX(0), TX(SPI_TEST_MAX_SIZE));

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-restricted-pointers-spi-393d0b85c76b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


