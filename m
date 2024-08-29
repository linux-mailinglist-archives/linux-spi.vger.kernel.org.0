Return-Path: <linux-spi+bounces-4421-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC45964317
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C671C23706
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A191922D9;
	Thu, 29 Aug 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITuQd2rQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F61922D6;
	Thu, 29 Aug 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931150; cv=none; b=mkZDC6XHbPfwFuXBKKq/ovk508C0kU+jc0j+IWqoPtBjxjMi2/gvMmooAN7QyFoA/XYhMQM8NWKL6r22jWH0HT59nfEk3KQVYo8yqchPjlRUHZ9R7OGvUcAoFq5gxAhlBhTmXKvbcz1RFfrp/zH3d95nynlCsqqcV5pKMTM8AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931150; c=relaxed/simple;
	bh=mtsKnJUCgyh4sO6tE1O6AsEeDERUlIp0k/BpQVMiSis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t47uPcAHOvDoNEpGMVndKW0lpBRNQnJ4CtWy8lHtZ7dqrcg1CgkU4YgJ7TaD0dAVqlHtd0KaJB2gc/XDcwfEngYnjOHDcUSbxeezdomMqHGtknWz6MJZWqtzKVUQwfBe95/cwkf0gOcZpIPYQ0+sG2HhcFuSzcqvEGlkRxSyNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITuQd2rQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202376301e6so4204875ad.0;
        Thu, 29 Aug 2024 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931148; x=1725535948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR8YT69dlvewjZEm1MxPVsGzbFeVzKVfTm8mac3hNEE=;
        b=ITuQd2rQXmdU8xBzxgJCITAOjsSRLXZdjrTw15GL7xFBAy1xMDbRSfs++L4U1kkcCE
         2cCxalRgrhtSUtKpQM6zhmZ5Q1d8VIe5ZrhkhcxonxKR2S/HaVuFmoDNMgCyZ2NSVb9C
         BXQjjhRQw+vMt64tw/gakJNeEqSxEGeUCbssFosw7954ZFjkhTn49orrtDoRL4GnLA2m
         zSXWCjXRyeQmhRz8WMWnnbTfCocCx9+y7ciwdQey2I92RgY7LWCAPwEYYTVRfxrOjznj
         jEBFFvaKZV6+hMoM3sk3IhW/NRtMts2eWo+aNuz5G3d4Imncl65KlgkCiiCbn7aGOvN7
         OUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931148; x=1725535948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR8YT69dlvewjZEm1MxPVsGzbFeVzKVfTm8mac3hNEE=;
        b=DGAZBu2Ved3ZkqrBKDCvjTi+2kYhqrJ4E4TidPQ9ykxkkL+jVq8YC40Pvja0C7qE4T
         /vm7QOm88cOgJK3TGZR3laqgkSq3BU2OJWHqy6sYKFuZudDMbIYpmwFqxtIwjEjnx/ry
         SR4A56pTs94IqyloPEsH6uY9oOhEp4ur2n+vDHl/FKC16vVXVsBiDDqkpUTvHhiZoPsw
         knN6g6bYscKGkJk5/iu6Lbo+xP6vF35/DWdYEnZHF0RhlaAay/BQDcnFBL7haDUsnbGF
         2/FHR5UvI5yaKYIjPVDippShvmmYAbP6M019c+ZuQ5wNBXcAwcvP/K3ZRoxGX4bB+S6h
         7SxA==
X-Forwarded-Encrypted: i=1; AJvYcCVbcq24rNW9fONAGNEuWTz3WpyIz8j/GipfQ/Rje4aI3ncEaqsqOqrHHnHUaYDtYOU9+tIdWXYoo9RB@vger.kernel.org
X-Gm-Message-State: AOJu0YwERSsQLcVrLUN5NgBkr1XsT4XSV6uwhKsvna8XDnE26fXAdhue
	B3tdAmJWIy2TCETOV6H8Ua4aYSOVxx27BfMzguz/9nYH5l5l7jSV
X-Google-Smtp-Source: AGHT+IEDzCGqMNpZtAvvXzDEKRi9FF1uQPctjTdp9Ly/vwn/x4NGJeKSEb0+hW/nAqiXQVAjGEtecQ==
X-Received: by 2002:a17:902:ecc8:b0:1fd:a264:9433 with SMTP id d9443c01a7336-2050c34eb54mr25492865ad.29.1724931147874;
        Thu, 29 Aug 2024 04:32:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20514fce4fdsm9652665ad.0.2024.08.29.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:32:27 -0700 (PDT)
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
Subject: [PATCH v4 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device
Date: Thu, 29 Aug 2024 08:31:58 -0300
Message-Id: <20240829113158.3324928-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829113158.3324928-1-festevam@gmail.com>
References: <20240829113158.3324928-1-festevam@gmail.com>
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
Changes since v3:
- Fix the series numbering version.

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


