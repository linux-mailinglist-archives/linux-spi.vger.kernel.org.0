Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707662AC568
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgKITs6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbgKITs6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:58 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729CF206A4;
        Mon,  9 Nov 2020 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951338;
        bh=TgS5hL+bSyLNUcmEn3P8SGT7omjElDp+PuvdKWglKLI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=onGJW3yULI6L5kKdRJquxeSiFG8BRCdb1ECxGiX4gljlWJEWYrh7kL8gki0kusAHL
         KabpEifzgRhFN3Zvw09A/iYTp8Asn8ClRwLjNfqcAxkM8GRzwuLrdyWvy6q+JZEtW0
         E8wJiS0IheuJKjcoOjUFQ5vfgb/faIUA0gMVbUGM=
Date:   Mon, 09 Nov 2020 19:48:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-spi@vger.kernel.org
In-Reply-To: <20201103141323.5841-1-zhangqilong3@huawei.com>
References: <20201103141323.5841-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: tegra20-sflash: fix reference leak in tegra_sflash_resume
Message-Id: <160495129749.49337.10378655904235948124.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:13:23 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in tegra_sflash_resume, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-sflash: fix reference leak in tegra_sflash_resume
      commit: 3482e797ab688da6703fe18d8bad52f94199f4f2

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
