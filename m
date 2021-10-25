Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F05439BBF
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhJYQlz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 12:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhJYQly (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Oct 2021 12:41:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 593BF60F22;
        Mon, 25 Oct 2021 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179971;
        bh=q5Ez5JbLCqN70dDkrM+9uRXuqcQSXhvfGofg5dM80a4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1MjzAKsas1AXVB0VpkLB7QrBvydyVmgfL/URD1cHj8hFWa3m4nBlb7DKR53jIF1w
         n8QOcOubaB7Ccwg126t8cnNZwN5x4v/85c7/CdbTFzAfsGEhDtPmkzyGB1rj7fXcua
         eo+N9buQo4X8xahPfGStKozm2aY3B+Ujx2hKgrlc54A6kDv+rMhsVcpuQjjtH82Xbw
         CuuN8RGpVfU49VUZFO69lvrt/diM3EwBH8k46Hw/1WPGnsUTyolNwU7gPEWMaZEDW/
         NWf8S4P9ZBmUugGTVv20HL7cMOg1rTGNezg+lgWZi0umcRKRZjLCmr0Pm2wwU0MY8I
         S3iErhawXjaxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <treding@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: tegra20-slink: Put device into suspend on driver removal
Date:   Mon, 25 Oct 2021 17:39:19 +0100
Message-Id: <163517996468.3558223.16284650168566204659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211023225951.14253-1-digetx@gmail.com>
References: <20211023225951.14253-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 24 Oct 2021 01:59:50 +0300, Dmitry Osipenko wrote:
> pm_runtime_disable() cancels all pending power requests, while they
> should be completed for the Tegra SPI driver. Otherwise SPI clock won't
> be disabled ever again because clk refcount will become unbalanced.
> Enforce runtime PM suspension to put device into expected state before
> driver is unbound and device's RPM state is reset by driver's core.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tegra20-slink: Put device into suspend on driver removal
      commit: f4bafa944553f606e0f471fadfb64d84afe70fb0
[2/2] spi: tegra210-quad: Put device into suspend on driver removal
      commit: 186640328685ef09d2c575fb26a243d3ac7963aa

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
