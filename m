Return-Path: <linux-spi+bounces-11145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F8C48F18
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 20:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 663214EE094
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0693A32B9A7;
	Mon, 10 Nov 2025 19:15:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367530AAAD;
	Mon, 10 Nov 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802151; cv=none; b=rKXoYkHTcCo4/5ZpiZQYR7psa3YgaPAK6ZOHdynNlGtHXWfcQGEBVlexY4sp1UIaKLTwe7WwgjE55UyA4TXuMb5SKtljVjVafHj/NJMVlEDZEjvrGdAeox6cwSnvrzWsmwSEUpp7/ALHgUurNmH6YKNsdVGkGMyo2YuU+v/QIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802151; c=relaxed/simple;
	bh=7+obkWlFOlCgYi1gvLlelNaSXmUPyVp5CQygoFDhooA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KhY8LVZce350jtF5pRM/+QhFb5XUbUzLwRbvPbT3vAZp57Npxyf7VPXDgeYiLtMln7ocQNxxD5cN9MVceIN871CsYMx1UvU7ixXU2r2NVtM986a0cWMB/GTdueqGDQUnVX7L+HN70A+8sqb0yESy+UjHUuPSP13Fdfvo4k5SOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id F02291C019A;
	Mon, 10 Nov 2025 20:10:29 +0100 (CET)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdd8:ff00:36bc:9812:27d4:17cf])
	by srv01.abscue.de (Postfix) with ESMTPSA id 488041C0036;
	Mon, 10 Nov 2025 20:10:29 +0100 (CET)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v2 0/3] mfd: sprd-sc27xx: Move poweroff/reboot support to
 the parent MFD driver
Date: Mon, 10 Nov 2025 20:08:57 +0100
Message-Id: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEk4EmkC/32NQQ7CIBBFr9LM2jGAIRRX3sN00cKMZWFpoFZM0
 7uLPYDL95L//gaZUqAM12aDRGvIIU4V1KkBN/bTgzD4yqCE0lIIg9kpUwo+2eMc35QiM1rHRrV
 eayYPdTkn4lCO6r2rPIa8xPQ5Tlb5s/97q0SBre0VW2kHc5G3fsjuRWdP0O37/gWGO7NotgAAA
 A==
X-Change-ID: 20251007-sc27xx-mfd-poweroff-9cf728d55fed
To: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
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
Changes in v2:
- Fix style issues in MFD driver
- Use dev_err instead of pr_emerg
- Link to v1: https://lore.kernel.org/r/20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de

---
Otto Pflüger (3):
      mfd: sprd-sc27xx: Integrate power off and reboot support
      spi: sprd-adi: Remove code for storing the reboot mode
      power: reset: sc27xx: Drop unused driver

 drivers/mfd/sprd-sc27xx-spi.c         | 148 ++++++++++++++++++++++++++++++++++
 drivers/power/reset/Kconfig           |   9 ---
 drivers/power/reset/Makefile          |   1 -
 drivers/power/reset/sc27xx-poweroff.c |  79 ------------------
 drivers/spi/spi-sprd-adi.c            |  73 +----------------
 5 files changed, 149 insertions(+), 161 deletions(-)
---
base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
change-id: 20251007-sc27xx-mfd-poweroff-9cf728d55fed

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>


