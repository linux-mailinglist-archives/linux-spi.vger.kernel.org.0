Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C82ED536
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbhAGRLp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 12:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbhAGRLp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 12:11:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE51F2342C;
        Thu,  7 Jan 2021 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610039464;
        bh=t1Gp2oo3VLef1KacdDRypyEhQ0ao26y+8U5vpHSprDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YDiHmK9y+SoviYeeCmkcueyJ6ZEjnCVAPehbjLC5BWasEEak9OST/syPJ0zuzJ65i
         qy+QJLDKqy9ISA5kZbdbzjq3i7qdzhljHHcHl322XkClnpnClpGK9MSTKqZWlxqjOg
         UBGDOZMypFG9CcDqFEQaqI/H0HC0iGigOmgXtoxyUPcA5fyyvNPmbDeiQydqgDr0rV
         k1SF2qWidk3IP6sbIbo46FylXHGhpHcsvQx2fKYSjWnxHFvjrt4m5BDuyW/V55pYyW
         hBE/VUQrhi2C4G1RmjYzs6Rg1mhokkbYCkhE1FX77xgEU7r91AWErfW33EzqbD/tPl
         3SQvEnTAGzzZA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.11-rc2
Date:   Thu, 07 Jan 2021 17:10:22 +0000
Message-Id: <20210107171103.EE51F2342C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc2

for you to fetch changes up to 6170d077bf92c5b3dfbe1021688d3c0404f7c9e9:

  spi: fix the divide by 0 error when calculating xfer waiting time (2021-01-04 14:24:58 +0000)

----------------------------------------------------------------
spi: Fixes for v5.11

A couple of core fixes here, both to do with handling of drivers which
don't report their maximum speed since we factored some of the handling
for transfer speeds out into the core in the previous release.  There's
also some driver specific fixes, including a relatively large set for
some races around timeouts in spi-geni-qcom.

----------------------------------------------------------------
Douglas Anderson (4):
      spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
      spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
      spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
      spi: spi-geni-qcom: Print an error when we timeout setting the CS

Mark Brown (2):
      Merge remote-tracking branch 'spi/for-5.10' into spi-5.11
      Merge tag 'v5.11-rc1' into spi-5.11

Roman Guskov (1):
      spi: stm32: FIFO threshold level - fix align packet size

Tudor Ambarus (1):
      spi: Fix the clamping of spi->max_speed_hz

Xu Yilun (2):
      spi: altera: fix return value for altera_spi_txrx()
      spi: fix the divide by 0 error when calculating xfer waiting time

 drivers/spi/spi-altera.c    | 26 +++++++-------
 drivers/spi/spi-geni-qcom.c | 84 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-stm32.c     |  4 +--
 drivers/spi/spi.c           | 11 ++++--
 4 files changed, 104 insertions(+), 21 deletions(-)
