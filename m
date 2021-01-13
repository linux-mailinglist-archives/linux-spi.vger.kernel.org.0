Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB22F4EB7
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbhAMP3p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbhAMP3o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:29:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F54F233EA;
        Wed, 13 Jan 2021 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551744;
        bh=bWsINNChrgBVID6nsVHR+SPM6eCH/SYMN0yzKSvyWLI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XMP2/xx8ExtxJfyOqTZWgN0c/YBvqPnFh8VaLHcBswHGtFWbgsfN9YKpB0TMerCPJ
         yZPW+qv5gJ/qfncbHsAQF/GFt7RVJfeQcEDveTY3ijkQvRuzkNktbhUZBIN20nTlFF
         gQi3LJbBcBuK3+6tckwmyRd2NGuLS7rqIcUE8tS1412Or/Q6oXaHbFmfn5YZA+PrUA
         oBhZuSnErzsjj1IKDV3NJUVn9/y8Ju1SI0U6gUbaCyCCBNAzqCm/rmePtfkfF7bDQg
         T/h0UOeT7daQN8SuwBrygx1o8UiK58yhPOZQMbSxVjA5JybE/zIG6Tg4EYZMmM6EQG
         d9xq+l1SD+iZw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Alain Volmat <alain.volmat@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Roman Guskov <rguskov@dh-electronics.com>
In-Reply-To: <20210104123114.261596-1-marex@denx.de>
References: <20210104123114.261596-1-marex@denx.de>
Subject: Re: [PATCH] spi: stm32: Simplify stm32h7_spi_prepare_fthlv()
Message-Id: <161055171029.21847.15772313801435250449.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Jan 2021 13:31:14 +0100, Marek Vasut wrote:
> Simplify stm32h7_spi_prepare_fthlv() function implementation,
> no functional change intended.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Simplify stm32h7_spi_prepare_fthlv()
      commit: 970e8eaa08195a26ba99ec0843968cbc7ad8e947

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
