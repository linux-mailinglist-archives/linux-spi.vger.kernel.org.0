Return-Path: <linux-spi+bounces-5265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83139A55CB
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C344B2456D
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E331990D1;
	Sun, 20 Oct 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGhzaqNQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B2198E63;
	Sun, 20 Oct 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448524; cv=none; b=OYNzWFGae+Dc+aKhogz5EEhDFjZ4Gi3C3bKedDVPXarx9KuRxK4mFEk2Cj1ttnKx4AWLGSavhAJHkmt8e+AvOgFmm+8K9h+YMvhF007WqqSYbGUxg+PN0vXNW1cm1xvvGu6Cdn7fRN8TfvPzP0i0lK0FW7IE+tPASwpxtzSMrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448524; c=relaxed/simple;
	bh=AlHhXPUTaX7Z/aFRoI6MpFzKLTUW5hcy6mq+BW3Wl7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCGTBfhyh1+qV3BHjeVRAYa1eS3sq01dClKbESQqO9Sf1eTo3lDT2OIXPpngb6XvAuSRNz8cicR0CkkkIzdu0Sy+VTfeUzE7S6vInOz6X+n2gv537ua7k9xh8Y0xcSg9tCIOhiAbM8N4XRTQoD8CjINw8w2Xnz1APbaujK9lhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGhzaqNQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314a26002bso40909185e9.0;
        Sun, 20 Oct 2024 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448521; x=1730053321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vusWTnCz/1sObXYKY1keEPs26uHgXaV2tYOQstmgfG4=;
        b=AGhzaqNQmThR/rnAiWum5yNC/ZBkt27GkrB8lYj9O3NqKptVjfpzMlFA1ieLPKu3F1
         YxMW4tSOSLFj8rQDJp9id7a5KV2FXuvS2+LL53UFx0Chx8LHOYM60/PAYEfRlY2JxxWB
         zMSNYVwjrr5MzkB21xrdTivGco6T/6FfSVvZfI267LuORe0+FUJqJKv82bV2CqIau+UV
         dmbcBjAqhCygejr43z+Z7r5AGT3p8L1ONF6O1huL1WdRooWpHM07Zp+12qMz6gKMik7V
         +fS/rVSR1m44q7iTpFBbqyWcTP2AW+noMR1CjoWnYXc0zncCFiP2GrrriReYzm+Dj8nn
         S3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448521; x=1730053321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vusWTnCz/1sObXYKY1keEPs26uHgXaV2tYOQstmgfG4=;
        b=DfBd1RxdsrEckKcBsOoXSFleBqc4pEbQIyIKTD4kcTqRTg1PsSM1p4JWKBvk3eW5iN
         zqmA/GQWvYv4bBpGBxmhWY6FLfwFoaOkeBBfMTN8V8TQ8Sxm142giq1IjGc811T/sAd/
         MzhvVJNsoe5YS+2y+QZyqIJLOqSEuNvP/7Fb1ahNDsRGeruVrqv0do3Crhv+VtqLsVjk
         ctrQHHD3JMnnM43E+5h6PszJWkp5UQVADe6ZgjCaG+0p4s7D1ZZmWa0Hy4ZJrIjcNdZu
         rUD3kpxtF+zH1vw1zPqsvQZdu7gXU7mXg/pn7sQCNPybPx/Zj7dtNBUdCuPVhMnGZdrq
         qSbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCO7dUoa/7wm+peysZVnbFmggtxwdnf958hgJAcnMZPa49ZP8gI1LKPFa7JlUkoy/HseTIqNjtpyBX@vger.kernel.org, AJvYcCVY4hjGCMsAb4Fbh+JCM8uptrsJ233Bv5Zpr2J1/Z9ZA1nfO3OsAZnPzcsqSFSesR8x9vt8TBINmwga4YXSfjNpiEY=@vger.kernel.org, AJvYcCWu0ZWAT/w5ZkAq7VbHN76bvwWyStUTcvGyfy1bgFnJL9iABNmC2eaAR5Sw9V92gES1OgSl1R6Qh3zZ41qK@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAKif8rntqptOoS5vQpSn7Q74hvgHed6TTjGT51wuoKe6rZJl
	hrsysmMBZKiPt0udv1jNLt0R+WZ+B/BeaoDDWfOv10+hIvDXH+zBwK2AGDiM
X-Google-Smtp-Source: AGHT+IEVn1bgu6i8w+sQTRqs3eb30dA3LNaVp1FKzkemUXiHiVF+qKDmNgVm3K2iwD+2dK1ZsiInZg==
X-Received: by 2002:adf:f209:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-37eab7272damr5381184f8f.5.1729448520680;
        Sun, 20 Oct 2024 11:22:00 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:59 -0700 (PDT)
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
Subject: [PATCH v1 5/6] arm64: dts: exynos8895: Add serial_0/1 nodes
Date: Sun, 20 Oct 2024 21:21:20 +0300
Message-ID: <20241020182121.377969-6-ivo.ivanov.ivanov1@gmail.com>
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

Add nodes for serial_0 (UART_DBG) and serial_1 (UART_BT), which
allows using them.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index c95e4713a..c57b7243d 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -218,6 +218,19 @@ cmu_peric0: clock-controller@10400000 {
 				      "usi01", "usi02", "usi03";
 		};
 
+		serial_0: serial@10430000 {
+			compatible = "samsung,exynos8895-uart";
+			reg = <0x10430000 0x100>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_UART_DBG_PCLK>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_UART_DBG_EXT_UCLK>;
+			clock-names = "uart", "clk_uart_baud0";
+			interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_bus>;
+			samsung,uart-fifosize = <256>;
+			status = "disabled";
+		};
+
 		pinctrl_peric0: pinctrl@104d0000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x104d0000 0x1000>;
@@ -250,6 +263,19 @@ cmu_peric1: clock-controller@10800000 {
 				      "usi10", "usi11", "usi12", "usi13";
 		};
 
+		serial_1: serial@10830000 {
+			compatible = "samsung,exynos8895-uart";
+			reg = <0x10830000 0x100>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_UART_BT_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_UART_BT_EXT_UCLK>;
+			clock-names = "uart", "clk_uart_baud0";
+			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_bus>;
+			samsung,uart-fifosize = <256>;
+			status = "disabled";
+		};
+
 		pinctrl_peric1: pinctrl@10980000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x10980000 0x1000>;
-- 
2.43.0


