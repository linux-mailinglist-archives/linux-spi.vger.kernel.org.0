Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22144EE95
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKLVa0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235768AbhKLVaZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83F8960F51;
        Fri, 12 Nov 2021 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752454;
        bh=Ecwkgb9e14C6Kune5wLkv+S7iKP60oFn4zyvFneEyQ0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O9WlAVYFLSiIb7njnNns+4Doo7GH3SvUfdVdtp19eck61kYCDRwtcqkAPg3hiQKmC
         paa4cvvK9WdEnUkqd6FXe7T5TIvH4zKwKZVwdB8evaElSrJCubjKODE6iysQcofR32
         ARRMJrAqoeRSThUaosXN8hDLGwuerEp43m+KZU6XEuv2ch6xh6xOyb4GC7wQsSO5/f
         h+km3TPyGESimpViSN9XbNHqCfOqOFVXq5yOV6Hk2EJz/fx7SZPuyKBKxY24mmzs31
         oi8tx9rZ1SflG3fE+sCfVJoKnQ38yOA0LqHP/X5+R3Thd7HxaEajAU4SHDhd9rSbd3
         /y64BJvXcAksw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20211110073935.GA5176@kili>
References: <20211110073935.GA5176@kili>
Subject: Re: [PATCH] spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()
Message-Id: <163675245327.742446.568186014319841579.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 10 Nov 2021 10:39:35 +0300, Dan Carpenter wrote:
> This code has several issues:
> 1) It passes IS_ERR() to dev_err_probe() instead of PTR_ERR().
> 2) It always prints an error message, even when it succeeds.
> 3) The "if (ret < 0) {" conditions are never true.
> 4) If requesting "mas->tx" fails then it sets "mas->rx" to NULL but the
>    intention was to set "mas->tx" to NULL.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()
      commit: 6532582c353f4c83e3ccdd7255020ab852b90b0b

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
