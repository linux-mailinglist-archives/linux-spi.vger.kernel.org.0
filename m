Return-Path: <linux-spi+bounces-11404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA3C7433D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C616C2B0D4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AFD33FE0E;
	Thu, 20 Nov 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x5QXq3XL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2330C35D
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645065; cv=none; b=Lm6M0nsEZe58/0VIsCVFE3BjrRTuG0w/9nS8mTBWwV12y1sYiCAcxgV2fEJ65mzXzuynlePEPSmynPp+DTfrKx+w+8UwjxUSmJ/oYhadI/UDumlIdmKaPW3bnnlx96DXge0m/EhP8lhr/HA7TLGESdApv7eLnfcLSKm3Y34pnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645065; c=relaxed/simple;
	bh=xKxkAWH4Dczupi1GaaNtdbgqFj51lObDxl6PmZMGnFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7RI6R1zqv389guSnaZwLzfDRniYg/3jNpJ7qeUYQ9cox38S/JFmLvPlBJPoM+xLdm2HnASYSjbdI/JGV9QkAkSExWzBIrT88kXau5uxC1jPY19d4BSLD8xrOa6vR0ZN88YP0tVekTOtfptAyl9QzP7BNoyEcY7W+l07IRaCMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=x5QXq3XL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so9911915e9.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645058; x=1764249858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5vizWl8rhZW0RSqNph2iU7whaAxLz0S9Wta2HZ+aHY=;
        b=x5QXq3XL0dp5nSAbdvgqC+GpZdy8DXACk7R2sa8EX4BrCa+GhZzJ1W5CEyZIon1umU
         wt5oi1jBTbPb1T4uF86HYj7jrblB1Y64njPnvafiBLL21qBq+qKq80tbWYqCYRfOI2DD
         aMv2l5Lzf3hAgnsrtCeEvK+BaaHWFui9S5tEoTecdVOQtP102nzNPF8MQKvJ8oodrroF
         l/5aAfIWEnpaQuNOc76fCdKAEhuymZyNeazQEd2CouTjpQaE3EQedwHTIAUKEJHBQlrv
         rmHDZdhHJ+tiv60MljseWsQAhLePkPSfgmvtzbp9TF8J0QKEosZlVnjO1qz2q2d405cc
         LIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645058; x=1764249858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5vizWl8rhZW0RSqNph2iU7whaAxLz0S9Wta2HZ+aHY=;
        b=XLTncQWtE4FmjtTVyAsLh4VB42hN3mKDuLxsBy9/FqL1rHwiJh4qPUwSSAVLn8ljPo
         b2JaEV+cobhLoSL2GTcktFe5PBwb6wHOWYf6l0P+ZmjUeEWmKDEMpk5x9vZbLyA6gnqh
         CfrnIAdIswU9PHMfypTJRzfm+D2WzgyoicSbKbxSk+hc9fyrw1mw/whS3+FbF7R3ZkGx
         Sz79gqoVCm8qPoqYRPxp+ONFwawzpPFkA60807wWDCRoDaJph0YmdC/MkejIqf2th/Xv
         +2F/K6pqvAjpq/92j6lx1ht0+9XZihUZAnpIYLOho1ZWKFCgJJpuxvMITJJfsRBd1rkO
         FlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7meY4SU1PSFNKMsJ6cXgUEYRb7eSrME9GPfPj+aQL6woCx2OuTtwPpRZEqOIQSSeD1M+49igM7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSorIAspzyU1s8gZUHdumSN5Al08peg86rTA5sW0vN5M1xQcri
	Eo1xSQpJ58+R6YnROsCPZNjN06Xmr2qO8iDU+G/iUNgC50Tdwm53lhQ17teLco8Lkwk=
X-Gm-Gg: ASbGncuMLR7ucvg86461Uqgopl/hS9bK1Qi/7SomyezInS6Dz5451YD2jIx3G0BKI5k
	YVmFQOcOX/OGFqK1uV3KPIKtPCHA2sD8Hw/6rXDv7nmTNaYCkiE6/1Fya4/GyL+Fn0p9cgQe5yG
	MyX82vtYLQ62igVw5Lo7GmUlaRUvKWbblpQrum2KV2IDdLZqWNO+osVzoWNII4iLO8mBRXxe+2y
	S1yogSHgl2Yamk9IxxGjfghHIOaLxSEF+Osh20P8Ci/bW6C3Rem+4iFScTdL7iDyFzewwaj+AEd
	m87JlvdguUQ8bQwOBVv4pRmf+FHdauEQUQ8O3q8EK3w74TmuUnIkXzPP22I4mSvAoxYxuOhwOL+
	dT1J/TWUi6AZ9KWx2Oyv2X+4LPR1K6ZwKaa78+Gp4tnPttKeRa0i+fjvJMeuF7jENb1VoQXM5N8
	IoVPE=
X-Google-Smtp-Source: AGHT+IGRr4yukGKYf2pApMEgpzEgng5lwLAdGmuWgZBY3u2bUJBecmuK0ddXMVwX0AtEQYOu191Fow==
X-Received: by 2002:a05:600c:5488:b0:477:b0b9:312a with SMTP id 5b1f17b1804b1-477b8a51880mr30543285e9.7.1763645057616;
        Thu, 20 Nov 2025 05:24:17 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 14:24:01 +0100
Subject: [PATCH v7 6/9] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-reset-gpios-swnodes-v7-6-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8Ie2dCuu8QXdvPTAlAcJf0uowzb7E2XgoBNHHNwWq7o=;
 b=owEBbAKT/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZ0ksI2ssXrYXVp7fpyre9TZ24sPg23CCf4a
 BdcXf+uYd6JAjIEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WdAAKCRAFnS7L/zaE
 w771D/isIARPHlgEcchxRvSiESyU79he8yBQ/W67kgACmkURbQmMzS94heu5F/B4UQkHSIi1A8x
 TAh8hHUZpA/fLMbhiW8YpS/RKXSe0zn002nHki5k1lb0JcY+gBecFogrTfBcX9FWIJvg3oS90WV
 aywSENKMeVY6l5sYZCwYko90Nzh7FdmkfJKq/i7UdpcmiS843GrfIo86aNpV5XEkmGB0HCJfIbL
 7byDTrfz9larGmQz3ikyYa44qD4DMLbK8vVCtEZC9wScYUktJRth0dO2O5blLKXJq7D4D656CPy
 8Wf3WRQB+861ae3pJLA4lFh1cfqeOpatqaAHiRs0aovxSGY91aOQeZ+j9P/CXff4JZBRjydBSGb
 XmaLw6qna47OUKOS3kY/deyvMXb5LlZ7WoZSI8nXQOia3skoJ+r5Qhfqo7MNihc/lN3hgTJ9NbG
 kFxScWa/OGSZRsRJ3fZbl6ff0VI1Y5BVzqyz8c8u2qMHDw2OaTuPPNE1+fWFDMKrEZgrS7kbwJf
 02V1C+QgA6PSv85HNldjKiQIO69uxXXEOYfN4oCWFXJEpaBbzggZ2OTdW/WJVE0l8CpoSwyHvdo
 vJRISFsUu6XhUmi9w8xYbOHueIzyLTgoMRqyJS2E262O5dHBKgdiHjzEz+5Vs9HKI9xyMQUSIee
 pagPib/jm+iL6
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 20cd50804ba1b649faa5d74d17d6f128341ccbc4..5b6f314bdbdde84a1cf613fbf70ae39cbb5e20e2 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.51.0


