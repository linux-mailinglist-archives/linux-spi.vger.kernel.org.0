Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2221C7778
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgEFRLq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 13:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbgEFRLq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 13:11:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6265D2080D;
        Wed,  6 May 2020 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588785105;
        bh=+KM2GG5M8SQItJjbgm0MOxjOvOYTVB3+nXFI9KE74O8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=c+IiKVsLRbeacvG3b+YaLcwqKVVH9q1ebD2mIvtp8+24ZsGiriwP2SZ65VNhzFzbq
         qXxHV5u+XKi/yddvhzsFVU5NUpa62WMIxYgEeT4qfin1ckE8o7ug1U51ugHhfsTaes
         t4+AbxOJnEzGG3b4dkkxd1zHXuEBReQgWXwNp/lI=
Date:   Wed, 06 May 2020 18:11:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/8] spi: dw: Zero DMA Tx and Rx configurations on stack
Message-Id: <158878510325.23547.5213766420856150647.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 6 May 2020 18:30:18 +0300, Andy Shevchenko wrote:
> Some DMA controller drivers do not tolerate non-zero values in
> the DMA configuration structures. Zero them to avoid issues with
> such DMA controller drivers. Even despite above this is a good
> practice per se.
> 
> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Feng Tang <feng.tang@intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/8] spi: dw: Zero DMA Tx and Rx configurations on stack
      commit: 3cb97e223d277f84171cc4ccecab31e08b2ee7b5
[2/8] spi: dw: Remove unused variable in CR0 configuring hooks
      commit: d4dd6c0a404a2ed3843b4b685d6990c4438a64c0
[3/8] spi: dw: Move interrupt.h to spi-dw.h who is user of it
      commit: 0c2ce3fe4dd0b8f8dda07ea029f51ddf4c5190c2
[4/8] spi: dw: Downgrade interrupt.h to irqreturn.h where appropriate
      commit: e62a15d97b0adede829ba5b4f1c8e28f230bd8e8
[5/8] spi: dw: Move few headers under #ifdef CONFIG_SPI_DW_MID_DMA
      commit: e7940952644558e680033ae0450978445e53b423
[6/8] spi: dw: Add 'mfld' suffix to Intel Medfield related routines
      commit: 37aa8aa68492deb56f9e4c8b2d00aa5d9dae7da2
[7/8] spi: dw: Propagate struct device pointer to ->dma_init() callback
      commit: 6370ababce81911576d7c96663ae64fb84820c7b
[8/8] spi: dw: Add Elkhart Lake PSE DMA support
      commit: 22d48ad7bfacda05900c3f7b43510fc4d40d5d53

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
