Return-Path: <linux-spi+bounces-5195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF19987D9
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B3C1F2466A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329F1CC140;
	Thu, 10 Oct 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Gik41LHL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73251C9EB9;
	Thu, 10 Oct 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567348; cv=none; b=CN/0i/BUto8FV7SyZZjPS6lguEZjTGJddvyFVPcmKIPN1nOiEeFDH1iE9zi5kHm31wEIx60IQz5Vqzpk1r75WhDLwRKlFVglJC9Eb+qdyg3KAf5Y6W+qBeFBlHxQWChCWiiOcpVGMT2ZKShxlwk28OWrrY152i5kSr5ccauBZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567348; c=relaxed/simple;
	bh=k0HtH83EL2wJQXYZ09ajW7eIIBzN4S0ykXE7AJ5b1So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OjRPloVTATJKLyxOSJ+5pP25rJBfoXGyTJAMvCaCIbBwcz6IMPjJLezyNQgsg64Xdo5XnQflpcPY638Dy5DUY9S5rw3HuSE0bZruGisPRHNtG0/6JoPrl4/Z/1Jg0ZsDv9WNh0wB1LpAfnKNyymPN6zEwBe2fVDwCdxwTmIb6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Gik41LHL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8i8eS000480;
	Thu, 10 Oct 2024 15:35:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=esXsrZ2YS/C1yT+ZzCtwwQ
	+71ddeQi/llzx1JUf1z3k=; b=Gik41LHLW8cAdrTWQZPOWhGCFI6nzYcgmi1DaG
	9kPZUEmwdN6NCEyWT7ASCbYOCaLN2yGp4OeouROtgJjGqPtFrV3M2YzwKZQ57VXB
	z2Awu2xTKSSTku7lQK0Q1MO7nKTxqiy1XYlOtckf0eoCPdOzxAixvTMC+q5J4KpT
	ak7lVGIGpXpjOIQiDg/2SU987UOpXugM+S2QLQWWnOnSYBgHYcJYC7bKXB0XUTKo
	5vvgv9w1rpvTgKWPfRPKx3hzUOlOLb1s/O8X4P75va4y3W2REWGVCF4vju5AuU4k
	4qsu8/gpy6lUKqC+oQeSwlMrx0DkY/j9Uaz3RCXPS/OZQabg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 423f1175hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:35:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1AA014005D;
	Thu, 10 Oct 2024 15:34:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6E7E273516;
	Thu, 10 Oct 2024 15:33:15 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 15:33:15 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 10 Oct 2024 15:33:03 +0200
Subject: [PATCH v2] spi: stm32: fix missing device mode capability in
 stm32mp25
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAI/XB2cC/32NTQ6CMBBGr0Jm7ZBpAamsvIdhgWWQWUBJhxAN4
 e5WDuDyvXw/OyhHYYUm2yHyJiphTmAvGfixm1+M0icGS7Y0RDfURXBabIV9SnvGQd7IVJR0tY4
 8WUjNJXLS5+qjTTyKriF+zpPN/Oz/vc2gQceV7+r+WbvC3Yegmuua+zBBexzHF3thBSm4AAAA
X-Change-ID: 20241009-spi-mp25-device-fix-e03406280c02
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

The STM32MP25 SOC has capability to behave in device mode however
missing .has_device_mode within its stm32mp25_spi_cfg structure leads
to not being able to enable the device mode.

Fixes: f6cd66231aa5 ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
Changes in v2:
- correct Fixes commit sha1
- Link to v1: https://lore.kernel.org/r/20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com
---
 drivers/spi/spi-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f2dd8ab12df831d54758d21ec1a68ffc40e2f0a6..da3517d7102dce5f830cdf0dbdee3e19184f69c5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2044,6 +2044,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
 	.has_fifo = true,
 	.prevent_dma_burst = true,
+	.has_device_mode = true,
 };
 
 static const struct of_device_id stm32_spi_of_match[] = {

---
base-commit: c2a59c892f20379a3e48124a83491a12374cd7e0
change-id: 20241009-spi-mp25-device-fix-e03406280c02

Best regards,
-- 
Alain Volmat <alain.volmat@foss.st.com>


