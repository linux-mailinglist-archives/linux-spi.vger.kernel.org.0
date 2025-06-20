Return-Path: <linux-spi+bounces-8691-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99BAE258A
	for <lists+linux-spi@lfdr.de>; Sat, 21 Jun 2025 00:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5393A78AC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A323E346;
	Fri, 20 Jun 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GIF1FiK1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECE23E32D
	for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458085; cv=none; b=F/8N1IPGA9FDQptaipRssydLHtjmzHNeOdGJtdY4FMFim649LCKbIivG5wRm/758Dj4wWLzo9hV0Q+eqd6hMcAOIdbsiV+zbcjgiDSL2qASfpxRe4j31u7Rw7rcrmDn9L17jOAwubr8vdedr1ur7VleGSgWbz0+2jLBY3l+F/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458085; c=relaxed/simple;
	bh=vVDOA4sZGcugRpefiICW8+34bR/a/+ZbrGgJnmbrQc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=npUc4/sDAAeZ3f4W4M0o8btAUw361S5sA2TmoJDnoHlpZitzWT3YRBgDTMx+wIKJ2tBsZlKto+6YTFQWd8SFHnjo9ckr8iZ08mDhORCs52OaGr8zZGo20Qz0CJgft6QjNefZ8RTTd1JPjowWJpFxnBm9QDa13WaG7mLVcNl11mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GIF1FiK1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6113f0cafb2so1232094eaf.1
        for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458080; x=1751062880; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnoWbL9TACCNhDK9xUx+88BoeMpitd1subnhXAJpw30=;
        b=GIF1FiK10eYBo6H2UG1AHfoaxkd6T6rQbg3PjfpqmPT9Wm0Uria1yqU0m4FATCJZou
         cWKEumktX/qs542qeBlf1iNUeGqVGZAYJlZEdfu0OE3Q0ViZGDICWgbIquXiYmiTHJFS
         6CV2K5E8EWNF22X6RZzCUH3BRGZYE1Mz/+dBoksAKxePzNi/HmV5Ms1jE6huIUIH0Wl+
         /FERCdfmANRZ7iNRgsL1SyuI8DyINfVsLHy3jZNewlEAiylEIM2t7zoZJg30O5piydOG
         osLJam6SElDcT4p3Hy7af29yEgj4P80CghJOgdSNO54wI2T1NJYdK3qzY0xVXZpFs4g8
         NWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458080; x=1751062880;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnoWbL9TACCNhDK9xUx+88BoeMpitd1subnhXAJpw30=;
        b=sfbfTdvSyasxngxLUfiXB2+V5X8tyyji5AnXe1IZeUwPEiTmfD7U6ahfLdf2XJZnaP
         pOGvFdlfMmNnaBQ32EsiSR5zcuOnw6mRrhKp0vQB0+4MCDP5ZqMXUoyx0AFDhWA5AlQm
         vMYcxg49+2Z/HbfFhTeoOKax1BxyjF3zBzD51i/vX5HLNOKq4tyRS5cNHHXPeffTZ+Jd
         0+HHqljlYo2L6JSeAeLtGaNrY1cDWX3zjn3qZnI6srzC3/hqRjFhR5Iv1QlGbS60w2J6
         LhD+hQsBiHclAJJ9V/UAaua5FUbbpnWXzdbqFxgNLvHY2hGuVWneQi3Xak9Ipi8iJDBu
         mZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/hpZAG33oQV1PWPQGBvm5guMK2dJ9V61Fmsb1+6y2SvLPz3IIQOLmi/ZJP37R4F7DjnLdu5OY6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1hiUB1LDtEIipffTFrINHRJqX4WsP7frYzdw00TVhZ4q5eRU
	U0KwxhIfvhDZHk95f06yRMI2/WscNmopPIQ0Zv3BDzUYO3RIdG7hrUupqEeBCTaUa2M=
X-Gm-Gg: ASbGncvgpqsMaoT+yedrqYGu1gh1vbk7ZSYlsuZuJ6k3zlflPLSXCOr99raPSN/aBW9
	FBYJOjAZpbdNS9oEBoqPUJWxna7ZCm0JpVtqeiANmutyXl2lmffkYcxonRkdUiAir25ylxxF/7k
	VSpem2xkMRD0aUftoq0WFR/frumBjkUVjSMXirvV20bSNPVioWOYIrbkM0+C3/4+DN/EaRqJrt4
	KuRUdet608PrMfB2FI5bEDAqEVlHr3ZXvKqkH0bqYupB0U42tUwcf0BwcckZ1Vq2/WqwtAqeaPK
	56akQwHFBht8oNTkdz7fCyGaOLRRVaiBG5+cWOiIw6Sb3LpcpCfWZtAdfYAlbFwy/iiH
