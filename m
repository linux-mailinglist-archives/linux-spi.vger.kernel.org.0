Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6762E8032
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 14:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgLaNa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 08:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgLaNa4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 31 Dec 2020 08:30:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BD49223E0;
        Thu, 31 Dec 2020 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421416;
        bh=NbAgO49jiVJRCpSElG9g19rRkpcoecdZcoOnFPf54sU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gL5vIoNWZ8srvUPM8fz94f8ZbjH4pGDpTcsQSsBY1UXb6soi8ra3582cP4c3QlNFG
         FFBg3pJN5QjXL1MgoLKzJ2RQ7PpGOj75QXTLBzk+jbSn8qasCslBZCgb0b4n5cuyim
         /HsUaLelb1slifzdjI0pcMxHeuUQ/aRKVODA9J9qhrAYQ7O4qFprxphYJlwO8nJFPN
         0VkquKx/TJlPpMAJJkoQJem1RtQtf+fUICO4cnwwWDpiB5K11kglO+VZUMP+HO0UT0
         DU6h2/KEoZouP7fMNRJkE7kj6YzYLGiG3HLF5fr2ok6UQwKs77jby3NXk5KO4/1g5Z
         KD3nP2EScdcWA==
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>, Jiri Kosina <trivial@kernel.org>
Cc:     linux-spi@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH 0/2] spi: rpc-if: Trivial fixes
Message-Id: <160942139228.56552.16978804371025808850.b4-ty@kernel.org>
Date:   Thu, 31 Dec 2020 13:29:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 30 Dec 2020 14:57:06 +0000, Lad Prabhakar wrote:
> These patches are trivial fixes for rpc-if SPI driver.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   spi: rpc-if: Avoid use of C++ style comments
>   spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
      commit: 9584fc95cadc0b86e5e01cefcff0ab2b31ee3a5b

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
