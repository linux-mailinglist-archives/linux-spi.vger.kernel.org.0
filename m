Return-Path: <linux-spi+bounces-5264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795559A55C6
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9F1F2223E
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E1198E7A;
	Sun, 20 Oct 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWqgrOsw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE371198A03;
	Sun, 20 Oct 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448522; cv=none; b=H7U9OqW7ga1U4LfK5bd1Sa71vcpu6mytDr8uW1mTuARlvX8U+kE3f9ByfNRPJ3boDjRsjfZm1W6i+TsSZkwfuE7OQxh4vRa2Qu8Ctwd5JlYUFmKsfednpc98h4Yg89I5XtlPD1j+mwcAxXqwLLqnB+Igu9NTSrBpfUGHln8d4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448522; c=relaxed/simple;
	bh=DzDpSRyC88LkWgWqyUjnlZ0cKOBn/GRahM5cLjCtms8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrym1Gr2O84i/c9JyCJWIuzVBcYX5gEnP2MdkI9Go5ATj8CKVn53u9ffawYkWYo65XQz+LtvMWNbK0E4qZXKRl+L9easGIyWUBrwDnWH90dSrbQhPbZbB+utx5Cr7i3XLu5x94I9GIPaGx0hinAe28/bMMG/fQmTRungUAxeONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWqgrOsw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43169902057so11865375e9.0;
        Sun, 20 Oct 2024 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448519; x=1730053319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoFiO4t/E3af6lH/W9rynyhOwVr3dD1Sx9PXSKqMKFk=;
        b=iWqgrOswau29lQ1rkcR1yInhY28A3ZaPkYItglqsBY1twV8KFSUZck8detSQRpIOi3
         GeuDz4Ax4SVdbhCRJf8yc2zU4KiCUu+WP9Phl3gGrV33xrRsTdOKUw7zkV5ooltco69y
         r1u+zXmdLz/RAzrwv+PJGzE+kY+8GGPqWF1amnoXUkn/Qvq5g+5DGt4IZHDgTkFEVVYg
         ZIB2jzFIuTpviNGksJ1mPI0jyLPYRjtdA8KRgZcmuR2WK8eqLd3chLzYd+IHw/itH+Ji
         VNqRvMZKGWUWNt9Ms/MBCcdPnYCLwsvz14lcA3k5XFQeeG9OjqlIOeXEvUSSvQmOLka5
         0YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448519; x=1730053319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoFiO4t/E3af6lH/W9rynyhOwVr3dD1Sx9PXSKqMKFk=;
        b=ktbvLynD/Can5un6n81bDKBw7Lz62eAmxmjdaP3QlQDSwT6NvlIP8QYjP8rIlgkj6A
         fSRrNZZkUP+KBB1mING+4T+95GOuTsJLqrH3bcZ3oOr/9mlVAXk2MwfrZj/bi9OEYtvV
         DLo8zHfEC6qyug1gK88BBqtqITCpPtu3hdZME5vh8M/pHOf9VbaXsdMUmF57c9m16UJ5
         EHKzjqSvX63EQn+3Jys8YY3GI3NAYOXbKGM7ZYEkM1FRGiZl0fet81KevPVoWe4Ca6UU
         tmZB67lzoQofxroHlNV4kEKnBa3KnzQJD2cVNRUOlX9iWNmEbWzQTU0hUBEpHy0xP9ko
         e/fA==
X-Forwarded-Encrypted: i=1; AJvYcCV+3Lat4LgtkjTN6UvK2hzFyNZlSwi2Es/6l2l2+/SiMxgCyzaM6fcOOkuAIi0DbhJ+fi87sjBo1zgRHC1F@vger.kernel.org, AJvYcCVpvwjhbKIId+Y1ubvBWr5+u8zH6rdnsT201AQ/dhxPkXbfxCTB+At0zjVy+zPHv5HMQwIqm/Ek4Pji@vger.kernel.org, AJvYcCW/4Zmr98zXAl7SksLERnv2eqMQgua82ABJGEeS1jxehwUsGwlGBYC0gaX9z4rXYzXSERbY1iDnxdXhLHoFjKvoxyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln5nK5Ohlaq35WSxEgfEe4HoMfbQSobwznpW1TWw52kLCFwUy
	2/YWVzDlmVwU+z9SJVs8ElFQVCXho2Hai3kQHvQXI+axhANYdK4D
X-Google-Smtp-Source: AGHT+IFJZjum28xn+PrqK+hVAT4SnwtB3vmTyk2FAQRhj3mClh4nuh2fPDn5hGp1ZIBGOPE7tAGxtA==
X-Received: by 2002:a05:600c:1d01:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-4316168f28cmr74795465e9.24.1729448519045;
        Sun, 20 Oct 2024 11:21:59 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:58 -0700 (PDT)
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
Subject: [PATCH v1 4/6] arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
Date: Sun, 20 Oct 2024 21:21:19 +0300
Message-ID: <20241020182121.377969-5-ivo.ivanov.ivanov1@gmail.com>
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

MCT has one global timer and 8 CPU local timers. The global timer
can generate 4 interrupts, and each local timer can generate an
interrupt making 12 interrupts in total.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index 802e135c4..c95e4713a 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -169,6 +169,26 @@ cmu_peris: clock-controller@10010000 {
 			clock-names = "oscclk", "bus";
 		};
 
+		timer@10040000 {
+			compatible = "samsung,exynos8895-mct",
+				     "samsung,exynos4210-mct";
+			reg = <0x10040000 0x800>;
+			clocks = <&oscclk>, <&cmu_peris CLK_GOUT_PERIS_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
+			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		gic: interrupt-controller@10201000 {
 			compatible = "arm,gic-400";
 			reg = <0x10201000 0x1000>,
-- 
2.43.0


