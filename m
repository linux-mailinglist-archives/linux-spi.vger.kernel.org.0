Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75691BE5A1
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2Rw3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 13:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rw2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 13:52:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95734214AF;
        Wed, 29 Apr 2020 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182748;
        bh=8wxMjUSJvDUhsCN6WjjH3pm6MbKdMIrwrboUrFkVs1w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yzXsZ0C17wj1a8BJzoT2T2sSR2Dw96jjlrTNqMECECzceQ9fxWxUWKQ9E84aWx1p8
         z5l1NJ2735SgQ/pfQjqG/V5/9/FJkz3Hz2JuX9W+T3Gs4IPN0tLIVTnGH6Mo+q3JnO
         MBVNNGORiF6ib7BNhEBIu3cIMPV3eHH/wQGQtldY=
Date:   Wed, 29 Apr 2020 18:52:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200429025426.167664-1-weiyongjun1@huawei.com>
References: <20200429025426.167664-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] spi: spi-amd: Fix a NULL vs IS_ERR() check in amd_spi_probe()
Message-Id: <158818274449.17408.17312221145865344653.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Apr 2020 02:54:26 +0000, Wei Yongjun wrote:
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-amd: Fix a NULL vs IS_ERR() check in amd_spi_probe()
      commit: f84b604dbaf242d17135f527dbe81093a41226b3

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
