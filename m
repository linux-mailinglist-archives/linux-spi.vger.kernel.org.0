Return-Path: <linux-spi+bounces-9490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01CB28545
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD58D7A604D
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664353176E8;
	Fri, 15 Aug 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B8M++/VE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3E3176E1
	for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279628; cv=none; b=R0m7k567JWctlBm6f3Vl3tIrya3his5T83LoEg5O0ylX+1ydVBflHH5JjrUPQL558k7FjP56T8Yu06sitbaSLUXzth67w3E4kWxo24i0NN5iygsxrdj7ER3Le1OZgux26tg4YXTQ4Hu/4TFvaN4T6eaKdgxUstaEOQCabvKK49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279628; c=relaxed/simple;
	bh=B28sXvGjCFOYUvu0JiN97kvX/cAZKMehY5og6dNVKsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TDQDHdkAQ1m4UGtRxO4EQfbZCMOuJFN1zX1/Ga3+7EttVVrfnOx1upiQs1hHNXTcSzcJLFcbxiPDG8GYbyIu1qXGOknRtgLINkJqiU5yogNE0TMEW9NNLEldU/JdWwzXylbFHtiDqLoD3mViU+arth5cdzREq4tlbvIVJH2Hya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B8M++/VE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-743814bcca2so2114448a34.0
        for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755279625; x=1755884425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZDQWRGa5nfehDHnGzi8kJNQaEZJ5fb4XWdRg//ziTQ=;
        b=B8M++/VEcWS4dFNrOQ3QzYzfDQ0mwJUWjot8R/jZTMGT7eohYb06E7/BKnKA+Fl/K+
         JJ4Ry24qb3SSgPZAJV3nXdFYyr38lzWHj1tNTNIM0dpeQRDI9FzMMjVOCjG7qxmqwKxU
         /cIbtT8kdpXVPLxt0Y29HmMSQygqqIftq8+z9VcPNg3mwRTOO4pcGd1PzN86O1fFFXb+
         vMgCn7ZlTsX3aoEKZlkv6cw9ypWr2KJjaO3PdvtaGbcWvEVazSzqJZx1OOF1xTxTTh7h
         5UNeSc/Mk2PGdUH8jfY46LS6yd5VkpBpL2I+AvlSwNPs7z6AiGKOyakA2F73K5VRcvDl
         NQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279625; x=1755884425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZDQWRGa5nfehDHnGzi8kJNQaEZJ5fb4XWdRg//ziTQ=;
        b=WGlyGhAssd0CBtBr5sUVtWq7yctvb7tGdd9tZbVfJekwGVuhIYFccQlPI1qqfREGIQ
         KUukHcjIr0TGUDNDileUdvP31QtCSY1dQyoT/IRCDVELMfKiJM93R8n1U3n8b4g4Wun1
         MzpOFCi+j6Ww+61GnCMptYzrPybDP846oa8E6dgtyxop9Cm7ZO63HsTCwsrzWEwGbZlz
         Aq1ZCqHd93ydYJYgN1Vl26NkMH/cLpf15DWsxvqAQQwVP35QwbvFcemawZZxFu69JfWu
         hFgirzXuHAcb3lacmt4FTi6i+dAUTXTjUrC5SDe8Xgm5CIikjQ3Jb2m6Hl9/oSVRmPKm
         WRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU620NL66Bt8D2JAbaM0wr8qqRwm0S5PMH5pUE4dRU81w5nOYe9P2MU1QNxwVKb1GTu82tS8/B2JDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrxz7BBlxpGJWBkTm6gFeSkLLEsbRYtQ3LgzBHee895Qfc9Odu
	Xsni9jWih7vYb5xRCnZGwwdD3yVIqz1dBiUkk7OsQ60OcToLWLvVf6EIt/mAEFAu8cJAKJZGzeM
	SFHRP
