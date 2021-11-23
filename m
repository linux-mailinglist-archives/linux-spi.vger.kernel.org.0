Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BC845A967
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 17:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhKWRA7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236377AbhKWRA6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:00:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93F9C60F9B;
        Tue, 23 Nov 2021 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637686669;
        bh=IU/wLx+M6k0m/XPOQix1mz1gNY2YVAwPH01ZGzG35Is=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CPyDYDXGMZoxaQ8IIUIR+HjMb0EUFSWwbSMWolzQJ/Vzgg3Zo+VjfYGngDGE3qGu+
         xNX7MtNsswApXwnnVq13V4b6Un8pOPQdMOElsMwLNLXLNARMEPFGEM6SHoj5OGQX+K
         SIXyhbWCQsaa3fPqw+P7WI72+q82oUrsrRpNmwUFsMo41qWLe207YG8OEOqWjtymlr
         L6S7abwbihMbCUgCDmxPavCYNO1hlcKUJ8faqq8xsPk316GzY3HSHPdvfg3P9OLPhI
         2taRKgyU3LSOaZyyQgMRH2gmcH6BBxUm44GOdLiyU3mmzRBWsufcYDyKwLFe6pvoop
         xx6T4ipcvtg7w==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
In-Reply-To: <20211122200622.43305-1-andriy.shevchenko@linux.intel.com>
References: <20211122200622.43305-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Remove redundant ->read() and ->write() in struct chip_data
Message-Id: <163768666834.1388476.6693782453089642459.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 16:57:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Nov 2021 22:06:22 +0200, Andy Shevchenko wrote:
> Since the commit 196b0e2cf237 ("spi: pxa2xx: Remove if statement
> that is always true in pump_transfers()") the ->read() and ->write()
> methods in the struct driver_data are reconfigured for each transfer.
> Hence no need to keep the intermediate state in the struct chip_data.
> 
> The same applies to n_bytes member of the same data structure.
> Get rid of unneeded storage for good.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Remove redundant ->read() and ->write() in struct chip_data
      commit: 44ec41b7f7831f91c79a06de5e45f2d7ce6e4fbd

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
