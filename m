Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59511B45DE
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 15:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDVNIR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 09:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVNIQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 09:08:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09BD206EC;
        Wed, 22 Apr 2020 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587560896;
        bh=yl80ZoEsd8qiX3qZ8zET8g2MraOr8WAwLvjaFPPzZvQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OOsA/qGy77hgbf88yL2s8wB9nYCWOIoncSKy+B1DJTFpBSK21aaQJhbuV+HE4+ANh
         xxALgy0NTJz/0Ua0vFmb4wFH4wPKtgXS0CoOa8DugUy7z6TjYIRiDf/uvP1uq5siKO
         14gmjHyK/4KzkDu8Zyz0u0Gd2LM9tpBA0ZiedbE4=
Date:   Wed, 22 Apr 2020 14:08:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>, Han Xu <han.xu@nxp.com>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200422014543.111070-1-weiyongjun1@huawei.com>
References: <20200421093908.48213-1-weiyongjun1@huawei.com> <20200422014543.111070-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next v2] spi: spi-fsl-qspi: Fix return value check of devm_ioremap() in probe
Message-Id: <158756089381.21648.5729614569863821840.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 Apr 2020 01:45:43 +0000, Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: 858e26a515c2 ("spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Acked-by: Han Xu <han.xu@nxp.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-fsl-qspi: Fix return value check of devm_ioremap() in probe
      commit: f58dcab68aa57e74c12c9bec7ff1bb73e0b35143

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
