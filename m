Return-Path: <linux-spi+bounces-12242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5570D0B97B
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D8F306C42C
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62236657C;
	Fri,  9 Jan 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pj3Dd7rP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A5364E98;
	Fri,  9 Jan 2026 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979105; cv=none; b=hLPBhbU5doJs34LGB6LLfljjzDXbwy3TJGTqZaogjLId+oUoFmxvl4yXwqcY+hRnX34TP+nAoGzYrAcaeGWVxV/do4MSl2SZoD3BBTQbfsH9wkv2LY9p/XMn7+bzFW4/qDeFnyXilw+GH8Rd3DUTf4U5vhlccpZdBYBAIwFZ8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979105; c=relaxed/simple;
	bh=R6GlVPGDpq1uR2NO4kCfloP6M5eya3woLdSSYYgdg0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSOFtyQLEmipS2UPbAdHJvcubFoJy42XTV8mqE4zYcuMfa8orN/Ix0akLlHyBkIitjdwY/MAecCmTFxJbmA9JIdZ+VWATa+u33xOKRULWesQN/54KO5beFtQnYKpyEOeEl8Sw2vFxmNBdY+kfNWkfA3h0/kUbpFidNaTUSyPfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pj3Dd7rP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC727C1F6E4;
	Fri,  9 Jan 2026 17:17:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4146606C6;
	Fri,  9 Jan 2026 17:18:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19591103C8956;
	Fri,  9 Jan 2026 18:18:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767979098; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Nk6VYcCVM0dbZkuSsvXeXsco6Qkys/I/rgDW/FQldcQ=;
	b=pj3Dd7rPaTHREoqeQrezQtCbnfQ26+bke+WyrcVrSBwnSu5mVscaAIGOxW1meuTJ3+XQWH
	B/R4xhAZHC6ddKFKz2wADfx6TOW/SATVGpqze5o/U6l1OJRU0yB2Zxu9WuDd+o3W5fxo7a
	NxyDgHtYONLOmBh/LiumZ0pWeM6FmaiDSiZoIzjKcvWjEskf5pNXEEnBZbirb//MLRlncI
	cJrXKRZ58YmrpFxKZ+BlYEuPEw38444+1WSroyI9Dp3Oj+lFDRpskHe8B23ggjYu3yOll7
	oB5Nq+x6WVWSUkncXLy9Y/2nvJKlJ33plDv/gOtJzvKSeTERob5WDEJ//8ZO0g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/27] mtd: spinand: Octal DTR support
Date: Fri, 09 Jan 2026 18:17:58 +0100
Message-Id: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0K6dkyn/IiuvIdhQekgk2iHtKRqC
 He3cgGX7yXf+1YVKTBFdSlWFShxZPEZzKFQw9T7OwG7zMpoU6MuEV7srXgHqQE8QRgQxLkAZVu
 PumraqndnlcdzoJHfe/jWZZ44LhI++0/Cn/2bTAgaLFXGkSnJjni1IsuD/XGQp+q2bfsCkfVAx
 r4AAAA=
X-Change-ID: 20251031-winbond-v6-17-rc1-oddr-385f04684ad9
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
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
Changes in v2:
- Rebased on v6.19-rc1.
- Collected tags.
- Fixed commit logs as reported.
- Removed inline functions and turned them into proper functions in a C
  file as suggested by Tudor.
- Squashed patches 10 and 11 as suggested by Tudor.
- Link to v1: https://lore.kernel.org/r/20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com

---
Miquel Raynal (27):
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

 drivers/mtd/nand/spi/core.c       | 387 +++++++++++++++++++++++++++++++++-----
 drivers/mtd/nand/spi/esmt.c       |   4 +-
 drivers/mtd/nand/spi/gigadevice.c |   8 +-
 drivers/mtd/nand/spi/macronix.c   |  49 ++++-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    | 129 +++++++++----
 drivers/spi/spi-mem.c             |  15 +-
 include/linux/mtd/spinand.h       | 161 ++++++++++++++--
 include/linux/spi/spi-mem.h       |  14 +-
 10 files changed, 651 insertions(+), 127 deletions(-)
---
base-commit: f7fae19731779c45416e3961fa7127ca225554a0
change-id: 20251031-winbond-v6-17-rc1-oddr-385f04684ad9

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


