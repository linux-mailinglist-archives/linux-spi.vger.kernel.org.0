Return-Path: <linux-spi+bounces-8964-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D3AF05AB
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75011C0734A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C95302079;
	Tue,  1 Jul 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ANanGD/2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA415266576
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405975; cv=none; b=fK+mYDLYZlZ9+9zT70WPVW/Uo9+2W4PyewHZkH+E8cTBrVrOkZxLfUK2rPRptr64C8K1Y7pqR1v2vjWG3lv5H8PREHW/r1lpvapmZmkws0D3MgQeDUY1+CDS9dpO36AfqUfCFg5YSFBGZRmOfpDvVQQBW2o9hA5GnjkqIe+8yCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405975; c=relaxed/simple;
	bh=VxYROUM2GfmJ/KXDwxe8XCPoe5O2XiSmt5z/jZcbr3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W/ifyn4gRZXAwXpm4yomlG24keTDo443OTIFpW4pby+N76cCOYsXTMIJoG44hX9BV35GI55b5qnA741n/klBg1IgOlfCXPxYCEtQn8uAxzrfGaU7KeNalyOdH7GsXFYKU47mZOaFFkcfyD7XiQ9AwGBS37sof1qIwI2HS/xU3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ANanGD/2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4080548891fso2153538b6e.3
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405971; x=1752010771; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhZPY2wdf4iLhO1Z5AiYBhsJE4q+NPXvJ5l9xNX680M=;
        b=ANanGD/2CPOtDOWa9dJlBvDj0Ia856+R4cb3N3r7ond96Nj610Nd/VzOBMEuFqRwVw
         RMoes33uq/AFLKfXnNQTUYr37eQxm1AC17QImVxR6iUVM5wRf8J+3f5BH8E+EM+vMW4H
         5gMXMScKFA7TC1919ai+U7OBbzpLtsi3HSIqQzum+O7Zfq/gIC0TOtNH0mtRwdEn8UMh
         Cl8335zl0eZOL5CWqU96a4+cvJIxym51EOdH1IeJHlgQE3uQv594dpit4fowiRtiHErT
         FZSIw7MyyRYvOZiIVxf49fmsJqmNIzgIgP85AQl3qlybSJ1jh2MtSv0YaKA1ZCzoSjhM
         XUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405971; x=1752010771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhZPY2wdf4iLhO1Z5AiYBhsJE4q+NPXvJ5l9xNX680M=;
        b=vE/lEqORbBu7d9gdvQl61JVca++Mc7FVZlfkjLjucQAxjiI5DQ/FB4NvUF3L33aBmC
         QzC9xz3Lo2/Qg8MydY1jUJFZHKnJjlu3YRNG/CHDiIsk31IJjvISZC++eSA1x4NjSPyg
         VTTpweArj3/r2t2mCg9UYZkJURs1huZdAIdpJ1//F7Zdt5EZ8AB7xn5mhuc5xw3zuWUX
         9uJ3wg4qx0jk+5xhIjgIjVqksUB8Kma5TGP5BzyIiiPdc9enJfcu2WNZirZ+qcifNr49
         WwTXeispL59UKiCtqRU6ZVd0cH5jUS1AWI+d8i1Y2MQwo3PKXPnbUpo2PeGQUElBrIlW
         jgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUzTyrr+fwbwYcakIIF/5+Nqy/c6MWxukXNUvcYiFGkH2V+YIC/gqmcQW7z4lHvJm129SpTYu7BE94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXxkEnMKXDLW4IL4bIa5c6cGfTde44lSyR3cQsEKqRmfdGMLo
	6FUZ5tddsuznNqg2hTS1+gd7XjNejiJf3da+jRuNQOryp1lbLNz+XF5brUmAHpEsHsc=
