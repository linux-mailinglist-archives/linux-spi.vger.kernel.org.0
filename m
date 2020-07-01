Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D82115F2
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgGAWYq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgGAWYp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA3F20853;
        Wed,  1 Jul 2020 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642285;
        bh=FHBh1mxPgfAWN1bzSoTB4s7mrsMW5ytak9w9b0zSggs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=frMh+kziKHUgVefYXDYKCfSq9uFnCLrqxGhglAJNLuLpI1qBHH3CYwq0csPtnqgrW
         y2aEAEnlxD6fkyDP/i8VSGnDNIf5WQPt/uvtuAgdY9aXiuYD2ZDYYs77SD28M1pIW9
         Rgaty/yJ2JcuQ7KMnayhiqIpjqD6VzwILARfnrQY=
Date:   Wed, 01 Jul 2020 23:24:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20200622162611.83694-1-luc.vanoostenryck@gmail.com>
References: <20200622162611.83694-1-luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] spi: fsl: add missing __iomem annotation
Message-Id: <159364224815.10988.7192403124686277429.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Jun 2020 18:26:11 +0200, Luc Van Oostenryck wrote:
> The field mspi->reg_base is annotated as an __iomem pointer. Good.
> 
> However, this field is often assigned to a temporary variable:
> before being used. For example:
> 	struct fsl_spi_reg *reg_base = mspi->reg_base;
> 
> But this variable is missing the __iomem annotation.
> So, add the missing __iomem and make sparse & the bot happier.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl: add missing __iomem annotation
      commit: dd67de8c3b421376b4b6dac14263763aa75535fc

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
