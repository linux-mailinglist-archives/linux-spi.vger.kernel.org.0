Return-Path: <linux-spi+bounces-10626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6792BBDB8B3
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47EFA4E7525
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A330DEA3;
	Tue, 14 Oct 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AmsOo1zF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654230CDB8
	for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479390; cv=none; b=YsiAOBbKR0mOi9KOjFaLpuB7GFbO8WBto+2zeSfjgNiEpXeZBPQRFVGYoEePWj3mBDPb1Dyu7gSWsN7ktTYKqNOyRCBJwARv8WxNC+bioVaUxpgWcBYK9eszTyfHhotjrrsnAW+HsTCCcDpqDn93suUhAkiv94GcvXwMT2hsUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479390; c=relaxed/simple;
	bh=4CqVCZcygZWUEZQ30wthncfqjOostuEs/o8pgXKJiB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ppu0sX/dhiHdrELKavJeLhf3aWZh1Awu4WEJumzKwzgq0KIiTzv9cqic3V9SGIRLMT8bPMNAuvwuhDglC9BHtYE9tNIdpOg6K/X3PWk0RnMY8jHZiULo7bva1h4l822AHhecod3EFOoXR5Gf+Ojlga84aUCUIrFxZqHYnhPVWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AmsOo1zF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f802f8571so1410017b6e.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479387; x=1761084187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgbcPx1cr/17wtO8OObzdd/2joADqfl7IEGfA1dWiH0=;
        b=AmsOo1zF16ponGf1Q43LF1AAHeG+4sy2Toly49XfuI8DAMTnqTfhzI04xSyLCDCW4O
         BoldXvvyU85pDwsPPbOy1SJHGFnUcDWHn617ClEut/DLOhdsijWlK7RsNeluAB4FoZg7
         Y6tTHUbF+5oxlL5cVOttdBmIv1TMHV14lq20PdkG+w/GbpikeMONd+W19e8rg8p/SyoZ
         LOGSZFFHfQaa7Q5oUjVAHy2I4cdlHEQg6h5qip0XvgcZpHMrwSPLgmN6YirJlzaYZncp
         akzv0D2VuecP/0L2b07ClbSkB+LJ5/vFWh+F8zdM+rujhq0lsVb4YTv7dnK7MZmqi6MF
         TRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479387; x=1761084187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgbcPx1cr/17wtO8OObzdd/2joADqfl7IEGfA1dWiH0=;
        b=TSvPVv6VHi+BgHlAjotw7eI3u9bCH/UdtWb28ck17QlyodHKzWpMauu0HtlEN12JVp
         epUxU8GfTz1KGlXhSjLrtFT8lPpHyu0/1K9MDzA5aFtia78qY1tBHjqfl4w/j+kGjkuK
         2AY1bSN5vDpKStp7WGAFUxc04vOZ0hxHdnVFkmoW6+M76cpREgV0nMmqhzn/HIwop+a9
         XA/tLoO2aCmIjoUrQTwY3c9wIUMvV2tAi23YsAFvR+azS8ctVOxrXj1rlz+boS352a+u
         on+baP4iPWvFFfzXTQ/QLF+F3kYy1X6ff53xSCOikH8ENwG1+jYb0lrXYs6cqLjQEgD0
         QBHw==
X-Forwarded-Encrypted: i=1; AJvYcCVJPBUD26mdOq9LlvBYfA9cpSHsHEFV59SMr+TG5nO+hxFKhhB8+t/DfkVEGtesTZInZHAL9ALZggM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELqHemJq7I72he3LyIMZbsDskcPNX5SM5cNsuxuSYXnrPVX72
	K5xb9RijqbosoKTYVGvrKNVt3FFEW0aQp5ZNWc2hqz+ADwx6dHp4Z58erq6XmGr9gCE=
X-Gm-Gg: ASbGncvReGmKujys5BGba1H/Qhq+kDz6KKZJWhwQdaLcFpa7iMfr9McuAUr9ZMajY1z
	aps7DixXalhLZaNkRVMBRp9k5DMhisQp91sJpVxHB726kkc3k1DHlIxRlyEZlFRGFFE3w9oTCHm
	oR8SfWgyOMYYTN2Hd30P/UgosgrqvCCYbxvsjWnEWKbHtAwC1JLnBoeKmaT84rNCZf8Kw6jTrFA
	rq+N+MZC+8wTDD6PJUnWifLBeUHaFKlfucRNZxyYWYVy5+7y7OtPtga5LoOrJuyU57yqNI4/5gB
	RjfccfBLLEbXgvXCoZKXTqJaUUsaFbQxPABH7rw/A5R3nCKdvdFeRb2ORmbKh6ZmaBBVKWF5ifG
	BBMqeOJHfmv14ewVXGmxaxTtpifldbk7hUqe8nH5CNPgjGmKc0cCnHVzz
