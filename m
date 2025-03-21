Return-Path: <linux-spi+bounces-7264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F9A6B7F7
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4A03BC06D
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3131F17E5;
	Fri, 21 Mar 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sieHespP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F71F03D3;
	Fri, 21 Mar 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550374; cv=none; b=tk810/4aUUVOjKhV+bQ8Y7s4UEKuFlX79RsgL1JbPXx4uJnTDrELynTu+LKr+XAIbMoeqfwz1NwbdXQqM8VNqJ+L1K83vTsQN8WXGKkaazNYfXmM4MlLmZY/oi0bmsiu1uMVxXdRJAHQjJhMcCOQBWFAaVOY8YMUWHEHOElKC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550374; c=relaxed/simple;
	bh=HJiQ2a+yVYKQb53Rbx+LpOGUTCdBuuNIE/u8MjDDamI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZYCsk2ce+nwPFM2pBZwX+Y+bPpN4SvaQBv5hi+bP3VXYKfu0UjKQk23u7myhGMNlcMFQ9OO+fwd9F8FtWc2jzNMU8CFtmdqGAhiQeVMdrLeBYfZP/558EYcypP+7OeupzkhAUlknBYrTxVSwUM2XZfDHAgP4Ja2VbYExtkHCmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sieHespP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7Wugv022748;
	Fri, 21 Mar 2025 10:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=7Y7qy82W/MHyCEGXEwG2Lm
	tsCr2HxaEkUE++ooAr6hc=; b=sieHespPBE871IVXmcCJp+MWOXdP3dKvauL2JH
	uH2kHRNpgYjjk/PEp2QM+uM9HNDZLOdV8neSNY1zHNfcNpYV5UPPl317EXHk6s1c
	WwfRXK97/VQ/q9kmPWXO4orkhNhtW3om4yrRtQL23HAIk1BkaCymJ0Ftv3oOTULb
	lVZauc43F8dN6q+DUCiYVsDThhi/ZyFNpfj7+8Dr3a+NGIo7TWJEKU9rqqLaGXke
	sdf997s7G3LHsteRcbyjar1CZ8y7k0qWIoowlbnUmlGXfTSplgV+qqC4yLw8VZwv
	czADI3at8qrExPMvdxFM6DSNuB1Ecw0HT0z8iC/wyvbaVeAg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45h3tqrq41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:46:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CBA5D40051;
	Fri, 21 Mar 2025 10:44:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA89F7C17B5;
	Fri, 21 Mar 2025 10:44:06 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:44:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] spi: spi-stm32-ospi: dt-bindings fixes
Date: Fri, 21 Mar 2025 10:44:05 +0100
Message-ID: <20250321-upstream_ospi_required_resets-v1-0-9aa4702e3ae2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOU03WcC/x3MQQqDQAxG4atI1h0wo9XSqxSRUf+2WajTREUQ7
 97B3fs27yCDCoye2UGKTUzmKYFvGfXfMH3gZEgmn/t7Xnh2a7RFEcZ2tiit4reKYkhhWMwVZXh
 0XFfMXUXpERVv2a//qznPP7YLko5vAAAA
X-Change-ID: 20250321-upstream_ospi_required_resets-34a8b17611b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <christophe.kerello@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01

Make "resets" property mandatory.
Update spi-stm32-ospi driver and dt-bindings accordingly.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
      spi: spi-stm32-ospi: Make "resets" a required property

 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml | 1 +
 drivers/spi/spi-stm32-ospi.c                                 | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
change-id: 20250321-upstream_ospi_required_resets-34a8b17611b6

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


