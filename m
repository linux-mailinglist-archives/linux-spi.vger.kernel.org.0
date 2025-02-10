Return-Path: <linux-spi+bounces-6752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4BA2FE42
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 00:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8601886B5B
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6A261394;
	Mon, 10 Feb 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fI4uEXCG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92626137D
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229386; cv=none; b=pS/GHwrjP0W80snpJEn+ejQipLAkgyLN1WMUB3iAIc8rxS9Ef+q85fPiawvg+Xqv2aJ3/uQ0homRDUlHorX1qWKW3j8MtB6nPnLvAqm6VSuQiAtyJhQ9BpXQ5ZneTIbqrUP36hZfwUE4nGEeKCGlGDfbSqy/v49uslQTgQmCZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229386; c=relaxed/simple;
	bh=E64vimrA6sAQmqcb8D5CIBdvE/5/9FWh9JZxsOyC0Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4BP+ueeFhp0JvIbt4X6JkxHl2IvTIGRpcyliMPf+gQ4vSVJMnG2NzbaTfIagM6eiqlkCRf+RLKj8Bgt5KO2YquT1+qckvTuAdXIF9iQKT3/5akZwkOL4pjVJz246C/mhw0LCjoG81+EkyADCUR+ggINpqVdjnRC4mwluurBIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fI4uEXCG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-726e744c798so267027a34.1
        for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739229383; x=1739834183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzovOp0gWLRUdwhwXTDu1YuijsWTRmR+OknRU/gsakM=;
        b=fI4uEXCGoe3H52IQSfOQA1UQAp5UBhAoxoLolvcj9MaTGlT9XQPm3zSX2hqaW02D0V
         jwy3sWbYvuxab5s5Vh55bgM7P6DqXVdEKt7Rpa1kuwU5oS3JJltpaFzBQmMPRMpQafe9
         T5m3WzUgQNBZLP2cGaRjJR88OA7aYsLVFNTK8URHCLl7lI15i0yM3X7FUX2LzFNGG49t
         LWokoGJRp3XwhoqzJ1DRfkJZJbKQEQlBaVoSqjT8EEHyz5FXe79Bo6YW1F62Z944xeaH
         bTSWaaKRfZ9RXnt4LWpnTNYFwtyoZocCg87kYNaB+iT4o5YaM8uSFwD2VcSDF+7h3pGz
         xvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739229383; x=1739834183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzovOp0gWLRUdwhwXTDu1YuijsWTRmR+OknRU/gsakM=;
        b=LIjLt3XACV4qejjFRPr+UBjrOoQcBq+IMLG0PhpiFNpoaaKV3IdtvhZoE0tJsX1gnN
         n1BnuMQE99tVISYr2D+gax84pkaxbEoYvhDu3bej+Df7n1q+cVjs9/p0/w9KPHVlmtbw
         vkr6PviKjszBNi+B7msqDvd9ehcFqzbYS2JnTIUMP+0GOCtCNCl2E2DcWuxmL+yd/+li
         iS7hdr0wAWCOz9rkxmQMz3/TWX5pWdQPtU0hn0ppHvSiJ46y+hVYHj2DdJlTz7kcZMN7
         dq3g/o+Hsj0rA1jwWZ47tvv/SocTUXa7Uxh4Bm7BmQtwN4McmCwBbyRzn576z71FQe6u
         Rt7w==
X-Gm-Message-State: AOJu0YyhL7Qmmk9TkPZBjV098dmNMQJfnTm5SxF+ERSz3eT3eEAryTgh
	Z0uZ5bWNsrLtr3xmgeE36HhvMzHhopWTTtDntgQqOok/3uXWrO1Hyj4A94cvFgjxOuVIhIe7sHl
	n
X-Gm-Gg: ASbGncv3BYpf9H3rn+VHjn9Bf3mLgvLAkG0eAKWNV87WjD0MrluLqybB7awIQ2Fi2QU
	57G+e4rqoY5fRHFenkPTnw13HLG18yJI2Hy+QOO46nSBiURhl4ltvlwxQ2cULtPugDZ71BODok4
	az8MglCYEUISdjm8Gl7HLvbTKmPGYHsLOeooob+yH3kcUwAiT6+UAlQ2iRNDvozL2R1+7+i50pO
	1o0fpRsM+tznHqdmEifWjHCO1uuaa8BW1WRt+yHrc7nZJZitSNPyW+P6rL3vNA1/mMsArc9WuSA
	4RY8tckLyL+JmKM+xLje0U3dkRCSB48KooAEFUWpsOHiR7E=
X-Google-Smtp-Source: AGHT+IEVJH69m3Tol6MXlyMkcLSWbCYFUgZIG3ickNDxavyuj3Qbw/ZqUcyoMFnpf3iYuY0BbllMXw==
X-Received: by 2002:a05:6830:4988:b0:71d:eee3:fd19 with SMTP id 46e09a7af769-726b87b3d9emr9563503a34.6.1739229383654;
        Mon, 10 Feb 2025 15:16:23 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc545bc40esm2758043eaf.29.2025.02.10.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:16:22 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 17:16:15 -0600
Subject: [PATCH 2/2] spi: spi-offload-trigger-pwm: add extra headers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-spi-offload-extra-headers-v1-2-0f3356362254@baylibre.com>
References: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
In-Reply-To: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2

Add additional headers used in this driver. This is better than relying
on implicit includes via other unrelated headers.

Also sort the existing includes while doing so.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-offload-trigger-pwm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
index b26d4437c589052709a8206f8314ffd08355870e..805ed41560df090d85a8547b59f122cf2e3941a2 100644
--- a/drivers/spi/spi-offload-trigger-pwm.c
+++ b/drivers/spi/spi-offload-trigger-pwm.c
@@ -6,10 +6,17 @@
  * Generic PWM trigger for SPI offload.
  */
 
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
-#include <linux/mod_devicetable.h>
 #include <linux/spi/offload/provider.h>
+#include <linux/spi/offload/types.h>
+#include <linux/time.h>
 #include <linux/types.h>
 
 struct spi_offload_trigger_pwm_state {

-- 
2.43.0


