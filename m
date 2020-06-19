Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914EF200A19
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgFSN2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 09:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732706AbgFSN2Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 09:28:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CDE2158C;
        Fri, 19 Jun 2020 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573301;
        bh=CXCAueWu2DiyNaZhr+sNkbMx3i2rB1tDUfG/1hzhOTI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Ed3pEx8QIkGBIOa9QMTaxoaPbujhmwE/7/oMdbjG16YGKyfDFL3n5N2ywAKVEJWo8
         KkLsbt1tIu/RvIxh9ExoiKmyJMIFqGos0gQW7slDuECS29rkxY0otoO9bxOKHK+82p
         3Fy/qEa8+lQjgE94U/Gx1jWgzE2GrRShjiHO3KMc=
Date:   Fri, 19 Jun 2020 14:28:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tali Perry <tali.perry1@gmail.com>, linux-spi@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200618170144.57433-1-andriy.shevchenko@linux.intel.com>
References: <20200618170144.57433-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] spi: npcm-fiu: Reuse BITS_PER_BYTE definition
Message-Id: <159257327821.5984.1946818063117231399.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Jun 2020 20:01:44 +0300, Andy Shevchenko wrote:
> No need to redefine already existing definition.
> So, replace custom by generic one.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: npcm-fiu: Reuse BITS_PER_BYTE definition
      commit: 0ec544ceb1c1ff65fb5588c6d71bccff2713f0d9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
