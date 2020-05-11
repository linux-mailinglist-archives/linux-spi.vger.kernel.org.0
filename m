Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0D1CE194
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgEKRWB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 13:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730966AbgEKRWB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 13:22:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F68720714;
        Mon, 11 May 2020 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589217720;
        bh=6lsmrtwsjS337+6ZaMJ1uBpd2A8KX8OTri/jsmfkVsY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GqwA1+soX8/N+5KPE26D5ForS1gU5fJ9AlJ7l/J7WzCfy2kMAOpE0COf5LJRGwyiw
         GwgBXNebjLjld5GjFImJ9jhBF0UxIkYOJUD6gMhGPOaCrMg3QKcBgBUFciboD3fzA3
         st/Aeh/ip4NQmPaLDrXd2xQT54fLfenVdii2fNSE=
Date:   Mon, 11 May 2020 18:21:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
In-Reply-To: <20200507115550.139457-1-weiyongjun1@huawei.com>
References: <20200507115550.139457-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] spi: spi-amd: Remove spi_master_put in amd_spi_remove()
Message-Id: <158921769453.22432.2365518895564552869.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 May 2020 11:55:50 +0000, Wei Yongjun wrote:
> The call to spi_master_put() in amd_spi_remove() is redundant and
> may causes user after free since the master have been freed by
> spi_unregister_master(), so remove it.

Applied to

   local tree spi/for-5.7

Thanks!

[1/1] spi: spi-amd: Remove spi_master_put in amd_spi_remove()
      (no commit info)

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
