Return-Path: <linux-spi+bounces-9487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCBB28434
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA96B1C8202F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECD30E0E7;
	Fri, 15 Aug 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oKCu43NV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055530E0C9
	for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276266; cv=none; b=Y5gKTRACg5y73DbqWmKpW/16HTD7CeWvYkGnSSDph988u02QRe6DoISVjtP1zMF1Av3J+P2sAuoXmBxBhcEgNKyMNNWSNF+4caOGoNYntGajlwi4lrCA9Liy5D7maH5U0iJnqY2Ww4j/qgPxHk7+C/g+ycgdaMabEFUwaa9/H1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276266; c=relaxed/simple;
	bh=4mSg7/FJF+dNCJc9keQwuNfI4XYRtRidKb+j1+8mh8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ohUeLNdyi80ULMRgHDZwsi5sVT9IvU5791QzAEUUW9lbdrv3iLsged+MfO+bzNCkQnmkxVUQhjaqfHlJ4aGPzfOZUHiEIQ/VpeXBMY7V2NQ9++sodt/4GEE/OW+3u7lHPUq2NzItIO+21n9iDq+td/yl3UXr/L72R6t/OM3m3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oKCu43NV; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61bd4e84776so684045eaf.3
        for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755276263; x=1755881063; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeTCzOhB8KlIbjBAM+JfgXZgHbqV4L9r/ttlxrn63B4=;
        b=oKCu43NVt953zlSg1P5W1H3Kvf/mnpyXZhDyqd+sJiKSf27o5q9CNPI7DVeQbPLsaJ
         xfJxSXaySzuDmLVOM3lXjhhi7d3PS/LhIYOHNorx4GMfOAqbflOXTBv0GanK7ZRWkfb2
         +OuEKcem1aY2YZHcJ9wu7muphRpaBOwvFrbRrQf/8/VB4KKrnQFC9kIUt87H+3kV5+QT
         SoVJxAHrHwhIsXWzFD6vYyGQ4n+kVkYyyJvVpSfo6LCOYfYkk9g0jrr5GH2D8nXl0i1J
         GCm9gqNsv0oV8rDi30P2jjV2WbbcRhcJgkfWj3rxpH/yLhZUcW7Vm1N6mWRqLGbXiGMU
         OMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276263; x=1755881063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeTCzOhB8KlIbjBAM+JfgXZgHbqV4L9r/ttlxrn63B4=;
        b=P+ExEmHCYNSBvuM2kPzmhfOK2qJZJeG7gno/XKz2/9FSMHlyCyqJfK1NUd69OSDaPd
         cv6KQp2nUVWW/vVDuYZLG65zm12kEw88ATNhxzYaZzdXkILzX8LK0/6vs42cEmhfq708
         qTMSQ8iPKIQZ5M/WNKjr2iqhfIQlxl+OrLeVwAG0bKbsojsl79rRdxdWClogUh6jd5UG
         nDIlufa7btM+IYSoVvVECzp2e/CpLMVKOPJPYDg4w3pvpHPWMZRCHWO6wzkkkITF5HYQ
         c86Frk4pC7/2L9uYiSHOC2Yu/XGn6gMKG7qWvEFPve1a+doRH1X1XKx9YNNWdbevx11L
         LpVA==
X-Forwarded-Encrypted: i=1; AJvYcCW7iWF7ZjP3WuyHu9hvZ2r+BP5crp/QEUhIFFHS1YEqvTiECy+zItq69gEAQPxBuxRtxvM95kRwKio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCsigztnWY25Oa5jy625BBTIkdTe+neUFSt4y3lZeqPprv+F2
	oyQTcx4BwxPrnA//GyIbCwfevg8J7uuM3Cf8iKGXmRRC297Xntu2UNNEQ/sYgsfbiXk=
X-Gm-Gg: ASbGnctv4FFMsd3yf9khYimUKcfgJQAND2XCgJsiB4yabDhdCuCtBawEoRMhKnlCShs
	neeWWyNwsyaBbNZa5yoydsWaCUNzWmJxTUSX82oPt+xwPR06K7VYDpT2S5bvDw5rMYyA/2LeZNG
	Six45oLEQN6CoPESllN8SVyLxOdAtOusnwc53ESoDCFQfbp8UTdJvhR3uYZLFb1SIDISDg73PiD
	lq54xM4B658Wu68OlvZ97MnIvlwKe0dL5AI/ug7UkK3mC/hUXv6nu+VgUiMqoZIS5j+teCUH/Ny
	fVI5RCQ7iZqTmJuWgJeTeGes8exrVkFn0P8lQxdS9nrhpbb3VyCn4LWiUuQkrtxGLxEkRu4lSzy
	WxVy/cjB0GrJLj/vqbttXLkOdb+s=
X-Google-Smtp-Source: AGHT+IEo11i/uc/Hufr9lPF4hwWNBHjn9+ucSXTQlaalqfaTXDcHGp7UsewwnkPTdi+uu/hMcbjDYg==
X-Received: by 2002:a05:6808:10d6:b0:434:d39:63bf with SMTP id 5614622812f47-435ec48ee26mr1198739b6e.14.1755276262853;
        Fri, 15 Aug 2025 09:44:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1b186bsm305263b6e.21.2025.08.15.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:44:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] spi: offload-trigger: followup
Date: Fri, 15 Aug 2025 11:43:59 -0500
Message-Id: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9jn2gC/x3MzQqDMAwA4FeRnBewrYruVcYOsiZdoJiS7g/Ed
 7fs+F2+HSqZUIVrt4PRR6ro1uAuHTye65YIJTaD7/3Yz27EWgSVOesa8WWSEhmy5qzfd8EYAvs
 puGmJA7SiGLH8/v3tfhwnv5GMMm4AAAA=
X-Change-ID: 20250815-spi-offload-trigger-followup-d33f263169d4
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4mSg7/FJF+dNCJc9keQwuNfI4XYRtRidKb+j1+8mh8g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon2PRmJwQLsyKooC72AoFETjaYLn/XzO2yFqLJ
 Hs5xJ1Xfi6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9j0QAKCRDCzCAB/wGP
 wG8eCACd/wPlJUMamVDnAuTfSpA3J7dv4WgxloBtOsquEjQrCO3X0cBW/ug7R6HkXzAow5IzJqE
 0Ww0VVJlRZnkiROVGOo5XA4cuCfD4J26plTtoCuK87UQU5MAYdT1USCqP0BF5HudhGybKNo5Vrn
 hSgygwu0YSWDzyGWwrhPddJSr9ZlE7l3CTefIq4BN6z1E9D5h+RDtdtAEFAzZ6BosU1T8Mhmrk4
 cldwTn5U1oY3QPL4+irBqLP3l3Y80fHMcKdmxQfROgoQviSUH6aOQuUr+zmgf9vQ91ZdFSni1/E
 +DpUqPfrXX4IwNknygJazce9M7w17W5KbUMs3OyYbwDf8e9j
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This cleans up a few loose ends from the series that added the ADI Util
Sigma-Delta SPI driver [1].

[1]: https://lore.kernel.org/linux-spi/20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      MAINTAINERS: merge TRIGGER SOURCE sections
      spi: offload trigger: adi-util-sigma-delta: clean up imports

 MAINTAINERS                                            | 8 +-------
 drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c | 5 ++++-
 2 files changed, 5 insertions(+), 8 deletions(-)
---
base-commit: bbe4656eae2729b8ca87116defa19c568898d08f
change-id: 20250815-spi-offload-trigger-followup-d33f263169d4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


