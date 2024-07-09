Return-Path: <linux-spi+bounces-3806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758992AD86
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11476B221B7
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E23FB87;
	Tue,  9 Jul 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UFXh2G6b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BD2BD05
	for <linux-spi@vger.kernel.org>; Tue,  9 Jul 2024 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487151; cv=none; b=iQnApKdAt+bQo62nhIU4+DLxOsEmNMTRP3zBCvEFDFIaf4Lnuw1QvyRaEFql92ZIeiNPNWEsT0s+m3uOqLDRaQ44vk8CI+ZPnCXhoGMTAq5jdBrsXbzVVkwHVgndPy9NubU39deGBYdO9K7d4jS21vgI+ripK1fBdJh/kmE2DV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487151; c=relaxed/simple;
	bh=JBlHcMkzS15u8ND8hNvi40N/b9+EWWSiZbc1/rFWigw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4dh1EEad9gBVcBihYNI8CRgMXaSnWOSMkOncpneMn1/Sg+LhnjFFsGdCqnFUCrfu6R/buSZm3RbwHb3Li64xJYdzK1X4MWqwd6aVn5emH6ufEcwLxQMcucTqmp43iqEDsiK3Gle2TQCng8ElIlzWbQL8UhtQSTtp8KzVN7akUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UFXh2G6b; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d928b2843dso1513943b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jul 2024 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487148; x=1721091948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY82VmqqmPpfhidAfS3DgOLc0sNGbQY6E8N48MCsNkk=;
        b=UFXh2G6bTHO97N2r5HUKCnvhJg93EPq+MkXb4pT6q4Kvqie8skmysFooBkdjSxZciC
         21X4HAuWVRJ5tmxFjNTjJ3KNA+JotmPaBXp13kNqAswVxgnhSfFt29Ldd6Edgt3bUK6v
         3HtHDVSSl/+bECp6QWhtH94FnlPuvlT3mf7vLSsicH+X3Qy6G7HvyjuKtO3JgoVeGfAK
         Y+RRg599RtSgQVlO/uCCqOSCdzutOrj5wiD6tmOm0uB7Mj1SkoGqRJ/1OrwMnjDgvqt5
         k8Xffw0vYa1TZbip2rQfgLcWPDwBwxY3Xt9rYejc/ftetrr12gtfiDN37rBtwDJx4jQu
         4eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487148; x=1721091948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY82VmqqmPpfhidAfS3DgOLc0sNGbQY6E8N48MCsNkk=;
        b=gEvqITcOX9io+KFPszljL+gga6OFU3jwEavIwq/YY/9xxrM/cQ816h3DhuYIztVKGM
         aoVTm6BMoSQ5dznVxmpwKQe1OfJiCRCUAdo/PMCVqn2YJJkOjI7QDlUl9CiwH9I2M8Cf
         /Mw0krEEH55tVIx0czHGZJNdxqPP9BlMkGqPJHHO4hc96yOFK+QWh3M83v6d3iy0GQ/X
         tiiNje46KQnhXyu5bCLaiNc5j75uHzv6zMjpZOZECYZwmcWydVNYyC1CtGGIEJ1W5CzU
         9obUTKc+cPFt7j4toMjt3QCeVYX0fwAKdrWOteQBgzN8L+ZodkwS3dHZp58TDi+g69Wt
         Cwqw==
X-Forwarded-Encrypted: i=1; AJvYcCUpZzwGfI9jQpgrMrVzueLqE9FLk85YSaqDa115qykmwNEGuYzDXJyiUFjwH3gKXUKFXGw1OT8IWk4ZjeMuVh5dqopjITM292yh
X-Gm-Message-State: AOJu0YzdjHyUtbv68zsWRXYTN1XVWDG2kdGkfHcNiAHEEa4GgLm/CPin
	vRFO0I9xEogkT/awF6mIT+OuEnhwcv+ACKcyBCkla3jsvJu3YTf7e5UTrxM/R5qxBZDcgazKU83
	Q
X-Google-Smtp-Source: AGHT+IE8iQR+fKKNorUZF0zU9+lAAJ66e1Nwhu/VHdxNQ+S7Uc35tiSC1e38maUhILfLt1ltKqrEwg==
X-Received: by 2002:a05:6808:1b2c:b0:3d9:2e7e:53c4 with SMTP id 5614622812f47-3d93c046573mr1289948b6e.34.1720487147044;
        Mon, 08 Jul 2024 18:05:47 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: add defer_optimize_message controller flag
