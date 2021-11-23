Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A145A965
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 17:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhKWRA5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhKWRA4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:00:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A9960F5D;
        Tue, 23 Nov 2021 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637686668;
        bh=kXAjFuAp9qJUggReislth4p5ggBo1MTMJtfc4aFMfGk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hwGK/spAy3vbhpXke8g24gcAQHfTg2w7+SQxrhWqDtlJcHTAjlCJGXYeidkGfkOep
         5UUDfL+Gso1J5YPQQqYMVl4XbwYUcgI7+9VjG6ohrZheB60unkypsJD+EhhvNsaWyy
         9yoo9y+v6qPTJSRHBhRShsPydn27mz3GklH+SO31Sto5VwuKpiLtjwFwGWaCapEe9T
         JOVTQTAFufYKy2AC/x3qmWVzM5BIEpUwECAI3qjHCV4nhOraHEWkof/NWzpxr+ahpm
         5t7SkxC+pR3DzjIOgJ17BmODdLX4ZAmgRg4rLhHTqFsHCuAV4MQ2x8+NvWC8wo67H1
         ewgq7+7ckE7UA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211122175245.84691-1-andriy.shevchenko@linux.intel.com>
References: <20211122175245.84691-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: spidev: Use SPI_MODE_USER_MASK instead of casting
Message-Id: <163768666726.1388476.11718279194714572718.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 16:57:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Nov 2021 19:52:45 +0200, Andy Shevchenko wrote:
> Currently the 16-bit mode is what being used in user space.
> However assuming that is not fully correct. Instead we should
> use the respective mask, i.e. SPI_MODE_USER_MASK, which
> precisely defines what bits are available for user space apps.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Use SPI_MODE_USER_MASK instead of casting
      commit: dd06a0c6b6f64f6610c0bb8f7651df3ebfb0f990

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
