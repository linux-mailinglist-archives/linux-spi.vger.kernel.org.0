Return-Path: <linux-spi+bounces-7983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F8AAE621
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A301E3A6CC9
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB228B7DC;
	Wed,  7 May 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CYSX60hd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD328A3F2;
	Wed,  7 May 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634013; cv=none; b=YWlciHVzwv/1QlrLDra6AFtlSprjnmczkuEcgzCTHGMA18SWdGJVfKnCd1yVeoqPbBZgU9A1ByPboQaDFSmy8Wdi9WO+QnXG++KdgH9TQCnvUvzKi94nwnpfivXewK8W88fgM0Ua8E9lEWrZmfqmtcsE/sKigO6fUiLaZC5KWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634013; c=relaxed/simple;
	bh=ZVcFxrUwLsp8UimoHBNXmU+mH22fGYyQQiTP85i9eWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tB2hbFcc5qhGmYd11FEgmOwRhcDmpdlq3bBybzZksA2NN3mpJt6GlbXVVKGmy9eDOpjCVgdlYZq/JveXtrRE0CakhYh0N2rwtAFW4Cu36XTxU5csqGOmMvTE0e6jctwICH/IBHsMj82Ei4e1xhSDGkpA7xBrmVttL/3xlfkBWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CYSX60hd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547G61NL018057;
	Wed, 7 May 2025 18:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=vCapwiYCSryyoPcvy0z16j
	reDDrgyZ3re2vUlLK59e4=; b=CYSX60hda3TKyka1XN8/exySgPYR9R5gST/ggB
	JN3LbA17CTpQUaJcVhOMurWwLwTBaYEaVvexTPWaEjfTfxLTRI0svuQzTUoOR4WZ
	V0dZrtA8hR8TD9+rMnWfd2adKHXZq4TWypteTSreRA6kPRRuG6ThEHv2kiA7dY2M
	V+Cx/k54g4A0gKjyqgGP2AuKTERuWHs2+g1bQrFbfq0+1sns8qQkpHXNdD0bQ6G2
	o/Uoozr4UAI5IS4yLJJRIjyXH+JlFYHNnI+4Lr2BDIDaR0LUgo4j0T9VBk4rnGKr
	efd63g6DYem97xBR1Xjor1fYbTc+1fBLzrG/lQuKiUoqdghw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46g1sxarxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 18:06:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F19D34004C;
	Wed,  7 May 2025 18:04:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3027EA5E0C1;
	Wed,  7 May 2025 18:04:15 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 18:04:14 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 7 May 2025 18:04:13 +0200
Subject: [PATCH v3] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250507-b4-upstream_ospi_reset_update-v3-1-7e46a8797572@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAHyEG2gC/43NQQ6CMBCF4auQWVtCa6vBlfcwhFQ6yCygTacQD
 endrZzA5fcW/9uBMRIy3KodIm7E5JeC86mCYbLLCwW5YlCNMo2WUjy1WAOniHbuPQfqIzKmfg3
 OJhSmvQyotLHOSiiNEHGk99F/dMUTcfLxc9xt6rf+W96UaIR2eB2Nc8q28j565ppTPfgZupzzF
 3prTFrMAAAA
X-Change-ID: 20250411-b4-upstream_ospi_reset_update-596ce245ada1
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01

As ospi reset is consumed by both OMM and OSPI drivers, use the reset
acquire/release mechanism which ensure exclusive reset usage.

This avoid to call reset_control_get/put() in OMM driver each time
we need to reset OSPI children and guarantee the reset line stays
deasserted.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v3:
  - Remove previous patch 1/2 as already merged.
  - Keep the reset control acquired from probe() to remove().
  - Link to v2: https://lore.kernel.org/r/20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com

Changes in v2:
  - Rebased on spi/for-next (7a978d8fcf57).
  - Remove useless check on reset.
  - Add error handling on reset_control_acquire().
  - Link to v1: https://lore.kernel.org/all/20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com/
---
 drivers/spi/spi-stm32-ospi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 668022098b1eac3628f0677e6d786e5a267346be..b2597b52beb1133155e0d6f601b0632ad4b8e8f5 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		return ret;
 	}
 
-	ospi->rstc = devm_reset_control_array_get_optional_exclusive(dev);
+	ospi->rstc = devm_reset_control_array_get_exclusive_released(dev);
 	if (IS_ERR(ospi->rstc))
 		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
 				     "Can't get reset\n");
@@ -936,11 +936,13 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_enable;
 
-	if (ospi->rstc) {
-		reset_control_assert(ospi->rstc);
-		udelay(2);
-		reset_control_deassert(ospi->rstc);
-	}
+	ret = reset_control_acquire(ospi->rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
+
+	reset_control_assert(ospi->rstc);
+	udelay(2);
+	reset_control_deassert(ospi->rstc);
 
 	ret = spi_register_controller(ctrl);
 	if (ret) {
@@ -983,6 +985,8 @@ static void stm32_ospi_remove(struct platform_device *pdev)
 	if (ospi->dma_chrx)
 		dma_release_channel(ospi->dma_chrx);
 
+	reset_control_release(ospi->rstc);
+
 	pm_runtime_put_sync_suspend(ospi->dev);
 	pm_runtime_force_suspend(ospi->dev);
 }
@@ -993,6 +997,8 @@ static int __maybe_unused stm32_ospi_suspend(struct device *dev)
 
 	pinctrl_pm_select_sleep_state(dev);
 
+	reset_control_release(ospi->rstc);
+
 	return pm_runtime_force_suspend(ospi->dev);
 }
 
@@ -1012,6 +1018,12 @@ static int __maybe_unused stm32_ospi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = reset_control_acquire(ospi->rstc);
+	if (ret) {
+		dev_err(dev, "Can not acquire reset\n");
+		return ret;
+	}
+
 	writel_relaxed(ospi->cr_reg, regs_base + OSPI_CR);
 	writel_relaxed(ospi->dcr_reg, regs_base + OSPI_DCR1);
 	pm_runtime_mark_last_busy(ospi->dev);

---
base-commit: 1c64de886b8893c0158097edd6ba08d527a2c97a
change-id: 20250411-b4-upstream_ospi_reset_update-596ce245ada1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


