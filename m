Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF14058A1
	for <lists+linux-spi@lfdr.de>; Thu,  9 Sep 2021 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351810AbhIIOJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Sep 2021 10:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344135AbhIIOJa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Sep 2021 10:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB87C610CE;
        Thu,  9 Sep 2021 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631196501;
        bh=BsTmdX5bO+FmxT3XZKgWd5tSrIJfiR3FHnshKEPMjMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cs8Ak0xUucXNGp1hLxMoq9eFtjJaqxiPE1CGY4rxPctngW8jvHcnHP89kswLZVOqU
         SfR1h1d5vrE6pLtInQBQZ2zycrpdVeWDiikRL6r8iWl8onoY81FMpSbv/oLUVuashE
         U1FAJ2bPTp1YzNzKuIjFwCh7xbCteH+iat8OMdI53VBYYh7obxWFWdjiJGA6By/YOa
         B8FFTO20k4qD0Ql5KcW0+Em1Pqjk2j+l9IbtntBDhJe4Pnj4APYAk7kFKKZ5LJNdWq
         3smunlQE+d4vb9g4QQEuFcTH2hfa9Lg7BaZE4fPiAbGgBg3x2Le6MFU1FRnGKxvs7R
         y38WTWoQzwqzw==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: Declare runtime suspend and resume functions conditionally
Date:   Thu,  9 Sep 2021 15:07:44 +0100
Message-Id: <163119634904.38811.4267330416570346420.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907045358.2138282-1-linux@roeck-us.net>
References: <20210907045358.2138282-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 6 Sep 2021 21:53:58 -0700, Guenter Roeck wrote:
> The following build error is seen with CONFIG_PM=n.
> 
> drivers/spi/spi-tegra20-slink.c:1188:12: error:
> 	'tegra_slink_runtime_suspend' defined but not used
> drivers/spi/spi-tegra20-slink.c:1200:12: error:
> 	'tegra_slink_runtime_resume' defined but not used
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: Declare runtime suspend and resume functions conditionally
      commit: 2bab94090b01bc593d8bc25f68df41f198721173

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
