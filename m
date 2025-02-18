Return-Path: <linux-spi+bounces-6853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94FA39CD9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4551893958
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E16269807;
	Tue, 18 Feb 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gmSr6x/+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370C23FC54;
	Tue, 18 Feb 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883760; cv=none; b=SrUw9uSlPWXMMO/oU8GJ+ugvkZ9NRnYms54E+fJzG45eVzmCoOW9AGkAsZ8ME3rzsmByaRWA8JuEICbFsCxju4X+vT3kpNgfMHa4HspzGYgI2PA1zMk2EEazvhjORrSxisuE/8YWQ2B2SpQZostcwQc87lnIpQBxiqJ/Tc9aouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883760; c=relaxed/simple;
	bh=3FJqN6EwD8+bzIowll8O8GIFxS2xh1EL0QvmtMy+ma4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ3klELlXQhMe4mzgMaTd04FDUNB+aZURTAN0PJZkBuNIRIbONoI7bPBgYaF10PimGlePkTFX2NjZ3SP79pKfFXgyhtOJb9mVM+2ov5VRhhAHThQDYYpI4Tp3UNdixbSB3zmZ6KmdcLVg3vqd6A0Xe+WoTDfjuzMzKCeBp+u0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gmSr6x/+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ICTR5o017234;
	Tue, 18 Feb 2025 14:02:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	L+7sXH1zQ3Bs1zuV6xldCwud87Dn2o2qNqX9CUqAE+w=; b=gmSr6x/+CHsp6Q9+
	0KqjY2+mj2qsUHFDQBt/G05UPyMU0P4Ddpy/Eew+aN51eNUgXW6ZT+jKBLauVqrm
	nHFVUFeTtXj52iQhv92m3tawpSP4E7KWCYCRdgSUxtyl2GxcPmwVTY46SKGW5anV
	eUjr7zlADEuGdAUrsCchL/8YKwLIYv/jajjq9iI+VEp7UmEmfRe0v7bQqiwy+3ll
	AqRfJRxmkhk4q65TCEHcCgiJE/xfyf9TEaGqjh3XMklmfmnSp5PPiNPV7mhPDgij
	mRfTyOmysESL1xSVlVvV8qmCmpWogpyx02ehT7EqlRl0JAi5dthodW+Py24IMr/0
	Eae64Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tkvmmcs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 14:02:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3FEAC40051;
	Tue, 18 Feb 2025 14:01:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8F933C139B;
	Tue, 18 Feb 2025 14:00:08 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 14:00:08 +0100
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
Subject: [PATCH v4 8/8] arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI driver
Date: Tue, 18 Feb 2025 14:00:00 +0100
Message-ID: <20250218130000.87889-9-patrice.chotard@foss.st.com>
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

Enable STM32 OctoSPI driver.
Enable STM32 Octo Memory Manager (OMM) driver which is needed
for OSPI usage on STM32MP257F-EV1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 246a13412bf0..b089cf4b90a1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -577,6 +577,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_QCOM_GENI=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
+CONFIG_SPI_STM32_OSPI=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA210_QUAD=m
 CONFIG_SPI_TEGRA114=m
@@ -1506,6 +1507,7 @@ CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_FSL_IFC=y
 CONFIG_RENESAS_RPCIF=m
+CONFIG_STM32_OMM=m
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_IMX8QXP_ADC=m
-- 
2.25.1


