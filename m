Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB12F665B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 17:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbhANQuF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 11:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbhANQuF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 11:50:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1939023B31;
        Thu, 14 Jan 2021 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610642964;
        bh=H3FwxhFZ6SmtNt9wHW2fCSLG+B6atpqcRTK2kJa5bkc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K67iuTb9kWZa5Ylld5DjkjH6+KGpc2yD9KSWC380O3FJBL4lzODATKkdMEhj4oXuH
         V9Y78p6cRAW4FYTc8l3z54HUjhuee38VGF0FidTwaNlA3aG8+zFMsvad3bIUT7Pvlx
         A3EwLhBTpJQu1bl8T2wZnI2tiZYaqt7QM7/hnJQoA2jeiYBaZqUO9NYpNGkTQEyFFa
         SZe1cHeegOKim++YtymnDcmmBUnLaLq8swuSBDMamDF1CSEfJ/nYCDh+Derr5WDxbr
         Szc953g28TYB0iYUlK0g803KKl+Ly8k2Mwli6kA9K2+gTGpQm0e2kWr2GsJDSeq0kh
         Mc9g6ja4aVVTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20210114144021.1820262-1-jarkko.nikula@linux.intel.com>
References: <20210114144021.1820262-1-jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-P
Message-Id: <161064292109.43781.506297412961786304.b4-ty@kernel.org>
Date:   Thu, 14 Jan 2021 16:48:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Jan 2021 16:40:21 +0200, Jarkko Nikula wrote:
> Add support for LPSS SPI on Intel Alder Lake PCH-P variant.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Alder Lake PCH-P
      commit: a402e397b938fbf7e7977bded44f3db9a659a931

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
