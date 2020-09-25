Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982082791FC
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgIYUVh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 16:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgIYUTc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Sep 2020 16:19:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4470521D42;
        Fri, 25 Sep 2020 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601065069;
        bh=9hrloYmTV/iAmrcqAToHBZUm/mlxs2GnPwaYLrzTHeg=;
        h=From:To:Cc:Subject:Date:From;
        b=1eADcv4o4XwAjOeWvdMUMrs1j4rLqlNQJR6VKhKrkn7hAkjobEzR0ZP2FwfOrdVSc
         TAmYgQiFZho9liqiE/zCvQDGYC84bMTCGLMgS1jdM0nZ/aLjDTsEXOw3txDoE1gZDf
         cCq+J6tC+/i7n0mRFlXBDQDfQN7FWPJtXitWuUnA=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.9-rc6
Date:   Fri, 25 Sep 2020 21:16:43 +0100
Message-Id: <20200925201749.4470521D42@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit c170a5a3b6944ad8e76547c4a1d9fe81c8f23ac8:

  spi: stm32: fix pm_runtime_get_sync() error checking (2020-09-09 15:11:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc6

for you to fetch changes up to 00fb259c618ea1198fc51b53a6167aa0d78672a9:

  spi: bcm-qspi: Fix probe regression on iProc platforms (2020-09-24 12:09:46 +0100)

----------------------------------------------------------------
spi: Fixes for v5.9

A small collection of driver specific fixes, the fsl-espi and bcm-qspi
changes in particular have been causing breakage for users.

----------------------------------------------------------------
Chris Packham (1):
      spi: fsl-espi: Only process interrupts for expected events

Jason Yan (1):
      spi: bcm2835: Make polling_limit_us static

Ray Jui (1):
      spi: bcm-qspi: Fix probe regression on iProc platforms

Sascha Hauer (1):
      spi: fsl-dspi: fix use-after-free in remove path

Vladimir Oltean (1):
      spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs

 drivers/spi/spi-bcm-qspi.c |  2 +-
 drivers/spi/spi-bcm2835.c  |  2 +-
 drivers/spi/spi-fsl-dspi.c | 18 ++++++++++--------
 drivers/spi/spi-fsl-espi.c |  5 +++--
 4 files changed, 15 insertions(+), 12 deletions(-)
