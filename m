Return-Path: <linux-spi+bounces-5143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21299942D0
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AABD1F26347
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7091E1A2C;
	Tue,  8 Oct 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Gc9eu0lh"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC521E1A1A;
	Tue,  8 Oct 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376384; cv=none; b=GIdf1wN1WBrRfZxL2QfuR/YfPbX5HdYSdA8YAazHxLikBiIteFEsZvKcYiPP1Sbyljr2jHst/Cen2m5VKB85mFvakemBkNjmGPu/zdeOB/BtLvxKeKMnXqcIvb7sqPMctJKLOaWOb3TCNjdCab+791dfTOAzaA/7ITZElSRVhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376384; c=relaxed/simple;
	bh=C/9kjE0IKBLPyXAJuCEK/YE6AmWF7Huay4NBcgr0Q6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwVvsQ9lLmPh/zdQgMe47jj8nOPQnzF5nVTKLe1NWXaTJfCmkIE/vTirC99bNqRg4vCNfXWd1k24SBxpjLrAyJI3NHRoMUrDEwbTfHPUlHDdKyBpYNRjNd0sXX8+emZeK3SlDRiMREg7T0GOjZAtxZ8Yiwh92mTyGBYISFeoY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Gc9eu0lh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728376382; x=1759912382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C/9kjE0IKBLPyXAJuCEK/YE6AmWF7Huay4NBcgr0Q6Q=;
  b=Gc9eu0lh5IZs/wSCz72YpIbx2hUe14LjjcsYJMPkLBzkWlZuR9ZRgpcI
   2mOWyXRZXCw+BN11w0lKmCGCG6U30TGbsR4kwjPOIsRx1k55Ogxz4tGfo
   Shb+SGTaxdtFyP5aH82W/714FXpB+HYOugnm4bO9NKA0/eU/4uobwE5Rq
   +Mti0SGn+zLCB1yCYBiM8U2UBhVYjkt39BDyJpAucrSf07/fUmRkuXW77
   DObxR3DfySCeC+UQHBraaareEJBXpt7cvLP+dn4+oRRifBEZRi+LolqvU
   1hK4aFBzwdxcFe8z3YT7FA463gAmqJM2yhF9Jc4DEFHqMdcKUKt29YiDN
   g==;
X-CSE-ConnectionGUID: k+6XvfjjS8Wv4g1uerPOyA==
X-CSE-MsgGUID: +NJs6W61QiSTcmlgdVmqrg==
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="32554911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2024 01:32:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 8 Oct 2024 01:32:43 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 8 Oct 2024 01:32:42 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: Print the controller version and used irq
Date: Tue, 8 Oct 2024 11:32:26 +0300
Message-ID: <20241008083226.51163-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support to print the controller version and used irq
similar to other at91 drivers (spi, twi, usart).

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 95cdfc28361e..757f07132585 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -687,6 +687,8 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	dev_info(&pdev->dev, "AT91 QSPI Controller version %#x (irq %d)\n",
+		 atmel_qspi_read(aq, QSPI_VERSION), irq);
 	return 0;
 
 disable_qspick:

base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
prerequisite-patch-id: 5e1313094386b146c9180d72c15bae49aaffbfa8
-- 
2.47.0


