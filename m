Return-Path: <linux-spi+bounces-11794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA52CA919B
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 20:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA81C301D5BD
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA42E22AA;
	Fri,  5 Dec 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ePySEHFg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E083B8D5F
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963584; cv=none; b=Bk00TZgzDSf//HXErWDB5Tjb70x1u37FkAinqSJ2yKwGtH1ykYj73j0Onsp7IdkvXOSmLXAxMsdkDte9oQf3vPQexjCL5QV2osh7cI109NxoeP7TNyP0Id+5i/bmcg+n5GF/UMMpnWaZkBHN+4wVVFP9mOK6uroFyKOfnFTIITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963584; c=relaxed/simple;
	bh=p2qDtg3IJWGXGkruF5KNVDxupI2sfCEAI8vHsM/3WFc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qT20JYG//2H9eRZDX55QYFhVQ2nmrtGincmdZeLtxEnLP4uTpaMdhceV/qywI9KBbKd4nMNHpk5v5Qnj+IoIz2j80V6wHIsY0od6L8goL16qlYkxNtydsO4qQg5DP9fZpdzIgNEMPh7boTrT4eqOfiwoCbaJwPe5Dd5HlkLxeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ePySEHFg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6C34F1A1F9C;
	Fri,  5 Dec 2025 19:39:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34479606AC;
	Fri,  5 Dec 2025 19:39:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAEBA102F170A;
	Fri,  5 Dec 2025 20:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764963578; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=0Qawmau/PjPZ3PGQY+c8TNDQ5ZTEU3SIELVRk+KNuaE=;
	b=ePySEHFg8LAQLNMkVoZk/Ez1k9esGYMFwX9Oq8QNhRJwip1xOS9k00gAoYewbHvH8iokJl
	bBLJ2U78g0/iq+/Gf3BKBVT0dmK+rNoFYvPeTcdVoCZcredcK3FDrOoDZK1UGlB/fiMpAq
	1BjG2nrox6wsA0KfBY/US87eL7pE9p22sTO/o+DS1ecSOS6J1YRtVton3TPpcsFcj1FlyN
	ptT39Zpd77e6RKOn9HLFOIviMgeDfN8h+x+VAPF2b+pOLGxDV/N+0308QNQnyh2iPZrTQk
	fiqDBDsVBVRJLyjz4i4Ret9FmjrJ6STkiCbVbSkj7bUbS9MPlDYP3OXEhrjppA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RFC 0/8] mtd: spinand: Winbond continuous read support
Date: Fri, 05 Dec 2025 20:38:51 +0100
Message-Id: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOw7CMAwA0KtUnrFUhxI+KxIHYK0Y2tiAF6dyU
 KlU9e5EjG95KxRxlQKXZgWXWYtmq6BdA+k92EtQuRpCGw4U2g6/amM2xjkindATYcr2QZeBMcb
 ueCbmMcQ91GFyeery33u4367w2LYfWEP9DnIAAAA=
X-Change-ID: 20251204-winbond-v6-18-rc1-cont-read-664791ddb263
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,

SPI NAND continuous read support has already been added a few releases
ago, but only Macronix chips were benefiting from this support. Winbond
chips also have a continuous read feature, which is slightly more
complex to use in the scope of the Linux kernel, because they these
chips expect a different read from cache operation once in continuous
mode.

In order to be more flexible, this series changes the logic behind
dirmaps. Direct mappings used to be very static, not flexible. I am
proposing to change this and turn them in to slightly more dynamic
interfaces, where for instance we can:
- Enable/disable the correction (was previously handled by creating yet
  another pair of direct mappings per target).
- Select one or another variant for the cache operations.

I propose to name the variants available in a direct mapping "primary"
and "secondary", and let the upper layer (SPI NOR or SPI NAND) point to
the one that needs to be used for the operation. Controller drivers
should not really care about this change, expect the fact that they
should not keep a static representation of the template on their
side. Because of that, I am creating a capability boolean to flag
drivers that support this capability (the flag is ignored in the
nodirmap case).

