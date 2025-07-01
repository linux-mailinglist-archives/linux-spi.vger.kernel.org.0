Return-Path: <linux-spi+bounces-8968-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7935AF05C2
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109804E291F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22045307AC4;
	Tue,  1 Jul 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d+YvQV3X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04906306DB7
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405980; cv=none; b=dzyLc/FQihOk9m7HRrhOdfC1r7d27XcKhAbajinhLw7R8FHzNThsfFwKl/WqWoqC+MgsOZc3of+UN976T4xBUYzdCnnXzQHzgt54b7qLx2rYetnvINGzdcRRUxaLlXZaOzhIUPK/WZs5V48wonsgEY5o5/T6e6HeWSEjFyFmWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405980; c=relaxed/simple;
	bh=1pUnPmEW6s+eLqvk9BXOOUemrGb7ur2APhmFlPgVmmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxNwjvMHQ9CKno8/RyUCgCjvv5jPFG9LRsNTutIl91yyeKeKec+Gb+S35sOhzITRuIPqceeHT/Dode0MbpsNTol6fjNBtnD0WOaKUTi8X63+Hc2hNMI+3a8iZRMPeDwSuY9GblxcoTKTKfxo4hC3uqk5g7e13j6/Elwx7Ax2fLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d+YvQV3X; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4079f80ff0fso4158146b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405977; x=1752010777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHniCqYc2VQTDAA4fWnYCZus3iLgaAx0sPomUMoMA1o=;
        b=d+YvQV3XzqVan+eNfHNMON2ndzk9VxERr5TRJhvsSQlNfzbDdEq6BODmv7lJkrYdew
         B0LhEQiqZLjF4ZwiBcx48SVdlHgiQ3AV9g1HYJxy/iZ46fFukqN042GeGM/5m2hWt9AS
         c5d32WTimJJHbOBinpgehDoKmr99nmDM4EVsIcJpYRP6hbUSOVRiXIHT65/mLSPATJLq
         FJJPxlGRIdEv9tq6ofTraj2HEnWQjgnwJqh7bGaEF7mYZFqOtwaM7EayGlSFbfiSBWa8
         kg7EoIbe9418VyHP6y6cupghwIFck2ptcMVwGbnnxEihVk+cQzZ3c33YMcjc3gLBhHYw
         Ffpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405977; x=1752010777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHniCqYc2VQTDAA4fWnYCZus3iLgaAx0sPomUMoMA1o=;
        b=GyPgqF9b6vCuo+2khDTFA1kFWKyA1rqMwJveWyuVw1O4wrcGsFNQbAG/O85jB9xYUP
         bkGzw4QMLBCYlALs+S/n3mhaX5rqm/AbAsnfIvLMzjowtwVwHu0QY7MG5YE2qgVARriG
         g33Lk/uiJPKl2Irh6i22516uGMRAJhTBEEyoSYY3g/4RQ6EFhj3dQD8Vmo+9l6BYaB3C
         3hDScGWmDJOr6mFTqeXn0yx/g8qFIzLBgzb/euOKmYUvzi8orp8Tl3g3Ol8+Nx8mmb6o
         NiAdoXV/VVoQNMWrEzF2nje1mvRHBfNkFfIEaRVuNkjjZBlY1AaVcYjR7WydTYVM6U2H
         HB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUut3Rmmhncskfd5sTjgjaO4fx/yWbHs7RGkBc3shQ6QyuFhR+2yu3CINgI2riTOlX4aVY6nKkEd/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPqjJGyW6L+P7hpUisR/273GZ06NSSfe+lmMv5Vk+HAHrXdaD
	upCebb75klC7W5BsIeMdrjeFfkjJYmt2lz8PN+4tq3sdLKsnAVhsWwCkMhtocTOv3w4=
X-Gm-Gg: ASbGncsaR9/pQU/YvOAEXl2bv0VU563JxjUWU+RiHC64n8NyrZ0+HvaLV6eSg4lu0Fm
	+3ke7vijDaXDXHuyrx4pZV3meBaS7jNTRBzEL8WXDgFRp9Dsh13lUXDb2b3jNwvYx0DbaYnOYBw
	duY5pcjnty7sOXsW9F3kQfDFgkbF32eLAVTRZKcB9lKBU0XP5+aArR/F35+LaRS9V5EM7gnkP5s
	WVbg1IPvB5fKJi23E/n5v3zIU2nvuHZihNn3kwXuSDN1K3GIoS4fDkSI0FOYGmNIG/cYm54e2jC
	2wb+xF1v1W3+JS25UOywsOCvFJknoQ7EaJ5+InsKs/bT2HvSoEneTvB0y/WVcG+PblQG
X-Google-Smtp-Source: AGHT+IG0bhBx3lA01RN18NYfLT0rpHpS0ckfjNDTHVbR/kan8VENJvcoqo8/X2nSGkB61dwgGiAHgA==
X-Received: by 2002:a05:6808:4fc7:b0:40b:1826:34c1 with SMTP id 5614622812f47-40b8999b39fmr191361b6e.6.1751405976599;
        Tue, 01 Jul 2025 14:39:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:54 -0500
Subject: [PATCH v3 06/12] iio: adc: ad_sigma_delta: audit included headers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-6-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1pUnPmEW6s+eLqvk9BXOOUemrGb7ur2APhmFlPgVmmE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVh1rpys8PmWV9xj3NC/o49aXlvbxJ3xeDIQ
 1gRRA/KMOiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVYQAKCRDCzCAB/wGP
 wLkqB/4oOW2IyFjdlSpnzdKReg/rrMYr109m+uGSKjMXb/6sTXnma00V8PIOaRfWER327KKpQBt
 GuxYElkSh+MVDeQaLlyIoHMXrN45mT6xMTrDtDklY8zEL78amVIp5mw7QmjOJo8pyvbM/TKYOu4
 4+BQwyA3KjzPwolaM7y1TQgDreZZ+G0kOHej5SWm5YwPZgE3JYn69k7FFV2pCjqHd0vbrK84Nsd
 1WNCaJlJL9oXbEPnvQQbP/W+qhS/SHuP5I/r2wvYS/DPdVzhClBDZHdpPY/h6sI/BBohZUtguMx
 31E0mY/KhKjV3d7hJxauINaCfoDSXp1KtDjZ2kh8ad6zSVT3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop linux/iio/sysfs.h since it is unused and replace linux/kernel.h
with more explicit headers. There are a couple of other headers added
weren't covered by kernel.h, like linux/gpio/consumer.h that are added
since the module makes use of those APIs as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index f91f7ae6dfca05cf3ae632a5f19990f3d153b706..b5c66a6cc47ec8e36c458fae87309fd30109c0ec 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,21 +7,28 @@
  */
 
 #include <linux/align.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
+#include <linux/find.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>

-- 
2.43.0


