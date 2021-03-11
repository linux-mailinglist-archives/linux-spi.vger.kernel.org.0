Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F1337918
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhCKQT4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 11:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234258AbhCKQTh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 11:19:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5B3464F9C;
        Thu, 11 Mar 2021 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479577;
        bh=KggN/HW1a2vQ4SGzBJ8jnbNIsyStFoH/eHKz0JbOLp0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=apC8y9l5v895SynA/Ffe/RDrJU1QoCvrprizy9Hn7ygInav5RW+W0QScg+S6ip4bm
         nAoYHYNfqZ8cHNbUfDK8y3dzBeHOzf8hfOU1WC/WoxudhfaK5N/Adr0XPUpjehq5Md
         a71Y4D2tiRiY74h/+4Psezt4fwW0gClPJ69hJ8ToqX8/2SyORXvCnSbrZh3AO9Xknd
         iSwrBbbJD3BfqTpwLV35X+uMALe7uu6reNwRiMNShe3OMQ0iZaLhMfx8nqeYk1xb0G
         k9IGwhSd6B9yegQpvOXdgXTNZtc8Dp+JQrZrr9O/4/Ds5zYZDjSeVHET5ArKl8oPB0
         YTmXyLoc9rMwA==
From:   Mark Brown <broonie@kernel.org>
To:     Meng.Li@windriver.com, linux-kernel@vger.kernel.org
Cc:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-spi@vger.kernel.org, meng.li@windriver.com, vigneshr@ti.com,
        tudor.ambarus@microchip.com
In-Reply-To: <20210311091220.3615-1-Meng.Li@windriver.com>
References: <20210311091220.3615-1-Meng.Li@windriver.com>
Subject: Re: [PATCH] drivers: spi: cadence: set cqspi to the driver_data field of struct device
Message-Id: <161547949200.51229.6800375335632446420.b4-ty@kernel.org>
Date:   Thu, 11 Mar 2021 16:18:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Mar 2021 17:12:20 +0800, Meng.Li@windriver.com wrote:
> When initialize cadence qspi controller, it is need to set cqspi
> to the driver_data field of struct device, because it will be
> used in function cqspi_remove/suspend/resume(). Otherwise, there
> will be a crash trace as below when invoking these finctions.
> Call trace:
>  cqspi_suspend+0x14/0x44
>  dpm_run_callback+0x50/0x1c0
>  __device_suspend+0x114/0x514
>  ......
>  el0_svc+0x20/0x30
>  el0_sync_handler+0x1a4/0x1b0
>  el0_sync+0x174/0x180

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] drivers: spi: cadence: set cqspi to the driver_data field of struct device
      commit: ea94191e584b146878f0b7fd4b767500d7aae870

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