X-Gm-Gg: ASbGncu9C4qOCGtRbg46SBl+/ek1l8XFYNlWeGqbXDWpaVzWwsq4G8gUxzvRMk+DLv4
	fl4at148z7DMp3c5PpkiVaWSn6OXYjy6cddd+qjzmnVqkJnvoRWHDDqBFyGdEEMt7kzp6MNjhdB
	ZI0D7KKEiY4q39S7rs2nXidLbQ3bahBtJ8lal0w9Lbn8Wmmapg2CzrS9YBETKWAhWAEBvCESZjt
	JSG3uRAmdeMoUgt0X2qTkFqlxSvdh4QRPQDG7khA60HS/3SPsVssLKR3EiBWDajXSJ64m5L+2Q8
	HrN/oma8kcV52KIR1KpeZGMNBhnI6x0vDSVOYEnaYrwGJ/QZhaXzSIoiSWt2/5QoK+ZYPnetPTc
	bEHba9xRjf4sekFmg2zK+h0jHhvs=
X-Google-Smtp-Source: AGHT+IFXaxzjWw+oA/KSMliexhuvKtsGdlQq86jSQO92a0BGM3xz0pCDcRhNs66WPy+CPmotDuvdfQ==
X-Received: by 2002:a05:6830:3901:b0:743:541d:4fa3 with SMTP id 46e09a7af769-74382cb5912mr4279781a34.0.1755279625154;
        Fri, 15 Aug 2025 10:40:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74392073439sm405826a34.48.2025.08.15.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:40:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] spi: axi-spi-engine: improve version checks
Date: Fri, 15 Aug 2025 12:40:01 -0500
Message-Id: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPFwn2gC/x2NwQqDQAxEf0VybkAtK9JfKT1IdtRQXJcEFkH89
 249DQ/mzZzkMIXTqznJUNR1TxW6R0OyTmkBa6xMfduHduwCe1aeDr0TSZdUG1u2vYAL7K+zrJC
 vs0QB4vwMQxyo7mXDrMf99f5c1w+HGFTKewAAAA==
X-Change-ID: 20250815-spi-axi-spi-enigne-improve-version-checks-cdceedf356d6
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=B28sXvGjCFOYUvu0JiN97kvX/cAZKMehY5og6dNVKsY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon3DzHixko/YuL4pal5oD+kOQJ9ojaGqQNegoc
 bKv4fMZUHCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9w8wAKCRDCzCAB/wGP
 wACuB/9wLFyaqAgpH8/ZlpsLfDPx2w9qfuDqkWzdAbV+ROT+8W0F9ZnLNNqwSiMbP+ogNsnJ20C
 rKU6S/hR0H7tAzf1jCn6hvWCCBxqLQ4ogAbGuPGm6E4kit+KJXHk5OxUI8KSr92NXU5mgDpwCOH
 BAXk84o97AE8yHdAsSjR4vMZEZjWrg9vZYftLtvqxX8AfaeJAlF3dTQEC/JS5n03ZtX/EXv0ISh
 ord+KqztbeZsr/MO+MID/mJY+YNzVjlY78BI5cyo0ppm7Qdrgr43aJkazmav9gamfo71PRYo/rr
 oB96AbnTyTAZ/tMYCRaEF4ZjdOHTkimYQF6058+rgIEoSwUm
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

We have a pending major version bump for the axi-spi-engine so to
prepare for that, improve the existing version checks for feature
enablement.

Unless Nuno knows something I don't, it should be fine for the header
file patch to go through the SPI tree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      include: adi-axi-common: add version check function
      spi: axi-spi-engine: use adi_axi_pcore_ver_gteq()

 drivers/spi/spi-axi-spi-engine.c | 17 +++++++----------
 include/linux/adi-axi-common.h   | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 10 deletions(-)
---
base-commit: bbe4656eae2729b8ca87116defa19c568898d08f
change-id: 20250815-spi-axi-spi-enigne-improve-version-checks-cdceedf356d6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


