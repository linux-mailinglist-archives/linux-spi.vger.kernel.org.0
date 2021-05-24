Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE738E5FC
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhEXMBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 08:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhEXMBb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 08:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0923B61289;
        Mon, 24 May 2021 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857603;
        bh=PugRtYLJNoVJuEvwoeKNQow3dG8JFwjBLVMYbwXXycE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crlAaypzhHUg2TwEU3g/0fBNcKX8Af851Aw1gxuZRty8raNgJGaOWXdIX0CCmMRv0
         0PfjndO7Pyp6BEzSTfDhl+xGcINi6HFSaLxuVJZkvAfGgxhW3lwLfBGmnTZf5M73aR
         tOQjQm3FzeUueC6ZuIvbIiwBRn0FIjqpb7rBOotXim1cMeUprww0u2RUhepswhNQEE
         Xm3ShP+tX79UmncgWvEzaa7h8Q/935mycwm+P5IIu6/9Ej6j31ISZDGX6mCJ0Lb3Jb
         XkuvJF9OrG27uZK5I6iChDCScnN1xALI0hQYeSk+Ue/yrsVVv6dTh1JNJLMg1Bqh59
         8DkNOZxgVp8hg==
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH] spi: bcm2835: Fix out-of-bounds access with more than 4 slaves
Date:   Mon, 24 May 2021 12:59:47 +0100
Message-Id: <162185759496.49562.15428024536374749432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <75854affc1923309fde05e47494263bde73e5592.1621703210.git.lukas@wunner.de>
References: <75854affc1923309fde05e47494263bde73e5592.1621703210.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 May 2021 19:49:50 +0200, Lukas Wunner wrote:
> Commit 571e31fa60b3 ("spi: bcm2835: Cache CS register value for
> ->prepare_message()") limited the number of slaves to 3 at compile-time.
> The limitation was necessitated by a statically-sized array prepare_cs[]
> in the driver private data which contains a per-slave register value.
> 
> The commit sought to enforce the limitation at run-time by setting the
> controller's num_chipselect to 3:  Slaves with a higher chipselect are
> rejected by spi_add_device().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Fix out-of-bounds access with more than 4 slaves
      commit: 13817d466eb8713a1ffd254f537402f091d48444

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
