Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372544EE94
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhKLVaY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhKLVaY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C3CB610A5;
        Fri, 12 Nov 2021 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752453;
        bh=Am8xQUVhrZY6N9HRLIaVipelEZ0XaNdb9r7nw3erB3Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZpP1JrunVK5ypshsJM7wImi7IJjfmgcW/ckYmvq0J0pMpy96wfpH9YcACh0AXaA45
         F5ihCal9wOd9XFIhbQI/vDTek13HCxf+hL5VzhcKtpOscPsrcQ3t47J/bXbdS3SnMs
         8VxHfs4bkiWB8dk3T/PRCVvkVONUg+Y+Si2me6EFENabrz1H/dCPEVLj8/tklGfF7t
         /HbOy7z1WjzGo7vdeYXUFA2DseTGjLsaT3v3DRqwj54WsqIGpTd8bCDjwcAEj3cvzk
         6HYe3VNC69EgQ6uypDm1FUQJ1UbQPcPl8JXp7autrce1TeX1u+StPH6guVY/fwWmMs
         MA8C1UFHQLXbw==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20211108145523.1797609-1-alexander.stein@ew.tq-group.com>
References: <20211108145523.1797609-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] spi: lpspi: Silence error message upon deferred probe
Message-Id: <163675245237.742446.12570457338547822169.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Nov 2021 15:55:23 +0100, Alexander Stein wrote:
> Do not print error messages with error code -517. Silences the following
> errors upon on imx8qm:
> fsl_lpspi 5a000000.spi: spi_register_controller error: -517
> fsl_lpspi 5a010000.spi: spi_register_controller error: -517
> fsl_lpspi 5a020000.spi: spi_register_controller error: -517
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: lpspi: Silence error message upon deferred probe
      commit: 12f62a857c83b2efcbf8d9961aacd352bf81ad3d

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
