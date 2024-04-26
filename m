Return-Path: <linux-spi+bounces-2539-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7C8B32C3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 10:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2AAB23BF3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F713E89D;
	Fri, 26 Apr 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjzFKMMD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD213D299;
	Fri, 26 Apr 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120273; cv=none; b=DiIuJI3NzJQRje5JK0iq79RvAiQGVdd5g00QQKCZXfKHAadU4deHlCFXufLeDqLP51SfjKnwypK8QmYkBwnhCth2Wa9U2isfUkoIIX0b4FQpXHkqEv/HSXtg7lHIM7xr4B/aElxS68ybZkraO1xyP5F0Vq7VkS2mE16lFiISXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120273; c=relaxed/simple;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEK0wXD3oCWiMH90DQc9EU1yUh9LCOG0dK4ND2Zr7Cjel02XzPBMsQA2HrLGsyX3LVnpV4arNCY3OwPzCF+yCvvHn+AvC9guzCMDs/AQT7+YZBlxklJHq20Pm7ZuWjKUIBRbXlLf8fxiIPf9eRZh3Y9R5qiZ1KKQ6d4MEg+R0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjzFKMMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CDEC113CD;
	Fri, 26 Apr 2024 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120272;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjzFKMMDj9igqvNHFC/GYQ+bZYJj8fdS52+6Foo8b5J3EFzwoTTOxXH0v3wbj2e1X
	 oC5Xkxks3eDoQqvlTQYE/6e0PKnjbW1esCRTgfyKXQo17TZavnzn56ao5b08pxcWXO
	 YCs2rAFEavBHFMZQC9XygyB23XzNnY7JTmeOI8UM8m5wtr3O/i0HTWRxggDZ0MdPXH
	 fPSjinDILtyBu/2+ODSufue9vuKnqQNVy4RTV2iHZjSOeVwVrj2IeRgWXs6s71TNSp
	 yf154ke9FrgJposH8Pcyg03ORubgzJwLMDhZQtzbtQUelgXG4welhuHk4+fNJhKLXC
	 U+xRYThBHJb1g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	broonie@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: [PATCH v4 2/3] arm64: dts: airoha: add EN7581 spi-nand node
Date: Fri, 26 Apr 2024 10:30:52 +0200
Message-ID: <132a887e1b200d4a732ac2100ac81ae6137e43fe.1714119615.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714119615.git.lorenzo@kernel.org>
References: <cover.1714119615.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the Airoha EN7581 spi-nand node in Airoha EN7581 dtsi

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 5c4bfe3e1e5a..98c2a86086e1 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -159,5 +159,24 @@ scuclk: clock-controller@1fa20000 {
 			      <0x0 0x1fbe3400 0x0 0xfc>;
 			#clock-cells = <1>;
 		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x160>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
 	};
 };
-- 
2.44.0


