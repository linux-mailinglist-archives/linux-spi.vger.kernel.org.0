Return-Path: <linux-spi+bounces-2458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73488AE1EC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA341F21FB6
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5060B95;
	Tue, 23 Apr 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWvOLx3Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A156772;
	Tue, 23 Apr 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867417; cv=none; b=cGutwzeTlgbCFPdF3L80KhS2hF3A0hL+gzEMDy2GHQTG9hyjcyK25h4YlWhZYxD6igcnBWex4ZVSK0lObE+ccIMs211UKpUTBTWdSSabnmL61jntXXqAXP3nMLsqL/erpnP2G3pTWXQ++nJvlWmVZSKgu56SeVoc6bexWad7X5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867417; c=relaxed/simple;
	bh=D5nPqCyfylNeNN8NxRke0D9NYMsok42vmKtGncvphR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cktfAhpTObXV/fCSzx8Fu97gEyfBw2Zr/pOsQ2X7G1lRQ+m4sJ0MIbZNPXnKjnirgURMOXGtz8KjuKPVr3Aj59CHCRRcw3PeL9yp1ZRt3n1IlKuFQ3RvEdkCn98fJahYkTjOBbJTcgIJ/EmegGz9YO5KL5wEuQv+HFb3cfEatcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWvOLx3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C38C116B1;
	Tue, 23 Apr 2024 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867416;
	bh=D5nPqCyfylNeNN8NxRke0D9NYMsok42vmKtGncvphR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWvOLx3Zr35/+b/0AFSL9heRIvfjivEIbL/JUJE0JRrNJIwr90hOafXUgSK2dMX8z
	 hb76OaGtEhH1apd0JbR4EXFziHqSz8UHrtQAlW4/tcn3gP9HFt4QKO97o/pAiG5LMX
	 +qt7MWmJUdy+qt55N7vuPPho5cSCyAvl/nPizz2G3yxDsDn6FJVA229GcwdK0ZMd+Q
	 k3NoexpuIOCZFPsJ/0I1SLaue9dHLLlnv9hEWLVwmRvreJVViDQWYVzNA+TNt9p6bP
	 LxaTjZroGFBDC6tzirXDX3NmQ5OWNFbOpGf6LSulctn6QrDr12ILE6z3By/ZmwVaLN
	 Kt/R2i0Z5p3Dg==
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
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v3 2/3] arm64: dts: airoha: add EN7581 spi-nand node
Date: Tue, 23 Apr 2024 12:16:36 +0200
Message-ID: <44d066871ca08d1ebb233bba1a1c86620f3036f4.1713866770.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713866770.git.lorenzo@kernel.org>
References: <cover.1713866770.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the Airoha EN7581 spi-nand node in Airoha EN7581 dtsi

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


