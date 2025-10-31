Return-Path: <linux-spi+bounces-10939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1496EC2658D
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F6E3BF843
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADAD315777;
	Fri, 31 Oct 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OUydQVO8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EF2F3607
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931696; cv=none; b=Hj3i2bOsxtx/zQ6YFh1Ux4lRsEQZcAZBfEgpfqqQi9pavX08Tj3qMB5R8af8c6n/5FiRLTNOUNftXS2HCchLR5uBQEAqntwEAqkToLSTRrPRRYaed9J9ZKzegSQ4Nqea5FRJ8IwFiK3YVVfaqPylaKHVZfGiDB4nrWrX1jtHNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931696; c=relaxed/simple;
	bh=Ml0+puobOr15atbDR6Js54+RvH0AL45e5tSJs6UJB+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u1/z/YIduyh+yVsYf4UKZzhacV947NynN4TPOqnO2vi2zMw1h+LSKH2p+T1ei4lETShHSwMwQR+1fLI1I/Gmm83tOtcGlS2Z70PZMQXSvRqAhJudhH+ra65INtXFOvTXF2Upj4CsRLgrkShf7gwVmz6Mx2tb9Awv9YP6OLH++DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OUydQVO8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 347C9C0E958;
	Fri, 31 Oct 2025 17:27:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF75660704;
	Fri, 31 Oct 2025 17:28:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39D5C11818007;
	Fri, 31 Oct 2025 18:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931689; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Fq+SD7dZXVNCzjRnu2v6o1CWVJn5BJ/WuAi9xUnaeHo=;
	b=OUydQVO8Cu07f+UP4SO047uIenuskYJFzXnEozwc4WSizjn254jbRDCjiA0n+CBQkAiuU7
	l3bhqYGvEARuqGTfgHwtlkmu0Zll4M+fAMEIFaY9vjnkSrgAr9vdE+JQ/LIDd0mcXCkcZ0
	O1h6Em1pdCHZW56wOKtvY6Ua9knPQS5bNz0iWb+Gp+CKKyDfBLRzwstlqvAZAdO+ABhW8P
	gauuyTchQm49P4yD+hBXGMhWMaG36ahLdbldvEUCwIQmQb39BlLZlrixN2jpasBxVO+gfj
	CkFibuXIIkpYFYTfoJGl2eri76ONht8Co6e7kTLtN6Jx7c1MNK+uG4KmWvu6jw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/28] mtd: spinand: Octal DTR support
Date: Fri, 31 Oct 2025 18:26:44 +0100
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFTxBGkC/x3MOwqFQAxA0a1IagMT/7qVh4WaqGlmJAM+Qdy7g
 +Up7r0hiqlEGLIbTE6NGnwC5Rks++Q3QeVkKFxRkysJ/+rn4BnPBqlFWwgDs2HZ1aurmq6auIc
 UHyarXt/4Nz7PCxPSFORoAAAA
X-Change-ID: 20251031-winbond-v6-17-rc1-oddr-385f04684ad9
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hello,

This series adds support for 8D-8D-8D in SPI NAND, which can already be
leveraged without any SPI changes as controllers already have this
support for some SPI NOR devices.

The series is a bit long because many preparation patches were needed
in order to have a clean 8D-8D-8D introduction (one of the last
patches), but I believe the split is worth it.

Among the few spi-mem patches, they are needed for building the SPI NAND
changes (especially the ODTR introduction at the end) and therefore an
immutable tag will be needed for merging in the MTD tree (unless all the
series goes through MTD directly ofc).

There is a benchmark in the last Winbond patch, we get +55% read speed
and +26% write speed with this series, at 25MHz!

    1S-8S-8S:
    
       # flash_speed /dev/mtd0 -c1 -d
       eraseblock write speed is 7529 KiB/s
       eraseblock read speed is 15058 KiB/s
    
    8D-8D-8D:
    
       # flash_speed /dev/mtd0 -c1 -d
       eraseblock write speed is 9481 KiB/s
       eraseblock read speed is 23272 KiB/s

I am excited to see this finally upstream! Next step will be to see TI's
PHY tuning series from Santhosh in conjunction with this one to operate at
maximum speed.

Thanks!
Miquèl

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (28):
      spi: spi-mem: Make the DTR command operation macro more suitable
      spi: spi-mem: Create a repeated address operation
      spi: spi-mem: Limit octal DTR constraints to octal DTR situations
      mtd: spinand: Fix kernel doc
      mtd: spinand: Add missing check
      mtd: spinand: Remove stale definitions
      mtd: spinand: Use standard return values
      mtd: spinand: Decouple write enable and write disable operations
      mtd: spinand: Create an array of operation templates
      mtd: spinand: Make use of the operation templates through SPINAND_OP()
      mtd: spinand: Convert vendor drivers to SPINAND_OP()
      mtd: spinand: macronix: Convert vendor specific operation to SPINAND_OP()
      mtd: spinand: winbond: Convert W25N specific operation to SPINAND_OP()
      mtd: spinand: winbond: Convert W35N specific operation to SPINAND_OP()
      mtd: spinand: List vendor specific operations and make sure they are supported
      mtd: spinand: macronix: Register vendor specific operation
      mtd: spinand: winbond: Register W25N vendor specific operation
      mtd: spinand: winbond: Register W35N vendor specific operation
      mtd: spinand: winbond: Fix style
      mtd: spinand: winbond: Rename IO_MODE register macro
      mtd: spinand: winbond: Configure the IO mode after the dummy cycles
      mtd: spinand: Gather all the bus interface steps in one single function
      mtd: spinand: Add support for setting a bus interface
      mtd: spinand: Propagate the bus interface across core helpers
      mtd: spinand: Give the bus interface to the configuration helper
      mtd: spinand: Warn if using SSDR-only vendor commands in a non SSDR mode
      mtd: spinand: Add octal DTR support
      mtd: spinand: winbond: W35N octal DTR support

 drivers/mtd/nand/spi/core.c       | 297 +++++++++++++++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c       |   4 +-
 drivers/mtd/nand/spi/gigadevice.c |   8 +-
 drivers/mtd/nand/spi/macronix.c   |  49 ++++++-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    | 129 ++++++++++++-----
 drivers/spi/spi-mem.c             |  15 +-
 include/linux/mtd/spinand.h       | 246 ++++++++++++++++++++++++++++---
 include/linux/spi/spi-mem.h       |  14 +-
 10 files changed, 646 insertions(+), 127 deletions(-)
---
base-commit: 604a0841a26de188280b47fb7e78dcdaa966a09e
change-id: 20251031-winbond-v6-17-rc1-oddr-385f04684ad9

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


