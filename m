Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C649D20D39A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgF2TAX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 15:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730359AbgF2TAV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8282D2558B;
        Mon, 29 Jun 2020 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593448391;
        bh=/bnSaBaAaRQIMkfhY0O24MZ95YBJs3ZmI1WjGHAXBRY=;
        h=From:To:Cc:Subject:Date:From;
        b=VWyT96avA8HauBL0P57cdOPKyaOo4Pdk7twj+6KdeG6NINni5AGn1B/vMn04UDwNz
         fO2vHTisik1Go1f8mwtidGg1twy9hcMicHZBEcxmjE4e9m+qRygeRraRl8/8uvVfnC
         GMx2EYzfFhr8eZXrOuYNSJBq/uA/bCDMOERS+Wvk=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.8-rc3
Date:   Mon, 29 Jun 2020 17:32:14 +0100
Message-Id: <20200629163310.8282D2558B@mail.kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 06096cc6c5a84ced929634b0d79376b94c65a4bd:

  spi: spidev: fix a potential use-after-free in spidev_release() (2020-06-18 17:47:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.8-rc3

for you to fetch changes up to cf961fce30f8269d0c2662c48b2618005b67dfd4:

  spi: pxa2xx: Add support for Intel Tiger Lake PCH-H (2020-06-25 15:50:50 +0100)

----------------------------------------------------------------
spi: Fixes for v5.8

A batch of fixes for the Freescale DSPI driver fixing some serious
issues with removal of active devices and one resume case, plus a few
new PCI IDs for Intel platforms.

----------------------------------------------------------------
Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Tiger Lake PCH-H

Krzysztof Kozlowski (4):
      spi: spi-fsl-dspi: Fix lockup if device is removed during SPI transfer
      spi: spi-fsl-dspi: Fix lockup if device is shutdown during SPI transfer
      spi: spi-fsl-dspi: Fix external abort on interrupt in resume or exit paths
      spi: spi-fsl-dspi: Initialize completion before possible interrupt

 drivers/spi/spi-fsl-dspi.c | 39 ++++++++++++++++++++++-----------------
 drivers/spi/spi-pxa2xx.c   |  5 +++++
 2 files changed, 27 insertions(+), 17 deletions(-)
