Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3C3E2CFF
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhHFO4H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Aug 2021 10:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhHFO4H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Aug 2021 10:56:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 243236105A;
        Fri,  6 Aug 2021 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628261751;
        bh=S+TZfXj0n4NYdVUzQNuVBdQ9fbkUOCu9yibxXu4Rgi4=;
        h=From:To:Cc:Subject:Date:From;
        b=dP+VngRhOPcMJKKLByh1YHKiBkOAqAziDkkcxHHt+Z637NNzSsuZ7jsrywgKv8Yn4
         9/RvQ3KAxJRWM8/+q+LaqLMNjZTDlqEsTmjqgcvklUnbxIw65kCJ5PFoD6cMv+iA/A
         trv76fcgMZC/4KG+Q5h34t3NIl9lhpBgIkSTtpSXT6KQBrzhHQipIAhWcgPlK6IZh4
         Md21gSphO9L2uCa81/fR6P+czu1Md5DNd7Y41Pe2lk83xLFzBatue/S+AHohnkUsFI
         wKj4+IHJW6wqEEslKtR/fL8eLZbYybZGn4RaI9L+jkdVo1ujUwBnhxYiCtu2AJTPsA
         gQlmMXbKB8FRw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.14-rc4
Date:   Fri, 06 Aug 2021 15:55:19 +0100
Message-Id: <20210806145551.243236105A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit c45c1e82bba130db4f19d9dbc1deefcf4ea994ed:

  spi: spi-bcm2835: Fix deadlock (2021-07-20 13:34:05 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.14-rc4

for you to fetch changes up to 0395be967b067d99494113d78470574e86a02ed4:

  spi: cadence-quadspi: Fix check condition for DTR ops (2021-08-05 20:18:10 +0100)

----------------------------------------------------------------
spi: Fixes for v5.14

A small collection of fixes for SPI, small mostly driver specific things
plus a fix for module autoloading which hadn't been working properly for
DT systems.

----------------------------------------------------------------
Andreas Schwab (1):
      spi: update modalias_show after of_device_uevent_modalias support

Apurva Nandan (1):
      spi: cadence-quadspi: Fix check condition for DTR ops

Dongliang Mu (1):
      spi: meson-spicc: fix memory leak in meson_spicc_remove

Guenter Roeck (1):
      spi: mediatek: Fix fifo transfer

Marek Vasut (2):
      spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation
      spi: imx: mx51-ecspi: Fix CONFIGREG delay comment

Uwe Kleine-König (1):
      spi: spi-mux: Add module info needed for autoloading

 drivers/spi/spi-cadence-quadspi.c | 21 ++++++++++++++++++---
 drivers/spi/spi-imx.c             | 18 ++++++++++++++++--
 drivers/spi/spi-meson-spicc.c     |  2 ++
 drivers/spi/spi-mt65xx.c          | 19 +++++--------------
 drivers/spi/spi-mux.c             |  8 ++++++++
 drivers/spi/spi.c                 |  4 ++++
 6 files changed, 53 insertions(+), 19 deletions(-)
