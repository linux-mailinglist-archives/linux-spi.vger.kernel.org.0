Return-Path: <linux-spi+bounces-6348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38EA0C32F
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A1B166AE8
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D151FBCBD;
	Mon, 13 Jan 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oO8oVVzk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53C1FA827
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802075; cv=none; b=j7YMCyrg0PCZxv4NpL7lMAqReIgLYM/P5VlIBbCn3vK2Etrdwon65RkcZ/ElYF3+JG62CvYpaXlxVtcRX8u2hcXzfW/fA2p8KVJM49Uc1uPOw7IGIPOThzOSmyemG1v3xkpEUUXeFb47ZfCeKQp8E1lspV4s2BLxuKhWjhVt9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802075; c=relaxed/simple;
	bh=DhX51StZjS6ZG3+/IYLjnj3db6LuckpDYDUdYX9k1yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsChhZMSwfWHmxihdXHHXF15teGqLnK7V/WnxXU7MNtE2l0vQMObRDmhIg6RgMj5uX1LT4ljtFwl0Pr+4H+a6VCCFOBJLgGyUA7GSElLZG3/8dJENcUxCgcuXbKSPhBpa0CUpBt580PIltqw5fntfP3DBuwYeYwUfnWOCm88diA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oO8oVVzk; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3284f963so2442171a34.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802069; x=1737406869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=oO8oVVzkgh/3DbqDs4SG4VVOS4uI+OBm5VGglyfYJX0R42kcxpc2GCknp5c/2qWI2/
         sEN3OE3EQKcokewCpz1Mf8OGnvMt+nLhikf4CYbMbJCdreNJpH1ySgq27ioaYowtp1jB
         dorfejL39eBJkAB4wHhITwrlkCz/ksL6PWY9ODrC/DOhtyWyHUhIIjy6nqB9KSkzi8bx
         hRG322g04gTXwnrNI8C8C7qv8xCIFywYxouRWQBFiXsQq7qYEILwTQe5VMAg6r/fyp1M
         T5onHXNLtdl8o9yzC+Hlx8Gu3DllHKhU943AlXnAQ3eD4h58W8Opb7MoY204C+w3eXLC
         ABlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802069; x=1737406869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=dJGHkBD8s06GbNdPqVhcqDnHzcPZCCrRktRgWfj/MJck0y4Xkg/9FL7RsnMTw0GoOT
         0H911kXSFQkzusot6iDqljiizp+MAUTOvx/bcisjX/gQ0zdt40ZH4I40O0riXQAzGkLh
         I9r2ClrOZQauytuTlRGiaagV5qfScULYfZBP2wTYpyAbTuPWf5XniMtU/Kg11N+/0I6/
         Ns1uTq79BtCjkMKzcZRph6QpJuRj+pRJI9qbwddWAzPvUVeTfbz9NH4dIW5YU+P/8Vji
         1JmZIl4wSoHsCO/+EZl7TfaeU540HfxGk1hespu0W7CwBnYQ9S2JDFewPpbJfIO9nAfm
         qCNw==
X-Forwarded-Encrypted: i=1; AJvYcCWfV+d3Wog8vVX7a1JRjtFsA4NrY4vWs4ZkaGsJGDrYTQUHY1IKWsrc1NR88rk4GyPt9mBMst7obg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEynmkwpP0IACtNilf+7HcJw/nz/aqpi/lc3MSKUTzLHSsna1Y
	JHNKZ4buOKceIExcEB+ffG7JNbRGcTPefhpg5eP1cO4YYpHVfqysk9vZ9jUL6Xc=
X-Gm-Gg: ASbGnctC92TwSVlxewpWCh3HDuoNXg9XMktLaimgLFrrmh7PxjHzHekDcb9O9eMZSBc
	ddKfS/tzhVDGJH7uULoLDDSkjud5+T9ZGQ/VqEvcG7oT7nItUhZVx+1DFotyr2IeLKLf0XwMEhZ
	pEdqlWbT8znyq1uSIjF9jPMLf38MHycAEIkHLi6gM1xOXhYId6DuoWWnPW4qx+/zchk8/UtSkbV
	jRXtSM+biI/6XOBKXhA/7GSMpS+bRjrEExs5jXNnPZ0JfOVuQIcKn0Sxd9vSc72dSkGLAp1vZRM
	vU82IlTiJM+4
X-Google-Smtp-Source: AGHT+IGulA4qmDQ8WGRs1VyQjDXlPbYFho/RM3G2U9CehZxAyN2Da3u9SYC//Ca05O7nTL9Ydwk4QA==
X-Received: by 2002:a05:6830:2a9f:b0:71d:fa78:a5e7 with SMTP id 46e09a7af769-721e2cccb60mr16384875a34.0.1736802069599;
        Mon, 13 Jan 2025 13:01:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:20 -0600
Subject: [PATCH v7 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-15-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Fixed double "all"
* Don't abbreviate "sampling_frequency" attribute names for clarity.

v5 changes: new patch in v5
---
 Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 9ec8bf466c15bf94cbae2ebdb61875f66af1264f..ead0faadff4b5aede2a34bac52e103e375da6f21 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
 To use this mode, in the device tree, omit the ``cnv-gpios`` and
 ``spi-rx-bus-width`` properties.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+When used with a SPI offload, the supported wiring configuration is:
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |    GP0/BUSY |-------->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    |             |         |             |
+    |             |         +-------------+
+    |         CNV |<-----+--| PWM         |
+    |             |      +--| GPIO        |
+    +-------------+         +-------------+
+
+In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
+The ``#trigger-source-cells = <2>`` property is also required to connect back
+to the SPI offload. The SPI offload will have ``trigger-sources`` property
+with cells to indicate the busy signal and which GPx pin is used, e.g
+``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
+
+.. seealso:: `SPI offload support`_
+
 Channel configuration
 ---------------------
 
@@ -158,6 +188,27 @@ Unimplemented features
 - GPIO support
 - CRC support
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
+
+.. seealso:: `SPI offload wiring`_
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0_type`` attribute.
+
 Device buffers
 ==============
 
@@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
 sequencer" feature of the chip to trigger a burst of conversions.
 
 Also see :doc:`iio_devbuf` for more general information.
+
+Effective sample rate for buffered reads
+----------------------------------------
+
+When SPI offload is not used, the sample rate is determined by the trigger that
+is manually configured in userspace. All enabled channels will be read in a
+burst when the trigger is received.
+
+When SPI offload is used, the sample rate is configured per channel. All
+channels will have the same rate, so only one ``in_voltageY_sampling_frequency``
+attribute needs to be set. Since this rate determines the delay between each
+individual conversion, the effective sample rate for each sample is actually
+the sum of the periods of each enabled channel in a buffered read. In other
+words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
+divided by the number of enabled channels. So if 4 channels are enabled, with
+the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
+sample rate is 250 kHz.

-- 
2.43.0


