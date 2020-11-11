Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B52AF568
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 16:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKKPs2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 10:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgKKPs1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:48:27 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFC920709;
        Wed, 11 Nov 2020 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109707;
        bh=oI7bvlM+XQDEUeywMg6ebIblQMGk3Om1vOkpZO/GiDc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=M+qgUB2Bl4xyC5wdaUVMnzVJqksnVEgZnqmx89ZpE0juN0msNFTrJz9KQpGABQnBM
         ik+emIG7deoGW32rtRB68Orloi1Jb1z1M8ebd4ixqx/kg6KwrXS5vFPCPZrhwkWnyC
         aw0PFhAvm6axgqgNgeYJax+qfGj48VwfhHjXD5v0=
Date:   Wed, 11 Nov 2020 15:48:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20201106015035.139574-1-zhangqilong3@huawei.com>
References: <20201106015035.139574-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: sprd: fix reference leak in sprd_spi_remove
Message-Id: <160510968064.12304.11059570696073252679.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 09:50:35 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in sprd_spi_remove, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sprd: fix reference leak in sprd_spi_remove
      commit: e4062765bc2a41e025e29dd56bad798505036427

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
