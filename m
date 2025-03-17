Return-Path: <linux-spi+bounces-7161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96758A6478D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A101D16FF45
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2532253E4;
	Mon, 17 Mar 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bw9ir2Fg"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752621D5A2;
	Mon, 17 Mar 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204107; cv=none; b=JT0dlXCoge9FP+xfKEPnrogVZMJBNcXOtC4a+pEcxRgpOnyMG9bt7wGN49nAnFfo97tZj4LCMGut3pY7KMQ9GYSXuoGESqoTbb85YSIWNb1fiRjcg/fRB10hSUhgdoQr2v3HBmY2LdDSt//QSu0AeY2Ue/J1EDGmaoZAeu6m1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204107; c=relaxed/simple;
	bh=SdEzEJ2gLHV8h4tgX8aQVVF54sCPHDjOMa8xRrvB/tE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOsvQODV+EHP+oW7Hk1hYCPDps0g9nIx4zprbjedbpModNTH8/msDDnsa+eULtCi/HLpJhlBEiuNxNKYXGkUs0IPPn2af93s3epPdSTqwgq3owfS7a13QU4VpbZY4HttOSwNPOpXGk5HfyitUXpuXPj4vXwylJTeGFMwtfhoJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bw9ir2Fg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BAC59A00A7;
	Mon, 17 Mar 2025 10:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=p9rtY7T/5FbeYUgyuooDTwafPSFIqhxRRsMfKKK+iYw=; b=
	bw9ir2Fgh04fFvfDrRsG7V1d95pF74h6qNEDoYJvvUhIVj99j7eWFaAUiNQTYUn2
	TSeUCYPG1V318DVjhhCs2vzT70EUn01MRMkb0LSMZ5qfI56gO0HVSaRHSEA1N/2p
	kC40GHgH1kfHEWAzeU0UcrBlDfHfHrpdvf/NciXIJ3U1YCbpvV6qkwL+nh1c6D+C
	tV1DmVcQiWRdszrRdWOLUW/ZVZciRK0CiRfADjPQgmUNaPfVQhfKA3oC1DvslC2N
	5oLC+lnuU0Kli/L5j8C4V0/hUvv1yaLE+owB47EFQuovJbnxF9wDGJG4S2MSMotI
	6psW0h7uHQPrzLmDCfv7nVnYRzHdKGEDxudEbGbGFSpRmzgCbNMJt192TWPktU3S
	Svcof1dY24eRp2ayWY4VmwBb/Fe9V0LV0Nn4csKdbYWdnzcTCHf9NnW50AR/VEBw
	it+jogzWEeBaHPC4ux0t9JPcKe5LAJEQJexPPSxTwMKdQt8eYV9RdXWmzYoVA349
	FJyru63cqowMr0lkGOXGMbo4hQ6aBtgJxq8xfu04VGO4KI4/LbeFI8ea51nMl0/h
	ByXFj4X+6vKRbpayaGspew6NrkV54xQkpyfLvjRH+382PteCnpeGIjbWTF7KmxR8
	umeoVeC8rLQq1tfWnCNztLlWtAnhP/gwEakE0XbPdQg=
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
Subject: [PATCH v5 0/2] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c
Date: Mon, 17 Mar 2025 10:34:41 +0100
Message-ID: <20250317093445.361821-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742204094;VERSION=7986;MC=881707077;ID=162298;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7462

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

Bence Csókás (2):
  pm: runtime: Add new devm functions
  spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

 drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c  | 18 +++++-------------
 include/linux/pm_runtime.h   |  4 ++++
 3 files changed, 45 insertions(+), 13 deletions(-)

-- 
2.48.1



