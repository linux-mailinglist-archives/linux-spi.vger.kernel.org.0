Return-Path: <linux-spi+bounces-7351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E310A73F24
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2CE1894E72
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57E1B87FD;
	Thu, 27 Mar 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="VwB2A6eC"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07E18AE2;
	Thu, 27 Mar 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743105589; cv=none; b=CXR3Z+J0uAi/D0mAzRJzLkbCAOJUCa6kXVNZ2V//t1BZeCZW4eRm2VaaLFS3yvvcash7MOjbBccjzUi6Br08mZ9J5W8FQo6wFRUXtd4Mczm/LbrbBgktRyYdw5j4dE4VOe+UtdfOTWLrhVlE1W/E6lCjMupxTbHY3UkFQd4uayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743105589; c=relaxed/simple;
	bh=SoMaNrVV51gxBQhSR5uOLfOfT7ilMR1drag2BCwWNOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GIR5VY2W68Wr/jT9kzAE5PKoRv4dLGolMzmpQ5nOg+F1ax7DAWrHetlQSN/44f0UI5iOp6X1n/SOI3JureqkXy8Y0BNIejPuSYQArW8XM6SIiWx3TpGVPrAvvDCoe9C4aELRe9aVwGm72vfsnC4xMdZBFGxXE2hL2pDrS9TNJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=VwB2A6eC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A84D7A06AB;
	Thu, 27 Mar 2025 20:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=MLKLWQghRFfoCawFKRGWPxJXg92KIL/1MA9aUdW+dqQ=; b=
	VwB2A6eC6Aa9C1iipDu3RgNMnNOfZ0DpKu3n0j8q1KxLIBiTlbCcknGQK5o95Zlk
	itfUhB5F7B0gbJH8nhea4cWdJieeY81OH+UrTkb1YYYfm279pfgzz29de6/neuuF
	pL+BIr80ZCcwPqPIHNqU3r90H5Xa58WYz/V6Dvy41ktCTdfRvKwkWAxzkvjLOgVM
	EbNlGbYHgcIGQhQVo8i+08997sV8Nt8IXE4AcU855itsXTeV7mlYm5tcNCK63BxK
	T0ORrdpcK1jxd1vdfIS2UEaYrBV3mgBFQ1ejfw0QWBbT4UOLzPbffj3JZ1PqVnHo
	IdWDMsIQRvoglZNwMnHWUDz6n8jQm4Mk0jPcfzWRFoSmf3ZEBeSB0tVCLP7JQdby
	tNdyvnOtI8uDeyJ7Wx3eoYfEXL8C6CCQh5K4YNxGZO3WIh2C/kZED9vtO3jpQPf5
	d+gIGu+17HLaQ4vR59wAuV7HtVmTtQmYEWKMP50IFBLfgGzyF1Oqus8WMGpv3+LQ
	Sv4HlmISSznJuNHT5momCbm2J2g8TR4aos2H/sycet84VYUVG1MZnFegxY7jvVYJ
	iK4ZLTph8xLsSnmwDLRs3DKetyNNhDgyspJtyw0z+C/GHq1Is0dcajUFa/Go1RqG
	h0wJOJM64uL8bpvVw3ytZBxC5PGeCgbANpsWglkqWcY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v6 0/2] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c
Date: Thu, 27 Mar 2025 20:59:25 +0100
Message-ID: <20250327195928.680771-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1743105582;VERSION=7987;MC=2827852488;ID=112013;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C776A

The probe() function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. During the port, a bug was introduced, where
the PM get() and put() calls were imbalanced. To alleivate this - and
similar problems in the future - an effort was made to migrate as many
functions as possible, to their devm_ managed counterparts. The few
functions, which did not yet have a devm_ variant, are added in patch 1 of
this series. Patch 2 then uses these APIs to fix the probe() function.

Change in v4:
* the DMA cleanup was split out and will be submitted separately for 6.15

Change in v5:
* rebased to linux-pm/linux-next, will now target 6.15

Change in v6:
* add `devm_pm_runtime_set_active_enabled()`, which is safer

Links to previous versions:
pre-series:
https://lore.kernel.org/linux-kernel/20250114222851.1023194-1-csokas.bence@prolan.hu/
v1:
https://lore.kernel.org/linux-kernel/20250115160244.1102881-1-csokas.bence@prolan.hu/
v2:
https://lore.kernel.org/linux-kernel/20250124085221.766303-8-csokas.bence@prolan.hu/
v3:
https://lore.kernel.org/linux-kernel/20250207124802.165408-1-csokas.bence@prolan.hu/
v4:
https://lore.kernel.org/linux-kernel/20250210111008.248929-1-csokas.bence@prolan.hu/
v5:
https://lore.kernel.org/linux-kernel/20250317093445.361821-1-csokas.bence@prolan.hu

Bence Csókás (2):
  pm: runtime: Add new devm functions
  spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

 drivers/base/power/runtime.c | 44 ++++++++++++++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c  | 17 ++++----------
 include/linux/pm_runtime.h   |  4 ++++
 3 files changed, 52 insertions(+), 13 deletions(-)


base-commit: 8f61ea3ebb4de9a4cacff995b6885e91450cb094
-- 
2.49.0



