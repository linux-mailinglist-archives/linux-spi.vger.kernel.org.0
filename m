Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2D2B99EF
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 18:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgKSRpk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 12:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKSRpj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 12:45:39 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FC5246D1;
        Thu, 19 Nov 2020 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605807939;
        bh=0Ily8GU1L3meC7su53GWzSiSKHlT/zHGHdGumDMVjTg=;
        h=From:To:Cc:Subject:Date:From;
        b=L1hxl53ILHRF2vp07xAaKF6NxzddOcXjZEylZITKs5hacW6xav0WxfdGlcU10GSDC
         Kgz3aVcFeT0e3sDyBTm8/XNztzx3lrtdKxThSUHELP8MQwp/HVopa7CkwG39SLCg3a
         hdlzSqcOh55ZL9ihmy4iDcM686cjOPQzc7JoCRsw=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.10-rc4
Date:   Thu, 19 Nov 2020 17:45:17 +0000
Message-Id: <20201119174538.A2FC5246D1@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit bc7f2cd7559c5595dc38b909ae9a8d43e0215994:

  spi: bcm2835: remove use of uninitialized gpio flags variable (2020-11-06 11:23:26 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc4

for you to fetch changes up to 04a9cd51d3f3308a98cbc6adc07acb12fbade011:

  spi: npcm-fiu: Don't leak SPI master in probe error path (2020-11-17 17:08:39 +0000)

----------------------------------------------------------------
spi: Fixes for v5.10

This is a relatively large set of fixes, the bulk of it being a series
from Lukas Wunner which fixes confusion with the lifetime of driver data
allocated along with the SPI controller structure that's been created as
part of the conversion to devm APIs.  The simplest fix, explained in
detail in Lukas' commit message, is to move to a devm_ function for
allocation of the controller and hence driver data in order to push the
free of that after anything tries to reference the driver data in the
remove path.  This results in a relatively large diff due to the
addition of a new function but isn't particularly complex.

There's also a fix from sven van Asbroeck which fixes yet more fallout
from the conflicts between the various different places one can
configure the polarity of GPIOs in modern systems.

Otherwise everything is fairly small and driver specific.

----------------------------------------------------------------
Eddie James (1):
      spi: fsi: Fix transfer returning without finalizing message

Lukas Wunner (6):
      spi: Introduce device-managed SPI controller allocation
      spi: bcm2835: Fix use-after-free on unbind
      spi: bcm2835aux: Fix use-after-free on unbind
      spi: bcm-qspi: Fix use-after-free on unbind
      spi: lpspi: Fix use-after-free on unbind
      spi: npcm-fiu: Don't leak SPI master in probe error path

Mark Brown (1):
      Merge series "Use-after-free be gone" from Lukas Wunner <lukas@wunner.de>:

Nathan Chancellor (1):
      spi: bcm2835aux: Restore err assignment in bcm2835aux_spi_probe

Serge Semin (1):
      spi: dw: Set transfer handler before unmasking the IRQs

Sven Van Asbroeck (1):
      spi: fix client driver breakages when using GPIO descriptors

Zhihao Cheng (1):
      spi: cadence-quadspi: Fix error return code in cqspi_probe

 drivers/spi/spi-bcm-qspi.c        | 34 ++++++----------
 drivers/spi/spi-bcm2835.c         | 24 ++++--------
 drivers/spi/spi-bcm2835aux.c      | 20 ++++------
 drivers/spi/spi-cadence-quadspi.c |  2 +
 drivers/spi/spi-dw-core.c         |  4 +-
 drivers/spi/spi-fsi.c             |  2 +-
 drivers/spi/spi-fsl-lpspi.c       |  3 --
 drivers/spi/spi-npcm-fiu.c        |  2 +-
 drivers/spi/spi.c                 | 81 ++++++++++++++++++++++++++++++---------
 include/linux/spi/spi.h           | 19 +++++++++
 10 files changed, 115 insertions(+), 76 deletions(-)
