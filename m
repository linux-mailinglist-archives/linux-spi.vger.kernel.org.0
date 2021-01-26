Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E74303D8E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbhAZMqt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jan 2021 07:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391809AbhAZMqa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Jan 2021 07:46:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 055F723122;
        Tue, 26 Jan 2021 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611665149;
        bh=Fw5JHeWsMW3m9meLbOrgcgd6ITwG2t0vC9dq5se19cM=;
        h=From:To:Cc:Subject:Date:From;
        b=R6fznTSM64UMBG9KKfnYFdRkXQssdZurLhA7KHc6XS98lVGHgnMaRe0G8/S4+uGw8
         JZx6U/6xpcYloUqT+J5fBtMxtnNFR2fk3ftZ03izlSrQ4lY97kMh8syvjs0UO/YUsI
         0Og0eDvVY3LjU5seTxTCUDXhjErfZ1axYoisTH6KBpSGRDMZ/skb3nVE8i/p6Epe4x
         5aOXCuTckBtSHCtY1g8Y8C+//rqK866J9J38PKd2nj3locrN6+ldYm6nOY4Nmq+EsR
         G8jnxVnreXb9+8SY8cro8U9dUl53cUSjF6SF8TrkrMmZnlSiTm1X7RmzhAALOGtNDp
         GZPSE4H12uMYg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.11-rc5
Date:   Tue, 26 Jan 2021 12:44:56 +0000
Message-Id: <20210126124549.055F723122@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 4d163ad79b155c71bf30366dc38f8d2502f78844:

  spi: cadence: cache reference clock rate during probe (2021-01-15 14:14:38 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc5

for you to fetch changes up to 396cf2a46adddbf51373e16225c1d25254310046:

  spidev: Add cisco device compatible (2021-01-25 12:53:48 +0000)

----------------------------------------------------------------
spi: Fixes for v5.11

One new device ID here, plus an error handling fix - nothing remarkable
in either.

----------------------------------------------------------------
Daniel Walker (1):
      spidev: Add cisco device compatible

Pan Bian (1):
      spi: altera: Fix memory leak on error path

 drivers/spi/spi-altera.c | 3 ++-
 drivers/spi/spidev.c     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)
