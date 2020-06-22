Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF72035F2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFVLmQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 07:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgFVLmP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jun 2020 07:42:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75A9206BE;
        Mon, 22 Jun 2020 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592826135;
        bh=8fqOVcicxmcsJvAkvo8xOU6VB/fRqIArRtjKreJVJt8=;
        h=From:To:Cc:Subject:Date:From;
        b=n++EEbiGQ1kIbhxmbAd5JCnUreKtIchnL613eQJPNSnR3LhQxD20BXaXr976+WJ5q
         VF63QoIVsQDek9XJ8o2+GrJhLn6vc/J8vuG28pPXLZpQ/Z00NhTODV47b9wppTw43g
         r7RuGpRKPR9SsPMnAyTZyL8SUUsonyisnlj2olDM=
From:   broonie@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.8-rc2
Date:   Mon, 22 Jun 2020 12:41:19 +0100
Message-Id: <20200622114214.C75A9206BE@mail.kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 263b81dc6c932c8bc550d5e7bfc178d2b3fc491e:

  spi: spi-fsl-dspi: fix native data copy (2020-05-29 23:43:15 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.8-rc2

for you to fetch changes up to 06096cc6c5a84ced929634b0d79376b94c65a4bd:

  spi: spidev: fix a potential use-after-free in spidev_release() (2020-06-18 17:47:00 +0100)

----------------------------------------------------------------
spi: Fixes for v5.8

Quite a lot of fixes here for no single reason.  There's a collection of
the usual sort of device specific fixes and also a bunch of people have
been working on spidev and the userspace test program spidev_test so
they've got an unusually large collection of small fixes.

----------------------------------------------------------------
Alexander Stein (1):
      spi: dt-bindings: amlogic, meson-gx-spicc: Fix schema for meson-g12a

Geert Uytterhoeven (3):
      spi: spidev_test: Use %u to format unsigned numbers
      spi: rspi: Use requested instead of maximum bit rate
      spi: uapi: spidev: Use TABs for alignment

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Free DMA memory with matching function

Lingling Xu (1):
      spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH

Patrice Chotard (1):
      spi: stm32-qspi: Fix error path in case of -EPROBE_DEFER

Qing Zhang (2):
      spi: tools: Make default_tx/rx and input_tx static
      spi: tools: Add macro definitions to fix build errors

Zhenzhong Duan (2):
      spi: spidev: fix a race between spidev_release and spidev_remove
      spi: spidev: fix a potential use-after-free in spidev_release()

 .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 26 +++++++-----
 drivers/spi/spi-fsl-dspi.c                         |  8 ++--
 drivers/spi/spi-rspi.c                             | 28 +++++++++----
 drivers/spi/spi-sprd-adi.c                         |  2 +-
 drivers/spi/spi-stm32-qspi.c                       | 46 ++++++++++++----------
 drivers/spi/spidev.c                               | 24 +++++------
 include/uapi/linux/spi/spidev.h                    |  4 ++
 tools/spi/spidev_test.c                            | 10 ++---
 8 files changed, 90 insertions(+), 58 deletions(-)