X-Gm-Gg: ASbGnctichqaRvCzd84rysghG+a+pUZaQjOlC6HhBi4VmsLiW8LLuKqufKL1JIWtKgU
	YLOrUch4kluzIpnemXs23/yygRVz0jTmuMSzowUsPanFuiMAWz0ekrXHypaLjBpX8xm/Q4vbnBt
	XEw5lop/I9HLqbFkaJuKGzQnKbHbZTiD+yUFHKUmn//nuLp5Tcp2yY05D69DQSSztSrPtfj9uH/
	d0E6/FlJg0Sg6z1k3I8YBl4NiY4QrlJkSjHdfDN9sECXd9JMCOMMWZknp06bxUjqpmmyNHzQzvM
	I8V8E8bCdi/ZVzYHRUQo+XD5kkOVIoqk4x1EjQDTin5aPtJ8mxOMZDtXl+SUHqrdiSF8
X-Google-Smtp-Source: AGHT+IEmIlyTP9bN5FcZOGUVizFGWHz30kCL8m/3oyY91aEG/xyVWS8vK2c7mTxX1xDiOK9rPl6j2A==
X-Received: by 2002:a05:6808:bcd:b0:40b:1597:b2d1 with SMTP id 5614622812f47-40b88798a87mr254209b6e.17.1751405970662;
        Tue, 01 Jul 2025 14:39:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 00/12] iio: adc: ad7173: add SPI offload support
Date: Tue, 01 Jul 2025 16:37:48 -0500
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxVZGgC/5WOPW7DMAxGr2JoDgP9RFKcqfcoOsg21RBILFdSj
 ASB717WXoJO7UCQHwG+x6comAmLODVPkXGmQmnkYHaN6M9h/ESggbPQUlvptASiBGHoubzyhts
 AZSJIMV5S4Pk2TSlXMDoof+ycc8EIhk0ZI91X0fvHljN+3dhXt6XoQkHo0/VK9dSMeK+wOaUVP
 wdnKjXlx/rorNaL//40K5AgvXPR6dYfjHzrwuNCXcY9e1fLrF/J/s9kzeR4aHtrbdsqZX6Rl2X
 5BtiZwhZqAQAA
X-Change-ID: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VxYROUM2GfmJ/KXDwxe8XCPoe5O2XiSmt5z/jZcbr3M=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFU0eriObLuCHhRkzBiZdtTzSKJ84cqD8X+HT
 VCZuuW6AY6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVNAAKCRDCzCAB/wGP
 wJ5JB/9wNv/tkmGqHpQE0xdU0nKNPjt5uVZZSRpYMwVniV7Bgoqplhyejh5v798/ScFEMUwcEYq
 h7aLymK9ZBWobXWBfPbJPheF9klRDCsOhaYRcUURuqQL4718tnqn6hyjxJjW3CXKLBSK/Ef/0x1
 5GkmpAIBkpYsGDmLaoA7qqEfHV486yiKA9K/IECYmrqMOkw+9YUBLd/6LbR5X8q3zbD1zGfDsvq
 suIYqmbcxmDjewYiC81WPnGDdVLbHnAKgQB3lNxJaOhHiz/wd7M4nywrcnJQ0WFek3tbuOntqH1
 OckR7WOWS6YVwvmtX2ZgWF2mbnbyNWecno2qDinrbSrC3G0P
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
Changes in v3:
- Added extra patch to replace 8 with sizeof(s64) in ALIGN() [4/12]
- Fixed typo in commit message. [6/12]
- Fixed includes in spi offload trigger driver. [10/12]
- Link to v2: https://lore.kernel.org/r/20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com

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
David Lechner (12):
      iio: adc: ad_sigma_delta: don't overallocate scan buffer
      iio: adc: ad_sigma_delta: sort includes
      iio: adc: ad_sigma_delta: use u8 instead of uint8_t
      iio: adc: ad_sigma_delta: use sizeof() in ALIGN()
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
 drivers/iio/adc/ad_sigma_delta.c                   | 295 +++++++++++++--------
 drivers/spi/Kconfig                                |   5 +
 drivers/spi/Makefile                               |   1 +
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c |  62 +++++
 include/linux/iio/adc/ad_sigma_delta.h             |  27 +-
 8 files changed, 345 insertions(+), 114 deletions(-)
---
base-commit: d02f330b0c78bcf76643fbb7d3215a58b181f829
change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


