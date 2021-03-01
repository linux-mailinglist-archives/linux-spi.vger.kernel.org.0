Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D732A5D6
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhCBNRD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346232AbhCAXjr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 18:39:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 097E16024A;
        Mon,  1 Mar 2021 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641938;
        bh=G/BB5DHTa84dJpLDhMzDsAYuA5hNrVLVMURNMKpd+Pk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sONeWh1NnT94fWQhp8bgcwDjmmWJIZy5Z7p7UXMqfA3/uARfY/hPZ8QBdVR7fRQHJ
         x/9SEkDQrfRs47dxT9J2oHTtmr/EBzA9obkLFGdB4C9hc9vyrsh1PHjTDHnlU6NYoe
         +aMCfitNMPNDbdNDWaDSOREGoRAMLWF6MYOoN0T1Imz9sK+vrT7t7beTeu3kqaEjAX
         Ls1YvyeMUEwcrtfHZ/uXXqmOoHpMm4h+mGXgV5+rxu+KXWbsQv4ibhdWzvfALCToza
         zrfjkopefUDwmto9KEZxQTspkxnzMLX74xSnveuL9aN/EXUhIr73wC7pWerCC72h+g
         5+6WBaoDHVZ5Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20210222023243.491432-1-alexander.sverdlin@gmail.com>
References: <20210222023243.491432-1-alexander.sverdlin@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Activate pinctrl idle state during runtime suspend
Message-Id: <161464187231.31555.1398673115827346364.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Feb 2021 03:32:43 +0100, Alexander Sverdlin wrote:
> Set the (optional) idle pinctrl state during runtime suspend. This is the
> same schema used in PL022 driver and can help with HW designs sharing
> the SPI lines for different purposes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Activate pinctrl idle state during runtime suspend
      commit: 9923f8e3039ed0361c2476d5d3c5195c7f766504

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
