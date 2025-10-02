Return-Path: <linux-spi+bounces-10429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E9BB3DC2
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6881219C64BB
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE402310630;
	Thu,  2 Oct 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qjFU0Dob"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080C24DFF9
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407302; cv=none; b=Qvh5T2+xO9EH+e1aEkW9twZZjC12Y+EndnjiZqK+a38Eq6K+U0glPDSp4YhO3lfBGC7GH4dlb6BbZvOto8a7jNRUy9YY/LRHBT9vO5dZbE1KngviMi0MfM0jKUutVB0vQqle9OyEaaZTcpESWi0N2qEpdog0u1EF6U63x9Gh4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407302; c=relaxed/simple;
	bh=jg6+lZ5Q373i+5+o+VsqW5K8Vy0z1SgJ9lBIP7iNdEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oEyhPLoBe0kfWqy8qaAR95VtnocmefMYUc1AY9pDdfAUftXvMp98R5JGFLWxPrzBNlJMQhii6llQVVdebys8IEblRdVrgc2SbGEBrBimA4JggmzVzXWC17WcOZwEXpjzEQsIG7zAhj+9mZeQIJayKnDE5Ok86uCz8DmJrRr2Ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qjFU0Dob; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3D9B5C011E4;
	Thu,  2 Oct 2025 12:14:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22CD26062C;
	Thu,  2 Oct 2025 12:14:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13901102F1BE3;
	Thu,  2 Oct 2025 14:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759407295; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7VgFMuixuCviEK+bCjYGIXvLrZ7qggxWGo4NNrgcfVg=;
	b=qjFU0DobLAH2hgPHsqomM9xfWmAN4jXPhP1Ob5qMil3TDQJHktND3Hi+vsVZ6a2SIbbhZX
	d5uHKRnHQExuB+iYRNAFZNJd6T2UnvbRFnXY+6SPuRMhh1sWLY4FMqYt0nuy/1WpnaN4Sk
	7u6Tcoe9/BWW+Jgjkanaj/VLQGzuW0ajcM1FxWfgWZFLuBagIuYmN3IamZLSoq9UdhJEYi
	1FBKa0HvJL9t9OQP6muGu34VpYxXuaw3CY4AkOCqBbn+V/z4xWRdWFJsgIHfa6ZPs63h18
	MNQ9L3diqlNBzjyvrdaRy6jf1LrL3r2vMMW31hcOdhaT6ndZ3gev3+rc8s1V4g==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH RFC 0/2] Add target mode support for the DesignWare SPI
 controller
Date: Thu, 02 Oct 2025 14:14:36 +0200
Message-Id: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKxs3mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3eKCTN2Uct2SxKL01BJd0yQjS0sTA6CMeZISUE9BUWpaZgXYvGi
 lIDdnpdjaWgCrC63fZAAAAA==
X-Change-ID: 20250910-spi-dw-target-5b299400917b
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The DesignWare SPI controller can act as a host or a target; the
choice between the two is set in hardware and cannot be changed by
software. When configured in target mode, the controller has a much
reduced set of capabilities. It only has a single chip-select input and
can only run standard SPI mode (no dual, quad, or octal mode). Despite
this, the overall logic of doing an SPI transfer and the register layout
is identical between both modes, so implementing the target mode reuses
much of the existing code.

The first part of this two-patch series renames the spi_controller to
ctlr instead of host and also changes the suffix of the related functions
to controller. This is done to avoid confusion when referring to the
controller in target mode.

The second patch implements the target mode support by allocating an
SPI controller of the correct type based on the spi-slave property. The
controller is then configured differently depending on the mode. For
an SPI transfer, the same transfer_one() callback is used, with the
difference being in dw_spi_update_config() where only the CTRLR0
register is set. The other registers are not relevant in target mode
and are read-only.

I am posting this as an RFC because I could only perform partial testing
on my setup. I am using an SoC with two DesignWare SPI memory-mapped
controllers identified as Synopsys DWC APB SSI v4.03, one in host mode and
the other in target mode. On the evaluation board, a microcontroller acts
as an SPI relay between the two, but it has some limitations. The number
of bits per word is fixed, as are the clock phase and polarity. It also
only copies data from the host to the target. With this limited setup,
I did test that data can be successfully transferred from the host
to the target using spidev_test. I also checked that polling works by
temporarily disabling the IRQ, but I cannot test DMA. Therefore, more
testing on different devices would be welcome.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Benoît Monin (2):
      spi: dw: rename the spi controller to ctlr
      spi: dw: add target mode support

 drivers/spi/spi-dw-bt1.c  |   4 +-
 drivers/spi/spi-dw-core.c | 188 +++++++++++++++++++++++++++-------------------
 drivers/spi/spi-dw-dma.c  |  22 +++---
 drivers/spi/spi-dw-mmio.c |   9 +--
 drivers/spi/spi-dw-pci.c  |   8 +-
 drivers/spi/spi-dw.h      |  12 +--
 6 files changed, 135 insertions(+), 108 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250910-spi-dw-target-5b299400917b

Best regards,
-- 
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


