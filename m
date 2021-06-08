Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8039F90F
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhFHO3U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 10:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233374AbhFHO3Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 10:29:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F3861003;
        Tue,  8 Jun 2021 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623162443;
        bh=ibW8RuYchsJJpX+NrppqOg6mttInE95osEDBNg2jiQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jNCx/f7qoBn7Me6VR6uYN/bs3xyIB5cTP9WIuCEAML3zqWWgqhtEpj3EpX40xf//t
         +3nHscVSnJHqaJql6umvHdOd6JozF4l4om59tB6yVmPFGg/FQd7STE0DfsNFDstkXA
         5vWHH5S4qXu5KQXFhD/pX6Cxbjpgc2yT7fRnN1vuqqZuxgOys3kEI9jc596rRi8gWB
         NPEAB+UCpnkFJdwPUsqtAnmwbpdrON3mBWiDg6Bh91YVc/M7izpkyNv+1llsgtFCAf
         sQqw+vsROyXprVAL9GXIEsprGcpRWAUBJOAzvx38Y4eLSRyM0XdymrSJOg2Fbtwqa2
         m74KKxAoKzR/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.13-rc4
Date:   Tue, 08 Jun 2021 15:26:54 +0100
Message-Id: <20210608142723.07F3861003@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit b4e46c9954ad55092502e1e8c44ceb9b6744bade:

  spi: sc18is602: implement .max_{transfer,message}_size() for the controller (2021-05-21 13:13:33 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc4

for you to fetch changes up to d38fa9a155b2829b7e2cfcf8a4171b6dd3672808:

  spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd() (2021-06-03 13:55:36 +0100)

----------------------------------------------------------------
spi: Fixes for v5.13

A small set of SPI fixes that have come up since the merge window, all
fairly small fixes for rare cases.

----------------------------------------------------------------
Lukas Wunner (2):
      spi: bcm2835: Fix out-of-bounds access with more than 4 slaves
      spi: Cleanup on failure of initial setup

Patrice Chotard (1):
      spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd()

zpershuai (1):
      spi: spi-zynq-qspi: Fix some wrong goto jumps & missing error code

 drivers/spi/spi-bcm2835.c     | 10 ++++++++--
 drivers/spi/spi-bitbang.c     | 18 ++++++++++++++----
 drivers/spi/spi-fsl-spi.c     |  4 ++++
 drivers/spi/spi-omap-uwire.c  |  9 ++++++++-
 drivers/spi/spi-omap2-mcspi.c | 33 ++++++++++++++++++++-------------
 drivers/spi/spi-pxa2xx.c      |  9 ++++++++-
 drivers/spi/spi-stm32-qspi.c  |  5 ++++-
 drivers/spi/spi-zynq-qspi.c   |  7 ++++---
 8 files changed, 70 insertions(+), 25 deletions(-)
