Return-Path: <linux-spi+bounces-3902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF473935252
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 22:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32290B220EA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA01459F7;
	Thu, 18 Jul 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q48LjsiY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778D69D31;
	Thu, 18 Jul 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333156; cv=none; b=DhsVcFuM0hhD3FC7pvzW3IYxhSSE/1YNBvNNhQyO2FAONvQkDw0COZjkMflS9pjUnHPoC6+QxWU3PUNCQscBEWpun3nHIHPSsZt1rWIKe/8P6vW4Bs/49X5vQw1WrKdr0YiReDAxhu5mdzgP8UCwytbWsrnZQXfMwM4WbGpDypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333156; c=relaxed/simple;
	bh=seoxYgat+6J640iJDS1FtT9nanPqBr1LbV5X968zLUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIPY/7yvi2N5IoIKL91Gz5vi0Vtz6Llxphpzy94H9yfpBz6wKqjSKffX4E39tegllyO+WB0pdLVlfWc1Y3O6mjENDrmpqmkelNiXI1yJjyLL0uOGcWUPBVqhijdNLnSP0mWxgmenxJ1xVxQBhOJVexdJ+kcDvK03CisNmc39CFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q48LjsiY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc0f82e4f5so1323945ad.1;
        Thu, 18 Jul 2024 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721333154; x=1721937954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HEbbNWY9Z5mHrYsqb2yWfy8npWaP5Im1C26uHQ7+pg=;
        b=Q48LjsiYG3VqGWUAmlsdkYZ8csCOAzgGPcfXMi3s1QOxQMlfuICJ0w4XzKbGjrbLul
         /gNVR3GEeH2/1aE02Fv08pm2Y8J1iw31JhaWsUhDa+NOQWt8rva5Otc4BCz62liT7JZ1
         Dc3Y7jbaYOn+QUFqM2Yj5tyfc5SkbV+XN9mTyyiDuxXufo9npdhPRFbVVxS7lGIb/fgX
         D6SwL3PK8jIC/wJJALkdLOfO4YcRIEgN4+sOfCGWYgg9qlTRHy5ZBr0dQu8m5XsS6bNi
         tB46fpe3+4JU5Mq0E2VND7t552BZSseunibGVTmclIknt9UHTy5oX/pbMbWK3FL6yYfx
         kCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721333154; x=1721937954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HEbbNWY9Z5mHrYsqb2yWfy8npWaP5Im1C26uHQ7+pg=;
        b=OsDglekJYSlxazqaswfWj8EGB38NX3Z1R9BnJiLqPywdGrwu15b+wNIpbEBEjYap/l
         sw0HLrw5wDTe4hju7QpFwXwTxDWZjb3LDWpc/w68KOZOzq1IOt+mDQ6EEiUhCGGcSAQv
         kZAXabTRZY4oC1zuzSND2TC53bgtJ8HZGspM58X8Wc4bHNSRwNh4KuM0Y4K/0qc/yXwR
         fxnnnm5wXBFCqorVnQc9Z++Vg9u+K9pSXfDrw9mzCz0JlVtP81kW3Q/lgAqE1dIsjOkg
         gTWgJJ+kGsiU9HOJxTcac5SewZXJit7ieV6eY4qwGvDjg1ZLMmtMrLxDumW7UE58nAUN
         Y3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQnMMiFfd9JSHGj8IzD/IfRLz0q9e3qP76UCTFGJ9zb64cmoW7Z1ObRGuATJP5XBR8Sob9HEu4xeb39KB9Mw/IogtTFJ+IWEftXg==
X-Gm-Message-State: AOJu0YyKr8rE1ssxw7xpRZNr57Th0rUNfKtSLaao34NZ/hJrZP3m28Ur
	K7Irry/xN+gzHM7ZW5l73MOoW2WHGv8pLsFxZOwo4YSMq+1w2qGn
X-Google-Smtp-Source: AGHT+IEGG1ywSSeOx176WKs+s7kKUKcub5mzF+z9PhVOaBPgWFb15APDf+a3XETGrQDwr0M8Wiga3g==
X-Received: by 2002:a17:902:f68c:b0:1fc:52f4:d7c8 with SMTP id d9443c01a7336-1fd5ed72a6cmr4470775ad.10.1721333154374;
        Thu, 18 Jul 2024 13:05:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb74145sm97350135ad.3.2024.07.18.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:05:53 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device
Date: Thu, 18 Jul 2024 17:05:40 -0300
Message-Id: <20240718200540.955370-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718200540.955370-1-festevam@gmail.com>
References: <20240718200540.955370-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no DAC connected to the SPI bus of the Elgin RV1108 R1 board.

There is an LCD controlled via SPI though.

Properly describe it by adding the "elgin,spi-lcd" compatible
string.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi Heiko,

Conor sent a patch removing the rohm,dh2228fv entry from rv1108-elgin-r1.dts:

https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/

If you prefer, I can send a patch on top of his.

Or you can apply this one instead.

 arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
index 2d9994379eb2..971bb617e845 100644
--- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
@@ -168,8 +168,8 @@ &spi {
 	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
 	status = "okay";
 
-	dh2228fv: dac@0 {
-		compatible = "rohm,dh2228fv";
+	display: display@0 {
+		compatible = "elgin,spi-lcd";
 		reg = <0>;
 		spi-max-frequency = <24000000>;
 		spi-cpha;
-- 
2.34.1


