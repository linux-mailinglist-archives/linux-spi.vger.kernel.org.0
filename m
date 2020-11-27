Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5A2C6731
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgK0NtI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 08:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbgK0NtI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 27 Nov 2020 08:49:08 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8BA221EB;
        Fri, 27 Nov 2020 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606484948;
        bh=wTCBRUiihoT9q2ZS346JiZs8EzR20O9G2B8G/jSbqhc=;
        h=From:To:Cc:Subject:Date:From;
        b=FT1bXxIrqyHfuog/Z8RSPFDxhNVWm2AfZrcE/n7684DImVxnghyjJuSBpzyIGtzUO
         qFTylBRVOMKxMgoi3HQBKy5x8669D55j6kA7ZvB78TmHxnhSnSWXjZxjkE+3z8ONxE
         iX2h5k2DpcqqKK2f6iArx2mpGXYVseTX36Gk6MPE=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.10-rc5
Date:   Fri, 27 Nov 2020 13:48:29 +0000
Message-Id: <20201127134907.9C8BA221EB@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 04a9cd51d3f3308a98cbc6adc07acb12fbade011:

  spi: npcm-fiu: Don't leak SPI master in probe error path (2020-11-17 17:08:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc5

for you to fetch changes up to 0abdb0fba07322ce960d32a92a64847b3009b2e2:

  spi: dw: Fix spi registration for controllers overriding CS (2020-11-25 12:54:05 +0000)

----------------------------------------------------------------
spi: Fixes for v5.10

A few fixes for v5.10, one for the core which fixes some potential races
for controllers with multiple chip selects when configuration of the
chip select for one client device races with the addition and initial
setup of an additional client.

----------------------------------------------------------------
Clark Wang (1):
      spi: imx: fix the unbalanced spi runtime pm management

Lars Povlsen (1):
      spi: dw: Fix spi registration for controllers overriding CS

Ran Wang (1):
      spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts

Serge Semin (1):
      spi: Take the SPI IO-mutex in the spi_setup() method

 drivers/spi/spi-dw-core.c  | 3 ++-
 drivers/spi/spi-imx.c      | 1 +
 drivers/spi/spi-nxp-fspi.c | 7 +++++++
 drivers/spi/spi.c          | 5 +++++
 4 files changed, 15 insertions(+), 1 deletion(-)
