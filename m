Return-Path: <linux-spi+bounces-7811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3BAA5C94
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252231BA7AF5
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4A22CBDC;
	Thu,  1 May 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsWECJFl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49672253E4;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746091265; cv=none; b=nxNMxOjXpSixzO61Sdl7Y1p+vNmFIAOHLB3upWysu/FCeM1sUQnSRvZUIcxMqW9XMRK5NVv0zpByDANiZ9oI2p6P55JQ2OeF70J4BkmKIVfRfrttgZdESPYPI/FnL3or4OpmQX4qRsWKhEf9Mbd0BiHFv4B1LtInx7ZD38AW2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746091265; c=relaxed/simple;
	bh=bhaFvK3xEdQZODsOKhObltwsVATxMH+Qtg0rmi0q1eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qmtg2Ea89tjjvAm0YbfS11A75He5sYA78m55GBdLKV+xwK9jsB9ce5Mnah1MgHsbk/xVcGV3HzVADJXcxMhGbacot8/4H82IyX2b0888My7bDbr0g+yj7fZEqFlRTj9m8QylcuhyRwSjbQLnsK+22SGZ1nLqtc5i/75HgxTtDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsWECJFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D3E1C4CEE9;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746091265;
	bh=bhaFvK3xEdQZODsOKhObltwsVATxMH+Qtg0rmi0q1eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YsWECJFloHM0Jgs5Nhz/h45t5fALZxzFJG5jEiI3+JHISAj5DIrIVpGV2CQyq1s6z
	 VZC9BMc50ud3Kdsyk8xu2qc7UTUk2LQiw/cTz9qOWkI/ISeLXd8UtJl097uFLyiVQs
	 RDrhp8HB0PzupfttBsDDk6CTZlM7Okeh5rRdEnl3RZuSNZw7paWMTFExhQ0Ofw6i9s
	 c5KDGZPkl1YCPbxM28rToU+W5qkgJbtMSi2QB/66SocMznOTJr4u+LxqjozEENZ7Bw
	 mNhfXVuPfRuu+qxQ7KDYrRBjgV2lIfW37xVj4OzQO/Ws/dd/8dvknTHYDwcHyuPlI3
	 Ww9DO49XBRkKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A49EC3ABAD;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 01 May 2025 13:20:52 +0400
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5018: Add SPI nand support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-ipq5018-spi-qpic-snand-v1-2-31e01fbb606f@outlook.com>
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, sadre Alam <quic_mdalam@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746091263; l=1584;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=SBXgAzr3U3+TwfIxnK19bwzVraHDh3dGsR1Xo4qgNv0=;
 b=mOvM1N4u8d1/IEZw8j0dzk/IDbEQ63omKyGqY3Qw62xStrm5RIXFeKb/XZ1Abm9r71DWrnzgd
 ilacLtBDzj+ArC+MzCc7OEDVFwAz8XvCKtbJdMoVFFFvdLPczjca1hB
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add QPIC SPI NAND support for IPQ5018 SoC.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc47fda243b19174f77ce73fc10757d..b7454ed64474edb71c284bdb8e9f1e781b128437 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -238,6 +238,44 @@ blsp1_spi1: spi@78b5000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x07984000 0x1c000>;
+
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,ipq5018-snand", "qcom,ipq9574-snand";
+			reg = <0x079b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core",
+				      "aon",
+				      "iom";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx",
+				    "rx",
+				    "cmd";
+
+			status = "disabled";
+		};
+
 		usb: usb@8af8800 {
 			compatible = "qcom,ipq5018-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;

-- 
2.49.0



