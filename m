Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14A6253828
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHZTRt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 15:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgHZTRq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17952078A;
        Wed, 26 Aug 2020 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469466;
        bh=Mr6SlxCsan6zJF8gAY31r3tPoWTaIKbSwG/RSWwG1tc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZXjfSpll3EjVEGigVNW1fzW/O3ujde3tObpVRQckX4E1LAVDYlqGf+xHgEy87/pJf
         /roeTQMOveovh8Xy9X1RO0MY0vnCF5rktlA0YZ0WGrPIEQRH1qDYdyfBQOF+eO69kU
         CsK3G4vIeJ0gV9q2/x0gV9NeuRjkWpKtmMJ6qlXE=
Date:   Wed, 26 Aug 2020 20:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
References: <20200826151455.55970-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] spi: pxa2xx: Update header block in pxa2xx_ssp.h
Message-Id: <159846942993.39994.13582935724402815273.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Aug 2020 18:14:53 +0300, Andy Shevchenko wrote:
> We have direct users of some headers that are missed and
> have header included when forward declarations are enough.
> 
> Update header block in pxa2xx_ssp.h to align with actual usage.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: pxa2xx: Update header block in pxa2xx_ssp.h
      commit: e7aaf8748897d88fd1d17bfa461df84cf233d5a9
[2/3] spi: pxa2xx: Switch to use BIT() and GENMASK() in pxa2xx_ssp.h
      commit: 410f4cf79f64b1831e207b89f3c7ab08e36aa646
[3/3] spi: pxa2xx: Drop useless comment in the pxa2xx_ssp.h
      commit: 3a2fd4011a1ecec361498301a27d79d5fef255de

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
