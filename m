Return-Path: <linux-spi+bounces-847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C583DF9B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A090B1C223D9
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2E1EB5E;
	Fri, 26 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgozXHhi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD71EB46
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289352; cv=none; b=dPC+Iv1N6BJ1XKzccYu3jRmANDfLGkn3WM6OHOdJJuThjaO+tz8GzpMCvHRO8WDBFPJYesYKlkjmje/I3NfOTfLs9+3vtubXM7fe8SvaY+p0VKRZgZXD9ef/iCgTXfjpuX6nUUVONNGhKnRTMsQcKBO1TyJPgP5gkACDNMZZi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289352; c=relaxed/simple;
	bh=ESbWEf4Jl9fYqrFI7JEFHOnujDBpgh6Ob+8gu7+WPuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4a81/9xZdHOOzX0n9MTaFVvNQlGR0cnM9rjFO4sARdPMMxL3Ox6qoFazOAEYabMF9nuU6dDnYzWZuJCfDEdGn/EpXgjKBjWgk0n5VMNxXbG0XZfpQI4Rm30knZkwM9oDywPbhkRbEAUSOg9VaYhb6Wqjo/q4T0QRBJ5EInDfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zgozXHhi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ee705e9e3so7013845e9.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289349; x=1706894149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=600VwywIwYkKhIBCMOdOgBJMPRHlSjpGBD3EGORG+P4=;
        b=zgozXHhitCfcIHbUu0rpKUXPRmyFrII4Dgqc59eKK4RyRtc3tXcotYu82pLT+SG47Z
         hbFRMg3xaDpDeqpMaZtGK5S+pkOxVBab9JSG1QT/p5RAwBxB1W1YTHjQInTovZCknaVm
         +t4MBVvx06tsA/mbsJC57v8wWhSmWxBiZaToXZUuTg1C7OXAOBDosZnh9xqqia0C+tTj
         JJ/dTiceArq2ZrbKAk8+s+ArPl2DV649rusGQwyXNnwPFs3Tm5jVhycr7zYkkw3ZAHy7
         x+zr87MmpuwZgdJTnwA/WUgJEi5kCK0ClcJ729iyH+v8g/x1y/fBX/Eqql7MVCdnBbdA
         M/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289349; x=1706894149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=600VwywIwYkKhIBCMOdOgBJMPRHlSjpGBD3EGORG+P4=;
        b=SFX02tFYM2lcVxZPDZ00cUwT8Z+G0InypHiJnh2ccIxI9BMB4i+IPUdtue3p6ukAWg
         d2iKsPoNMDe1YKoXhqf8LzzIIvgO1yji1w9c7JRW5t5fKRWljPjYsh+R6bjyflK6hHcF
         0OM3NNofsj5CV0DWA2B+hZNk+RG7rny9AHxxwwbU1BwKXwG/TLAbJPM7HP6YLLeBnJD9
         /yfJvN+BQ/uNC5InGbRbkfhPEtMNy1TdGMKFavIwN5nDykTa04wPVi6ygKzCLroDFf6l
         CWQcVFCPehf4jjkJHSAWYBkKQKjK7VvUh96yiK/NahXlgzrGRryErS4IRjzdaj3vsICY
         FnYw==
X-Gm-Message-State: AOJu0YzhI6X6xxuX90EoeKQmS1GWV1Sb6NelFTcSu+ao4Gsqv9AMCnOO
	eXAL88Zt2osFYohzc2NGqqeCBv94QALFqion0awNCngrz9AGcfk55MFzN9HR6No=
X-Google-Smtp-Source: AGHT+IFxC11M+LjBfLJPSBh9/EVnhgXhYyzN+hO1o/eiQaDN7j05eFKx0HSJPEBY9Ly2uaqGYz2UCA==
X-Received: by 2002:a05:600c:5492:b0:40e:6710:c10b with SMTP id iv18-20020a05600c549200b0040e6710c10bmr84903wmb.117.1706289349415;
        Fri, 26 Jan 2024 09:15:49 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:48 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 01/17] spi: s3c64xx: explicitly include <linux/io.h>
Date: Fri, 26 Jan 2024 17:15:29 +0000
Message-ID: <20240126171546.1233172-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses readl() but does not include <linux/io.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f7eb8f742e4..c1cbc4780a3b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-- 
2.43.0.429.g432eaa2c6b-goog


