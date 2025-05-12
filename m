Return-Path: <linux-spi+bounces-8069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3802AB3038
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD93B50E9
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951782561A1;
	Mon, 12 May 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kd7B7NGk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E832550D0;
	Mon, 12 May 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747033414; cv=none; b=c03KCBqh/95z2pRhg6iq4AedYDXTE3K8oQy8qO+unfLPP4LebMqB9EWBXXS2K2C0/czv48nd8Vy+5Hg4MVjWoLRcp6Z+0qXeSkqDl/r9Q3fm+pZuny2TE6g1Bw10zsgcIa2yCuUDMLob8MJo4MIK+InWxm3rXj2oEzMg6BvNREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747033414; c=relaxed/simple;
	bh=nDptblRdB6kbWyDdFocql4XJth9/Hrh1Kx84cdZ9fKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=f0XVwI4Gzj6dCdkcUZXItFaoN8Fp8pMLGn132OxaiPh8W4+laJQ6JjPyO5OrhX8fyBStNcVXJY7OH/o9I+utmyboVzBCdnfRCI/+4hX/12UZtYQvxpxLZ/W3l/Nxt+RPHDmT39molhVMqwsHatWxOyHfJEAuU+kfJQrnuTefza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kd7B7NGk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BLMiVR021016;
	Mon, 12 May 2025 09:03:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=3fdcVl0cGdqaLl1bpQLUPK
	GXcr9zQxv8eka5RMO2E4A=; b=kd7B7NGkyVWhD4WVakC/n/+fN8BQm9r9jUPPND
	4KrEIbE/H289Y03oJcowrq4pY+Lx4New6FvDMhFNveK1ucJYcQDfCzIceLfP4AF1
	H6Ui44dQTxFOj+x2fGHY/mC8DB4x3lcI2ylLl44KBV89EEd4kPQt/2bn7CEpevzJ
	mnE4Kv6PdX8PiPR+mbDhfu4hEz0iqBEX5TeOeewZqnVZr/ajSDfmgobpUZ945O5p
	BpdlFP7JV/YJS5MBuHN3gw4KwjhcSkVyqnt1Q7Inymhc6wZ1zqEh4eY5dLZ3UU6D
	WGxXP1pP/KlpuY2952S8H6eMzHf3dhAhR6+IA7SE56nzRaqQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46jhrmu28k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:03:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5C5B24007D;
	Mon, 12 May 2025 09:02:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 40714A644DF;
	Mon, 12 May 2025 09:01:11 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 09:01:10 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 12 May 2025 09:01:04 +0200
Subject: [PATCH v4] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAK+cIWgC/43NsQ6DIBSF4VdpmIsRBKmd+h5NY6hcK4NCuEjaG
 N+96NJ0asf/DN9ZCEKwgOR8WEiAZNG6KYc4Hkg36OkB1JrchJdcloIxehd09hgD6LF16G0bACG
 2szc6ApVN3QEXUhvNSDZ8gN4+d/96yz1YjC689rvEt/VfOXFaUmFA9dIYrht26R1igbHo3Eg2O
 1UfT5bql1dRRhWIWp9Uo6Ti3966rm+dAZfqHAEAAA==
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
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01

As ospi reset is consumed by both OMM and OSPI drivers, use the reset
acquire/release mechanism which ensure exclusive reset usage.

This avoid to call reset_control_get/put() in OMM driver each time
we need to reset OSPI children and guarantee the reset line stays
deasserted.

During resume, OMM driver takes temporarily control of reset.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
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


