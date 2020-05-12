Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0171CFB3C
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgELQp2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 12:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQp2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 May 2020 12:45:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4D5720722;
        Tue, 12 May 2020 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301928;
        bh=xu1R/5/aQFub8Yk4YW+K8HPwR+BqQG8rqcb423wPgrA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hS+O6yQ3eFD/nHYTaDFHd7mVZP+ucpW6O7/S2Gzlqh3GIGY7UoUGPY6c13uf5XUp3
         3ZeCRghXaz+UqaoV3SCyVLK9pUOVr6Nc0yzEvdgh5dBKj7bAemNUaFk4EEd5ZSh+AG
         k97b7q+vk2ESAN/bLsXzwz+AAm0GjBc3KYeTO930=
Date:   Tue, 12 May 2020 17:45:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200512110315.58845-1-andriy.shevchenko@linux.intel.com>
References: <20200512110315.58845-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] spi: dw: Drop duplicate error message when remap resource
Message-Id: <158930192569.56061.17018608522071967336.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 May 2020 14:03:15 +0300, Andy Shevchenko wrote:
> devm_platform_ioremap_resource() will issue a message in the error case.
> Thus, no need to duplicate in the driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: dw: Drop duplicate error message when remap resource
      commit: afb7f565249aca3d46954889f07b48e8caf860ce

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
