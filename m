Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D42AC561
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbgKITsc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbgKITsb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:31 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A25206A4;
        Mon,  9 Nov 2020 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951311;
        bh=R1pa8cJw7JcGhBO9Lu1hhtuvpBT7E8wNl+dQAA3UyVg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LM3vothQy70CrcKw4Ahxr01ujS/kjn7UHap7MWUsS+sivQCOTcXcHm3R9t3I4Z5Sw
         b7wmiwGCh4/cNR6In20ffP+sdfnPysriZR2IYNDmv/IHublqjEkYP0ztdWhNg+Dq1e
         bVUDiEG12JyjGr9MvXXmP/lJwUE3J++HGQIA8eVQ=
Date:   Mon, 09 Nov 2020 19:48:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org
In-Reply-To: <20201103141345.6188-1-zhangqilong3@huawei.com>
References: <20201103141345.6188-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: tegra20-slink: fix reference leak in slink ops of tegra20
Message-Id: <160495129750.49337.7912431338508137838.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:13:45 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in two callers(tegra_slink_setup and
> tegra_slink_resume), so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: fix reference leak in slink ops of tegra20
      commit: 763eab7074f6e71babd85d796156f05a675f9510

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