This series is sent as an RFC because it changes the way direct mappings
work, even though in practice I expect no regressions™. I am interested
to get an "early" feedback on it. I have also not yet experimentally
tested all combinations yet (last patch is only compile tested), and
because this will take a lot of time, I would like to validate the
approach first.

The series must be applied on top of the SPI NAND Octal DTR series, as I
wanted to include the octal DTR variants in my testing/benchmarks.
Link: https://lore.kernel.org/r/20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com

Here is a benchmark with the faster Winbond chip I have, W35N02JW on a
TI AM62a7 LP SK featuring the Cadence QSPI controller, clocked at
25MHz. Speed gain for a 10-page read is about +32% in octal SDR mode,
+47% for a 10-page read in octal DTR mode and up to +83% for a entire
block read!

    1S-8S-8S, no continuous read:

       64 page read speed is 15058 KiB/s

    1S-8S-8S, with continuous reads:

       1 page read speed is 15058 KiB/s
       2 page read speed is 15058 KiB/s
       3 page read speed is 16800 KiB/s
       4 page read speed is 17066 KiB/s
       5 page read speed is 18461 KiB/s
       6 page read speed is 18461 KiB/s
       7 page read speed is 19384 KiB/s
       8 page read speed is 19692 KiB/s
       9 page read speed is 19384 KiB/s
       10 page read speed is 20000 KiB/s
       11 page read speed is 20000 KiB/s
       12 page read speed is 20000 KiB/s
       13 page read speed is 20800 KiB/s
       14 page read speed is 20363 KiB/s
       15 page read speed is 20000 KiB/s
       16 page read speed is 19692 KiB/s
       32 page read speed is 19692 KiB/s
       64 page read speed is 19692 KiB/s

    8D-8D-8D, no continuous read:

       64 page read speed is 23272 KiB/s

    8D-8D-8D, with continuous read:

       1 page read speed is 23272 KiB/s
       2 page read speed is 23272 KiB/s
       3 page read speed is 28000 KiB/s
       4 page read speed is 32000 KiB/s
       5 page read speed is 34285 KiB/s
       6 page read speed is 34285 KiB/s
       7 page read speed is 36000 KiB/s
       8 page read speed is 36571 KiB/s
       9 page read speed is 36000 KiB/s
       10 page read speed is 34285 KiB/s
       11 page read speed is 36666 KiB/s
       12 page read speed is 40000 KiB/s
       13 page read speed is 41600 KiB/s
       14 page read speed is 37333 KiB/s
       15 page read speed is 40000 KiB/s
       16 page read speed is 36571 KiB/s
       32 page read speed is 42666 KiB/s
       64 page read speed is 42666 KiB/s

Thanks!
Miquèl

---
Miquel Raynal (8):
      mtd: spinand: Drop a too strong limitation
      mtd: spinand: Expose spinand_op_is_odtr()
      mtd: spinand: Drop ECC dirmaps
      spi: spi-mem: Transform the read operation template
      spi: spi-mem: Create a secondary read operation
      mtd: spinand: Use secondary ops for continuous reads
      mtd: spinand: winbond: Add support for continuous reads on W35NxxJW
      mtd: spinand: winbond: Add support for continuous reads on W25NxxJW

 drivers/mtd/nand/spi/core.c    | 125 ++++++++++++++---------
 drivers/mtd/nand/spi/winbond.c | 227 ++++++++++++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.c     |  20 ++--
 drivers/spi/spi-mem.c          |  32 ++++--
 include/linux/mtd/spinand.h    |  16 ++-
 include/linux/spi/spi-mem.h    |   8 +-
 6 files changed, 336 insertions(+), 92 deletions(-)
---
base-commit: dbb1c07d7654e3609ca892fcebafde7f33d67c38
change-id: 20251204-winbond-v6-18-rc1-cont-read-664791ddb263

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


