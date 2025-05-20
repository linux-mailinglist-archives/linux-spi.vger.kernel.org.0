Return-Path: <linux-spi+bounces-8213-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A22ABD416
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35663A1D71
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41EB26A1C1;
	Tue, 20 May 2025 10:01:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5301267728;
	Tue, 20 May 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735277; cv=none; b=fWBR9b/dhhoXcGWOn80+MaJ1OcYtyJg6MtHxhjWXtP3yqdLd/V8b8eNN7AepGDRpdQ4XuEoPttF0dpWmEu5uWEI4brA9+0rUS2Y92VD3PyP7nvXV3a9k2hgNtFeirg+SjLaeU5odwe/Mz0WxclY0TNEiqLy3FGIKMcDIrjBPGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735277; c=relaxed/simple;
	bh=BwwPyTo4XTaDIo9BJH06MmFU1Q2Sm9eKpj1fA+H+y78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CESghoCyo4qxT3o0bdCOyI5Lg5/Fuof6DPGSpjGvcSNrMNIo97GJ49OXZcmEYpuDnFwXICssGAKv3Qc6+oTVoW8KhMq0pEsDOu8RgEQ5FmXYYRGkYyp3Pw+MrpumAvPHDbjg0BX95vGhL/aRRJcwCYjaTHHXww0+MFo+zfji+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c04:7a30:290:8105:3706:5628])
	by smtp.qiye.163.com (Hmail) with ESMTP id 15b895913;
	Tue, 20 May 2025 18:01:10 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: Add spi nodes for RK3528
Date: Tue, 20 May 2025 18:01:02 +0800
Message-Id: <20250520100102.1226725-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
References: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkpDVhlCT0lDHkgaGBodT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtPQUwaSEtBSUJLQUNKS05BSExLTUFOTUlDWVdZFhoPEh
	UdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQktLWQY+
X-HM-Tid: 0a96ed23cfbb03a2kunm0a9e35a49fab8
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6LRw4CDE3EBo9FwgqNhou
	HhEKFCxVSlVKTE9MTEhOSUxKSkJKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS09BTBpIS0FJQktBQ0pLTkFITEtNQU5NSUNZV1kIAVlBSU5LSDcG

There are 2 SPI controllers on the RK3528 SoC, describe it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index b2724c969a76..4d60c09219f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -371,6 +371,34 @@ ioc_grf: syscon@ff540000 {
 			reg = <0x0 0xff540000 0x0 0x40000>;
 		};
 
+		spi0: spi@ff9c0000 {
+			compatible = "rockchip,rk3528-spi",
+				     "rockchip,rk3066-spi";
+			reg = <0x0 0xff9c0000 0x0 0x1000>;
+			clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
+			clock-names = "spiclk", "apb_pclk";
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmac 25>, <&dmac 24>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@ff9d0000 {
+			compatible = "rockchip,rk3528-spi",
+				     "rockchip,rk3066-spi";
+			reg = <0x0 0xff9d0000 0x0 0x1000>;
+			clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
+			clock-names = "spiclk", "apb_pclk";
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmac 31>, <&dmac 30>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@ff9f0000 {
 			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
 			reg = <0x0 0xff9f0000 0x0 0x100>;
-- 
2.25.1


