Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA21BE5A3
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2Rwf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 13:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Rwe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 13:52:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06721214AF;
        Wed, 29 Apr 2020 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182754;
        bh=bV5BXMWOppA1Ct35TVp4vONDvDN+O7QcIfgw3X1rATk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kUGN5hkdr9eBoiMGBaa6oiSMq5IACOH2MfpxYubC/sPULEAeacfYtwT6z2CJBmrYr
         V3Nzhxa93eJ4Rmo0aMfJlNhvjmc/heEC0+rRwCTUazSxgZ0s8oebWy6MHuL9xepowx
         izAJ+XgRXJPWRnYmGkXQnAeeMHFe8STIPJ5mFLzg=
Date:   Wed, 29 Apr 2020 18:52:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200429075855.104487-1-weiyongjun1@huawei.com>
References: <20200429075855.104487-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] spi: uniphier: fix error return code in uniphier_spi_probe()
Message-Id: <158818274449.17408.17250948289514421453.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Apr 2020 07:58:55 +0000, Wei Yongjun wrote:
> Fix to return negative error code -EPROBE_DEFER from the DMA probe defer
> error handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/spi/spi-uniphier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: uniphier: fix error return code in uniphier_spi_probe()
      commit: 18168291aa7dd48e9d9e3cbb1d4cd06e899357ca

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
