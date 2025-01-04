Return-Path: <linux-spi+bounces-6220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF21DA016DF
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 21:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1C11884CAA
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF31D7E42;
	Sat,  4 Jan 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlij1iJL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7221D7986
	for <linux-spi@vger.kernel.org>; Sat,  4 Jan 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024092; cv=none; b=n5rHPgShYafrBpcSDpT38BPthIAZVBAwbhYB+ADGhw3dWShu05GmIwrigE97fcu8rz6YiTQ7rzOhfNonSuZcJP1d/+/NVVXaRLu7J+3IPf1zxgXLhWkiiJfqQhQFoYfaZFpRRWPlG/1faQt8xBgaouRHt6jwZiPm7d7YvYipIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024092; c=relaxed/simple;
	bh=KoYJDmouknRxlX7izHTU83doe8p6XKitvlO210BlS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQinNt3plaPCkPavL2CP/lzPA40jeYLwu88pWicvPDeKESIQNKFgCX8gbYbni+sIv8ObC1+e5vdjCRhpdfPGYPpUGvuskCH4zFKG+PctTnp6PJufwvjNYb8skqc0amD+4x4f4gJiFIStOJ234gOWQgGxy8TPUzLAWS8v+RKCWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nlij1iJL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so222895066b.0
        for <linux-spi@vger.kernel.org>; Sat, 04 Jan 2025 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736024089; x=1736628889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmawReunhMQT1RzOmjM1xjN/S/KwjF4WQ4NuUA53NuA=;
        b=nlij1iJLZaSM+evO8c9zKTPpkE29lVavo8rdtfErtlz2i2eb3nFUKCRrluIU4URSFd
         dfVgSw7EMKaYBn1/w/q5SFyFegzaXg5AEc1H6TKF2agMO8qBhcIstLqxdc6/A8rq3CB0
         deeGfsOZ/afk5fD2Lmz61OsUuh23r+OJq17Avtgr1RzGexcZkMXA79S6sli+f0Ua+qpa
         qVe6A4PxA/E/HidmMEsYbu5POlN6ZlmNnCOLYvYUfUXIjasNDybFSM5T4PlPKqxjivO1
         0USawm2N2up/vxDLd3Qa/e4bh74fsyY35q6VixHAaJ4CuLml12cPiGojEOuNyZtCxdet
         nAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024089; x=1736628889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmawReunhMQT1RzOmjM1xjN/S/KwjF4WQ4NuUA53NuA=;
        b=fn7ooCC3HpHy7RB6mcEU6DsSRj5jwy5VU4ZKwFdjmvkE8z8fBnztFVJ6sqr61+Ygvy
         bG1Ea04+FHoz4WPiJkNgROrmKgzCbasv6achFYZuhGSFAdRYzs1LvbpNZEvJGCp71StJ
         Rrgwl2qvMFVnR7++yxnKTsz31ndK4bj7gv74tTiM3q+Oxvi6WmGv7Ix/KD383HeGGkyT
         uIwxEuzp8YS8guC0vW3GUKm9OsaQLYRS2JKvgDM1an57gzTNQJEuyI5/XFeIs4iejFZ7
         5OcQ6JitJ5TL7OON60q6uKdXp0LSgB282H2uZl+y8GdrMbh1gweXiAagQCMtjxE48/WR
         NA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1GGED3yeSIwV5UWJbDNLcHRGaPVERj5heDsHpTNW/+DfabrosifYINDOjvEvhUN7KSP336grYlyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPkJ79HCVjb0zqpXfgrw0mbjty1fqNLAZgBiFXBd9HdSg4gJm
	wPfI3WjkoZ05N4bPQeQv1hUEDXzTJ7Hut8h0hv1ZMs3ixk4fhHMn+P7OQbNg0Ds=
X-Gm-Gg: ASbGncsTDT+Ot+qPwLKwv2kWH/J2jASkb/MIqDjO/k5vdGA/1CSwNDN96oKdPXdWOsA
	R2jQOtYWp+LCB01tt8SaViCRwgT0eTkLgyxPNgy5fpWFLalBd/TxKHsHFR2bd99sDZD9fLfuAVp
	Hp5ow/AvTF3Qq7xLeN7xs2RRqLx1cxxlnmPQHwREFxyE34W6uqBfqCpWI//KzjeSZbnjUgGAEQN
	1KOYO8TbOBPE/uqb6KF7ei72OhicAhR/CoxUi7vLUeDUFqQkirFj4IvdN6rMV59psp4KSY=
X-Google-Smtp-Source: AGHT+IG0xF9hR17ga58c9EDJR/+6VF92Xk90OmLLRzHetd12T6z8pp2lmmUMDY7ynIlHUG5keK+6nQ==
X-Received: by 2002:a17:907:d9e:b0:aa6:aaa8:b4a4 with SMTP id a640c23a62f3a-aac2d431db3mr1515258466b.8.1736024088851;
        Sat, 04 Jan 2025 12:54:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf4a841749sm839666666b.137.2025.01.04.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:54:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] spi: cadence-quadspi: Assume device could match via platform
Date: Sat,  4 Jan 2025 21:54:37 +0100
Message-ID: <20250104205437.184782-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
References: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver has only of_device_id table, however it also has MODULE_ALIAS()
for platform name, thus assume there is a configuration where this can
be loaded outside of OF system.  In such case of_device_get_match_data()
will return NULL, which is already checked in one place of probe()
function but not in the other, leading to Smatch warning:

  drivers/spi/spi-cadence-quadspi.c:1942 cqspi_probe() error: we previously assumed 'ddata' could be null (see line 1885)

Driver should be consistent, so assume device can be matched via
platform bus and of_device_get_match_data() can indeed return NULL.
This is also possible with malformed DTS on OF-platform: no unit address
and device node name matching driver name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 47477f2d9a25..e9197bf9d739 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1939,7 +1939,7 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	host->num_chipselect = cqspi->num_chipselect;
 
-	if (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET)
+	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
 		cqspi_device_reset(cqspi);
 
 	if (cqspi->use_direct_mode) {
-- 
2.43.0


