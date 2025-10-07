Return-Path: <linux-spi+bounces-10449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45952BC25D7
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45F4D4F0AE6
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF72D5408;
	Tue,  7 Oct 2025 18:20:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5601FF7D7;
	Tue,  7 Oct 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861251; cv=none; b=BECNKAzHSe1FrWeOyQWDBP6wiGnyumGmSO2EdwinF1XKRWSCHMP8Ws++Nthby8Aw49KYUYYhKxkgS4syLE1s0ADCplyDLCv0d/7O06x18L1nKQpLJ055zOSu7waC2gmv4aIOHPfhnnkhfOZy/1DFc6O2VG0wHugfBy8OhLEqOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861251; c=relaxed/simple;
	bh=27K2/ZBDgHTP6yW5d1AUSBcswbQojOYwQj969/gczkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iogl1mFfuCBeClcdqNE5gfQMZgnz8zKUqmzO2QVObMSs/jssQ3n7beW31zHmxmVraKKOHS5JgPgtHiFTLDA1JsElYJEFw+DFXd79CrrmF2+5PExuGWk94xVkmj1VdB1i8uRILwSu1V3j98/wP547m695/7/nIu2Q8AAwobI6n00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 347C61C3B05;
	Tue, 07 Oct 2025 20:15:18 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdfe:cd00:889e:d706:979d:b1a])
	by srv01.abscue.de (Postfix) with ESMTPSA id 782B91C3AC5;
	Tue, 07 Oct 2025 20:15:17 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 0/3] mfd: sprd-sc27xx: Move poweroff/reboot support to the
 parent MFD driver
Date: Tue, 07 Oct 2025 20:14:18 +0200
Message-Id: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHpY5WgC/x3MQQqAIBBA0avErBswQayuEi1CZ2oWqSiUEN09a
 fkW/z9QKAsVmLsHMl1SJIaGoe/AHVvYCcU3g1baDEpZLE7bWvFkjynelCMzTo6tHr0xTB5amTK
 x1P+6rO/7AarQsTBlAAAA
X-Change-ID: 20251007-sc27xx-mfd-poweroff-9cf728d55fed
To: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Registers for powering off the system are present in all SC27xx-series
PMICs, although their locations vary between the specific PMIC models.
On systems using these chips, the PMIC can always power off the system
and is usually the only chip capable of doing this. Similarly, the PMICs
(except for SC2731) contain a reset register that can always be used to
restart the system.

There is an existing sc27xx-poweroff driver, but it currently only works
on SC2731 and is not probed anywhere since it is missing an OF match
table and is not instantiated by the MFD driver. Reboot for SC2731 is
implemented in drivers/spi/spi-sprd-adi.c, which is not really an
appropriate location for PMIC-specific code.

Since a separate device tree node for the poweroff support would not
provide anything useful (see [1]) and passing platform-specific data
between drivers is unnecessarily complex for such a simple feature,
reimplement the poweroff functionality in the main MFD driver. While at
it, add support for the newer SC2730 PMIC and its hardware reset
register.

Reboot is special because it requires storing the reboot mode. Move the
existing code for this from the SPI bus driver to the MFD driver.

[1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
Otto Pflüger (3):
      mfd: sprd-sc27xx: Integrate power off and reboot support
      spi: sprd-adi: Remove code for storing the reboot mode
      power: reset: sc27xx: Drop unused driver

 drivers/mfd/sprd-sc27xx-spi.c         | 152 ++++++++++++++++++++++++++++++++++
 drivers/power/reset/Kconfig           |   9 --
 drivers/power/reset/Makefile          |   1 -
 drivers/power/reset/sc27xx-poweroff.c |  79 ------------------
 drivers/spi/spi-sprd-adi.c            |  73 +---------------
 5 files changed, 153 insertions(+), 161 deletions(-)
---
base-commit: 68842969e138d9ad3e3aa2bbd65d514df1581b5c
change-id: 20251007-sc27xx-mfd-poweroff-9cf728d55fed

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>


