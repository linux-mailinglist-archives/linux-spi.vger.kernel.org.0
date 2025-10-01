Return-Path: <linux-spi+bounces-10404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0022BB17EB
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905884A4729
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D452D5419;
	Wed,  1 Oct 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1ZAaQka"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63C49620;
	Wed,  1 Oct 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343498; cv=none; b=G8bCGLvpDSTK1dx3sSjZR2GNfM/C8h21HTTftTPPCPtiHCG+cdiVNAPV4yDrXsbmE/sMgOpUb792SrYsJB1aiqvZEGiTxygoKG1NvW8wm0qRFrkb+4wfuqNB7J28t/qWm0rIIErwk5vv5da7r31XxAX4ykTuLN/r3P+XZpA9NjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343498; c=relaxed/simple;
	bh=PHcl1dE1lCANCZqnPCN9was7SxasDxHGeD7z9oJ+HwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6oVB7mhFADRniZDV3BMKOS73Nop1gEBvU+NUHFaxVFydysA5+LhbCkA9EIM/tsIVwry4kDriNK2XyiQ7/JYVrAff+7rYNZH08yfhUA31K9Z+u8Npd32Pgu9iom0rINijzZmQjaJdhZzxAOQcRQDoGdrJXr0cWXnBo2pxm73bZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1ZAaQka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EC7C4CEF7;
	Wed,  1 Oct 2025 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343498;
	bh=PHcl1dE1lCANCZqnPCN9was7SxasDxHGeD7z9oJ+HwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1ZAaQkaR+7mqUhr3lwMO7tVW4Ml2xCPZlHaxK0iaMeY0SI32oh+ynx613sKA7sQm
	 w20Yr0K6ZzIXW8/YTQQbXdPb3vR0QaNVckZFFIAIeEqTfCwLr9qgCchgKPysUeUr/y
	 i3a3eWX576XQvLrrl5eYRF8rLI56qCR8UIzenofLiDIIzUlJSTtlpABxw0Xz1iOXh+
	 Hw8WeBPKaGAPuBpuZLq7YTGWxGKmkMgHcOpGHIZxzFKHQfgSTO+30ZZr0l89jGg4Vs
	 8Cz7B/vfnLcBF0PR/r5d2fRxdCtqTclFSA89ziCulV4soaeWdPdRbuDVdsxFuUQKAi
	 yxHm45NoZapDQ==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jun Guo <Jun.Guo@cixtech.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/2] arm64: dts: xilinx: add soc-specific spi compatibles for zynqmp/versal-net
Date: Wed,  1 Oct 2025 19:31:13 +0100
Message-ID: <20251001-cheesy-shucking-c55431bbcae3@spud>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001-basics-grafting-a1a214ef65ac@spud>
References: <20251001-basics-grafting-a1a214ef65ac@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5g4PfVPLFBuaLYvor0B86romXUgNKzoaBX7dvqZsNgQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBl3iyv8Z19oCz7CxHdSsMdx7i6WLQbbVvra7Kucu21ZZ nNr6tSHHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI2iWMDH3erWf5/HituD/7 tS6NORvOEbTk/j+jWzOWKLWtqJzeuYfhr0hr/NqDhjO3Jr2YZHggdW+cZpaI61uBHc0fEyb9Xnq WmR0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Unlike zynq, which has a specific compatible for the Cadence spi
controller, zynqmp and versal-net do not have specific compatibles.
In order to "encourage" people to use soc-specific compatibles for new
devices using this IP, add specific compatibles for these devices, with
a fallback to the existing compatible for the r1p6 version of the IP so
that there will be no functional change.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Jun Guo <Jun.Guo@cixtech.com>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/boot/dts/xilinx/versal-net.dtsi | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
index fc9f49e57385..38af1a4e34f7 100644
--- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
+++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
@@ -610,7 +610,7 @@ smmu: iommu@ec000000 {
 		};
 
 		spi0: spi@f1960000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "xlnx,versal-net-spi-r1p6", "cdns,spi-r1p6";
 			status = "disabled";
 			interrupts = <0 23 4>;
 			reg = <0 0xf1960000 0 0x1000>;
@@ -618,7 +618,7 @@ spi0: spi@f1960000 {
 		};
 
 		spi1: spi@f1970000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "xlnx,versal-net-spi-r1p6", "cdns,spi-r1p6";
 			status = "disabled";
 			interrupts = <0 24 4>;
 			reg = <0 0xf1970000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index e11d282462bd..89c565bef274 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1076,7 +1076,7 @@ smmu: iommu@fd800000 {
 		};
 
 		spi0: spi@ff040000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "xlnx,zynqmp-spi-r1p6", "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -1088,7 +1088,7 @@ spi0: spi@ff040000 {
 		};
 
 		spi1: spi@ff050000 {
-			compatible = "cdns,spi-r1p6";
+			compatible = "xlnx,zynqmp-spi-r1p6", "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.47.3


