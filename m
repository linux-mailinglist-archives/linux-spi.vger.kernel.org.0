Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33D42F00F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbhJOMAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 08:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238605AbhJOMAH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 08:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E18A660524;
        Fri, 15 Oct 2021 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634299081;
        bh=3fr4eHBskIxF4SeM/b8osbOb5lVw3k06onHREelkq64=;
        h=From:To:Cc:Subject:Date:From;
        b=Ho5Sr0jZdxlY94vxioelJeyuN4ohLEuDdZQF48Iz5bikpCjZzi2WhV12vwEyPgVSv
         igtfg7Y547Pw81JEN0pCxODsl3Fx19ZjEpkENN+a/ICuX9mDbjdzzEbwT7AD0InTw5
         0x8fBrzUCGMx3fpkRuWH+9/hcHIwGgulbr/6r1xNY6xmjCfqgJ5af2qpTD2AN8o5Do
         nKDHjbEoss0UZCOFGxkA+hpFrbRza/A9vOza6fGtYxnDtgiEzLTwi0VKzVWKD23/30
         mdDQ4lgVw3L2RgoLwfot3wJD8LWURSxIGVtSrDZyLWS0PZnsk1D+E+MHpuu4vIWH2m
         TJuRAM7kbKetw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.15-rc5
Date:   Fri, 15 Oct 2021 12:57:45 +0100
Message-Id: <20211015115800.E18A660524@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc5

for you to fetch changes up to 16a8e2fbb2d49111004efc1c7342e083eafabeb0:

  spi-mux: Fix false-positive lockdep splats (2021-10-14 13:32:19 +0100)

----------------------------------------------------------------
spi: Fixes for v5.15

A few small fixes for v5.15, mostly driver specific but there's one in
the core which fixes a deadlock when adding devices on spi-mux that's
triggered because spi-mux is a SPI device which is itself a SPI
controller and so can instantiate devices when registered.  We were
using a global lock to protect against reusing chip selects but they're
a per controller thing so moving the lock per controller resolves that.

----------------------------------------------------------------
Apurva Nandan (1):
      spi: Use 'flash' node name instead of 'spi-flash' in example

Dafna Hirschfeld (1):
      spi: mediatek: skip delays if they are 0

Kamal Dasu (1):
      spi: bcm-qspi: clear MSPI spifie interrupt during probe

Mark Brown (4):
      Merge tag 'v5.15-rc2' into spi-5.15
      spi: spidev: Add SPI ID table
      Merge tag 'v5.15-rc3' into spi-5.15
      spi: Fix deadlock when adding SPI controllers on SPI buses

Michael Walle (1):
      spi: spi-nxp-fspi: don't depend on a specific node name erratum workaround

Uwe Kleine-König (1):
      spi-mux: Fix false-positive lockdep splats

Ville Baillie (1):
      spi: atmel: Fix PDC transfer setup bug

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  2 +-
 drivers/spi/spi-atmel.c                            |  4 +-
 drivers/spi/spi-bcm-qspi.c                         | 77 +++++++++++++---------
 drivers/spi/spi-mt65xx.c                           | 64 ++++++++++--------
 drivers/spi/spi-mux.c                              |  7 ++
 drivers/spi/spi-nxp-fspi.c                         | 26 ++------
 drivers/spi/spi-tegra20-slink.c                    |  4 +-
 drivers/spi/spi.c                                  | 27 ++++----
 drivers/spi/spidev.c                               | 14 ++++
 include/linux/spi/spi.h                            |  3 +
 10 files changed, 127 insertions(+), 101 deletions(-)