X-Google-Smtp-Source: AGHT+IGCXvHRrsNi8uSiAOTe9UffqT7RO20w35INrfykrCAFAUlg3XH1XUBicPw26kJZzY09Jk9COA==
X-Received: by 2002:a05:6808:251a:b0:441:8f74:f2a with SMTP id 5614622812f47-4418f741c0bmr7787584b6e.52.1760479386738;
        Tue, 14 Oct 2025 15:03:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:13 -0500
Subject: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3744; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4CqVCZcygZWUEZQ30wthncfqjOostuEs/o8pgXKJiB0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7sh6BzPQljNleuRvHGy1T+//g8qgNkkcKEB7m
 t2x2s/6pxuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IegAKCRDCzCAB/wGP
 wFtUB/9dBUXIQU9ybm7B92Fho2l86h72tDmoH2+mQWM06nRRo13tlDzZ3P60vvjI70TPS5wwUCC
 WNwyJTo5eVpAAh9+TIlXegk+8sC77xSUAc7vmKCgfKn7vamIiXizC5cEfFXXrv0WBHPcsMz5UMQ
 9T735QHdr+wEau9l4S9YdycINg726ZCdjm2WECdnvKKK+2P70NMPi3gJVQ3/KHY+27+BaXCKA/K
 maJwkWwxR6xLywlPtD9s+yBJ1ZUapklb4KXKHq9anZxuAfmEFqOmq4g21HYfpVZapESx4DUMyIu
 LgBST6h8Td9uHSqHE3Hv1i8OWJkGRttY+iXO2N5IXm7c4ZFG
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new multi_bus_mode field to struct spi_transfer to allow
peripherals that support multiple SPI buses to be used with a single
SPI controller.

This requires both the peripheral and the controller to have multiple
serializers connected to separate data buses. It could also be used with
a single controller and multiple peripherals that are functioning as a
single logical device (similar to parallel memories).

The possible values for this field have the following semantics:

- SPI_MULTI_BUS_MODE_SINGLE: Only use the first bus. This means that it
    it is operating just like a conventional SPI bus. It is the default
    value so that existing drivers do not need to be modified.

    Example:
        tx_buf[0] = 0x88;

        struct spi_transfer xfer = {
            .tx_buf = tx_buf,
            .len = 1,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    > data bits >     peripheral
        ----------   ----------------   ----------
            SDO 0    0-0-0-1-0-0-0-1    SDI 0

- SPI_MULTI_BUS_MODE_MIRROR: Send a single data word over all of the
    buses at the same time. This only makes sense for writes and not
    for reads.

    Example:
        tx_buf[0] = 0x88;

        struct spi_transfer xfer = {
            .tx_buf = tx_buf,
            .len = 1,
            .multi_bus_mode = SPI_MULTI_BUS_MODE_MIRROR,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    > data bits >     peripheral
        ----------   ----------------   ----------
            SDO 0    0-0-0-1-0-0-0-1    SDI 0
            SDO 1    0-0-0-1-0-0-0-1    SDI 1

- SPI_MULTI_BUS_MODE_STRIPE: Send or receive two different data words at
    the same time, one on each bus.

    Example:
        struct spi_transfer xfer = {
            .rx_buf = rx_buf,
            .len = 2, /* must be multiple of number of buses */
            .multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE,
        };

        spi_sync_transfer(spi, &xfer, 1);

        controller    < data bits <     peripheral
        ----------   ----------------   ----------
            SDI 0    0-0-0-1-0-0-0-1    SDO 0
            SDI 1    1-0-0-0-1-0-0-0    SDO 1

        After the transfer, rx_buf[0] == 0x11 (word from SDO 0) and
        rx_buf[1] == 0x88 (word from SDO 1). If the transfer was longer,
        the data would continue in an alternating fashion.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/spi/spi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c314194d4e7e2b396795ece10e142118ca05f4eb..7d22ef5077d1229cac2574831f80092c591b972f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -976,6 +976,8 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @multi_bus_mode: How to serialize data on multiple buses. One of the
+ *      SPI_MULTI_BUS_MODE_* values.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1112,6 +1114,10 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
+	unsigned	multi_bus_mode: 2;
+#define SPI_MULTI_BUS_MODE_SINGLE	0 /* only use single bus */
+#define SPI_MULTI_BUS_MODE_STRIPE	1 /* one data word per bus */
+#define SPI_MULTI_BUS_MODE_MIRROR	2 /* same word sent on all buses */
 	unsigned	timestamped:1;
 	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

-- 
2.43.0


