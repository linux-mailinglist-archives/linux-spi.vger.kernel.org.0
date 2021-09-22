Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96C1414FC9
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 20:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhIVSZs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Sep 2021 14:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237085AbhIVSZr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Sep 2021 14:25:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23A476124A;
        Wed, 22 Sep 2021 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632335057;
        bh=4lT8+7HhiPrBpRZXhN9cd75l4Wj4YVa0h9BpITgay34=;
        h=From:To:Cc:Subject:Date:From;
        b=bwGSmcq8Mr0EFYucIdqqVyD+xP7KOwEizurBjkdBheppapKkWJ6ITMuwDrJA7WPdX
         VHoKaqERb++B9uRFHPdocdACkp4cLW4CD1Pjcw0Ii0iwhTeBLjBecGjm3ormrrzpQJ
         82emIxnfHsfp52nDeDTrXvmdaS6ZLQDTbJUlbx8qWtWdm0fdqDpCSuKuqYQZMtiEby
         AxDmEBpYpyiGsPPve3lDfZXb6IrlhRg+Vxrk8ycDjfHN8/bcTOXs2DG/JQBdWBX/5R
         aDon3nrkPMmzMqikWdxA2fHBJ1th4e6akVxBAVYFjoZeRUDVdr8/otwsk3HkHfw42p
         rfEEkHw/b/kgQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.15-rc1
Date:   Wed, 22 Sep 2021 19:23:19 +0100
Message-Id: <20210922182417.23A476124A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.15-rc1

for you to fetch changes up to 96c8395e2166efa86082f3b71567ffd84936439b:

  spi: Revert modalias changes (2021-09-21 20:22:48 +0100)

----------------------------------------------------------------
spi: Fix modalias issues

As reported by Russell King the change to use OF style modaliases for DT
enumerated broke at least the spi-nor driver, the patch here reverts
that change to fix the regression.  Sadly this will mean that anything
that started loading since the change to OF modaliases will run into
issues, there doesn't seem to be any approach which doesn't cause some
problems and thi seems like the least bad approach - gory details are in
the commit log for the change.  I'm currently working through the SPI
drivers to add ID tables and missing IDs to tables which should address
things from the other end, this seems more straightforward and robust
than any other options.

----------------------------------------------------------------
Mark Brown (1):
      spi: Revert modalias changes

 drivers/spi/spi.c | 8 --------
 1 file changed, 8 deletions(-)
