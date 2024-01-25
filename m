Return-Path: <linux-spi+bounces-788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C527783C647
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AD328A519
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185F7318B;
	Thu, 25 Jan 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2XpZRtj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450E6EB74
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195805; cv=none; b=rykBR1VNFUoNEhEwAayfHkcf3XnRwlJeBQ4NqwsvN4ltKs5hXguV4Iyv/Ysgz8P+p6RCiV8Qi3iQWBmpAJh5cU+PvXHQCF4PtzD23OVMdUUmWB9+oLFzIANJXcBY9MgQvMrHeaMW0ltsL4K3SI44wBJVY+x8CvDslNiWc8yC7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195805; c=relaxed/simple;
	bh=8fhkwYMTO5zd1oqKM8Iyt+6kig9k4plTdDM5enIVcLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCutq50VaJhpI8fUChB1Qc0MAphXokgc5VF1CZvBUArJCGkyYSnwQtz90D1jBLHQFbisHJtTEyry3OZeQGZGipwS5q2dX9wsRWoYv0gjN283tt+Em+ObHKcGri1ia3jNYh6Wyu0gtx7ZH5jeLk94bB8sWsw+rAJl42Gw8RShmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2XpZRtj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33934567777so4650252f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 07:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195802; x=1706800602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilrhb+yvw7RYPUylHsWS4mRgbYDWwTIuPMtV7XuwEs8=;
        b=g2XpZRtjsr8wzGkq5Xc0zx4BT5vjq1Le5xfRQWmiaD4RlyTBXIAK5TiNOxJ20EHxPz
         TbfnmQxWaef0sOGRaH1wC1jShojAQ7QeHf4OSEgOJ2kJ7ARAqvcbN3IpfGmIQy0f+dK3
         BRz+N1e0jR1LWbFtCcFZpe1KaQUZhOFbr0rVOhl+wXFeO7kj+TrO8w/hviLwf+SR9yaG
         eqmh7AML4mqT3Km86Z7Ry0WAvy4keRah7/Zo077DeLw+YOdqvlyZJNk+eWsGy9Cgd62M
         QeTv3u8E6wIbN2AQfu2saESNGppVlZ1d5s/eiebagx/uTRgdmlbe/paMMLMH+8m0FvDe
         euyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195802; x=1706800602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilrhb+yvw7RYPUylHsWS4mRgbYDWwTIuPMtV7XuwEs8=;
        b=D5WZy6lJ37kKy9jXKhTQ0HcjybNjs83czYBuhUQyCirySmo0XJ69r08553yU1EsUlW
         xMzO3f9ZYmLqiAbQVBCpQcO620axyIb8lb/jYASFTLtpjZOuph1RIFRen8/zp4N/csRa
         qMIeIreci303tJBQlu+pSuw+kLMl0K6yjzRadt6IlNJkg7WA9djUR0wR53RPb47/LWMU
         5NEccPitDmKvr/OHaMOTz7yKuKmI/D/kA1ikTqPnttZiPJTP7/cIAOe/d7IwGpfWOVRQ
         /TKuWJV5hd/HDIMdw7Dk40grM4y6GGVn93OVjDcJlL8XAfntLdw8wLxm5HM2ZpcFxboX
         jTSA==
X-Gm-Message-State: AOJu0Yz5gnPgoU4Q82GiP0VpdzbgDRAZxlkpLqJk03grG4kE5vFt5NG2
	OxiPMbJks4XVA3PfQxkdj3K1k0nMk5Un9H66NzUEMHcfxWUYiadV5VkSypHzzaE=
X-Google-Smtp-Source: AGHT+IFCdeVIQDMEFggx7BG29AF0iTnRkUSlpmQhqh/e6UutEr+l//6no5ADcVZJRCWMQADXMYUYLg==
X-Received: by 2002:a05:6000:1e91:b0:337:d651:e65c with SMTP id dd17-20020a0560001e9100b00337d651e65cmr530562wrb.111.1706195802323;
        Thu, 25 Jan 2024 07:16:42 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:41 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/7] ARM: dts: samsung: exynos3250: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:25 +0000
Message-ID: <20240125151630.753318-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and specify the SPI FIFO size directly into the SPI node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos3250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos3250.dtsi b/arch/arm/boot/dts/samsung/exynos3250.dtsi
index 3f1015edab43..2f974059ec45 100644
--- a/arch/arm/boot/dts/samsung/exynos3250.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos3250.dtsi
@@ -826,6 +826,7 @@ spi_0: spi@13920000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
+			samsung,spi-fifosize = <256>;
 			status = "disabled";
 		};
 
@@ -842,6 +843,7 @@ spi_1: spi@13930000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


