Return-Path: <linux-spi+bounces-8397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04EAD2209
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C80170D15
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847501B425C;
	Mon,  9 Jun 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zbUEhb1w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37B1DED4C;
	Mon,  9 Jun 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481712; cv=none; b=NaKv2M3yprolmWChIkfhWYM8j3jFxBxeCYqfrNI8tVl6w05znQD+3/WJwhHh9erC4rBpOQFc0avDCy1OQSf6qe7uC0Ezs2Ly3FCUJBim9yEipnh87aEUklauY2WyOb8axNZn6yWjk6ITvJ0eceIjgDIH1LniY0jhs2m1780kZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481712; c=relaxed/simple;
	bh=6RlQJGYc3cQByqEQ5UnVltcdkYr558XiHh/+3IPkFFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EUHiYu/MdCIw5EL68v7NnWPAzbyu9uSfsd89W2KIj/4OoRHNa5i2RaLTX5XzdiuLaKCbnZjafUSi0E/NV4iRl5vqKN0XafMN2bIzXjSnF75oxwzrjZbPZi1UCrK5YmbQjfqaOGtR/MTXC8FaNkoqLyzIgbFKw10NdMypimW/Do4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zbUEhb1w; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Dtxkd009830;
	Mon, 9 Jun 2025 17:08:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=RHEwRJAXNMJDW0r76HBXTU
	vBrd9il/gic2C2Cm/Al7k=; b=zbUEhb1wGJdOJ/EdOcGNg/EOItH3HgAucyc4iH
	H/6bHmOMVjo3nWzrkxzox/38KHwSZ+84vdNY809jnf2dK4lDD3UzxWuzjbAyJrcR
	jQHGkOKT6wRfkj3EDEwcYq97C7wgngpdL+FMcHE2fjRmSW/DOqghihikjknX6e6o
	jYOEiH7+sQRRK4TDHyZO7gBXxCHRfbclXgOhcr1ENV+uC+pCEqTNkh/M1RDCWUwt
	hkuPcQsuw3iJwYRhV4yTFELIrzn+Xy90Gw5J2J4q5rPRr0R0wrgtjHn38FS8VL/R
	ZnObw8yfEN8Q6S8TJlcuQeL7jEEEc62pS/qwG2aEYPIsZeGg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs2g878-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 17:08:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 01A8B4004B;
	Mon,  9 Jun 2025 17:06:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18427BCE4C4;
	Mon,  9 Jun 2025 17:05:05 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 17:05:04 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 9 Jun 2025 17:05:04 +0200
Subject: [PATCH v6] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250609-b4-upstream_ospi_reset_update-v6-1-5b602b567e8a@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAB/4RmgC/43OsW7DIBDG8VeJmEsEhAPcqe9RVRaBo2FIsDhit
 Yr87sVZmiqDO/5v+H13Y4Q1I7HX3Y1VnDPlculhXnYsnPzlE3mOvZkSCoSWkh81v07UKvrzWGj
 KY0XCNl6n6BtyGExApcFHL1k3poopf93994/ep0yt1O/73KzW63/lWXHBdUSbIEblB/mWCtGe2
 j6UM1vt+fDrgbBb3oFLblEb7+xgwapnTz94Um15unuDU8Ek65zB9OzBo6e3PFj/O0JEAaCCC3+
 9ZVl+AH+8dva8AQAA
X-Change-ID: 20250411-b4-upstream_ospi_reset_update-596ce245ada1
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01

As ospi reset is consumed by both OMM and OSPI drivers, use the reset
acquire/release mechanism which ensure exclusive reset usage.

This avoid to call reset_control_get/put() in OMM driver each time
we need to reset OSPI children and guarantee the reset line stays
deasserted.

During resume, OMM driver takes temporarily control of reset.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v6:
- Add Fixes tag.
- Rebase on top of v6.16-rc1
- Link to v5: https://lore.kernel.org/r/20250514-b4-upstream_ospi_reset_update-v5-1-7b5de0552c8c@foss.st.com

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
index 7c1fa55fbc4726d2f3c5516245ccd81f59c3c44d..db6b1cfc970f6c80515a39073e2389311796da8f 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		return ret;
 	}
 
-	ospi->rstc = devm_reset_control_array_get_exclusive(dev);
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
@@ -987,6 +989,8 @@ static void stm32_ospi_remove(struct platform_device *pdev)
 	if (ospi->dma_chrx)
 		dma_release_channel(ospi->dma_chrx);
 
+	reset_control_release(ospi->rstc);
+
 	pm_runtime_put_sync_suspend(ospi->dev);
 	pm_runtime_force_suspend(ospi->dev);
 }
@@ -997,6 +1001,8 @@ static int __maybe_unused stm32_ospi_suspend(struct device *dev)
 
 	pinctrl_pm_select_sleep_state(dev);
 
+	reset_control_release(ospi->rstc);
+
 	return pm_runtime_force_suspend(ospi->dev);
 }
 
@@ -1016,6 +1022,12 @@ static int __maybe_unused stm32_ospi_resume(struct device *dev)
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
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250411-b4-upstream_ospi_reset_update-596ce245ada1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


