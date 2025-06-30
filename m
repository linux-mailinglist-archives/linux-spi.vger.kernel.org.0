Return-Path: <linux-spi+bounces-8879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B544AED700
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 10:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720EA1898D6A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB46F17C220;
	Mon, 30 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6yrs2Wn+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A221FF55;
	Mon, 30 Jun 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271712; cv=none; b=Wk//RLuDbLOGzxrNpOKca+FmNATz0MX9LW/Sm2AFa/RonVz4eGPr3xOCxl8MykTVXfF7YQnI8K1o24N/IIGcxqyoj+OkilW/OZjAczrg5iY4XkrViZ7nkgZEKZ7gN9vfSJ5fWc00EO1iNfM5VXAZRqDuL5yLK+K79sVzi92xeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271712; c=relaxed/simple;
	bh=bO0wNSTcJpD6QAr1bsa0anydA+/iZo70P2ARQ4NvovE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gBxXVwAjRJqmzX1o4QN7eFJL82Y4JnslqEngZwJwrAACcmaoZaFWNuMqXYCWZvp4KNQLHEPqQ+nQiZF8sOPHEAh9kisvhY9QmYurLbWYj1GUqXMdbNcBF1qY4t4kLmgUabXqiDrwy5IKWKdnFmqJ/frF7srK/zQIdZW8lhaVA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6yrs2Wn+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7peFA026641;
	Mon, 30 Jun 2025 10:21:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=IpPSj43m1cefXVsku8pwgV
	hOCIYnHfCUw3HEbomrVW0=; b=6yrs2Wn+1eiPM/Wk0jH/GOVMrh9S63bUTG2ds+
	xCMDGGXmYgD9ds9POLQ8Yw4gQ28ugSurkbOV9sS3O6kc0EnV03Ne7R7G5o4+I3Yk
	J3ujCzgnWaRa3BE5R6MARkC0rY59SFPystbaVy2sDP15B8VaEVHM8fnIXipgN6aH
	lKsC8T5px89cq/uPBu1Sk8xziHK4XEcc94V9CU7ipiB0MdeT66zCBHBPBsv4GcIt
	xsLsExjaf3iH33nZTjHIrdd1FZziAVQCBoU8ShedLcLimJTBTwaKGgiiv+wESMYy
	5+asimpNUK8W9VoqyU/vcd45xnT9ck2LZxhG5aktWzfKza4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jubnkrwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:21:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 28D1A40045;
	Mon, 30 Jun 2025 10:20:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC2F34A24F6;
	Mon, 30 Jun 2025 10:20:16 +0200 (CEST)
Received: from localhost (10.252.20.7) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 10:20:16 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 30 Jun 2025 10:20:13 +0200
Subject: [PATCH] spi: stm32: fix sram pool free in probe error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250630-spi-fix-v1-1-2e671c006e15@foss.st.com>
X-B4-Tracking: v=1; b=H4sIALxIYmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM2MD3eKCTN20zApdCzMDE0OzpLQkS7MUJaDqgqJUoDDYpOjY2loA4dS
 aHFkAAAA=
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
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01

Add a test to check whether the sram_pool is NULL before freeing it.

Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
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


