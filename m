Return-Path: <linux-spi+bounces-3908-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1680593770D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8870CB21E60
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27784A3F;
	Fri, 19 Jul 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiqsKjAI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681A1C32;
	Fri, 19 Jul 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387591; cv=none; b=Ux1sS3cJ2Xq2pVa2xizH0tVuQukbcOpifYIYIJLiejcJNVL3SZeXmlR0lYPiLB1qhlUBnL3F1B6hALc+79SDyLQDi8Fq00mR2cWrEJ+tCLMIgTY0iBjXtAdjb9XlG7abJUJPtSv2f2X/JzRp7Nqw8SjPwcOWXgEyQogAi8rRps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387591; c=relaxed/simple;
	bh=yGv+d05VUcp+940D6ofZXpayRyz+ydVQ8XrF9QmhIlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfX5ICdlaf4rjiv9FrIOhKFshekMCyb9Ut5t31I2LSr+4Limctm2Lextp5EPmT1LOW+osUsMaLMFPK5vLyHcUWLEz0Ll1ab+0d6ZqapqOytV3dghDeRy2Kfx9Dus8kX6bNgw7OjyVmBUUlkZpm2mndCbtbAf/RX+gwA3tVgSyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiqsKjAI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75b77be7611so211518a12.3;
        Fri, 19 Jul 2024 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721387589; x=1721992389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI2OyaGeJoZ3jwOXtrp/t3st7XUlc9wAYXqVZ5e8wn8=;
        b=GiqsKjAI1FdQBhmSLeBOWugJRYwNboErl3o2wfPzXw/NP9F9gxm7S8Z5SxLMd0Sgio
         zfaetHLTbuTHMHoXdHap84bXkuhiowcXQy+DdZ/dDPFWdRjL6EAcTKFiz1hW6/BaET7b
         QmsMozO+Jem4VnN2uJLRXk6f7HLZPGK/13mZCNOrLX3UDMF/FTxUmptPBXEDB4djwGuF
         noYIzaBf8p8DVnXp0Bx4sCNpoVH5VUjIFKrOffbGSeylGWGif/wyFrtXA8Bf6qaOxLdA
         wjVp7josJCF/MOWhCYOOKEge+B4jeDM7uCl6p/KQRfRR7rGVHk+NK/Jb6nR/i/Ci07wG
         RDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387589; x=1721992389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI2OyaGeJoZ3jwOXtrp/t3st7XUlc9wAYXqVZ5e8wn8=;
        b=eNv4Gu+LCQFBEwz5ZjA4onpneBs5zT/OXrCyTREj6dtEdJjPdUtHLcpx272j19T/IG
         ps7TLNtMVE4jecRGrmnfMBi4fcE3AhWuJrE0meg/rBC22q11OtdYhm2aa0h72vnC0zJj
         HAGgxbbmwYuisFmGiFHru9Yr43Q29nTmiNTv/Lki/EwtofO6dqa1lvZJvcqIv0DRitt4
         QQW1qb+2SChpldHoNC6BlLxgT//LY/ik0wLQF61f7+6Mcp6JGpxmxSO8ecGj77YQB5lm
         REV2fCnN1BvmWkd9ZFKzoqB2uOtg6BGKmhUOm/sVPnxAbKrhr+2BIb3drICQicPFlBYd
         d/6w==
X-Forwarded-Encrypted: i=1; AJvYcCVm9Hp15IIMJwZ8Ks3y5+0ZoZuGPD/btIiidY4ZmQPvgSOvwW2y2AM0LEEcHpFOVQHAh0n9AikxSUDagiH5xalij4UzaweAbKevdA==
X-Gm-Message-State: AOJu0Yyf0zNcjEWtZ0hyM5tr3OwbnYoXw/qni87cfRontps1RDMm2jiW
	pVJqNDampig7ddOLcTRXIAiza4Ux6RT+18iF8R1Rzj6VxMbFcG7+ESyW9w==
X-Google-Smtp-Source: AGHT+IG2JJJPxabdVPZ6T2TEjoovVVyfOK99NYS1AWCRX8RPjnc05mWwK92iQlMuHULD6A7++2/Vkg==
X-Received: by 2002:a05:6a20:e609:b0:1c1:5772:3bf3 with SMTP id adf61e73a8af0-1c417f5662bmr1447427637.0.1721387588787;
        Fri, 19 Jul 2024 04:13:08 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb76a619e8sm2303031a91.0.2024.07.19.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:13:08 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device
Date: Fri, 19 Jul 2024 08:12:10 -0300
Message-Id: <20240719111210.1287783-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719111210.1287783-1-festevam@gmail.com>
References: <20240719111210.1287783-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no DAC connected to the SPI bus of the Elgin RV1108 R1 board.

There is a JG10309-01 LCD controlled via SPI though.

Properly describe it by adding the "elgin,jg10309-01" compatible
string.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Use a more specific compatible string. (Conor)

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
+		compatible = "elgin,jg10309-01";
 		reg = <0>;
 		spi-max-frequency = <24000000>;
 		spi-cpha;
-- 
2.34.1


