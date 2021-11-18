Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F52456165
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhKRR2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 12:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhKRR2y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 12:28:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF0FB61284;
        Thu, 18 Nov 2021 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637256354;
        bh=WwmOGkKKg0zLLgzvK9bLyotJTO+HbvDvts6r7EmggQM=;
        h=From:To:Cc:Subject:Date:From;
        b=WNmADNxh32pTrQvEeF4sVYYNa3FNEYUax8almx8UI3TIQmoXZb21qY0zuGZ+AQXcn
         y+u0Clp7wQjru0BScXkvoiU8TpBNYvAjwET5snyQ8pHE0BOC5+haa8V6t4S2zJRF5a
         cjHIc7UpVY3zGPnIRngmvChcIVhaiE6Z8s70hIjTiC88q5vcd7eQfOhlR9rgBKpJLE
         KWFfcGUYNGER3t/u3QlkaPIF3IDOscf81ssLGsIelYZ+92fnQjmPyeI/pmX23IJyvS
         FXdeFL3mVYTBUoaxW4CtXnbqQxi39HaNxGr9LMMIhsX5vrCn0qjarGEo2/dq8wPTTt
         8DHROXG9bgLGw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.16-rc1
Date:   Thu, 18 Nov 2021 17:25:37 +0000
Message-Id: <20211118172553.DF0FB61284@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 28b5eaf9712bbed90c2b5a5608d70a16b7950856:

  spi: Convert NXP flexspi to json schema (2021-10-29 18:56:02 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.16-rc1

for you to fetch changes up to 6c53b45c71b4920b5e62f0ea8079a1da382b9434:

  spi: fix use-after-free of the add_lock mutex (2021-11-12 18:18:03 +0000)

----------------------------------------------------------------
spi: Fixes for v5.16

A few small fixes for v5.16, one in the core for an issue with handling
of controller unregistration that was introduced with the fixes for
registering nested SPI controllers and a few more minor device specific
ones.

----------------------------------------------------------------
Alexander Stein (1):
      spi: lpspi: Silence error message upon deferred probe

Dan Carpenter (1):
      spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()

Dinh Nguyen (1):
      spi: cadence-quadspi: fix write completion support

Michael Walle (1):
      spi: fix use-after-free of the add_lock mutex

 drivers/spi/spi-cadence-quadspi.c | 24 +++++++++++++++++++++---
 drivers/spi/spi-fsl-lpspi.c       |  2 +-
 drivers/spi/spi-geni-qcom.c       | 16 ++++++++++------
 drivers/spi/spi.c                 | 12 ++++++------
 4 files changed, 38 insertions(+), 16 deletions(-)
