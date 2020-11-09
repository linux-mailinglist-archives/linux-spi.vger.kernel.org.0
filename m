Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE702AC566
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKITsr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbgKITsr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:47 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B3B206E3;
        Mon,  9 Nov 2020 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951327;
        bh=74yArqU64WXgTZooOt7W5S+7l8oMwPzAv6a0vYpjX+M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LM0jO4fhl5Q97FncTS6yNI/vM/rKFmE2iMIeX3JQgkA5JRTvg81xR6vtb2ihf03fR
         KZS6a8hwJSrP6o9H9IFxSrndVk/jkwgtD5z46cKbhcOLyqxdpKat6r6DMRdLKb4yXy
         lYouWPBnwv/y0woEnKhrwnUVXukjtRw9BrNUh+rg=
Date:   Mon, 09 Nov 2020 19:48:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, thierry.reding@gmail.com
In-Reply-To: <20201103141306.5607-1-zhangqilong3@huawei.com>
References: <20201103141306.5607-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: tegra114: fix reference leak in tegra spi ops
Message-Id: <160495129749.49337.18177880530956246346.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:13:06 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in two callers(tegra_spi_setup and
> tegra_spi_resume), so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: fix reference leak in tegra spi ops
      commit: a042184c7fb99961ea083d4ec192614bec671969

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
