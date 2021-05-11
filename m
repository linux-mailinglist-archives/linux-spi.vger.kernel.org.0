Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61037A1BA
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhEKI1z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhEKI1v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:27:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A1561107;
        Tue, 11 May 2021 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721605;
        bh=bYIaUAprXVrQfA7WorJjuNskjH3tHeoOdXcsy6zWmqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mdi7DjVpvXPwq3QIlmFS4cQAhgrT1tsoPhmW/v1oaFswrqaVBoZb29Iv6+KgWq/X0
         RswE5cniiDVxehNo0YPebeIqJ0nI5zirtUbNDV4xM41Y/XfsiGxlY/v+29oFcg+vfB
         NlO/snxA05F7bZeIRF7ArOp87G9vey6+iepUnmBb2KFzRuwULDyXyfzfJGSqE9aWcI
         i5YPGqLUycafEUBajh5wuna+e24HWCCvX+lw4hPeslQkhtdIa0ogIjd56fsKH4J6Fa
         PEmyqFhOV1Yt1X5nnQ0S8zDBuB0Q4fqd4z/xjbaLhpB/C6mM7Tz8dvyWvYjcCBsCuu
         zuYblQWVBuqUw==
From:   Mark Brown <broonie@kernel.org>
To:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jonathanh@nvidia.com, ldewangan@nvidia.com
Cc:     Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: tegra210-quad: Fix an error message
Date:   Tue, 11 May 2021 09:25:30 +0100
Message-Id: <162072071981.33404.5625114795994944628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b990c1bb5830196142c3d70e3e3c6c0245a7e75f.1620404705.git.christophe.jaillet@wanadoo.fr>
References: <b990c1bb5830196142c3d70e3e3c6c0245a7e75f.1620404705.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 7 May 2021 18:26:39 +0200, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> No error code is available, so just remove it from the error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Fix an error message
      commit: 665a990fdbea66a4d2af0287420f8266631be2ab

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