X-Google-Smtp-Source: AGHT+IHkTikpQuDj9PrDQbT93iaWgnTsK9tNVi2euCxupUEhaUXbbEmdqU7CyKKsoAEt4Ih15q9KuA==
X-Received: by 2002:a05:6871:7287:b0:2c2:d2b8:e179 with SMTP id 586e51a60fabf-2eeda503eb1mr3907370fac.4.1750458080484;
        Fri, 20 Jun 2025 15:21:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/9] iio: adc: ad7173: add SPI offload support
Date: Fri, 20 Jun 2025 17:20:06 -0500
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbeVWgC/yWNQQqDMBBFryKz7kASMSlepbiIZmwHqkmTWATx7
 h3qYvjz/uK/AwplpgJ9c0CmLxeOq4C+NTC9/Pok5CAMRplOWaOQOaIPk5zTrpUIWBJjnOd39PJ
 vKcVcsTVeu/torfUtyFjKNPP+Fz2GizN9NvHVq4TRF8IpLgvXvllpr3g5VQfDef4A9F3IIqkAA
 AA=
X-Change-ID: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=vVDOA4sZGcugRpefiICW8+34bR/a/+ZbrGgJnmbrQc4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd6ccHt5opDnwzqD7X47mzjQNTTXgUlbBycN7
 2/akJOTiEWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXenAAKCRDCzCAB/wGP
 wEMLB/wMEb7Dmzk8reprmZqPVXSc2NrTVvvDc2tkK5otrsFDRmw0uWuDPj+OyaqHeoUjTNsjfyP
 P+1Jki+TmRbv7iKl3mZgMH6u6B5oMjovISPcfhl4fhuaddPntAYl3oF4wnEupKvtTz3ueAC9xRM
 PVicwTt5OBxAiv7SnHfdmbFgOuuQJzg3bNPvCMyaBzJmxraC8U4PIP9mkudYIeBtvMXcUw6p5/i
 6CgIPKLaUTFCMw3bKF6ci4C9cf4lvFUfAqCKjiHmir4fXvAx8x6wEWgXQ3GywxlBt7FFSpFClUB
 PhtBjY6oyjCIh4SQ+eq4JmQyyv/MNWrzTzDxQU5dfYI0RxlI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Here comes another series for adding SPI offload support to an ADC.

The primary target is AD411x, but since this uses the ad_sigma_delta
shared module, a lot of this series is focused on that.

To start with, we have some cleanups to the ad_sigma_delta code, so feel
free to pick these up as they are ready as they generally stand on their
own.

Then before adding proper SPI offload support, we make use of
spi_optimize_message() to reduce CPU usage of all users of this driver
during buffered reads.

Also there is a new dt-binding and driver for a special SPI offload
trigger FPGA IP core that is used in this particular setup.

Then finally actual SPI offload support is added to the ad_sigma_delta
module and the ad7173 driver.

This was tested using EVAL-AD4112ARDZ on a DE10-Nano.

---
David Lechner (9):
      iio: adc: ad_sigma_delta: sort includes
      iio: adc: ad_sigma_delta: use u8 instead of uint8_t
      iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
      iio: adc: ad_sigma_delta: refactor setting read address
      iio: adc: ad_sigma_delta: use spi_optimize_message()
      dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
      spi: offload trigger: add ADI Util Sigma-Delta SPI driver
      iio: adc: ad_sigma_delta: add SPI offload support
      iio: adc: ad7173: add SPI offload support

 .../trigger-source/adi,util-sigma-delta-spi.yaml   |  49 ++++
 MAINTAINERS                                        |   7 +-
 drivers/iio/adc/ad7173.c                           |  13 +
 drivers/iio/adc/ad_sigma_delta.c                   | 281 +++++++++++++--------
 drivers/spi/Kconfig                                |   5 +
 drivers/spi/Makefile                               |   1 +
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c |  59 +++++
 include/linux/iio/adc/ad_sigma_delta.h             |  27 +-
 8 files changed, 330 insertions(+), 112 deletions(-)
---
base-commit: d02f330b0c78bcf76643fbb7d3215a58b181f829
change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


