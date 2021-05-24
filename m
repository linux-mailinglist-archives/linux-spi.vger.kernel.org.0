Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1BF38E2E6
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhEXJE6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 05:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232396AbhEXJE5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 05:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA7260698;
        Mon, 24 May 2021 09:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621847010;
        bh=43P7ifsnYFSE/3iQU2ti66SsUBNlX+NB7DvG2QknK8U=;
        h=From:To:Cc:Subject:Date:From;
        b=j/u+K278kPXY909NRb9AJJ7Ygalv7bb4uTcgJHlZ+EzmNxcs+aFenyAVp/wpkkOd9
         bO0ljCTW6FxKo9DnYia/JBHjXjcz21LyAy31cQkGLZReW9jCQtgwx1wBXtjcsFKlTu
         XL3soks19EUwsiJdbFTbZeBaHK/ZMtEjreAtVN41ErPkQaSBhYshZ9BADJIdkfZirW
         whyrBcCzt6S3gafXHrB+pfrtWW0UwILoSv3Xgx5MVeoVzRglvPISoNc0ydteyUD7m0
         ca7QyG3gED1dbhyjySuJOFjvgkSGVMUhNEAF2CfN9jAqbfOV5n7PjjxhO9DMgdKpwg
         8bEycsH5zxMug==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.13-rc3
Date:   Mon, 24 May 2021 10:03:14 +0100
Message-Id: <20210524090329.9BA7260698@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc3

for you to fetch changes up to b4e46c9954ad55092502e1e8c44ceb9b6744bade:

  spi: sc18is602: implement .max_{transfer,message}_size() for the controller (2021-05-21 13:13:33 +0100)

----------------------------------------------------------------
spi: Fixes for v5.13

There's some device specific fixes here but also an unusually large
number of fixes for the core, including both fixes for breakage
introduced on ACPI systems while fixing the long standing confusion
about the polarity of GPIO chip selects specified through DT, and fixes
for ordering issues on unregistration which have been exposed through
the wider usage of devm_.

----------------------------------------------------------------
Alain Volmat (1):
      MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: Fix kernel-doc warning

Andy Shevchenko (2):
      spi: Switch to signed types for *_native_cs SPI controller fields
      spi: Assume GPIO CS active high in ACPI case

Christophe JAILLET (1):
      spi: spi-fsl-dspi: Fix a resource leak in an error handling path

Chunyan Zhang (1):
      spi: sprd: Add missing MODULE_DEVICE_TABLE

Geert Uytterhoeven (1):
      spi: altera: Make SPI_ALTERA_CORE invisible

Karen Dombroski (1):
      spi: spi-zynq-qspi: Fix stack violation bug

Leilk Liu (1):
      spi: take the SPI IO-mutex in the spi_set_cs_timing method

Mark Brown (1):
      Merge tag 'v5.13-rc2' into spi-5.13

Michael Walle (1):
      dt-bindings: spi: spi-mux: rename flash node

Saravana Kannan (2):
      spi: Fix spi device unregister flow
      spi: Don't have controller clean up spi device before driver unbind

Vladimir Oltean (2):
      spi: sc18is602: don't consider the chip select byte in sc18is602_check_transfer
      spi: sc18is602: implement .max_{transfer,message}_size() for the controller

 Documentation/devicetree/bindings/spi/spi-mux.yaml |  2 +-
 MAINTAINERS                                        |  6 +++
 drivers/spi/Kconfig                                |  2 +-
 drivers/spi/spi-fsl-dspi.c                         |  4 +-
 drivers/spi/spi-sc18is602.c                        |  9 +++-
 drivers/spi/spi-sprd.c                             |  1 +
 drivers/spi/spi-zynq-qspi.c                        |  9 ++--
 drivers/spi/spi.c                                  | 51 ++++++++++++++++------
 include/linux/spi/spi.h                            |  4 +-
 9 files changed, 64 insertions(+), 24 deletions(-)
