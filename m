Return-Path: <linux-spi+bounces-8912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96CAEDE35
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AA2188E732
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022928B7C1;
	Mon, 30 Jun 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ktFywgu0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9828FA9E;
	Mon, 30 Jun 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288474; cv=none; b=tMH5biR/eedL/PBWLoWIU/afpbEwMHm/Wo27uQBN87uP8kG6A53/4zbwQrzSp69/xCOLWHxqPVZYaBBCHWHvlOBG5Frth8/m+tCfoofkRoLDeSPA+ryPV/fVsIko19A8O5RcptYEvUJz0nFVtO23VlfFJKLXPgAMQs2gXcsTRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288474; c=relaxed/simple;
	bh=xqG95de3HvfX3kUQMy4NI6tShOXZRGGVRVlzbTD4Mo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=d4jcVRap+Aj/YIuWWpMoqXU1xNEdg8Jes9rMN6afryeYtus2fDgo0HmQkkLN84DzuMokBME+iK2Zh4lxK5TNkhk24Kx8VejrTxYTv4GlXFXkco+fJ58HWyJjH9zULPXCmv55kTFm+7n7Eoutbrog5yXG5EeEQW86EfhIAQNxb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ktFywgu0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UAhJQk015201;
	Mon, 30 Jun 2025 15:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=fUjxTU75ZD40DdIr6Z8X8u
	fn/8WVlq3YFcObITGk6Pg=; b=ktFywgu01LSZVISgRlLmmzgVOepR5cNYEzOpn2
	zVWxXroIb6x+nogDQQJYqkMi69rDnI3XcnNo8tUAGKw35i4a2EjUO6yfrQKnL++J
	g9mBsNr6bkw3odTJZNAU8gViEKDpJ22NjwPRT5JlnAU6CPn7MTtaa9o3MBlRsCTh
	DaPn57w+QSCmN+fDiu9rRXTHb5vgvGiBa8v0eX+JHAYSvaj3JadwozxtUoj0ytef
	jLpyt0/I9nZ/9n4AR0VT43psrBcpO3lpL2ya97fANVEJHKtCg+4Kpz3zq9pbwbfv
	WIwtQlIWXagJSIHExqRLuVIHxZhyi45rnCdf3hTnU3AELskw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jsy4na14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 15:00:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F1FCF40045;
	Mon, 30 Jun 2025 14:59:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 40FBAB46C86;
	Mon, 30 Jun 2025 14:59:27 +0200 (CEST)
Received: from localhost (10.252.20.7) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 14:59:26 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 30 Jun 2025 14:59:23 +0200
Subject: [PATCH v2] spi: stm32: fix sram pool free in probe error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com>
X-B4-Tracking: v=1; b=H4sIACqKYmgC/2WMQQ6CMBAAv0L2bMm2yqqc/IfhIGUre5CSLmk0h
 L9buXqcyWRWUE7CCm21QuIsKnEq4A4V+PExPdnIUBgcugbpiEZnMUHe5kJ4stSH/koDlHpOXPR
 +uneFR9Elps8+zvZn/x/ZGmsc09l6RGLb3EJUrXWpfXxBt23bF1B6QmCgAAAA
X-Change-ID: 20250630-spi-fix-860416bfb96d
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?=
	<clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01

Add a test to check whether the sram_pool is NULL before freeing it.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
Changes in v2:
- Add Alain Volmat's Acked-by.
- Link to v1: https://lore.kernel.org/r/20250630-spi-fix-v1-1-2e671c006e15@foss.st.com
---
 drivers/spi/spi-stm32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3d20f09f1ae7..858470a2cab5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2486,7 +2486,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->mdma_rx)
 		dma_release_channel(spi->mdma_rx);
 err_pool_free:
-	gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf, spi->sram_rx_buf_size);
+	if (spi->sram_pool)
+		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
+			      spi->sram_rx_buf_size);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);

---
base-commit: 045719b1d0aab98e6abdd7715e8587b997d1cefa
change-id: 20250630-spi-fix-860416bfb96d

Best regards,
-- 
Clément Le Goffic <clement.legoffic@foss.st.com>


