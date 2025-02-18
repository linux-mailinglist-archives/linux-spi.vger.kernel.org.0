Return-Path: <linux-spi+bounces-6861-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB07A39CF5
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 14:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC603B8A20
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EC26B09B;
	Tue, 18 Feb 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="b6k/BRVh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377D2417CF;
	Tue, 18 Feb 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883762; cv=none; b=Q51j+PZuqigl2tTIsrxN8v1HHCdgXzyNgy5rrKw10iEsITkzNIaJFjzKOhQnCzkwP0GpqGjZtutzB+Q+aq086Qw7edgqJZJ3fsIa4bX6szI+MCfJ9GmA81HL5+EoS9dvvYeQ0fQdrL7wtDQ5uLKups8UygE0Rd20KnjHPiVxMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883762; c=relaxed/simple;
	bh=y82PadXJbshw9eXVv7QcZwB3bwHg1iBXi+yFaeprgME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM5WlpgzXKzkz4rVuikLzyg9s0I+PoIRnDyMUu1ykLljTIzH0NpyC2AfcolMRViHmvmz1nOwOg9fz/DdSrjqCHxgllXuu+mvLYdc4e2BeGI427gXmjqJhUsjo6OsSlBYq5n5Nq+DHhb8V3hi5vIHJZPTQy4l4P/LrWH3iEVdRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=b6k/BRVh; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ICTR5j017234;
	Tue, 18 Feb 2025 14:02:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	vt89S6pzijLj7oWLrPzmzdiGrX2lA3/klO9FWSjgKdY=; b=b6k/BRVhJsBQ9EKb
	Rl7/GmNHPRt/zlEL1R3+L9A6TBRm/RmI7eJakVYZW+kAH5RLjBn8zRgR2mra7KK9
	nJlOGigAnIAscgb3hJZoUU34IU4XPHWvWSUELDUz/DbLa7EBBUt4VatgHFK7I0J7
	wOtW24i+D/lGP8NEFhTEn+JSvuou55pP5Q9vAMNjQv3iTRt+Jr1j5gYc7w9wuec6
	3ui8ZyKpQ3UVmE3HjssxYS8kw97WKfaQvsm6JsNjgrrDKOVwge76Nwr/Ih5KBElH
	kZ+PdS6zqjyN57ptGI+SMW/kcsABCf2rpy2ya6o4rZ5ubJFv2w5q/VITBUL2mVQz
	nrjJ1Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tkvmmcrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:02:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AECFF4002D;
	Tue, 18 Feb 2025 14:01:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 617D83276B6;
	Tue, 18 Feb 2025 14:00:07 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 14:00:07 +0100
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
Subject: [PATCH v4 6/8] arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Tue, 18 Feb 2025 13:59:58 +0100
Message-ID: <20250218130000.87889-7-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218130000.87889-1-patrice.chotard@foss.st.com>
References: <20250218130000.87889-1-patrice.chotard@foss.st.com>
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
 definitions=2025-02-18_05,2025-02-18_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add pinctrl entry related to OSPI's port1 in stm32mp25-pinctrl.dtsi

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 8fdd5f020425..cf5be316de26 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -101,6 +101,57 @@ pins2 {
 		};
 	};
 
+	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 0, AF10)>; /* OSPI1_CLK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+	};
+
+	ospi_port1_clk_sleep_pins_a: ospi-port1-clk-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 0, ANALOG)>; /* OSPI1_CLK */
+		};
+	};
+
+	ospi_port1_cs0_pins_a: ospi-port1-cs0-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 3, AF10)>; /* OSPI_NCS0 */
+			bias-pull-up;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	ospi_port1_cs0_sleep_pins_a: ospi-port1-cs0-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 3, ANALOG)>; /* OSPI_NCS0 */
+		};
+	};
+
+	ospi_port1_io03_pins_a: ospi-port1-io03-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, AF10)>, /* OSPI_IO0 */
+				 <STM32_PINMUX('D', 5, AF10)>, /* OSPI_IO1 */
+				 <STM32_PINMUX('D', 6, AF10)>, /* OSPI_IO2 */
+				 <STM32_PINMUX('D', 7, AF10)>; /* OSPI_IO3 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	ospi_port1_io03_sleep_pins_a: ospi-port1-io03-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, ANALOG)>, /* OSPI_IO0 */
+				 <STM32_PINMUX('D', 5, ANALOG)>, /* OSPI_IO1 */
+				 <STM32_PINMUX('D', 6, ANALOG)>, /* OSPI_IO2 */
+				 <STM32_PINMUX('D', 7, ANALOG)>; /* OSPI_IO3 */
+		};
+	};
+
 	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
-- 
2.25.1