Date: Mon,  8 Jul 2024 20:05:29 -0500
Message-ID: <20240708-spi-mux-fix-v1-2-6c8845193128@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
References: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Adding spi_optimize_message() broke the spi-mux driver because it
calls spi_async() from it's transfer_one_message() callback. This
resulted in passing an incorrectly optimized message to the controller.
For example, if the underlying controller has an optimize_message()
callback, this would have not been called and can cause a crash when
the underlying controller driver tries to transfer the message.

Also, since the spi-mux driver swaps out the controller pointer by
replacing msg->spi, __spi_unoptimize_message() was being called with a
different controller than the one used in __spi_optimize_message(). This
could cause a crash when attempting to free the message resources when
__spi_unoptimize_message() is called in spi_finalize_current_message()
since it is being called with a controller that did not allocate the
resources.

This is fixed by adding a defer_optimize_message flag for controllers.
This flag causes all of the spi_[maybe_][un]optimize_message() calls to
be a no-op (other than attaching a pointer to the spi device to the
message).

This allows the spi-mux driver to pass an unmodified message to
spi_async() in spi_mux_transfer_one_message() after the spi device has
been swapped out. This causes __spi_optimize_message() and
__spi_unoptimize_message() to be called only once per message and with
the correct/same controller in each case.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Closes: https://lore.kernel.org/linux-spi/Zn6HMrYG2b7epUxT@pengutronix.de/
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/linux-spi/20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de/
Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-mux.c   |  1 +
 drivers/spi/spi.c       | 18 +++++++++++++++++-
 include/linux/spi/spi.h |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 5d72e3d59df8..f4b619cc2657 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -164,6 +164,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->bus_num = -1;
 	ctlr->dev.of_node = spi->dev.of_node;
 	ctlr->must_async = true;
+	ctlr->defer_optimize_message = true;
 
 	ret = devm_spi_register_controller(&spi->dev, ctlr);
 	if (ret)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e48c2fdd7204..d4da5464dbd0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2132,7 +2132,8 @@ static void __spi_unoptimize_message(struct spi_message *msg)
  */
 static void spi_maybe_unoptimize_message(struct spi_message *msg)
 {
-	if (!msg->pre_optimized && msg->optimized)
+	if (!msg->pre_optimized && msg->optimized &&
+	    !msg->spi->controller->defer_optimize_message)
 		__spi_unoptimize_message(msg);
 }
 
@@ -4270,6 +4271,11 @@ static int __spi_optimize_message(struct spi_device *spi,
 static int spi_maybe_optimize_message(struct spi_device *spi,
 				      struct spi_message *msg)
 {
+	if (spi->controller->defer_optimize_message) {
+		msg->spi = spi;
+		return 0;
+	}
+
 	if (msg->pre_optimized)
 		return 0;
 
@@ -4300,6 +4306,13 @@ int spi_optimize_message(struct spi_device *spi, struct spi_message *msg)
 {
 	int ret;
 
+	/*
+	 * Pre-optimization is not supported and optimization is deferred e.g.
+	 * when using spi-mux.
+	 */
+	if (spi->controller->defer_optimize_message)
+		return 0;
+
 	ret = __spi_optimize_message(spi, msg);
 	if (ret)
 		return ret;
@@ -4326,6 +4339,9 @@ EXPORT_SYMBOL_GPL(spi_optimize_message);
  */
 void spi_unoptimize_message(struct spi_message *msg)
 {
+	if (msg->spi->controller->defer_optimize_message)
+		return;
+
 	__spi_unoptimize_message(msg);
 	msg->pre_optimized = false;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a9388714e7e7..d7a16e0adf44 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -532,6 +532,9 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
  * @must_async: disable all fast paths in the core
+ * @defer_optimize_message: set to true if controller cannot pre-optimize messages
+ *	and needs to defer the optimization step until the message is actually
+ *	being transferred
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -774,6 +777,7 @@ struct spi_controller {
 	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
 	bool			queue_empty;
 	bool			must_async;
+	bool			defer_optimize_message;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)

-- 
2.43.0


