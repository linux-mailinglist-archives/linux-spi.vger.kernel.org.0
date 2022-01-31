Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B424A4C4E
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380551AbiAaQjw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:39:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40480 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380554AbiAaQjw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:39:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE8FB82BB4
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 16:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40358C340E8;
        Mon, 31 Jan 2022 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647189;
        bh=1xJEbi30Ukeux1T6FAfLGdKDwClkF84hs+NtUMFIjVs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W2v6G425ryq9R0mmbk+ZYBQLZXWQDulnErL1BDWHem52sPxgNUL5gyiYTftLKZBX6
         O1hNbWpYxISNlrwP6H/U84aOWdNFOj4Es5MkOC/+FlpeR0rZjnEkHDCmgQLsR3lngd
         m9bfea9AcXCIIRZcj6uZuvaYFxGtPhS3ZLi/b2wXeneQu1RjdFC5isdSze+UXJARjk
         vO7r5YIRS5mIPuCxngrtmvXwQY0lDHiM/RI4FndEEdxMXYJwrelfo4jQDF5edg00cM
         xG+h2bQt1Qsbdyw/d4fSJCuHMm7ZPy8i816ErxvIaOedmfPg2A8wocwB+J171D/8Bv
         ElY4UMCnAFJJw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Leilk Liu <leilk.liu@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Hess <peter.hess@ph-home.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
In-Reply-To: <20220122003302.374304-1-linus.walleij@linaro.org>
References: <20220122003302.374304-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: mt65xx: Convert to GPIO descriptors
Message-Id: <164364718798.1030816.16239221191821606717.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 16:39:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 Jan 2022 01:33:02 +0100, Linus Walleij wrote:
> The MT65xx driver was already relying on the core to get some
> GPIO line numbers so it can be (hopefully) trivially converted
> to use descriptors instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: Convert to GPIO descriptors
      commit: 1a5a87d541b442293dfcc2253b652bc7b7e02d09

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
