Return-Path: <linux-spi+bounces-8116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D4AB6DC0
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DC27B0CBB
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBC27B4EE;
	Wed, 14 May 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bzRwqKcP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072E27A929;
	Wed, 14 May 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231080; cv=none; b=iPtofRx8cB15NewFgbRIYi+5fAXBslP1H4PA4xyBI89fID8wzxibuuSZ054EtNQXIdsu7QqUw6Kmu6ggTJ/NoQiBxnOVuygQ+WyBCGhUMQpv32KLjXCpZQi8PtT3laQzZjEVCEQ6a1B1bOYQQP5tJWe0WcF25VDYn8fbjEKekMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231080; c=relaxed/simple;
	bh=g8HawaKYyuUQUSgfPkZXUlib9/BoGPW/jckwCWgOItQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FlXwNdNU0yYZlXl8fh+aJVbyMXkUnjvQfjC90vMxWg+5t/9CWEgmthgULqhxg2q8QtRHVOKSGnkt1xtLX1SE9uWCEXWIdscdkNNQXILNspShw3IKybNJP2RYScScYxzi71qXtH7af7Yfcz144/iwTdDHj94IGLGZr0IMJnIi7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bzRwqKcP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDDN8p014107;
	Wed, 14 May 2025 15:57:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=8D/8IcKWoCb70xhhkBaIqG
	mFt/1iue7zeTvtoB41pQw=; b=bzRwqKcPHFxAmBHoGfLz/4E0HEXA/zZAfiC9d/
	nFprCDpBUGjBCWJ4hOPLRr67wFWY3zoRAvORrmG1E/C4xWA3olRUvQ4L537eK6Iv
	1PKST+LxMeVVrn+czNZkuNudXmkmzs7gTJHvvesWi9MO2ogsxw5AHjppGhvgzLsC
	KKit4zflVoNLj3+wQYNzdrY94NZZwZwcBHRH8Zx22sNWLA/D0Y2HyDvbFhkLcxUJ
	gJTUmKQc6c5L63N+X6xhvC29Ot+mB8S69zpcT5R6eRQpADJtvIdBiWdI+swC08tP
	/Kh/BNk0x+UQ7P7HFJ2I95OrUTmXdgW6YCKLGLcfSFimQHsQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbds42uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 15:57:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 064F140053;
	Wed, 14 May 2025 15:56:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9417AF5651;
	Wed, 14 May 2025 15:56:03 +0200 (CEST)
Received: from localhost (10.252.7.3) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 15:56:03 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 14 May 2025 15:56:01 +0200
Subject: [PATCH v5] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250514-b4-upstream_ospi_reset_update-v5-1-7b5de0552c8c@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAPCgJGgC/43NsQ7CIBSF4VcxzNKUWyitk+9hTIPlogxKw6WNx
 vTdxS5qHHT8z/CdOyOMHoltVncWcfLkwyWHWq9YfzKXI3JvczMoQZVSCH6QfBwoRTTnLtDgu4i
 EqRsHaxJy1dY9glTGGsGyMUR0/rr4u33uk6cU4m25m+C5/itPwEsuLWqnrAXTiq0LRAWlog9n9
 rSn6uWpUv/yKi64RlmbRrdaafj25Jsn4Jcns9c20NdON02N7tOb5/kBIVZXJ2wBAAA=
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
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01

As ospi reset is consumed by both OMM and OSPI drivers, use the reset
acquire/release mechanism which ensure exclusive reset usage.

This avoid to call reset_control_get/put() in OMM driver each time
we need to reset OSPI children and guarantee the reset line stays
deasserted.

During resume, OMM driver takes temporarily control of reset.

This patch is dependent on commit 6b3754009f87
("reset: Add devm_reset_control_array_get_exclusive_released()")
available on tag reset-for-v6.16.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v5:
  - Add dependency with commit 6b3754009f87 ("reset: Add devm_reset_control_array_get_exclusive_released()")
    in commit message.
  - Link to v4: https://lore.kernel.org/r/20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com

Changes in v4:
  - Add a comment about reset sharing between OSPI and OMM drivers durig resume.
  - Link to v3: https://lore.kernel.org/r/20250507-b4-upstream_ospi_reset_update-v3-1-7e46a8797572@foss.st.com

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


