Return-Path: <linux-spi+bounces-12068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49DCD3F1C
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612403010CD0
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F299292B54;
	Sun, 21 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdXw/GcX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120A207A32;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315120; cv=none; b=U43utSpFTikoA6P8pgotXL/lvlGElBiCxtdovi8w5Db6dLl15op2I9+D+A/ncBv7iIISeB5IgjQcvzHKa6OLaxTp914vui3IHu9AXNiPnZca3swPR9LLkStHCoWYQcSHbdvM4S+n9tWP1IUwFIOwA1mklyzNtb52vWhCExDq1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315120; c=relaxed/simple;
	bh=WIWtUvOCXqllobCBnum35H1c/nzaFuG9Bf2t7pmwke8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns+Qfix1kvLqTUXUuCqDnv0XM5Xcg2nBXRYZaMV6qgj6o90AtMU3olCQhk+yoQD8SgA0LX9nUORht3OTkY0kOH6YjAhKefJ4wqmcvGqiWTlw0wvR3xPPbQAgIN7AiswJcK3fnRleUECAHN60suqqrkmca18qAp6eh3GA4BBjOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdXw/GcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E52C19421;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315119;
	bh=WIWtUvOCXqllobCBnum35H1c/nzaFuG9Bf2t7pmwke8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdXw/GcX/Plbh9yviOIp+D7R73fpZzTGKvozTLxjXdP3f8OtJz+UdndQUKskJWTd0
	 VikTloCkvRmaDve4AqT8n0MOyg86SO9MdwzprKMMmOUWWGeWskO0qTGCYa5zLkI/4U
	 V0m0MH7YtMz1/ebRfT/69PdYSZGNrCGXZFg+G0uOvfHRNbJ2NO9pRawHW9vLhmNoiE
	 tXcNE/S4YOX+n5raBFuL8rR0OP4VEmmJbEBwcPh66IWHUSDIDjljmab7rBQdO+jl1d
	 WLcaLbW386OU+JabmttYqN0EeYMyu3FKzM4WYx1eVBdWHSkDNCkYNhORG/NUGH5kPI
	 dax1zsgEr+l1g==
Received: by wens.tw (Postfix, from userid 1000)
	id 5FDF85FE52; Sun, 21 Dec 2025 19:05:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR flash
Date: Sun, 21 Dec 2025 19:05:11 +0800
Message-ID: <20251221110513.1850535-5-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Orangepi 4A has a SPI-NOR flash connected to spi0 on the PC pins.
The HOLD and WP pins are not connected, and are instead pulled up by the
supply rail.

Enable spi0 and add a device node for the SPI-NOR flash.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index 9e6b21cf293e..055be86e5fae 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -400,6 +400,21 @@ &rtc {
 	assigned-clock-rates = <32768>;
 };
 
+&spi0  {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>, <&spi0_cs0_pc_pin>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		vcc-supply = <&reg_cldo1>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.47.3


