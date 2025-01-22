Return-Path: <linux-spi+bounces-6423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23526A19377
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A9B3A71DE
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60672213E6E;
	Wed, 22 Jan 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NbUFs9O7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B463213E61;
	Wed, 22 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555213; cv=none; b=FhKillxbmf6jMtT4+bL6dFF2tCY51VHWkRTUN/Xov+177L1eS0DE939I/OuPHTFebEQl6djphKD5Yu54V6Mzhih9z1VZTVm6c6SyopuGTZG73IHB8CsuScwN5+nAAKmE7LieVLkC4raqXEMy8tbKdZ+YKg2y5b6MXRKhcUSvs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555213; c=relaxed/simple;
	bh=p/KgqP4wMFR8iFlCC5FODZMgG5iuqwv1mOJFLpPcIK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5wp+IW5URdI8+/gYrVyQxAQyC+oHr8W1lQi78TQ9WynVuAKC8VlLSyKdNzgQELLLNATVxoiCsXqlbg2aVZhZXqJwTY9QlCNVu7YCyBiKO/TN/n+dE29g8GpYkEYGzFyNeyX3GgwJHez+XDqyCgLrtvobVql0KMdKFYgx/KVCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NbUFs9O7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDUunu022398;
	Wed, 22 Jan 2025 15:12:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Zys7cbzLbgYRubKwlDGLHzjMTZRaAzgB0n6UIeGfSeU=; b=NbUFs9O7E1afZpdU
	In+Ag3uJaT/wlhZP1zsvmq4EpX63XSJqFtA7IVSuO3Cp7gGyIJvoHpz0whbylAYI
	ipD3BBDyLCtH02B30LDvOoyeYHuNNV8Cti8BFmjpmsocJvKO72FErXrvQXqk7qRQ
	Ymv6Kws+kz1RHrGH5CUss6bnRqT5LwljHLOQlXP2x/Q1AWinhOa8bXiUuH1Yzs/p
	d8L5bqWsuo88UacU7sxAZh2pm7z3+2vu3FS39pvUfgSZY86/KedzO4yq3R1ioQ7p
	975w3ZySESwcUl8LP+4x0PfOoPMDWu2SgUbGdulj1dFDydBt+1L+0TwgJlUW/uP2
	p0vVmw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44awjc17cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:12:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 142C240047;
	Wed, 22 Jan 2025 15:11:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 49A65294385;
	Wed, 22 Jan 2025 15:10:45 +0100 (CET)
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
Subject: [PATCH 8/9] arm64: defconfig: Enable STM32 Octo Memory Manager driver
Date: Wed, 22 Jan 2025 15:10:36 +0100
Message-ID: <20250122141037.953934-9-patrice.chotard@foss.st.com>
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

Enable STM32 Octo Memory Manager (OMM) driver which is needed
for OSPI usage on STM32 platforms.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 246a13412bf0..28df37d1baa6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -294,6 +294,7 @@ CONFIG_BLK_DEV_NVME=m
 CONFIG_QCOM_COINCELL=m
 CONFIG_QCOM_FASTRPC=m
 CONFIG_SRAM=y
+CONFIG_STM32_OMM=m
 CONFIG_PCI_ENDPOINT_TEST=m
 CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_AT25=m
-- 
2.25.1


