Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C172EAFB0
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAEQJS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 11:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAEQJS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 11:09:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A2A22C9D;
        Tue,  5 Jan 2021 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609862917;
        bh=KwT1+5zC90PlzAWP3moOhsVfP6sC0zSJnqQqeJ1t2UU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V8QxB0Ygce0FRhe8lBT6lu4aRQqN29jrSbVjJixUwP18dhPsUy1XGoZZOYwcvtnCj
         frcydS4OiBW3i4CPFfUmg0WS0A3Y9ramsXwUaGQ/MHaNBXwcI6DmiCwQVbbyxAWk55
         NzWJToemhFlV9uiMCZFqbln56gH/VhFofjPIh8e93LBA1KYKnvHvUM7EbAuuW9R5yC
         +cLCOcY7rwiN5HLkx6CSooPPSOW9CG/UHvdgGjbfyCvVud7U/PtvEPUSviuSGBVJhn
         TwVHBSgx6dvygGGl15+5S4eNY0JyzYBsbkoQjQ8OC++TxRDwl+GjAlKc+0TBwVvYdz
         6KKLfpDbgNG5w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     andy.shevchenko@gmail.com, sfr@canb.auug.org.au
In-Reply-To: <20210104143103.56510-1-alexandru.ardelean@analog.com>
References: <20210104085923.53705-1-alexandru.ardelean@analog.com> <20210104143103.56510-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] spi: stm32: update dev_dbg() print format for SPI params
Message-Id: <160986289006.50207.10241683421352392982.b4-ty@kernel.org>
Date:   Tue, 05 Jan 2021 16:08:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Jan 2021 16:31:03 +0200, Alexandru Ardelean wrote:
> With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
> type of the macros are enforced to 'unsigned long int' via the _BITUL()
> macro.
> 
> This causes some -Wformat warnings in the spi-stm32 driver.
> This patch adds a double-negation operator to the bit-masks. Essentially,
> the important values for debugging are 0 or 1, while masking them directly
> would show 0 or BIT(x) values.
> This way, the type of the arguments are automatically re-cast.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: update dev_dbg() print format for SPI params
      commit: 8b835da61774d4482864bc081dfb428104842ad3

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
