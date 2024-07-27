Return-Path: <linux-spi+bounces-4017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7C93DF30
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86D81C212F8
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AF47F4D;
	Sat, 27 Jul 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPGD0RJ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D353373;
	Sat, 27 Jul 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722080926; cv=none; b=UGLX4EWNGtljmxNP3XxXTYXMKoesCl6xfIsZ4lMgFZ9g5D1n1EhbTQ7hm9EYgFUbDq78gKYxOCRGRKfVhntyC7y8GV6OQM5hz3qyH7vrnZ3HfJnLBz/O322ivEo9oF5koMrFT2sirTQD0Ve8R4Wg2SjGq6SW0KU0lsjGBHoEZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722080926; c=relaxed/simple;
	bh=PFd5L4vY6MFEbobL3PfpcKVz6T4XEkV+SklT8sIl0S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQAzsOUQFgotvRjyK93pTM1/dPK7g6lp1kDlybfJQuVkjpLg+VT0gYloh/RxlrE5jHuhK5Xppp19plfCqs7XZV47u9OUncxczVYq631tv4I3xv57+D3+f3fa0Am9e8pkdIs2gSF92R85e3UqsNb2XAvAms4wjI1YaeZM7RbcaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPGD0RJ3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso2518478e87.1;
        Sat, 27 Jul 2024 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722080923; x=1722685723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKCRLjbQA6RvyM/1xlZDuHSO8eeRysapt2U7o6q2WV8=;
        b=IPGD0RJ3BevWz1KJRJYX5d83LUHStn24nGPRAeZsMUDssALNGQyNa9Ifw0pVv/BbB0
         x0xc9MbhVWqJjomrY1Y6EKZEE6+mz6IDqzihCyR+4EyWn+R2rh2uLRRYGlnHaNhRcOFK
         djVRvoA+igKZBTjr1M79Qjr6Me0yXoBGu7gsJMcFlahNT2ljmS+vJK9FmroR8kl8LgJE
         AZoxehXuHC5k22wcHAfYVYKSpyQF9W3PZUpXRXOGAvbKnZJTGJrCFJv1iCCcEeulcpCF
         BvzBwUuOotYpO2d5Dw0w/6Q8HvU3Kb//K15C3zhpe7pbli5vXEPEteem2rO0NXtF30Vj
         YVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722080923; x=1722685723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKCRLjbQA6RvyM/1xlZDuHSO8eeRysapt2U7o6q2WV8=;
        b=GT1lxOXqlJAfNiJWWEVq6CuK4icmU1/TlQxvaM/9YWdUfl6BDNwMWiNrW1Bzt0+rhV
         XfNHq98uynpyIpYzEOfrX6i45j2dQb1pe+76vGr1Fa8A+rKqLQerXmfw1RY1CoukbNmt
         rjvtZpcJz4Y+fb32VrG5qab6mROvGN/PZ3ZEuSUOFhmwvUZLvswn+0Bn/qJXY678IUmO
         pDfrGvOomVLgBchWcHHqQbn2pP2dJzZYKMYmU6TFT11TKBWX2AzfJK3d8K+jau0BggRi
         fgjedSIizcj/1neAyXCcnrkSEOsiVPgs+Tmkypsdjhzu3eTRc2E1XmgekclALz4M2oEc
         y/yw==
X-Forwarded-Encrypted: i=1; AJvYcCUAW3v6IbIEGDY7rJiH8LW3HykC+xHUygBJ8HdfsVJbnrM82LfiFQJ4NDj8w6hS4ZsXTC8joYychm7Pf1q17nKgCAe0DwJa6ek4JHM0pVFNwhwvDpeLA2IIS0iv0qX6pMHR+FqvhQ==
X-Gm-Message-State: AOJu0YyuFAC2/YKXp0QA4gX/WnmNa9pE1jJ1dMJ8WrYmNMvlrsYJL96U
	23vhQPn+4EuHHbLqi+lEceypj+m0ng9dwDiQ7ia00HgVAtfrrElo
X-Google-Smtp-Source: AGHT+IHztZvH8zOyLXhWrkFxbk6bDQdmH6x989Bk067SMCu0neN94/uYnvBqs0sXqUfogLOjVpDGZw==
X-Received: by 2002:ac2:54a1:0:b0:52f:eb:aaca with SMTP id 2adb3069b0e04-5309b299206mr1338536e87.32.1722080922910;
        Sat, 27 Jul 2024 04:48:42 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9316csm272646166b.186.2024.07.27.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:48:42 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	John Crispin <john@phrozen.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7981: add SPI controllers
Date: Sat, 27 Jul 2024 13:48:28 +0200
Message-Id: <20240727114828.29558-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240727114828.29558-1-zajec5@gmail.com>
References: <20240727114828.29558-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 (Filogic 820) has three on-SoC SPI controllers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 64aeeb24efac..b096009ef99c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -109,6 +109,48 @@ i2c@11007000 {
 			status = "disabled";
 		};
 
+		spi@11009000 {
+			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
+			reg = <0 0x11009000 0 0x1000>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI2_CK>,
+				 <&infracfg CLK_INFRA_SPI2_HCK_CK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi@1100a000 {
+			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI0_CK>,
+				 <&infracfg CLK_INFRA_SPI0_HCK_CK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi@1100b000 {
+			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_SPI1_CK>,
+				 <&infracfg CLK_INFRA_SPI1_HCK_CK>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
-- 
2.35.3


