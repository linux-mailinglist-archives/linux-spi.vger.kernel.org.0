Return-Path: <linux-spi+bounces-6426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5094A1937D
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862391882874
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F3213E86;
	Wed, 22 Jan 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2pPULPLC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BC213E67;
	Wed, 22 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555213; cv=none; b=lxqIcl4zwTBGdwwXbeXOZcuHDgja4qbzKdPv9qUGNpXVOrlVeapHv2H8LwgW4Zc5AKnUajmvTTKTy58Eb7aa5XQDAYsozCNyOjEfhCFqOO9NAYLnINQuBMaKNzsJz1bIMC++uvYNgHfJ0lLuOljphTmVweXJFBglyiiZHrc/jLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555213; c=relaxed/simple;
	bh=Df3OFj9Sy/loGvXQQy9HJv9Pi8Utc642HweICzuwVmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgbR22LVeKJbraZX4iLM0/BEYVpPS5+yts2Wc4PR6ZOU8+Bk1vLnIOQf3sT67G8PTilCfKzz/KfnmRkJuW43YhKreAm7Lw5C9nNreHtk89Iih9OJGGSgqB4RDF1EmDRGtLXrRTHkf6M6XGJCisRhIYaIgq9auZCWJAf6u1sLT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2pPULPLC; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MAVP97000349;
	Wed, 22 Jan 2025 15:13:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LQeL0QIbGPtgqKXh5v+YN+NeJaVazIibxWZErW9F0fY=; b=2pPULPLCi9f9Agpu
	eaQV9qUa/ralx4fJG06TyRAcDeb6uvArpQxhhlVAs4mWZiBXxPn2GQwjw1Ql6/pc
	7k+AwzSrF4ZpB+7LCZkzKKz+2a/Sb5K2uaV9pMkiIvX4e17ZQ2WGrPH82YrJFsqU
	B4l1Zma4ugfsoLSWrq/d479DjgZPoYUfuioa6wHOMtSC3QvVp00VOozjrIV3QXgJ
	ekzFS6b1i6Ss4ieuNJ0f6CGbt6exa3ooCVxCsEM672arS91J1GlYmq/GlvE2RJK/
	6ob0jrbttu6iQkVx6OQNLFvoVb7k+rw0Mxtxaj0jrvSUfv0YmdhdK4H6GvYmBrGc
	blcvVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44ay0egrb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:13:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 514364005A;
	Wed, 22 Jan 2025 15:11:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07665294380;
	Wed, 22 Jan 2025 15:10:46 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 22 Jan
 2025 15:10:45 +0100
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
Subject: [PATCH 9/9] arm64: defconfig: Enable STM32 OctoSPI driver
Date: Wed, 22 Jan 2025 15:10:37 +0100
Message-ID: <20250122141037.953934-10-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122141037.953934-1-patrice.chotard@foss.st.com>
References: <20250122141037.953934-1-patrice.chotard@foss.st.com>
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
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Enable the STM32 OctoSPI driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 28df37d1baa6..dbd8ed3bbd7d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -578,6 +578,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_QCOM_GENI=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
+CONFIG_SPI_STM32_OSPI=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA210_QUAD=m
 CONFIG_SPI_TEGRA114=m
-- 
2.25.1


