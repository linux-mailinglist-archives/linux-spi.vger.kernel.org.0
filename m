Return-Path: <linux-spi+bounces-1429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F685AE92
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 23:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C601C231A1
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7A57324;
	Mon, 19 Feb 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Autx+eBN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059E56B6C
	for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382103; cv=none; b=Ujg9M5+8CWz8ETPxrg5y5zjLAbyJi+fUvUzDM5ODY5go8MfIuMyx9Ez5cLC7x2wp5zvwqTxHJ2+lPK6yCtqVTSHIbDnOK9frKNKBmmoM0C5LU3qRey5sKFYqpOsWpZxwm0Oh+CAXgBH1/vjP4Vtgfqz4tn6T16kF+K4SNoQDGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382103; c=relaxed/simple;
	bh=QsqGSd0YrGNt4iO+QSuv/owuo4NT7KSX8p+xqtQcChY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBnnvmEbSrEJyRba0xi0eJpx2iB5SIEmVSFs6MSdKO5kFXGcsQCgwk8qKT66cb8B6fmS3cUsPgaXjHXXHBnz9lcHPwGfUOoEeuPM6pIqIBOKT2FMRSrDZ20P3+QPk/9tS8B5dPtErWQKxSvoYpuw55gZcLlIjZT+2H0kGsDUvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Autx+eBN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2dbf54b2eso2803325a34.0
        for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708382101; x=1708986901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nguAE7f5YcWI/h5umYjj7eHdUyvOtkK6QQpK6mXXbx4=;
        b=Autx+eBNNCqYL35ZC0xL0rB31mo/p6dR/xOEzOklq4eWf1IMK5AUmGKdW+3Rdtwb28
         nwoTuLyfFwdGa8MpIaPz0vXjZ8OfkYRTlxUAqKALXi+BTqQ3kBGZ4+eMwu2STVqEwiEd
         mEoiAQvbPLzOrDVtkAWW7QgArX44AkDUf1n9M1+QV63ZQ5PjqYMgZP+YIfYpMIWftduw
         XYlwSzfT0AbVnB9Y8LY7Ji3SME0nA8eGib5w4aI/R9mQ+lbLMj9W9jbPSnm9KUbHNw90
         hgweH1prQEyn6/GeWokXEREudiWr5uZDA2xL41m+xSIfk5vZerGAgBY9zIXkrLOHqWeH
         iEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382101; x=1708986901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nguAE7f5YcWI/h5umYjj7eHdUyvOtkK6QQpK6mXXbx4=;
        b=B43mtpJ8Pi/zbkPTNx+pY23TwX5W7W9Ms52y3gf+p8n44pun5qI3G2fe4d4zgWKYQo
         LtXgqiIVo/py3CgxS52dN7ouVL4DdTPDf5QwTzTjoQKz4KIgA/ZfTA964TYKFoA2GJwg
         8xC/QWerH+hPDRoI+8dVq8LTgl7JhJM9mTxmPyA8hv5GMOYf926cOyY/P+RwCSwgDCud
         QH6ReaEjLwGtIC4rfrpRbrCyAGHDuH9YcB5d4xaFtE6eZvezXiFrmsiZalLKdgd7wFxh
         5Yb2+7lCqmhfpDJxW9WGB26y9ykgJo/VUUpZNVaHaKGaWtLxmK0lHKmiuntiTZtOE3qk
         tSsg==
X-Forwarded-Encrypted: i=1; AJvYcCUb7oGjHEg24WYnBkFBNEvXLv5xeMeqcH7kkO+Q0MXeUUpLBqcWBIw/Jm53J9wAYqREqHXYe4dNiJlouQ2XnN8Mvs4kQm3/FLN0
X-Gm-Message-State: AOJu0Yz3qNg25mBQ69yOh0Ct4zd9Nbv4nnYmr/hzTspnDj1eMZ4PuAsT
	y4iBgdAaabsduA35K+08zSumYlT4wEPHJSpugKaWDXZjRciQHKRWTmo0FkAoMtc=
X-Google-Smtp-Source: AGHT+IEKk7jzI/qkme4zk/gFRVTVBf/1nLdJFY+y7tiRySbZb046arGF15DJiOZ4ycZjN+0TNGVe+A==
X-Received: by 2002:a9d:7494:0:b0:6e2:e5a3:1732 with SMTP id t20-20020a9d7494000000b006e2e5a31732mr3221609otk.37.1708382101127;
        Mon, 19 Feb 2024 14:35:01 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d6419000000b006e45a5f0a70sm171776otl.49.2024.02.19.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:35:00 -0800 (PST)
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
	Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 5/5] iio: adc: ad7380: use spi_optimize_message()
Date: Mon, 19 Feb 2024 16:33:22 -0600
Message-ID: <20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com>
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

This modifies the ad7380 ADC driver to use spi_optimize_message() to
optimize the SPI message for the buffered read operation. Since buffered
reads reuse the same SPI message for each read, this can improve
performance by reducing the overhead of setting up some parts the SPI
message in each spi_sync() call.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- Removed dynamic allocation of spi xfer/msg
- Moved spi message optimization to probe function
- Dropped buffer pre/post callbacks

 drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index abd746aef868..6b3fd20c8f1f 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -133,6 +133,9 @@ struct ad7380_state {
 	struct spi_device *spi;
 	struct regulator *vref;
 	struct regmap *regmap;
+	/* xfer and msg for buffer reads */
+	struct spi_transfer xfer;
+	struct spi_message msg;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -236,14 +239,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7380_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
-		.len = 4,
-		.rx_buf = st->scan_data.raw,
-	};
 	int ret;
 
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	ret = spi_sync(st->spi, &st->msg);
 	if (ret)
 		goto out;
 
@@ -335,6 +333,28 @@ static const struct iio_info ad7380_info = {
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
+static void ad7380_unoptimize_spi_msg(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
+static int devm_ad7380_setup_spi_msg(struct device *dev, struct ad7380_state *st)
+{
+	int ret;
+
+	st->xfer.bits_per_word = st->chip_info->channels[0].scan_type.realbits;
+	st->xfer.len = 4;
+	st->xfer.rx_buf = st->scan_data.raw;
+
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
+
+	ret = spi_optimize_message(st->spi, &st->msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to optimize message\n");
+
+	return devm_add_action_or_reset(dev, ad7380_unoptimize_spi_msg, &st->msg);
+}
+
 static int ad7380_init(struct ad7380_state *st)
 {
 	int ret;
@@ -411,6 +431,10 @@ static int ad7380_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
 				     "failed to allocate register map\n");
 
+	ret = devm_ad7380_setup_spi_msg(&spi->dev, st);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->name = st->chip_info->name;

-- 
2.43.2


