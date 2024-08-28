Return-Path: <linux-spi+bounces-4362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190A962F27
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A60282686
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A21A76D0;
	Wed, 28 Aug 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iutkE3Gw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19D14EC47;
	Wed, 28 Aug 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868086; cv=none; b=O/1fbImLDNrXS9eqL9UprPUQizltLiifaMNrxqjBiK+LfhlvE9y3OPXXAHxWN7/cbxovM1Ci4sk4YnBCjxIHjqWV+Mr0DNfnOSNtDTsQqNh7Q0uiWrnJoQNYTirR7xr+DEOuWRp4RNS53yPCv5RrGeCL8YyB2Hf4IUJkwegwlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868086; c=relaxed/simple;
	bh=aJhEvLAWsYyxoxzNRHL5hjuH/JJUZC+GDJ4Cu3Xhr5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oWMq6hTkBr067hPKyNjyhvNhmotHMnGKxOCqYakbjZ0Yw/MFG1C8x2BXDOv/SmuOl7rEyNkljMLwwImGd3tveYjnK4FQoEp9G2SNbzB0fptph48HY5dV3mYNvnOjAXBl5P4RNtmzUrq2/20klY+kT07yEIJLW9plmK09m5bAS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iutkE3Gw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so4359159b3a.2;
        Wed, 28 Aug 2024 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868084; x=1725472884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZS6ELWnV1tkQc3T6NoGofUcfL9qygUh2allqW4ll1E=;
        b=iutkE3GwMOjzfeeWA80sbdhQZ+HwOjMnBfumBU7nlJEw/4dDDd8psp8OsuhFM79SaP
         l0woFFolG7F0x44sP2WaLPl1KBxN+vmednuxWSyutjFwQYIaXN4eOFsyP6eDpEkDQ9fQ
         L+LHP6Vlt6yCmqHfqdStRh7pYRjyCWyheGqdgwQtIi5POdgOUE5K5zJELQfxwg4hjoH2
         FgVGKG/+gVJSr7fAfH0b5obcm2AIhRwnXBOdPKFcZarmQkFRNgshDtk+IRucr3aQlcZ9
         rGwtHeeiDg3i1Sc/ij36odKjMQQ7/w5qjUOzGZAShul9k+tOPzzpRlfvRugHnCEO1UBx
         85Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868084; x=1725472884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZS6ELWnV1tkQc3T6NoGofUcfL9qygUh2allqW4ll1E=;
        b=DUmdqL0sweRcczQL/tLjFJWnzeebxmse+nkvCRW8ox15ChWADxAeqwfXnU9lQJtemT
         UCZ882a4u6W04uh5SL327ztXAc117riOj7AYSPVsUJQN/YBQgS6bzbSyJMFtApvlupN/
         91ve12mn+wXDw4Mq6GGDSGD7nBs2Glrf7NkCxJc6UQgG7HcaOv2gLrP2rPpKT0sqrofU
         tF+uj1ULdpstoa+UwJ8uCm3hYutgK/PicR1fFtNB0U56fKRojYyHHZEyLXlAvjmOEPgH
         Cj9CwBB3aJLWtO2lpNBxvFPBwErRVxtwRRCFScuQBowEyVLOvC7dW5B6A0c7h9euGQZp
         G7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWl7mpPndgZt5nFH9BjEGKoVcgJELobdFzR/0bBqzOqpwaXtb6nRBtWbkk9pvJ0IvmxM+YrzYItyg7n@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaYZXcyhR2WqYUtU4sMpFO/EnYV30C9owEdqLOY6UU1jmkSu7
	1T/bhhPsEdrsdv9Mu9zpL5pqE4IUZp24xKPoa//MfE5DO2LARg6mN9Ic/A==
X-Google-Smtp-Source: AGHT+IFTHRbGmXXy3otnNo/S+vtfWBLx85XWxXNsu+O3sqQzvqNugpbE9Xjs1vIIF3mQZz2KCe8V3g==
X-Received: by 2002:aa7:8893:0:b0:70e:9213:f321 with SMTP id d2e1a72fcca58-715dfb69069mr264995b3a.14.1724868083607;
        Wed, 28 Aug 2024 11:01:23 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143434294asm10300127b3a.216.2024.08.28.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:01:22 -0700 (PDT)
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
Subject: [PATCH RESEND v3 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device
Date: Wed, 28 Aug 2024 15:00:57 -0300
Message-Id: <20240828180057.3167190-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828180057.3167190-1-festevam@gmail.com>
References: <20240828180057.3167190-1-festevam@gmail.com>
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
Acked-by: Heiko Stuebner <heiko@sntech.de>
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


