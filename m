Return-Path: <linux-spi+bounces-3566-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777E91583B
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C684A1C225DF
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE581A08D5;
	Mon, 24 Jun 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZTx//brT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF61A00EE
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261997; cv=none; b=IZ+SR6oLAlgHk5gCvO1Am8qnWxOr/mCaGbr4bz3GMfaWG8MZ5WWmuiyZ59xOe9y7UKwdu3UIPIndvCDCsz4oIO81QaHoTzOt2w6kg+I+fTt9/BN475V1fB1tSCHJs5xjLgy6SEKipABZ39EkQJJswiYqpk4sGAAYzp6zh8DQjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261997; c=relaxed/simple;
	bh=M5ncsogjwIKi7yTwd3on+qTwjMFKb9OhWUuYpkcn5s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM3GEsbnVZ5M9SKRDzeq5mNxpYqH9WMBpUsdEvB483FZZIolESJLgTRm3WIpJjrljJlI2wI7Psd2fHUs64KUI+elyCX8rZDxzmieBWlpMsL3VoiACDq2sDdHk1V8a7rj6VoPJa8GENQF00YZpw/QNfPWo6SEV8EeRYWjviACmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZTx//brT; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d220039bc6so2701832b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719261994; x=1719866794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=ZTx//brTD8K18G842k/4ZHXiw/KkGaEtWETy9vIM1vMgW5Sl7JMOfF/fhCGUjHHcn6
         Zxs3t+h3cl4hx4Syk6eQgQUmLr/wzdm39GYHxvwEq+AKg1TeKxQYLUMxjMrvQpY8ofLS
         jIz5HA833nzMUDJr1XoMKbWJvreUNfmwGn/Lk57K3tSJDbH9OAAbr0JhdnZZZ1djPTXo
         VT2wpTBuM9IB9PaCLb1VgqN/BTatgBrSknDncVDdc5sq80WjfRg1Cip0X3LXJDqZCPUd
         MsqQAC2mWd6KcRsdscrrLgwdCszJGZq+WUMR864x/cExeWq437VfbFsqjXMOiusCCjAV
         4m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261994; x=1719866794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=N1Dx4x9flPXi0ea78TM3NjAyyBmSfrIAs9Do2EWZ++gEzdh88YVUEw0Y9QIZ6Ztzq/
         IKDRuVL2x3zO3fXtkFridOJbRY/hIhNVHOqN3CCg+i+MkxD2TtePcsPKcYXHYcwS11Z3
         kXFIoNr2psd08kOzTIDi8g/48/wLy9Jm9Kxnf3fb+E+UHCYb0mF2cvs5C42xbFvQsJb5
         ockzbNAAV66c+bJo2d8L5TFZopjWktFnDsFfAFpWwQ+MUFjHcqMK5wKeNQ5n7GPXx/nL
         wzHgv+eQx2JMsVWcqnCuyd6n2I4vEauHeCJ10Y0wklxaHY4tbtXrOs4tIc+kZQWeq+h7
         q/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC8TIcg1KX0nOfmtA76KJb1sprA5P7soPRs13Dl0i5+Fusy+L7vMW4thBjh26jhrWn5oXH9tJ/f6NwnBk2bbZzvNpD7c1htSti
X-Gm-Message-State: AOJu0YzBvzjfVldRllY967qpf2hjgTfXDYpzWYnaTOnxx+1K5WqNz8hI
	FOpMTH3qQzSPAKmVEwjQsPdNQKXlH5RhuMtzw5sCVXGisgw/YQi1sA7GuKPu9Ik=
X-Google-Smtp-Source: AGHT+IF7EFvGMEWr3pSOe3ttWzuPOBO9uekNYTXi7CPcw+9uIitHHwkUX7fmGEK32jf/6d5fRZGkyA==
X-Received: by 2002:a05:6870:d629:b0:251:2766:deb5 with SMTP id 586e51a60fabf-25d0163f01bmr6692531fac.9.1719261994534;
        Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c106dbsm2092849fac.58.2024.06.24.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: ad7944: use devm_spi_optimize_message()
Date: Mon, 24 Jun 2024 15:46:08 -0500
Message-ID: <20240624-devm_spi_optimize_message-v3-2-912138c27b66@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
References: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use new devm_spi_optimize_message() helper to simplify repeated code
in the ad7944 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..a6ac17c13a29 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -134,18 +134,12 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
-static void ad7944_unoptimize_msg(void *msg)
-{
-	spi_unoptimize_message(msg);
-}
-
 static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
 					 const struct iio_chan_spec *chan)
 {
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -175,11 +169,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -188,7 +178,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -209,11 +198,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -221,7 +206,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 				      u32 n_chain_dev)
 {
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: SCLK has to be low before we toggle CS to avoid triggering the
@@ -249,11 +233,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 /**

-- 
2.45.2


