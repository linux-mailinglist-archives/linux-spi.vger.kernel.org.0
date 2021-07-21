Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5123D1525
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhGUQxb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 12:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236338AbhGUQxb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 12:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 485936124B;
        Wed, 21 Jul 2021 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626888847;
        bh=b6z7/esTdXvxkRFP8Hdtl7YfEHwvkyxK8xKYwAwchuk=;
        h=From:To:Cc:Subject:Date:From;
        b=pTKTV7RHlxD81GPcOVD5Xk9vRtDOrTVPkofkSyGAcAhm8DlQEZBB+h97+JWnXhVx6
         37UOq3nXg/qSRp1Hc5cFauYQn7i1GyAJ19/bBUdtYxX+mIwdDBhwB1xfnVLSG9wDWk
         jXYKtTEAkWACLO+5fCwVcmds78CW82gPJpFQaRYQ7VY+2DPV1kQjx3v1zoRG/lUX7z
         b/ctna6WK9rphEHoK2vOOcTyzv5VDNai2WmSeLCGgsoUEDSNbJe/TDF2sY+Y8FNC/a
         Tf+3VOZs1BLcnVnhnPUtyRZCkKaymsWKWjWMhLkrTQrdXoxyXWCxa0blbII1cES82L
         CLW/aDMYCSa4w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.14-rc2
Date:   Wed, 21 Jul 2021 18:33:48 +0100
Message-Id: <20210721173407.485936124B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit b470e10eb43f19e08245cd87dd3192a8141cfbb5:

  spi: core: add dma_map_dev for dma device (2021-06-25 12:26:49 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc2

for you to fetch changes up to c45c1e82bba130db4f19d9dbc1deefcf4ea994ed:

  spi: spi-bcm2835: Fix deadlock (2021-07-20 13:34:05 +0100)

----------------------------------------------------------------
spi: Fixes for v5.14

A collection of driver specific fixes, there was a bit of a kerfuffle
with some last minute review on hte spi-cadence-quadspi division by zero
change but otherwise nothing terribly remarkable here - important fixes
if you have the hardware but nothing with too wide an impact.

----------------------------------------------------------------
Alain Volmat (2):
      spi: stm32h7: fix full duplex irq handler handling
      spi: stm32: fixes pm_runtime calls in probe/remove

Alexandru Tachici (1):
      spi: spi-bcm2835: Fix deadlock

Apurva Nandan (1):
      spi: cadence-quadspi: Disable Auto-HW polling

Dan Sneddon (1):
      spi: atmel: Fix CS and initialization bug

Marek Vasut (2):
      spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
      spi: cadence: Correct initialisation of runtime PM again

Mason Zhang (1):
      spi: mediatek: move devm_spi_register_master position

Peter Hess (1):
      spi: mediatek: fix fifo rx mode

Yoshitaka Ikeda (3):
      spi: spi-cadence-quadspi: Fix division by zero warning
      spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
      spi: spi-cadence-quadspi: Fix division by zero warning

 drivers/spi/spi-atmel.c           |  9 ++-------
 drivers/spi/spi-bcm2835.c         | 12 +++++++-----
 drivers/spi/spi-cadence-quadspi.c | 30 +++++++++++++++++-------------
 drivers/spi/spi-cadence.c         | 14 +++++++++-----
 drivers/spi/spi-imx.c             | 38 +++++++++++++++++++-------------------
 drivers/spi/spi-mt65xx.c          | 28 +++++++++++++++++++---------
 drivers/spi/spi-stm32.c           | 24 +++++++++++++++++-------
 7 files changed, 90 insertions(+), 65 deletions(-)
