Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8245CB2B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhKXRk1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Nov 2021 12:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237134AbhKXRkW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 628C360FD9;
        Wed, 24 Nov 2021 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637775424;
        bh=lUnWil39PZ3+2bUu2Q0bOTKpsSdsah5zdI2aumIQATg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p+hoUHDb0l+chlEPTjwJ2NCSfzlfq/fRF3l7XyFlQDOghbav8TpErYcS8Rs+nt0MM
         OtGR9S9RF+Lqx4BEEFhtNbuVevBI+dh+gyINMRw7c+etMEyPA9pOwYu7ITuJCmqty6
         pS2qjkoHETp0jIo/4AFDSXQWFF0BsoGdd3CYs+z6C6cufbfCSXqjHph2D/ZVwxSZNn
         WvCQFeKZeMrRePXjbo6QXLlAJbT55iUv6CDIAMkrxW/iwW9sk+dNWGmhyNzGZMrv32
         AkdmyeUFyGxWLciBrZ+K1Png0xSAsdEgVpTI1aHn5Co9mmmr9zUanh3JIM5nFBRkht
         UkbyvGquycCVw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
References: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v3 1/3] spi: Fix condition in the __spi_register_driver()
Message-Id: <163777542313.2712295.15442415383053073135.b4-ty@kernel.org>
Date:   Wed, 24 Nov 2021 17:37:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 23 Nov 2021 19:00:32 +0200, Andy Shevchenko wrote:
> The recent commit 3f07657506df ("spi: deduplicate spi_match_id()
> in __spi_register_driver()") inadvertently inverted a condition
> that provokes a (harmless) warning:
> 
>   WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
> 
> Restore logic to avoid such warning to be issued.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Fix condition in the __spi_register_driver()
      commit: b79332ef9d61513d0ccda74a5161bb7c31851e9c

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
