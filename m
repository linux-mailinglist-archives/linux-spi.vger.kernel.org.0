Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8B1E61BF
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390162AbgE1NIA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 09:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390155AbgE1NH7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 09:07:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B2C207F5;
        Thu, 28 May 2020 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590671278;
        bh=12Epg9vAaXMim+O4FTOBqKFL38ARs1D/yOOcXJzWAv8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LpbVzDS0suyEwE5Ldj7OymOkSAWNP1+PH6eaxY4/2a9iuIXQS+NDXYV2gUEZB0xeJ
         J8gS48kmxqpcE+VoT8xCcAWlZfbyjYgfsr/ARapFFy9s17jMPBNsbmvN4MVqmF3BTU
         O4nojSOkLEjPwroxxysLrnHeqe6Dg5HWqebI/HXg=
Date:   Thu, 28 May 2020 14:07:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200523122909.25247-1-dinghao.liu@zju.edu.cn>
References: <20200523122909.25247-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] [v2] spi: tegra20-slink: Fix runtime PM imbalance on error
Message-Id: <159067126729.55053.1525159932135385920.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 23 May 2020 20:29:09 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: Fix runtime PM imbalance on error
      commit: faedcc17ad183acfa5d74758ebc4f21aef341f11

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
