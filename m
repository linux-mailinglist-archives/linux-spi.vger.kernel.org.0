Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC142CA81
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbhJMUCE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 16:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJMUCD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A46611CB;
        Wed, 13 Oct 2021 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155200;
        bh=6Hj2eq97BsNNooolzlk+mY7C6SePzVG3vta8/MmHnsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oD43fy94RenROW6C1AdKw2ivCRXcc7ChE0rsS6VQROgadsZz67fR0M4gXsWxuIKFC
         1o7vwbE7EvjMLzQjqxxR8Cw2xxHeJNL6gTY0hhOW5wgPvw8eT9zYX6w8ThoNkQVOWr
         eZTMqcpZj3nbSoTNGvt62elRm1GdVvPsKGWwTs/irwXfxQYK63bTp/zAdahb/gLeUv
         33YZWRHahVvKnvSZhOrCCEoqldy6L4ijpfeB03j+h3ruf19Hn0fORgJo46EmijUxUe
         1qBEVXxWuoxcWgG9fzVDtTau5It31/n3/rbOe4D+oKtT3F5FHktzvLcMMSpOdKs/nk
         tTx4XuQvDLqAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
Date:   Wed, 13 Oct 2021 20:59:46 +0100
Message-Id: <163415517425.1358430.17611745343501937698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013144538.2346533-1-arnd@kernel.org>
References: <20211013144538.2346533-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Oct 2021 16:45:23 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is another one of these warnings:
> 
> drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
>  1197 | static int tegra_slink_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
      commit: 7dc9b9562740d858332894447c9779b146559239

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
