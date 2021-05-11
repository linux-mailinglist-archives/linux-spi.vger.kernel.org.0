Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6B37A1BD
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEKI17 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhEKI1y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:27:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E5E613C3;
        Tue, 11 May 2021 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721608;
        bh=8Txu08zUYVsrHITXx85x6pPmUEO9u+1xaOxDBIw9gGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XK1ZH7nHQwcSS1LiSspQ/saHPYhvr78b1zFjgiq7SmT03lOonU/eds0Z4E7VOsmLC
         /WmO04Jhocl5YYt8iwWVmJj4eFXmB6T1SM0Z7u4Msd2hwKjRKVcvnA3vhKk402DETD
         /jLXajewIESKcqtBCBUKceUTHFxg8EQoJPVU3+c+GZR+KvdKSERsrBFVGaLNdcJDoi
         6PQUXOXwemx8D/nQF18SXt42rtJmvttJnzSp6Da4yKJTC2ESmy5FOXpoPn/S/eFi6K
         53x+sS7/qFChnpPpcKCrhvf3yRqfF9qujqAlDhCjLsGGDnTAjPQVOVqNEneZWFrfM3
         RQ9nlwEcjLYAg==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        maitysanchayan@gmail.com, olteanv@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fix a resource leak in an error handling path
Date:   Tue, 11 May 2021 09:25:31 +0100
Message-Id: <162072071982.33404.3585996084879367200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d51caaac747277a1099ba8dea07acd85435b857e.1620587472.git.christophe.jaillet@wanadoo.fr>
References: <d51caaac747277a1099ba8dea07acd85435b857e.1620587472.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 9 May 2021 21:12:27 +0200, Christophe JAILLET wrote:
> 'dspi_request_dma()' should be undone by a 'dspi_release_dma()' call in the
> error handling path of the probe function, as already done in the remove
> function

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: Fix a resource leak in an error handling path
      commit: 680ec0549a055eb464dce6ffb4bfb736ef87236e

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
