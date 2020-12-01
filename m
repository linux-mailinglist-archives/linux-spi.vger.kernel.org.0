Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F306E2CA4C2
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbgLAN7x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 08:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403857AbgLAN7x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:53 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9FCE2173E;
        Tue,  1 Dec 2020 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831146;
        bh=4O6jrK+W5Po12wYUSSzX2/tS7T66ir4w2NAyU6znoiE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=xl7VRIN7WM5n4XRPkuy1iwnfPDlafzN2hOzveA5KjI8haiFtEY7TWGPExvhgPqPuJ
         XrElc21LjjUTlsUiUx75NAQMZX74g/4NjEcv/uwMzN4WPVd39uVltCgCcVVurP/RdH
         tDSgUgnxeUJIFJ2o+D0TTRBZDLNiTMJcwD6YBihg=
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20200928085500.28254-1-michael@walle.cc>
References: <20200928085500.28254-1-michael@walle.cc>
Subject: Re: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
Message-Id: <160683107674.35139.13937083243515034859.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Sep 2020 10:55:00 +0200, Michael Walle wrote:
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
> path") this driver causes a kernel oops:
> 
> [    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> [..]
> [    2.056973] Call trace:
> [    2.059425]  dspi_setup+0xc8/0x2e0
> [    2.062837]  spi_setup+0xcc/0x248
> [    2.066160]  spi_add_device+0xb4/0x198
> [    2.069918]  of_register_spi_device+0x250/0x370
> [    2.074462]  spi_register_controller+0x4f4/0x770
> [    2.079094]  dspi_probe+0x5bc/0x7b0
> [    2.082594]  platform_drv_probe+0x5c/0xb0
> [    2.086615]  really_probe+0xec/0x3c0
> [    2.090200]  driver_probe_device+0x60/0xc0
> [    2.094308]  device_driver_attach+0x7c/0x88
> [    2.098503]  __driver_attach+0x60/0xe8
> [    2.102263]  bus_for_each_dev+0x7c/0xd0
> [    2.106109]  driver_attach+0x2c/0x38
> [    2.109692]  bus_add_driver+0x194/0x1f8
> [    2.113538]  driver_register+0x6c/0x128
> [    2.117385]  __platform_driver_register+0x50/0x60
> [    2.122105]  fsl_dspi_driver_init+0x24/0x30
> [    2.126302]  do_one_initcall+0x54/0x2d0
> [    2.130149]  kernel_init_freeable+0x1ec/0x258
> [    2.134520]  kernel_init+0x1c/0x120
> [    2.138018]  ret_from_fork+0x10/0x34
> [    2.141606] Code: 97e0b11d aa0003f3 b4000680 f94006e0 (f9404000)
> [    2.147723] ---[ end trace 26cf63e6cbba33a8 ]---
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: fsl-dspi: fix NULL pointer dereference
      (no commit info)

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
