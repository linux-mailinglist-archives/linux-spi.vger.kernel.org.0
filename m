Return-Path: <linux-spi+bounces-12304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A84D14884
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6394630590D4
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813137F0F3;
	Mon, 12 Jan 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HsQ7v0W7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77424397A
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240000; cv=none; b=AdCu484gaHbtlxZpQlKtmA3UjdyQ6jB0jrzIFdGVy7zLgD11+fqNkLAhCGqpS8IbXjMLMY+ahebKC6WfpPOP9c3Fr7698C1C13NorjzikKvWuXLrdKya+/8iLqzde9nQnx6UIZAX6/zk2TM8WOb32H3fc0vGtVLn1cuQdqQeFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240000; c=relaxed/simple;
	bh=HF+bpVOoavKKEiID/RQ+Z83xMg2SKTxpfDjYlJ/W1Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtcwqAPMyECGRkp5aDG7E1QCYDsHWLjGlCdQsSB1UIj3o/zKs+UUaBt82q8ZQFAaGNE4K71ByJG5hBGE7w7ffMK47MC7ykVYWBC2xQBtafIJ5FyqCy8yEAbGttzEa4tZxWYgUOgdH/KTYbBuzMMYh/cHmDhsSll0r2LXMgrcOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HsQ7v0W7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3f551ad50d1so2496904fac.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239995; x=1768844795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne4Oc3piCV35xap5V5Dxt0Rd9if75XR+emO/qCvC+Q0=;
        b=HsQ7v0W7LEVEhx4htknvYbEQKoBpBQXv1vELWRB5GBFNTEQbcKyNodfhIt7RwEl6Xd
         3r3+cZXFvS+Serbj0Qv/g7QNdz9XCwBW9ODeSve+RTS+m4J9r6PET8dhtrwqv2SKAfW+
         B5KADONhJCh5FJuwshkOXUv2hv8DAvSO7gZIASIQH+zkToWtQkggMz8OnYYCT9jWs4qR
         W2VYl8R4KOXSwDv1yqyecYZOqk3yhbnLfyhfiyGcXj8c9+D/FyEOcHocQidBmca1hULZ
         6lQaSVbtvYbYIOLOecU0nVKWVFT2079nlRUwQFW8zOumfpja+wX1Y5+mIk/QNThq30Ah
         2cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239995; x=1768844795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ne4Oc3piCV35xap5V5Dxt0Rd9if75XR+emO/qCvC+Q0=;
        b=LBE5Nyq0Fkj1Y3fdsS9lLBf/62U3NBl7UV1fCLwsjINB4IwOzVIKkPwRhgNDbZ9X77
         xQeHZBp20/cXZ0JnJe0/ACQqvkf4qBoTQeZNsfBZHBrFawW4s0l8+PJ/HXmUVWFTL/QV
         +sa7L49pWH9f90aqC3mq4UKkg8l8Q0/XEzHoS2P/L0tcYc7TSkW5uf/dNr7KHXJ2bMnx
         hOFPNMceE2owEirolpKkKiNInPqmsiWsg9UJ+0yaPSYicm32y+e9Dp6HThRTKK8sMM0h
         pdspcN+qaTwgyG6mzRD5yDF4iFWc1Lpfzt69ee2GO1gOjAX/rKdY4ww3kJYj9GYA7gtl
         IEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDVgZlPqo3hY/FPbYaaFHyAaQQoBmf3z09VwfFRVdbpnTRJWRLhUmIHevosxbOeyAbBsLIVeIcEKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqzpagn6YWu7G2EGjBKoMPyH53+4sKhskjmhIA1nPltiVIDGO0
	K3XAj3AjvUXmfYtLddI6HJDpjJEKkglANdD28ipdVlUt53egTruiMsTfa520sjmuBh0=
X-Gm-Gg: AY/fxX6suW1A1yj87zmemE5rywPbklL1ZV1QKQ7nyNcc6gUaZ8kAdeObZFL3euET37L
	iU7Apms/jpLcd90LvR+lxG5ixPedoSSMeFaHJif+CEi/HoLQTmckW3XxVfcDDqNos+SVpNaP6GL
	jabKOYl/3VHXQC9YmqUE8x/wc4w9VfZamwN4up6PN3tuV13FxC1QtTQDUuJl3xnwMR1jYPY8S+W
	iyKs805M6v+p/zWbGG/9ki1FuYba6Zw+qfBiv4xJ2hcFgkpIoqEEyM8LS8pmuWnMus1WfCC9H4D
	o50Xgg9MLN8N1v0ZQVSAv1vQAoJD1ayRDToMZxxVHZiVyAoShFFN3wKAd+fnJFEgTSW1gY1ftXN
	su6vntOAN7Ww5URe/MB9rVoeCcQ9v0Foj14rWoZWI8c/RnxJck+BR5oEg4AYCHpICQzIo1g/MWE
	QgZkyuESlQ7CrpnwkksX2Oy1KY2g==
X-Google-Smtp-Source: AGHT+IFByKJyG/d5d4Pl79At+/4moJFdoo/+PNOzP5lXpwfeiLqeooV9dyhB4pCFEwEX8R3y0jxXeg==
X-Received: by 2002:a05:6871:c8e8:b0:3e8:9cd1:d626 with SMTP id 586e51a60fabf-3ffc0af6833mr10176141fac.32.1768239994478;
        Mon, 12 Jan 2026 09:46:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:22 -0600
Subject: [PATCH v5 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-4-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HF+bpVOoavKKEiID/RQ+Z83xMg2SKTxpfDjYlJ/W1Xc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNL2kNENIiGziFk8m2inVQdpDGqRJV+Dh/eW
 cFD1KwQp2uJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzSwAKCRDCzCAB/wGP
 wFkaCACPQYpZt37VSu9PqAeAH8yolD2PDRc4ZdROBOIn2vjcl2HqsVV/SURn7IiN9iVtv0Fp1+/
 zW1YZrq20FqHqLen6Xli0vycxJigzKdbox/GYnp3QpN/y2CU02Uay2ds3r0hAII+2Uhg3xETQQT
 t2qpIPzR1T9dkOrGmWfzCMQvyF8+8jJMVgsVa59ZT11KWqPlgYnRhoOxYRfuSCAbcN3ZI+QncQv
 TU5KsoSf3KURnV5TmW8Qoixju/9QUIv76Ty/udKqoqC6hS+tgpqbvf5iJWAh/qFZp1TLR8JxQy8
 QKceW2BNrDWnWCMvwIAdYvaxHleLg6X3GlE4a0HLxsBieZoE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new multi_lane_mode field to struct spi_transfer to allow
peripherals that support multiple SPI lanes to be used with a single
SPI controller.

This requires both the peripheral and the controller to have multiple
serializers connected to separate data lanes. It could also be used with
a single controller and multiple peripherals that are functioning as a
single logical device (similar to parallel memories).

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Shortened commit message (useful info will be in docs instead).
* Added whitespace to create clear grouping of macros and the field.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 include/linux/spi/spi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7aff60ab257e..eba7ae8466ac 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -981,6 +981,8 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @multi_lane_mode: How to serialize data on multiple lanes. One of the
+ *      SPI_MULTI_LANE_MODE_* values.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1117,6 +1119,12 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
+
+#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
+#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
+#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
+	unsigned	multi_lane_mode: 2;
+
 	unsigned	timestamped:1;
 	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

-- 
2.43.0


