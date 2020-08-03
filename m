Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5323A9EC
	for <lists+linux-spi@lfdr.de>; Mon,  3 Aug 2020 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHCPx3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Aug 2020 11:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHCPx3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995EC207FB;
        Mon,  3 Aug 2020 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596470008;
        bh=JABhoVBSZpIh4BV5/VjfrZb0SNvOA2zWIR1+c++uwWI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=X5MS31zDGgxIQ0QWVtqgkg6n3d4SEKFKT7kpwWJisX6E6x+MqkqGjSVb6Mj1kKV9Q
         vCDE5NckzKPul2Ud131Hw+/c2ocEnpNnUctPoU6tAOQUup2f5pKeBelFhKhM5gXpnx
         6xvcp91mL28p62fYcPlju+cNNXY61njbth/lQ9nc=
Date:   Mon, 03 Aug 2020 16:53:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Octavian Purdila <octavian.purdila@intel.com>
In-Reply-To: <a8c3205088a969dc8410eec1eba9aface60f36af.1596451035.git.lukas@wunner.de>
References: <a8c3205088a969dc8410eec1eba9aface60f36af.1596451035.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: Prevent adding devices below an unregistering controller
Message-Id: <159646998788.2734.17638663314582550308.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 3 Aug 2020 13:09:01 +0200, Lukas Wunner wrote:
> CONFIG_OF_DYNAMIC and CONFIG_ACPI allow adding SPI devices at runtime
> using a DeviceTree overlay or DSDT patch.  CONFIG_SPI_SLAVE allows the
> same via sysfs.
> 
> But there are no precautions to prevent adding a device below a
> controller that's being removed.  Such a device is unusable and may not
> even be able to unbind cleanly as it becomes inaccessible once the
> controller has been torn down.  E.g. it is then impossible to quiesce
> the device's interrupt.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Prevent adding devices below an unregistering controller
      commit: ddf75be47ca748f8b12d28ac64d624354fddf189

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
