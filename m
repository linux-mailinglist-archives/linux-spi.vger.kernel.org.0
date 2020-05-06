Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DD1C7365
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgEFOzY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 10:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgEFOzY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 10:55:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8A2208D5;
        Wed,  6 May 2020 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588776924;
        bh=isIdZF9p24otwVPsTZCE2r3D2THbHvuIvaL0GltlSnQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YR210sp9BEQh2sFZzNof2wGB/EXSQkTrVmU28B3+Si1/YT0FJlCS26SvhMZ/pda39
         M9OYQ+cLita8hrLJxvEYsiNRX3ey/qv6fK+g5vHlNY1M3jxZctOiFU7Yy64fcqxbM3
         +4KcobyLVRN3GRlXArVrQWMwUj1ttMdHUCVmICsY=
Date:   Wed, 06 May 2020 15:55:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20200506061911.19923-1-yanaijie@huawei.com>
References: <20200506061911.19923-1-yanaijie@huawei.com>
Subject: Re: [PATCH] spi: a3700: make a3700_spi_init() return void
Message-Id: <158877692139.14713.2399115526239890758.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 6 May 2020 14:19:11 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/spi/spi-armada-3700.c:283:8-11: Unneeded variable: "ret". Return
> "0" on line 315
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: a3700: make a3700_spi_init() return void
      commit: 5b684514af9052fdbaa60895620f75928a134196

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
