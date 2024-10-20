Return-Path: <linux-spi+bounces-5266-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22289A55CF
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63285B24A1E
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F11991D3;
	Sun, 20 Oct 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK6xgAR7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1D1990BB;
	Sun, 20 Oct 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448526; cv=none; b=NZCBOhp+1aIq7QqLZR1kjWs58wPVEtpUSWjXyoD46PaKywTjtrgOTqwx11V5IZhjmOiQs0cz4lGADBins4PiNz7DTnku46/AB7nQYdXaGb31pG2YBkyaqVd5+jZuIdfCcNoLrCRwwXqAWUaTWrmbWlIDFhfQaLBX9XYIkYHY1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448526; c=relaxed/simple;
	bh=rQDFcUnzkJ9BFuSeY9oNM9lBI52DXuy7K8Perx9Jq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibWMvHzRiT9xJoHOMjmwklqsrtwjGfGMkWuPkvpqqalD6EAEfFEnAzgj4eb14eetOdmRG16EoPyW79pccGg9GnGFFVg9nRC2/tz9Sfv+Ugx8xXgEripW9Ld3IFpLllaAt4nFkrGiBoWpJ1VJbgONZTWV+dxb9naVp66WJMDF4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK6xgAR7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431616c23b5so15196495e9.0;
        Sun, 20 Oct 2024 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448522; x=1730053322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv66YW5L6/jj49RpWN4ISuR3J2Fku5YT9aw2fCyxGkA=;
        b=MK6xgAR7dSHCGp7Upy3h5O0u3+fw6JW7Tprtu4JpDhX3FRr9bAe8EDcpVqOmWx6TDC
         K6e1dIbRwwhT8sbTze1LfERbh6SXe+thDBXW0H37vfeJx8nITLonxKmxUUOIzk5b7i2g
         /jFXJ1tO4fOYCYOfqJQNPRI6zphR4Iw1QrcrHYkCC4OPs4x3B76i7kTk3l12T2nzZhNh
         OLzuHlHQ7kZCGCcqWDlZ+Mztl1TJNjVJyq4nKquDOKg651NStccsBuaTdY5GprRmE7kP
         S564BWdFj06wO3fwKJ/hyAYjDgM5kyxtUk38DqPaT2uwCBYLQVLnaN6fSjc9pdjEZtBV
         EFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448522; x=1730053322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv66YW5L6/jj49RpWN4ISuR3J2Fku5YT9aw2fCyxGkA=;
        b=Vb/iRRQc4MjJ7Clm+k2N1mFNWoLs+W33jbYb3IBttDWX+g2hCOqR2dUKFpxGFpUR62
         i6FkAE88efISt7BZIDRSW6W+/HR95IU6JKdsMoYovBui9n0amOjYpR+8Fn8C1wI4qFZr
         xxLrVMe5Dawa496xUFPe6g1CFauxiUZWTrZkUPs+JBgomP+OjzA78qD9LlH54m0Wvw5b
         v4SG7DzEVdniEqlwDBMb9B/afYpFLI/hAdoQEwxXq7MWqAcKM6DZ7zVk5EsB6vJK7xZj
         yP6vt238ToNjUXMVBwf+wCaAtnBv4bBbRtc+0IAI0GIUMD9eWIRIEuWU+0aZLevs9Ss9
         Q9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDypJqUJx5L5lcw22GEiWk51/smu8LA59Lqmki2x6zCZpA6W7ZeCUGhS095w2XUPEhJ8tuC7jLfnykLHc0@vger.kernel.org, AJvYcCV80OUWXHWoZeiE/NJRLae3/CnV4KJatm84TljNUMdWahAbYzoXfrIHzCHT/WHGW11C2gxcDP1eFnz5liCQdgdM30g=@vger.kernel.org, AJvYcCWHl+ZW+hnAuCaozO+1+OFEiwoDiXupB675kN5ZPQWynARmKrFRGGTIb/dHUXEFjts7PR1jmP8lWQXM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/HAiqlRrtJEcLdVBv96zDzvwHS3ZWc47jIoqCmjNI7n3e93T
	kS5ehlDAXHQnwueB4aMZeZg7m9O8SE1+qZm5nJ2u1GakcyW5tr+B
X-Google-Smtp-Source: AGHT+IExxAQlZ8OeGLgSLSXLdOccWbsZ9T2b2+RHr9tBp5KTor7LS1jCccXn4K/1jhGb+EfWMbT1MA==
X-Received: by 2002:a05:600c:4fd2:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-43158760531mr87808305e9.16.1729448522343;
        Sun, 20 Oct 2024 11:22:02 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:22:01 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] arm64: dts: exynos8895: Add spi_0/1 nodes
Date: Sun, 20 Oct 2024 21:21:21 +0300
Message-ID: <20241020182121.377969-7-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for spi_0 (SPI_CAM0) and spi_1 (SPI_CAM1), which
allows using them.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index c57b7243d..d936c7bc9 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -282,6 +282,36 @@ pinctrl_peric1: pinctrl@10980000 {
 			interrupts = <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spi_0: spi@109d0000 {
+			compatible = "samsung,exynos8895-spi",
+				     "samsung,exynos850-spi";
+			reg = <0x109d0000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_SPI_CAM0_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_SPI_CAM0_SPI_EXT_CLK>;
+			clock-names = "spi", "spi_busclk0";
+			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&spi0_bus>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
+		spi_1: spi@109e0000 {
+			compatible = "samsung,exynos8895-spi",
+				     "samsung,exynos850-spi";
+			reg = <0x109e0000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_SPI_CAM1_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_SPI_CAM1_SPI_EXT_CLK>;
+			clock-names = "spi", "spi_busclk0";
+			interrupts = <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&spi1_bus>;
+			pinctrl-names = "default";
+			status = "disabled";
+		};
+
 		cmu_fsys0: clock-controller@11000000 {
 			compatible = "samsung,exynos8895-cmu-fsys0";
 			reg = <0x11000000 0x8000>;
-- 
2.43.0


