Return-Path: <linux-spi+bounces-8632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B468ADEB9E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB571BC01CC
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8E2E8E05;
	Wed, 18 Jun 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ReCysK3e"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A62DFF38;
	Wed, 18 Jun 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248940; cv=none; b=IcWMMn6S2RmqbhklmDLpEt180fxEH5zuGDqPAVfoi5ng4xzJpx2I8XH5DnZmYv7d5o24tcuNr08PmPvwK4r1f+OY1gNnYThbwbSyUb2K6DLqZpd9x0V+gOnPVFG7jXGV6JIZBZZP1lvK+fR0d43mBXnW73hkWJ5ekK/gyLxvWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248940; c=relaxed/simple;
	bh=GFufJpqJ0Ix6bVrqA6ceJslfkj3EMcpE3IDWXBToN5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=phXcAmR8LhaZuU+LhJcer+nAdf+axxXlNyy2BB1PxO1GXAYpTFC+0m/Jyut3ftw5jHL36Q33Fiknq6BojXCAd/rINwHmIdAAj7FSUlzcoZfo4Km2gp2P5UTtPaZGRA0igFBkJGvcNdFFkXqxzbskQ2n2F4zzaHqsz3kin8D1YBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ReCysK3e; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DBF143137;
	Wed, 18 Jun 2025 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750248935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lMS/pXtR5fwL/ucwouvgnFv8lBxKiYbXC7dEbGzUabk=;
	b=ReCysK3eNS/98qQKJ59qIiZ2mDTh/7ctALlXb4OB3bqeSABHuNY/s/17JpKvhVUr+jq9co
	MM4ArA1+5u7Fe46sPfCFL87o3cUl2qa4bQwNolsGeXVbOHgFJ2ooot0iGyyfWUTn39nojq
	EBOFg9MxnhYYHlFSMDFCfBaAULLqOeGUHYLGnYgLgR/aw1oGJLUNMiNU0SGNfGo8Xnuegf
	ulVR7z9FZb1Ml41e9sVUuLmlbUej1irMuzVBhHFf/dAp9/1Kp74rTQq3A2iRgWquUTNBuO
	30Ix0CVJBC/tvOlzaUPiVeWzxKZXEHIqUbmwZTKNhYIeK/K/JJ3oF6317yRYNw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/8] Enhance Winbond SPI NAND support
Date: Wed, 18 Jun 2025 14:14:17 +0200
Message-Id: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqtUmgC/x3NSw7CMAwA0atUXmOpNhC1XAV1ERJDLUESOeWnq
 ncnYvk2MytUMZUKp24Fk5dWzamBdh2E2aeboMZm4J6PvaM9vjVdcorokBxaIMxh8Xcs8xefpS4
 m/oFhGHkcDiyRCVqpmFz187+cp237AbHezPd1AAAA
X-Change-ID: 20250613-winbond-6-16-rc1-octal-phy-upstream-c8929842ed21
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yogesh S <yogeshs@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeghfffiedvfeffheehgfevgeelueeihfeiudfgkeffuedtjefhudeglefhgfeuteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihoghgvshhhshesthhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepr
 hhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopefuvffnihhnvdesfihinhgsohhnugdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Both w25n**jw and w35n**jw chips have a "normal" and a "high speed"
mode. In order to use the high speed modes, we need to configure
internal registers and adapt the number of dummy cycles. The benefits
are too interesting for not paying attention to this little extra
configuration. In particular, it is an important building block for the
introduction of PHY calibration on TI SPI controllers. With these
changes combined, the frequency used on these chips can be bumped from
~25MHz up to 166MHz.

This series was tested on TI AM62A SK with a W35N01JW and on Nuvoton
MA35D with a W25N01JW. At low speeds, this series does not bring any
improvement. However when enabling high speed modes (on TI's platform),
the difference is outstanding:

W35N*JW running in 1S-8S-8S @ 25MHz:

	 eraseblock read speed is 9552 KiB/s
	 page read speed is 9516 KiB/s
	 2 page read speed is 9552 KiB/s

W35N*JW running in 1S-8S-8S @ 166MHz:

	eraseblock read speed is 35555 KiB/s
	page read speed is 33684 KiB/s
	2 page read speed is 35068 KiB/s

Enabling high speeds currently requires applying extra patches from TI
to enable PHY calibration. They are currently in the upstreaming process.

Link: https://github.com/miquelraynal/linux/tree/winbond/6.16-rc1/octal-phy

In order to introduce all these variants and derive the quickest one, I
had to improve a bit the helper deriving the time an ops would
take. These changes can go through the spi tree, the other patches do
not depend on them and the performance hit is rather acceptable without.

While at adding maximum operation frequencies, I realized I got myself
confused with the macro parameters due to some of them being
optional (with variable arguments in macros). I decided it was too error
prone so I propose to add these values on all READ_FROM_CACHE
variants (where they are often relevant).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (8):
      spi: spi-mem: Use picoseconds for calculating the op durations
      spi: spi-mem: Take into account the actual maximum frequency
      mtd: spinand: Fix macro alignment
      mtd: spinand: Add a frequency field to all READ_FROM_CACHE variants
      mtd: spinand: Add a ->configure_chip() hook
      mtd: spinand: winbond: Enable high-speed modes on w25n0xjw
      mtd: spinand: winbond: Enable high-speed modes on w35n0xjw
      mtd: spinand: winbond: Add comment about the maximum frequency

 drivers/mtd/nand/spi/alliancememory.c |  12 +--
 drivers/mtd/nand/spi/ato.c            |   6 +-
 drivers/mtd/nand/spi/core.c           |  22 +++--
 drivers/mtd/nand/spi/esmt.c           |   8 +-
 drivers/mtd/nand/spi/foresee.c        |   8 +-
 drivers/mtd/nand/spi/gigadevice.c     |  48 +++++-----
 drivers/mtd/nand/spi/macronix.c       |   8 +-
 drivers/mtd/nand/spi/micron.c         |  20 ++---
 drivers/mtd/nand/spi/paragon.c        |  12 +--
 drivers/mtd/nand/spi/skyhigh.c        |  12 +--
 drivers/mtd/nand/spi/toshiba.c        |   8 +-
 drivers/mtd/nand/spi/winbond.c        | 163 ++++++++++++++++++++++++++++++----
 drivers/mtd/nand/spi/xtx.c            |  12 +--
 drivers/spi/spi-mem.c                 |  27 ++++--
 include/linux/mtd/spinand.h           |  70 +++++++++------
 include/linux/spi/spi-mem.h           |   2 +-
 16 files changed, 308 insertions(+), 130 deletions(-)
---
base-commit: 065b897a1044b1c67ba4d1066ee090097bae1499
change-id: 20250613-winbond-6-16-rc1-octal-phy-upstream-c8929842ed21

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


