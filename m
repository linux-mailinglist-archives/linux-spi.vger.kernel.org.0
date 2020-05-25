Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9081E1118
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbgEYO5h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 10:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404004AbgEYO5g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 10:57:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B66220899;
        Mon, 25 May 2020 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418656;
        bh=KNL8WWnAkz247YXlnDpHU5gZmIe/Xp5J0WWH6oSFc5c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fSJ7khPzavk5YfvqnYUWJ2s2t6dtiQhWpJd5n5fWAaHaBZ5ja8IzQkxyuw4QiT2WZ
         0R9GWpFb8qw/a2OYFdrY44t+ckVNGk88SVp6cgxaTanCq717vgAO392c4aeEOWq8hx
         HJUuy6YZ6fQeVOH0rtkQuU+rj/1eFEg0XrCjPBnE=
Date:   Mon, 25 May 2020 15:57:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200522155005.46099-1-broonie@kernel.org>
References: <20200522155005.46099-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: Make spi_delay_exec() warn if called from atomic context
Message-Id: <159041865398.1642.688073703678155218.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 May 2020 16:50:05 +0100, Mark Brown wrote:
> If the delay used is long enough the spi_delay_exec() will use a sleeping
> function to implement it. Add a might_sleep() here to help avoid callers
> using this from an atomic context and running into problems at runtime on
> other systems.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Make spi_delay_exec() warn if called from atomic context
      commit: 8fede89f853a7bfc671f9d8f069ccfe4190061f3

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
