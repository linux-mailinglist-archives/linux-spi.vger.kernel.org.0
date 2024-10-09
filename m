Return-Path: <linux-spi+bounces-5174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426A2997150
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 18:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2392874C8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E261E3DEF;
	Wed,  9 Oct 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y+cRSKzo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A81A070D;
	Wed,  9 Oct 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490665; cv=none; b=WFTMKqrNLqdJCHnVpyrtAAfLkvI/KEuUhPIUvLwwdubTm8/MS6aBwsXX2YE+9pGbon+kYZ5RRYc/VFe+H0xOsUzZbhYjTYTpxJ6HLpdRWpB84ndnBZrjBSvQZwgDdkpruqGwlDaixdLhcKYWUJnVZxhDo6zKFsw6EMVgpdtDMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490665; c=relaxed/simple;
	bh=FvFvcMzxneL3O/8lgM11J4wFha3kLFiFZvn7amvbH+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZhkJzUWo6F209KANmbdF5FLpSkk1MZwkT1awkXF8U1r2KCsAhHY90Z5y7Nsi8beTNBQBfWNznMBSqSmSYmy6t+FEx5BNRmCiTrr04fZTjPZQ6s4B3Ryshg+CFVG+kF7LZ3OGQLxaeTuhKKLFvQtdv85zjNfRofb/is/uilI8u7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y+cRSKzo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499E6MDB005053;
	Wed, 9 Oct 2024 18:17:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=qJUiUHmWLUtzihvXk8d46f
	me/yOPE6VGUx1rsJMri60=; b=Y+cRSKzoOrOCLIA9ZT2HglYnCNh1nFBZX+kZkJ
	9BszGM8BdRB3PKMb6CaPFs/Mj2glyqKe7CfEMjmwtfb2wbyvfUhOOSTEs4rFmkFX
	I7sG6z+ROw+ZVYFrLZ6S0Kka3pGIJuVxXB+4Jt0nPjzrvETtnBkAA677vQIGkeQB
	l+mbHUQkkfVquZnrAIlDqVmLKNZ0LOp9UIV8kfvH5tHEIZangTWi/Viivam7IFG/
	egGufHn5g24VUQOe98YNlYGmXpNLvHqXW/4DSZ+7pIocCC3seCzJXO74VIAyJgZ8
	v1bWrBNf5w9fKfl7R7QcVvrk5HxgAeYEAQw2j7GjWFOaYsWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425q97t0uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 18:17:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DEB4240044;
	Wed,  9 Oct 2024 18:16:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9284726AF2B;
	Wed,  9 Oct 2024 18:15:58 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 9 Oct
 2024 18:15:58 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Wed, 9 Oct 2024 18:15:52 +0200
Subject: [PATCH] spi: stm32: fix missing device mode capability in
 stm32mp25
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
X-B4-Tracking: v=1; b=H4sIADesBmcC/x2MSwqAMAwFryJZG4jxg3oVcSE1ahbW0oIIxbsbX
 M5j3mRIElUSjEWGKLcmvbxBVRbgjsXvgroaAxM3FdGAKSiegVtczXaCmz4oVDfUcU+OGOwZotj
 8V6f5fT+gnhfSZQAAAA==
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

Fixes: a4e7908abf0c ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
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


