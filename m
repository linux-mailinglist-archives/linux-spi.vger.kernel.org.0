Return-Path: <linux-spi+bounces-658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A883933E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1CF1C24A86
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91D64AAC;
	Tue, 23 Jan 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zn5i5rSv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAE634F1
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024089; cv=none; b=uYNuDrwLv+OIJ1Z5VTCpMtxGtJeH7fXsev6tx4QnttcytxbHJvUS8iESAv4KfYGHq4yZKzPBx2McbRQ2GGNgAUTk7YLRAnD3CacuNtqg4Li7lQO4zZAR0uFvOh9bjPc47pGAv9ftxVvFxhPSyv/krB8OGxci6A9ebquuwfHrLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024089; c=relaxed/simple;
	bh=1Cc0NM6fhLussfzfohHUT88afhdt/sIa5MfxqO5OBZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr9UMvtzSJj2/7bxdS9P0VMTHVoZk32Ky5ked7Z2pcQ9KF276kF1JjoCNCY0IMX7KWTG9pDcC15hvraKZIAulMfMpN+nUJrDkK8sknhtptdS5H2pGQUkPVhkdeEgVDjSUltnDqokwzmmma5GZCb6ljLtgJKK6OkI44smRp2/QnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zn5i5rSv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e800461baso53225495e9.3
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024086; x=1706628886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkm1sDmd91/8Icdqt+yhAM2zfTrJG1x4ZL3+cJTuru4=;
        b=Zn5i5rSvSY9328KM0si0UnV0VwXCnr95T0IbGW0bZo9ez8lYk00peIEOAaMD2flWr/
         zvMi661YQVkuA0vUMPkLeEChZpMyf42B+jMfIJWeWM1fJqLONW4rCXlzbrlEGJU6mLOT
         C+RgIoKMSWJL8QKWRrr5f0BLGy7UhihMBiJNS/VrIsrNJt9rR92wCOkJN1/yT6+Kh5d5
         HGygKjHrsktQ3Fw4p5NLXTWwAMqRnQC1cGZl9AawzHus7IADcHyce5rCt3JY8Rat1zYT
         G+AmtqlFAi3uhBm/lBM0jrtvmmmaJfKbYWqHPZ7ozeYuuP91hnYaFJvn88r/zZDtVATR
         HoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024086; x=1706628886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkm1sDmd91/8Icdqt+yhAM2zfTrJG1x4ZL3+cJTuru4=;
        b=Udj3sAbWaPM5pTTBcRqS/8X3BiH6wpHLnIDa4YvdV/P+YkIWZvzglBf14k1raIT9Kg
         JOWmiHIy00moQzEWkR7IE0V7UNiBKn1SxYAPV1Cjsdj5APQRbGaaMaFnbJRk0xMHEFSo
         dM7TfCyAbkimf3fENiNqV6+F0W3TeDZBSdiGel13fYoWTcZTeuQbv1i+RGdQhXgmxyNu
         601v2ZEm6q/Z9AeyZ7aUXQy8rAmmqTxcgSOsYg+O2SU1PdkCVnW0D6G99slzlcbpv4Bd
         VZDpDu1mw24uHc3MTRSInOL7yNVca383UdEN2DXgLqUbNIdaj+29CUL6SJS2QyjmVcaD
         32qQ==
X-Gm-Message-State: AOJu0Yzj8B5yXsKs3xtmm0cXM45DWLSeB4IG0NIycBRdcHVuINydJBdb
	EndS8TJR2ho/7tj+8jHfioQjLSc1PqlPPOHEiIcfX59LfAinJyC0irBzOiWTp2U=
X-Google-Smtp-Source: AGHT+IE4mLdB3TlfxdLmU2ph7jFqikJUsLFTael0hg9zuHgIorXMxGlhO+GRg4XyNJMUtoeWepFXyg==
X-Received: by 2002:a05:600c:3b90:b0:40e:bed2:7bcd with SMTP id n16-20020a05600c3b9000b0040ebed27bcdmr319089wms.140.1706024086420;
        Tue, 23 Jan 2024 07:34:46 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:45 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 21/21] MAINTAINERS: add Tudor Ambarus as R for the samsung SPI driver
Date: Tue, 23 Jan 2024 15:34:20 +0000
Message-ID: <20240123153421.715951-22-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm working with the samsung SPI driver and I'd like to review further
patches on this driver. Add myself as reviewer.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..b9cde7ed8489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19404,6 +19404,7 @@ F:	include/linux/clk/samsung.h
 
 SAMSUNG SPI DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.43.0.429.g432eaa2c6b-goog


