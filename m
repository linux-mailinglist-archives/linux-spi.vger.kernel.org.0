Return-Path: <linux-spi+bounces-8839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF5AEC317
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7113A9DD0
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B3202C50;
	Fri, 27 Jun 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i+fZP0Xg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D612290095
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067686; cv=none; b=NWwqs+wjbITRCc43A9ZOrGLVhNTZDH/JkUB0z82JIF9ex3o4ECU8McxwELKxx9UzzOfUcf51nMZVLlSGZXKpEALNn6SoFJ0zIYuAC8yJGCKHM/zKQXQH9v2kX7NaOWMnPaEAQdcxf4ugV3xGUtAUb9eXTpdtf9uRZyqrJPUTyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067686; c=relaxed/simple;
	bh=KkL9nx6xWz75QC67um30E7FvAUyDCBFhbQGkrXNp2lQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s29FjYVr+we3vvU9ynVWEeAWY92oklxi10Vr+1jmzd3oeSh/Qp0NlJY8TH4nLkY8/bDZhdxRiGDfmWG3Q9YSYYovFtWj1wLL/Yt9NZt8er3H2JQpJMtBA/higP4D7RfyK9Qt3xAltWHHp6IljYl/nl+mUpHO2yr3vh75LA7osjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i+fZP0Xg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40af40aee93so1738394b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067683; x=1751672483; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZQeNbyi/XgTcIb18rAAtFT3uJWB9QoyLs3h9EjzCMc=;
        b=i+fZP0Xgsjgis39FJdpBf/x6KkXygHgYFQp3vhnFySdrlsBykJ0kE2b3ilZIm0uFSW
         MiR1tPEfvNUV1/EaMJoHDuFfmWGJ8NPT4Vnk1epnOXdcNlMbPrahJj9o9536ytTJmpqT
         UpLPYq5Sv7N98zaWYFJ8aaDAQlmlG+E8hEMPT0VnmuZIGy7s3Jm6SDODNbxCq/5mpnbm
         tktLG4dq4oFCgUNJI4tlc8Rm6CT5+T+pSEpisLXd1DDb+C/G5k6CmsfQXeRFnfKwa5Fm
         /thqpqW3Sala9JWSvEOR9OSp3qQVwxet9EUCOXeiztHYPmimCjJGjvqMzssNS6RxyypW
         NJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067683; x=1751672483;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZQeNbyi/XgTcIb18rAAtFT3uJWB9QoyLs3h9EjzCMc=;
        b=gWzCokasukMfLbTWT9RIrlH51vP0si2VbPkOmQ0dveq/Xp0za0yuIIrYwmR1LDQRl2
         GwFA4TbZ47xZtM6mkpvtfaMRQ9zWWx0Jq2tppX2kBbD/rasFl81Rjv4F4WngShIjx6iN
         OijFoGaQlH62KCN2zKuhvH2X5OZdBzb89cGGhCU8OqWJWY1O2FA2JmVoSYrmQHgFVKA0
         3qQyKYSO6Svem9oEU/j1BFigfvDT8OJlQVu+o0ozXnrWM10RZ0id0hC1EOFg4kmYfe7D
         oMpXbTtS0UjK3+e77EKNvwa5HX1CTbTKQ2Zu/JVrnR5/3mlRUS3BE39pbIm+LevqKXMQ
         ebUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMe5IiUmSbTEKi3FZjZhBhfDaQ1KjxezujRQStYSlgYsJsl4WuMDdmfW8xmxBeOyrVZ+OmoSxr2k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyda+hsx4c0/KoWt+tq4yakmwvDiqmH1U9cGYYsaHO5r87NkBXn
	4btXEfn/OmPNLYLCXr4EYXTadbmlc4Px5kSNGS/myZ71j6eGzyW0WhAdIFV63SpJYbQ=
X-Gm-Gg: ASbGnctVh2N5v2yJJPWKwwwZB3nI39GydXmtjhzIWUFrr4Pl7KCGEDOTqGuopkLcWzn
	3s6PfzzYzpkZNx9VshjzfLlcUkMLkPHW8demVymPwblGVEFvXd1kvAAAAirGYKJ+O/4pNVDIqgp
	okI48rVKO+JoFN19NTjDn12pBMDTRqiWi26l00sCcGQ4PALeMoFRts5iPYw6B5QWBt4p7mnz44S
	HbHFidu5P1HesfyQ96Izu3g73h/6rTMLKv3mqQZQaLbiokNdyf649P3D3++adB++hAAc7fW6mrk
	33AMHfj979NM6XxDe8NjnePmAJ+zDtCKl6AXLBtwq/zdP7EPYhXcGziFB9vruVAFBbY=
