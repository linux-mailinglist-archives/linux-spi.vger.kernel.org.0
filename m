Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134603E4614
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhHINGs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 09:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhHINGs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 09:06:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BDA161004;
        Mon,  9 Aug 2021 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514388;
        bh=Iq+gT7aGbB5jwY5mIoHM84WkEfnTWJ0Yz9CFdGjS3LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j90/GNuhpO/S45HPQO5n+SrZ76G1v5D2A87vUXMDapxRzr0V+aMWqln0KfTIuo/zQ
         KbT3LgsatHRJSHwkF19znprb6a47Ef5K7lMaLT7ddWXKOVZEF7vWClrLPOLZcy3Hxt
         IqgJ3GVfWmSXmKNTvfJMZ4qNF1a3wALvNzy4O4yCa+0vW6LThSZWok09ZI25Ciu6lA
         G3/uYm2/XOXBrt7339peaSQhLatuwCJA5m1jJakCxKhgnqFycGzww8hBQf6PMnEFKE
         ETWdbyNscFuDCRyFqDo3CksWBQ3MxLU/6fKZsRbLIcQpuEPzEAhq9dKI5OI7vmpqDG
         qd3GEXnR+kC0A==
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: tegra20-slink: Improve runtime PM usage
Date:   Mon,  9 Aug 2021 14:06:04 +0100
Message-Id: <162851432638.51983.14201816544596196314.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210731192731.5869-1-digetx@gmail.com>
References: <20210731192731.5869-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 31 Jul 2021 22:27:30 +0300, Dmitry Osipenko wrote:
> The Tegra SPI driver supports runtime PM, which controls the clock
> enable state, but the clk is also enabled separately from the RPM
> at the driver probe time, and thus, stays always on. Fix it.
> 
> Runtime PM now is always available on Tegra, hence there is no need to
> check the RPM presence in the driver anymore. Remove these checks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tegra20-slink: Improve runtime PM usage
      commit: e4bb903fda0e9bbafa1338dcd2ee5e4d3ccc50da
[2/2] spi: tegra20-slink: Don't use resource-managed spi_register helper
      commit: 26c863418221344b1cfb8e6c11116b2b81144281

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
