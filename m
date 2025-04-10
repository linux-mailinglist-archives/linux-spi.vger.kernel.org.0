Return-Path: <linux-spi+bounces-7522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19971A84310
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A4F8C01F7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEA2853F1;
	Thu, 10 Apr 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PS9dKJRu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E3284B48;
	Thu, 10 Apr 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287918; cv=none; b=mVBieADw2hl8uVsC+CpcYR4XBmRt9PgS/DNtYshOiNiyYM4SmQNahIv+KKr2GoXUBfw/jjSteRnB8EugCo4DnN6oAH2H1Wq6DYT6HDgm5VgZBQtWme05+UZSSGwBkmwR4qZti2qQ9R+F5AfW5jXW/tBBYO2Iq2+w/022Ywbebrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287918; c=relaxed/simple;
	bh=Qw+LJWOn6GsrTmB6nYecoQCT0gEmbamFFH7JDTnWq6Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rzP+Hjw6/CP2OV235XUaQF1VQmJSn1LAvs/q/MTRjOqQKES9ZP/q/amiBsMCBT5tdmsvFVbO1yUNPl7iT0g4PLZv5GuP96Tas8mwd/uwfy4lc0IA4rM/zh6SneQ4knR1qtE1WC1Ol4RdJfnyWHckB/ZEOkXb9UpCbJXoAWD/bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PS9dKJRu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9Vdxr019225;
	Thu, 10 Apr 2025 14:25:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=37TpAl9wbgOsV5Z6M//ml7
	JiFhzHgyko7+RFEp3uV6k=; b=PS9dKJRukFSJlYQ4JNFU7B++TZvDxUXzBPEIr6
	sJIaEnUVLrlokz5m7NLHV8G860gOG7lFjiMZpVG5mjYvlUMStbk8EISlEHslN+wF
	pP7dz7JM6mQga4DgvVDDFd1KmY97wYcR++f4ZQWqGLWNdZjpAz7OxR7sIIeY5aKw
	mr8a2VoY2BvGGDbR2hyH00iaf/2gY+fuywcHyDemjnLutaYr/2Cug56dyk3qIpZl
	zldbQZYnyd1ly4Ky1KmRwmiJbF3oJth5ztD47WsC/FIuaAKNoSqgbXSGs7oIBkNI
	fGlOa2oIOsXeY/r/B6wbWgPyKWvq7Oa1r1Izcl8S/YpcAwNA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw6eqmaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:25:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98C4F40045;
	Thu, 10 Apr 2025 14:23:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A54BC9DA5B3;
	Thu, 10 Apr 2025 14:23:45 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 14:23:45 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
Date: Thu, 10 Apr 2025 14:23:43 +0200
Message-ID: <20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+492cC/x3MQQqDMBAF0KvIrBtIohbaq5QSUvPTzqIaZqIUx
 Lsbunybt5NCGEr3bifBxsrL3OAuHU2fOL9hODWTt360g7PmNZi1aBXEb1i0cBAoalhLihUmZ/h
 rcv1460HtKILMv///eB7HCS2Mgl1vAAAA
X-Change-ID: 20250410-b4-upstream_ospi_reset_update-ffe26d13593e
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01

Add the released variant of devm_reset_control_array_get_exclusive().
Needed by spi-smt32-ospi driver as same reset line is also used also
by stm32-omm driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      reset: Add devm_reset_control_array_get_exclusive_released()
      spi: stm32-ospi: Make usage of reset_control_acquire/release() API

 drivers/spi/spi-stm32-ospi.c | 4 +++-
 include/linux/reset.h        | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 4a65326311aba694faafcef9e3c0ef7ae1b722e6
change-id: 20250410-b4-upstream_ospi_reset_update-ffe26d13593e

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


