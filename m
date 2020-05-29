Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0B1E8974
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2VGR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 17:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE2VGQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 17:06:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2486220810;
        Fri, 29 May 2020 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786376;
        bh=QT16Mn7894CdBacVP3Kyw45K52umTEnl7gJ5iX+DB5k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FjSHJzdA9hK5QSBEp0ToEbzaL6rftd+7fwks9NWHgaNWzLzqFjnyIdV+RIKEtuX5J
         YuoFkJ3NTAKQ/YR2PHhjX5DihJ3Co9UvvcmU2uSgropcb9gqcZGKK/ry88TqR2TqxW
         +wW/Aehb696SzuuI45o1I0a7hl/p/f2VRV/ZffFw=
Date:   Fri, 29 May 2020 22:06:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
References: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
Message-Id: <159078636490.21150.9644492227368222786.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 28 May 2020 13:23:10 +0300, Andy Shevchenko wrote:
> The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> did a clean up of global variables, which is fine, but messed up with
> the carefully provided information in the custom DMA slave structures.
> There reader can find an assignment of the DMA request lines in use.
> 
> Partially revert the above mentioned commit to restore readability
> and maintainability of the code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
      commit: b3f82dc26c0d4e1348ef81e0189cb8838b8b0d22
[2/2] spi: dw: Refactor mid_spi_dma_setup() to separate DMA and IRQ config
      commit: 3d7db0f11c7ad19979a1a01cac1d379ff040e886

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
