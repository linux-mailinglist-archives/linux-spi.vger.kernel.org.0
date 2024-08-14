Return-Path: <linux-spi+bounces-4191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C9951E3E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EC3283676
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D941AD9D4;
	Wed, 14 Aug 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qIJb/8lH"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D1B3751;
	Wed, 14 Aug 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648381; cv=none; b=JKtu6ZSc0XRUOL7YKKQtlLi/xze0MsGGKG2+P069MUQR79x4dRlXCD3ogsd/47YgZw00XZb5oyvgxDjFEuzjA9R2Bl6FHJoap3sWtEkkRTIuY8rd6ZiXReS5aHcpumpEDkcdNHD/tsemZkWu4IN4hmFecWFPpTlNeEDGbWnk6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648381; c=relaxed/simple;
	bh=DoSgsVFzInOYcU8QE0XkZwZ3WTtLNLotcTkQ02D7LlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdBR7+bArp4XU+k8gsI2r2BeEBzAkPtszITRhzZg0SUxdkCpyfjhB2Emgh33uNrMZ+2uKWTL+z8f7+iMDLVzNtoSBYy34VvGxAycbNlGnUpnb9W6ldtCGxdnIu8Hym4P4cfrmSvEcSSwOlHW8ksO4l6DytcQxItdnkK5zvnlKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qIJb/8lH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EFCmGQ084686;
	Wed, 14 Aug 2024 10:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723648368;
	bh=DSELQhqczh8otWLp4IHWpTWwH59Ek4RdGCsN69OPi1Q=;
	h=From:To:CC:Subject:Date;
	b=qIJb/8lHbQ48XEW6ml8cVaPrz+IU12LINLx9xLpcO2RJDMaBUAUd6HVqJ+zHTlxOC
	 V2lX4gNfFUPNPCcCudpBqr28TQQf08kfqCtPfNNS8vzkIEOSod3OboBYmcgG28w1jV
	 oztupXn0jmB+7VVOfvCvoCELEMma2KBG7jsH72yg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EFCm2N115178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 10:12:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 10:12:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 10:12:48 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EFCkV8054193;
	Wed, 14 Aug 2024 10:12:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: <theo.lebrun@bootlin.com>, <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume
Date: Wed, 14 Aug 2024 20:42:37 +0530
Message-ID: <20240814151237.3856184-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Its necessary to call pm_runtime_force_*() hooks as part of system
suspend/resume calls so that the runtime_pm hooks get called. This
ensures latest state of the IP is cached and restored during system
sleep. This is especially true if runtime autosuspend is enabled as
runtime suspend hooks may not be called at all before system sleeps.

Without this patch, OSPI NOR enumeration (READ_ID) fails during resume
as context saved during suspend path is inconsistent.

Fixes: 6d35eef2f868 ("spi: cadence-qspi: add system-wide suspend and resume callbacks")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 05ebb03d319f..d4607cb89c48 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2000,13 +2000,25 @@ static int cqspi_runtime_resume(struct device *dev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	int ret;
 
-	return spi_controller_suspend(cqspi->host);
+	ret = spi_controller_suspend(cqspi->host);
+	if (ret)
+		return ret;
+
+	return pm_runtime_force_suspend(dev);
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "pm_runtime_force_resume failed on resume\n");
+		return ret;
+	}
 
 	return spi_controller_resume(cqspi->host);
 }
-- 
2.46.0


