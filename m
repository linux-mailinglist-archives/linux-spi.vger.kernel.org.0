Return-Path: <linux-spi+bounces-6671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCDA2CDC6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77420169475
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077531DE4FE;
	Fri,  7 Feb 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c/xQHjKJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005C1DE2CF
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958990; cv=none; b=I+fL5RjHMFoPV9gIPzm9mTt8NPbl+pG2gGWbHMcoNAkwbzpbmWD7QZvVoUmZX9KwWH+cRidCpDBiHHpN6aFNnimz+NkrrzEEZqhZLlyWZN+eR/rV9edBEITZTJcznQSx9TUfj0jRA/SBvTg3C48wMMzVmBNK1AyQwLFCYIADNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958990; c=relaxed/simple;
	bh=jRlTs2hPxFTMWzXud2pwyf/gDJQZpce7x7Xes5PCDq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onrzUbtY3Atu+4sgWjcGPC76DnHkPF57MsSC4FiV2UHc6IHWBwcI0SExC9NVhoOC8xk6rc+C1YL1riOx+GKVDiKf2/ATmvP8qPS2/ySg+4IA9DO/2YqAZb1zqqIM3hHEauj114lbneqNCviy9lqyKzxqfeOdY0iI0sBLwVuQMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c/xQHjKJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2efbc31deso1410236eaf.3
        for <linux-spi@vger.kernel.org>; Fri, 07 Feb 2025 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958988; x=1739563788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=c/xQHjKJuastuL7F4tSshhnKVOt8W5fYRMSzu1kwH8f1mcBTUTV+/CqgYIjyPhbEk8
         iyETe7xmqVbt3gFqi+cy9posN6t4MSxXkHVAqwE2ZND+0quXlkijyz63XB4yprJdgpjs
         hZXD3queVLzUTqNb7KxCVLSiYlyrDtU4QylpE0GrxiUhILKU3o2LTr0z4bBzTLe7Wkd0
         LN+bK9OGbDwMc559RsNj3wS6cHHzO1c5yM7kV9R5MkPkL5IWyAbwX2ky5rRuiQApnYsH
         1c1mnVo3mRkuayv4+rwjhc6OczSo0GGFPG5BQqM+HkUYtIq1J9yqxRjJZr9wESEwGS01
         w33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958988; x=1739563788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4qOy1E2SWXTRLQzjAjoUUpkXvVJq7HeawRi11wv1CQ=;
        b=Xf8s71T/XN+/lXjPcvM+dAcNjXecVJ5Wb3YIY3rE/mixVnSrQzKKBGrsEFCWQqz/iE
         tGNGEtp9EgabCXWm7w5R0UNFv0urfogC2NjIDXnnC/CiuRqqUalRIbfk6aYfrwXLW/9L
         XCvEJnHSaKI23ZM39AWlYtLHHtWb0hKNu5cY91JlXwyTZpiODfSEnzF0d8z4N2s/uwFH
         FsQNCVQAnmqxCJ4ugzjQ9zi6Yi2gubAb6Z8ciZmI+B0E0uTgeNqYG2/tBXyTrhm2Zych
         8FJEgCQdoC5Fm+RayExqe/gQydoEhNmKkEd0MRoMMd9VxwSr0VpKmqfiOHf3JAdsB0Sd
         chrA==
X-Forwarded-Encrypted: i=1; AJvYcCWIIcI43T8K7jKPtLhm+maqxbjVIx/34j4/4iN/87n1/spab4IUxPRqfwT1GPiY9lPehuX43ZRED30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrBnazu3Faq0V2a3uCzT6I1IbIeYas8v2wA93s7/mjEJYlyCU
	c/weqbCGlMjJb3g1+SirZOffMSETWjkUiNnuWr/SHrb7CiCpK6rePxeAJ4/UPpQ=
X-Gm-Gg: ASbGncsMMPpjs0+7ihLCnJlyaqgPhbz+VXgivSk6xt8lAys98kHygLOUkyWYpRXdEaj
	bni6+3mTpGHuyxBZZSYUc2BpoRMn09CtP2/+IPJzHROl8hVBGIoulIx/SeLyg2TPSDKPpKhFXvh
	I65Iq4aoD/OXHj7MCu/QjTdAT/1HH/icDMlOQI0D6kX0LiLZqdoOysH3r0/jumeURkjp0oh4oWc
	xH9odF6pDS2CGp/FKLxLxwjenUDuM2WyKKCMr45+iUX53GYQsFDI1Ka1jT/qSHG0GaNciciM7Zp
	iwy5wNKFYSVVtFe4H/CEg3hgMVl0EDUHfauPcVKgOQg+YMo=
X-Google-Smtp-Source: AGHT+IG77ZOpZoqliQs6i/d86fRFOW+Nrx505QHjkxGWQhm1CMXLj+So9sv5ltnLehIXmgyoVX5BBg==
X-Received: by 2002:a4a:ee14:0:b0:5fa:8925:3d76 with SMTP id 006d021491bc7-5fc5e5c755dmr2828112eaf.1.1738958988093;
        Fri, 07 Feb 2025 12:09:48 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:09 -0600
Subject: [PATCH v8 12/17] doc: iio: ad7944: describe offload support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-12-e48a489be48c@baylibre.com>
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
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a section to the ad7944 documentation describing how to use the
driver with SPI offloading.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes: none

v5 changes: new patch in v5
---
 Documentation/iio/ad7944.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
index 0d26e56aba8862a8d2ff541012bb4681d05c7bb5..e6dbe4d7f58cffd9f700f931ad2641d336526129 100644
--- a/Documentation/iio/ad7944.rst
+++ b/Documentation/iio/ad7944.rst
@@ -46,6 +46,8 @@ CS mode, 3-wire, without busy indicator
 To select this mode in the device tree, set the ``adi,spi-mode`` property to
 ``"single"`` and omit the ``cnv-gpios`` property.
 
+This is the only wiring configuration supported when using `SPI offload support`_.
+
 CS mode, 4-wire, without busy indicator
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -106,7 +108,6 @@ Unimplemented features
 ----------------------
 
 - ``BUSY`` indication
-- ``TURBO`` mode
 
 
 Device attributes
@@ -147,6 +148,27 @@ AD7986 is a fully-differential ADC and has the following attributes:
 In "chain" mode, additional chips will appear as additional voltage input
 channels, e.g. ``in_voltage2-voltage3_raw``.
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attribute is added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attribute is added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``in_voltage0_type`` attribute.
+
+If the ``turbo-gpios`` property is present in the device tree, the driver will
+turn on TURBO during buffered reads and turn it off otherwise.
 
 Device buffers
 ==============

-- 
2.43.0