X-Google-Smtp-Source: AGHT+IFzfk6ekHC37qyVzvk3yU2SiXLTE+N1CJOvqAo+DeliXH0yV/vT1NpjyvcOKdpSKrsqxVX9jA==
X-Received: by 2002:a05:6808:1902:b0:40a:52f5:f2b7 with SMTP id 5614622812f47-40b33c66525mr3795849b6e.1.1751067683424;
        Fri, 27 Jun 2025 16:41:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/11] iio: adc: ad7173: add SPI offload support
Date: Fri, 27 Jun 2025 18:39:56 -0500
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwrX2gC/5WOQQ6CMBBFr0Jm7ZhStFVW3sO4KDDoJEBrW4iEc
 HcrnMDFZOb/5M/7CwTyTAHKbAFPEwe2QxLykEH9MsOTkJukQQp5FkoKZLZomjqNznWRVoPBMdq
 27axJ9+ic9RELaXJ9qZRSpoD0zHlq+bOB7o9de3qPiRd3EyoTCGvb9xzLbKBPxJ0pzvALvDhE6
 +et6JRviX87TTkKFFqpVsmrPhXiVpm548rTMXHhsa7rF2h3keQQAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2728; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KkL9nx6xWz75QC67um30E7FvAUyDCBFhbQGkrXNp2lQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvQzqD0E/s83E2RyYbH7oq5HqUJLp6sK/HOD
 sUWXJuG5yOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r0AAKCRDCzCAB/wGP
 wP1tB/sH/Hp5y05bPf0zRVQwcxJaB/l3H0wz85OJvDkJ+Xk8/av62XPhqS5X2Ww+MfrplFeIh0M
 Cknp+glzlLcv6Ch41S0KQ/KvkBaEdAbmskM/1wpoOHG9hQuMlLYr8w/fJJXf3lX8O5veVZG5U8Y
 nxU8XId1wYgvAr+9IumoiXB1gFQCcsKBkAiRtQswvZ76P5vQPzb9rvD+7di37UQ/7w8R46bly26
 n8ETMgpsIE8nA6U2cNzJQ1BmX8m6t7UM9CDgyPZJrLmkdqrqXWgJTLotUsryzaQ30YYRYeyIAaJ
 p6RRC/2nfOWYicDxiHEsFhfRPpaqvnjh1b9+2MwkErh7XnzJ
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
Changes in v2:
- New patch to fix overallocation of buffer size. [1/11]
- Also change int64_t to s64. [3/11]
- Fix typo in commit message. [4/11]
- Factor out scan_type to reduce line wraps. [4/11]
- New patch to clean up include more. [5/11]
- Duplicate comment about odd case of 24-bit data. [7/11]
- Fixed missing MODULE_IMPORT_NS() [10/11]
- Link to v1: https://lore.kernel.org/r/20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com

---
David Lechner (11):
      iio: adc: ad_sigma_delta: don't overallocate scan buffer
      iio: adc: ad_sigma_delta: sort includes
      iio: adc: ad_sigma_delta: use u8 instead of uint8_t
      iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
      iio: adc: ad_sigma_delta: audit included headers
      iio: adc: ad_sigma_delta: refactor setting read address
      iio: adc: ad_sigma_delta: use spi_optimize_message()
      dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
      spi: offload trigger: add ADI Util Sigma-Delta SPI driver
      iio: adc: ad_sigma_delta: add SPI offload support
      iio: adc: ad7173: add SPI offload support

 .../trigger-source/adi,util-sigma-delta-spi.yaml   |  49 ++++
 MAINTAINERS                                        |   7 +-
 drivers/iio/adc/ad7173.c                           |  13 +
 drivers/iio/adc/ad_sigma_delta.c                   | 294 +++++++++++++--------
 drivers/spi/Kconfig                                |   5 +
 drivers/spi/Makefile                               |   1 +
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c |  59 +++++
 include/linux/iio/adc/ad_sigma_delta.h             |  27 +-
 8 files changed, 341 insertions(+), 114 deletions(-)
---
base-commit: d02f330b0c78bcf76643fbb7d3215a58b181f829
change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


