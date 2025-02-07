Return-Path: <linux-spi+bounces-6674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB6A2CDD6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808B13AD2E8
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0419F422;
	Fri,  7 Feb 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UIusOfQF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF551DF269
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958997; cv=none; b=eWYj52a3lobrDt0C2BG5/h7l0Dg6eOuW1mtn0AaVCSizybLoKmUTtkzOtb/ezfi6lGGNrAWfCbX6gRWSLwJMos7DVQI2yKyWa+fmsY8qB0KRvC/PVAbOF3t2WhIFE0HUKh1X+Fzs0RAusu689zOqMGbXXG9v+uBnbFd0iMUJThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958997; c=relaxed/simple;
	bh=DhX51StZjS6ZG3+/IYLjnj3db6LuckpDYDUdYX9k1yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ragHqbLS2lnyx4E12kir1JDIoqnOObdA1QqIPDWhAdPHDF2mD5jSFTsiZtbhKmm9yb+hQszBFP2pbsDSVx3StSipYtYX3m5hQ/UivxOhhI1Pn1onJA7MsM0mSd97RGlomSvUfLJfKQQg9DgdUQlwfGfc8JtJpcySmHbg34rJGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UIusOfQF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f6b65c89c4so630878eaf.2
        for <linux-spi@vger.kernel.org>; Fri, 07 Feb 2025 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958994; x=1739563794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=UIusOfQFpbY0NZvz5tAJ9fg8VlI6XO5rYeDpZsnIEI1hMh/11Fnm2tAsTds3HbjQWt
         m25ljZfwm3dwa1Ak8jrt/ywVI+R0kCULi1DBT5+T04Jx9wGklL1g4FIlHUbnpnBeFhVO
         EPXFfVOpQtIqPI7hFU/Mzcz+rLRUTHGVfTMs6UT+C2tsuiS/ymBIFtSA3ZwBCj3YOFNX
         q2nzi7fspti4uM7BnoJqUluIeJ6gnQB/5xg5H9sU5lLuLG430EEvx5Ln6YbjPHicFd0k
         dD3VRZAGH4dXbxjywOhHWWrxPQLxBs1imrTA16DJoDO0z9OAY4MEziEaHHftWV2E7Bv4
         hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958994; x=1739563794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=kGJ2HvFd4CMHXJsgeOOPfYITosJgFEogaUGJnW/dS95RbkpDvpj4dIW1C+CPlTn+UJ
         f/dq1tC7QH4mxmC6Y/tY9NLbTeKOQq9wmfANTzsO6OkKDIsY+D9ArbHqS5o1CCmxTeC6
         fgyCdTGcIbD+E8hQqg/CSAq1nBbl53sy/5iYF9KLbGgltPgrcLGiIbr4GJ7QcMUEm9CH
         +MNqar9SHl1AXkZl6xMxiQ2W5Etz/YndTBAEFD14QMskC0QpwvqFDQQi7rtZPLxeL7hB
         QSvvuDH9CYXWPjcCEQcHTxQ8nlDEjEVjVJQDngBlRIw53pO8knmaEHiJf+2g6ZpPky/f
         dfNw==
X-Forwarded-Encrypted: i=1; AJvYcCWcD2gCNyFDcHpMmWq9s902Xc/8soM0bNqA5S6yVuIUw59wJf4goaFjY3YXShuFb0YFplIJWjLJJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbU/6wjphwYzVSt2SUNByAaEx6qQzfJNTr7fiqOCdUE6EnDkDJ
	f3y77F/hTV+vPvtY4Ara6YmtGDBgplFSspiq1flMvVvea2Jt60FSidl6jjKBIQE=
X-Gm-Gg: ASbGncsxMWRA+JKy4FOLi4XnOPtUb5qABrYVpq9OaPDab660KqsR71ZYDlSdzN4u7jk
	E+IaDWzI40xJuqN8w/3MjTeoFG7jJcLyhOrWvw+LU47TRxUlmDkdQebYA4dgsyciooZZzR/YhMc
	iAboDg0a0VUtRsPHMPrmY4kNpIVc8JAK0x0tE/UbgvsvasTHwYNlm406pFHsa0LL4cS8dBaXGdq
	Y4dc2mSED98NUPEIATwziXD4Zo0Y68sp21e59c4NgT7tp3+yv89fapLH5Hxkr48x1XUqT4qKk7u
	8kb0aoLr6u1CIoa3ESP9jCSmYih3BZMgT44Okh9kwA0ukoU=
X-Google-Smtp-Source: AGHT+IHBvhoA/1vsHrBvSb8E+WSGvN4wz1yxpemeyG9bRp8GQ1qD6XCZmUkIVAeGNsD1uexoiKGc/Q==
X-Received: by 2002:a05:6820:80c:b0:5f3:4175:1d7f with SMTP id 006d021491bc7-5fc5e75e777mr2414422eaf.8.1738958994116;
        Fri, 07 Feb 2025 12:09:54 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:12 -0600
Subject: [PATCH v8 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-15-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
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


