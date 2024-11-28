Return-Path: <linux-spi+bounces-5864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087429DBBE2
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B076B21293
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22531C1741;
	Thu, 28 Nov 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RVenKOYJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F571C173D;
	Thu, 28 Nov 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815813; cv=none; b=O7+EtvDFD2Fa0MRK1h+SSXaG5+5yd1Yfa0oU9VRpQrvLBN5Rdg6LU2PMUm3PV8Emt6SZtaA/MJkMvqyODBOdqCgfFlSOvKOxvMmQpSue6C/EbarOZW35duswtyygJv5Hx/VnikZCmaL60uVTi31WReNA3VtrNnlgoXAYdE2TaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815813; c=relaxed/simple;
	bh=krtSkG4zCipv3CCJwHLEgEQrvoDi2jNpzXObBWNiaYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZ3bZSRGNzsa6ltPOMuoprlMAmVQL5pQptb0rhsIJGcxm/PbAESLmMrN75sqKVBkg02Qi8OCEsV7YW3WGq5h/J2wNGJtKD+qA0RykuTDsSvDM1q7eBJeMOPRqDfVQf2SfX2O7mULpJ5pyEmPMhnh54a5Q9kFoxWr4eKo+SCELxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RVenKOYJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E7286A0776;
	Thu, 28 Nov 2024 18:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=5X9q4hvLNT/dkkVeO6pX0XdR1CsMXfn5cOkxo1RV68Q=; b=
	RVenKOYJm0spgrKAgT3B6D1OAcck+/hRYSPx1G9Atd8YSV+G/L5KuVYX5kzqUs+o
	7z0hhmzhOSvJ8Vum6HC1CWmwiSd8xex4Ki3baU1O6AuKRCw7fv7d9oYXR5jSPmJQ
	S5AZWFO1hQUcua5enkJdmcB0OQnisn5pHbxTW3yBy0DRd0Rpl4eupojVftULiImD
	HXXPLDmYu9o/R0fxkzsOayDNdq3c2q+Pr35XNzPw5aDwVvOQHshV+AupsTV8C9Xk
	IGsHACapxW8HCkpgrrgFTAOzd7kpK8lXEKfGxNl1DE3dT98Wtbp0aLEk1mVxnYI9
	vWAkos9FUFbNXQCJIZfcr1ZZTcnsyJUTn3kIuYa6aw8XbyoWWejxmcxULe2iB7Rz
	ldPr7TBGvvrZ5e7xgZmc3IfMyrwJxQUW3nlX7XBW7KwEOrvbzgMgF/M4Dl80p39M
	ORRjUQKJUV0pxfWertNR2VGcXNZ/AME5W6QJJV8y6RnhdYZAPKun3jSbG9YbsGGz
	lqBZ8//bCAKnnqaX3PyAHfFJTN7rehz7OlD8LjCO+/1HCg3ZU3DBngoQ+OuAqC7R
	98l2CJ2+tX8jZGw2jNB+ZjAHve4gbO/wk7882rvQHpASNFtEAXlXKg0Hc1Yx73eZ
	avEJRoQd8z5kqjtYnhNg8FaQbJiBprg9Z2M2aAYEQ64=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Mark Brown <broonie@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v3 0/2] spi: atmel-quadspi: Refactor to allow supporting SAMA7G5 O/QSPI
Date: Thu, 28 Nov 2024 18:43:13 +0100
Message-ID: <20241128174316.3209354-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732815801;VERSION=7982;MC=2811862659;ID=123204;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637665

This is based on Tudor Ambarus' submission from 2021, and my refactor
of said sumbission from roughly a month ago.
Link: https://lore.kernel.org/linux-spi/20211214133404.121739-1-tudor.ambarus@microchip.com/
Link: https://lore.kernel.org/linux-spi/20241030084445.2438750-1-csokas.bence@prolan.hu/

This time, I submit both my refactor and the diff between it and the
original submission, rebased on top of Linus' master, namely:
commit 7d4050728c83 ("Merge tag 'vfs-6.13-rc1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")

Tested on a SAMA5G27C, we'll soon test on a SAMA7G54 we got from
Microchip for this purpose.

Csókás, Bence (1):
  spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC
    families

Tudor Ambarus (1):
  spi: atmel-quadspi: Add support for sama7g5 QSPI

 drivers/spi/atmel-quadspi.c | 925 ++++++++++++++++++++++++++++++++++--
 1 file changed, 874 insertions(+), 51 deletions(-)

-- 
2.34.1



