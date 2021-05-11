Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D566B37AE44
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKSVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKSVV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4906A617ED;
        Tue, 11 May 2021 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757214;
        bh=1xS6shtYnjIh3IDww/MAPy8ype2rwv5gzLmN8uf/sQM=;
        h=Subject:From:Date:To:From;
        b=UY5VD+9eYOH4JcNxbA57aXgPeU7dm5Yahmrb63VnGiCzoXu2+4+dyhSyc1648Z5ZX
         LRNTc5I/RcSnj/VlqxnlJ+YNzp1m2PJ8ffNlpiFXMlKc33q2dIE27ghkeu7V2JkW3r
         mona+fa9vF/CcumjHn9ZdXGUhCFWvGJTl4po1hoFSKPSaKOy5Swi/nPR/CEcBroPxm
         m1Rmd/tURhGIle/hJ6yafncp+Bby4yZTSlq7ec90mTHyJAy48dM1Uvx1uFsO69IG3i
         f0tl+jt4Avt9GapQ3RgHJHKI+WB8rIFScA39KPiazO3ap0nlXgAud858vsk6B0dUGY
         hjW5ZyGtrpA8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3500C60A02;
        Tue, 11 May 2021 18:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162075721415.18313.8028028189410446151.git-patchwork-summary@kernel.org>
Date:   Tue, 11 May 2021 18:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: pxa2xx: Set of cleanups
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=480467
  Lore link: https://lore.kernel.org/r/20210511141725.32097-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/8] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
             [v3,2/8] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
             [v3,3/8] spi: pxa2xx: Extract pxa2xx_spi_update() helper
             [v3,4/8] spi: pxa2xx: Extract clear_SSCR1_bits() helper
             [v3,5/8] spi: pxa2xx: Extract read_SSSR_bits() helper
             [v3,6/8] spi: pxa2xx: Constify struct driver_data parameter
             [v3,7/8] spi: pxa2xx: Introduce special type for Merrifield SPIs
             [v3,8/8] spi: Convert to use predefined time multipliers
Patch: [v1,1/1] spi: Convert to use predefined time multipliers
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=479557
  Lore link: https://lore.kernel.org/r/20210510131120.49253-1-andriy.shevchenko@linux.intel.com

Total patches: 9

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


