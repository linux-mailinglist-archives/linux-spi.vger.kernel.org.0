Return-Path: <linux-spi+bounces-6217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE4A016D7
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 21:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67A3A34C6
	for <lists+linux-spi@lfdr.de>; Sat,  4 Jan 2025 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697E1D5CFE;
	Sat,  4 Jan 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+CxS3Fs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B81D5CD4
	for <linux-spi@vger.kernel.org>; Sat,  4 Jan 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736024086; cv=none; b=cd+hx7S1Y1Gd/J2/G5Bd9EmRZZ4LDHdt+MiABx7zwBHSo88WKY4UHXsSLoPt1cY2HAj7czD0FyaitflQQiPOjVaNdqoOyFFwJag77qYsYQTViKWUVGy6xHcv/IyV1+QfX945GAQX9T16DJpyrp+QTfmVUXmjuv8cdes2Abmk4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736024086; c=relaxed/simple;
	bh=fYNFkZ4E49jBh8K15pvFiL/fAUn0j4KNd1uS/SNnNLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5lDOwISIy9ycZ5/oGR90AoM1Z5++kxt/YVagSYVmFmzXe0lJQUp7288J35F2TbVRrf0z1pIdF8bDYVnSx4BgX77W3L/Hsyw/rzneOMFMfMGU58lCgwBtdcO5zcDo4ylnPiQAfk7/3n4+AjGiiJHjMPi8vfLUhXB8PQtxChsEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f+CxS3Fs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso2740073a12.0
        for <linux-spi@vger.kernel.org>; Sat, 04 Jan 2025 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736024082; x=1736628882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMnEf52UfAT7r8nhxUJ27WGRgof8roegZaPYvjI6+Zo=;
        b=f+CxS3FstA746ECg9npg4+CiwW5WlafE12tuQam5CYW0TdFKRhBfbQLd8RD6s4gfl7
         Nd7h7dVqIncK8pygkk/z7eVV19BlwVZAYZ0AcIDG6cfdB8qHlKcbxZ2nv9Har/TPgH+F
         26hBP4L7bh6Vk808mIEjhII5fsKHUxyFu/caELwVAfhBqLDD/3dAg7SxajJPNK2rkqtK
         EUq6/cUh7VSgd/Pr9hkomoNjgwWoqPVAKmtyGvGtvnOEVvMO5Ncgp0EmbtFZB9nw7fGw
         cFCIZAyFWkL52JELQ+AvST7f3twucq45I5lqKiDI3P+W5Epz5l7KFf3zPqX7Myj/tLyf
         +oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736024082; x=1736628882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMnEf52UfAT7r8nhxUJ27WGRgof8roegZaPYvjI6+Zo=;
        b=FVuf9hj2Rg0V+CIEMLCDhlp7PWeknFA7Z3eVZabg9U9QWYh1EZA0Dh4hltzqydQ2rR
         9n5XAjbkyc7ns18sJ9KO2K98UTAJiOmS+iscGwAKuamXtdNpkiMADpwgRQtJbhWvstce
         krM/EMcHjgXJJ9Xhi2LX9Wlk0EO/15J7eke9tLCYCCiM2a1PqTPPkLMBvFoDO4qohRQy
         rREp3By5slVImT6kcTA8Ph8dRF55QzxBMS6KimBD2HEUv3lX272uLn8O3lY8CBk4S5Ga
         n8l22IUnhjYp/2qSm4TCvTlURIKJj7XohKzv+5RMeANV4134X0n3ab49nWDdBHQoX30b
         zMqw==
X-Forwarded-Encrypted: i=1; AJvYcCXEWY9vvePmQ/CDGeVQHAVVxtRY+sWXE+7dsGNxfBU7K32jxYdaJmVJb2nnSUr2vO47haoCQCRotug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxKCL8IzllOrM5agFu2hBCYkpaSyC/Wxld868m/ocrdcfXa6K
	hEbwCYzvz/AkcG6MF7PCxxdqIcamPWNJz4+opsGBWbqDPhb8G4ehx2qEelw6/bg=
X-Gm-Gg: ASbGnctaQqNUgtcphR4qjeeVd/r5pHArS8xqtyTUzn+yvJYTSipADggsMu+UCYlaHj1
	o974+UZCuwi27X8q7wEfp8miurlg7b9kqbWjlYyp1INSZ3G5+DkrkIvhaMrk1oGxTnTDkIggRaH
	KU/hSS6MVJ584fKf2v/DNxwbXqDgSMJ528tauyAOrBc0C+XWvhavajDexS2mWgiMGK8ydjNwpPg
	FYZfUvw4x6pmeb4AQiz2LeAeXJmqwzX+aw1wb0kgXg/SlEK9vCNv1KdkdXi2WVjFLfV41k=
X-Google-Smtp-Source: AGHT+IFLOaiX+zI3DneKZWxfhc5l0F3vw+qCGBukNa5K0q1p/ZxNgoJYKPDQaaRdI+EszfqyaVTwdg==
X-Received: by 2002:a05:6402:2801:b0:5d3:e79b:3b4f with SMTP id 4fb4d7f45d1cf-5d81de1695bmr17922824a12.8.1736024081142;
        Sat, 04 Jan 2025 12:54:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf4a841749sm839666666b.137.2025.01.04.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:54:40 -0800 (PST)
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
Subject: [PATCH 1/4] spi: atmel-quadspi: Fix struct atmel_qspi_pcal kerneldoc
Date: Sat,  4 Jan 2025 21:54:34 +0100
Message-ID: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the typo in parameter name for 'struct atmel_qspi_pcal'
kerneldoc and W=1 warnings:

  drivers/spi/atmel-quadspi.c:244: warning: Function parameter or struct member 'pclk_div' not described in 'atmel_qspi_pcal'
  drivers/spi/atmel-quadspi.c:244: warning: Excess struct member 'pclkdiv' description in 'atmel_qspi_pcal'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f46da363574f..d135cca4e454 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -235,7 +235,7 @@
 /**
  * struct atmel_qspi_pcal - Pad Calibration Clock Division
  * @pclk_rate: peripheral clock rate.
- * @pclkdiv: calibration clock division. The clock applied to the calibration
+ * @pclk_div: calibration clock division. The clock applied to the calibration
  *           cell is divided by pclkdiv + 1.
  */
 struct atmel_qspi_pcal {
-- 
2.43.0


