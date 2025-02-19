Return-Path: <linux-spi+bounces-6869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14FA3B30D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 09:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAED01652E9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAE1BC09F;
	Wed, 19 Feb 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EfIFORFx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC8192B66;
	Wed, 19 Feb 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952197; cv=none; b=m5xRCP/r/tMLSikkyvC+RjyqboN7VfoxlnoNoQvPPNVSrfVP1/5PbYGPIXYJA4H5aVEiEKrvXxR3iaucaU+VHP0vybUb1NNz/1FkouujwxuFA+pN62AC0GVvI0FxeaSa+sLyBTqyHfQU1+jiADoz9I7MmXkvh7y9fZ85eo10NHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952197; c=relaxed/simple;
	bh=MWUpN7jIrLDKnQNw3DaEFMaJ2vfXAzXJMeKWPz7nGUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjdoXo4yQ2AMZsCNYEugGYYwPL3YWPhIKHgnwGtjIj9N42MnojGokAldeZ0lfwzcoQXW+VvYVihXXXTkAELQNvn41Ejc6nTvvFeIJA/DGTzpM5YYURbWlFPKiw63PmJ0gjeIQ7VfUI4KbwEyxBlXgzUT7RmA0LrUZbvpXSlYnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EfIFORFx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J4sJMV004743;
	Wed, 19 Feb 2025 09:02:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	CdybSsPkvSWYJRfesz++DC37KlekJmyO0IzskUGhkLk=; b=EfIFORFxMxyN43/2
	Aj4awAbUK4oMUKyCpBUAouFdVciIDn7N3UhTpWcEmc3p41g3DOzZpqsz7ab0Vu5r
	Re+ENMhEJd1SecCLyaHxESB40XJg5RVuLTMUVxsEAgs0SR0XgF4H77HSiXgEvRgG
	jxsld9FuZqeMiywhnC5YgapDFh+8x763Bn/R5yhpQGkdkoPj7m6xWQcINEbqqCYr
	Llpn/9ekwoE7RPYtQBeQu5Yy5Xa+nPMHc3w0q3HT92/4FPcsavQzNpyaNdG16cJk
	Qf1vMnSYQU+m5ZLsbpVYxO9mvg4nDoXUuJ2U2XlaYapN0GHXz6UecfZJIvVxTNSU
	LMStOw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44vyym26sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:02:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ABB4640044;
	Wed, 19 Feb 2025 09:01:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56C2543E460;
	Wed, 19 Feb 2025 09:01:16 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 09:01:16 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH v5 5/8] arm64: dts: st: Add OMM node on stm32mp251
Date: Wed, 19 Feb 2025 09:00:56 +0100
Message-ID: <20250219080059.367045-6-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219080059.367045-1-patrice.chotard@foss.st.com>
References: <20250219080059.367045-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add Octo Memory Manager (OMM) entry on stm32mp251 and its two
OSPI instance.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index f3c6cdfd7008..2565236e369f 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -768,6 +768,54 @@ rng: rng@42020000 {
 				status = "disabled";
 			};
 
+			ommanager: ommanager@40500000 {
+				compatible = "st,stm32mp25-omm";
+				reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
+				reg-names = "regs", "memory_map";
+				ranges = <0 0 0x40430000 0x400>,
+					 <1 0 0x40440000 0x400>;
+				clocks = <&rcc CK_BUS_OSPIIOM>;
+				resets = <&rcc OSPIIOM_R>;
+				access-controllers = <&rifsc 111>;
+				power-domains = <&CLUSTER_PD>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
+				status = "disabled";
+
+				ospi1: spi@40430000 {
+					compatible = "st,stm32mp25-ospi";
+					reg = <0 0 0x400>;
+					interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&hpdma 2 0x62 0x00003121>,
+					       <&hpdma 2 0x42 0x00003112>;
+					dma-names = "tx", "rx";
+					clocks = <&scmi_clk CK_SCMI_OSPI1>;
+					resets = <&scmi_reset RST_SCMI_OSPI1>,
+						 <&scmi_reset RST_SCMI_OSPI1DLL>;
+					access-controllers = <&rifsc 74>;
+					power-domains = <&CLUSTER_PD>;
+					st,syscfg-dlyb = <&syscfg 0x1000>;
+					status = "disabled";
+				};
+
+				ospi2: spi@40440000 {
+					compatible = "st,stm32mp25-ospi";
+					reg = <1 0 0x400>;
+					interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&hpdma 3 0x62 0x00003121>,
+					       <&hpdma 3 0x42 0x00003112>;
+					dma-names = "tx", "rx";
+					clocks = <&scmi_clk CK_SCMI_OSPI2>;
+					resets = <&scmi_reset RST_SCMI_OSPI2>,
+						 <&scmi_reset RST_SCMI_OSPI2DLL>;
+					access-controllers = <&rifsc 75>;
+					power-domains = <&CLUSTER_PD>;
+					st,syscfg-dlyb = <&syscfg 0x1400>;
+					status = "disabled";
+				};
+			};
+
 			spi8: spi@46020000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.25.1


