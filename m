Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41C73CBBE1
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGPSeb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 14:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhGPSe3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 14:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 362B4613EE;
        Fri, 16 Jul 2021 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626460294;
        bh=ub2x6wlhuTK6D3r3/YbLRI32086jnWnfond4dVYaPLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptnJ0WnOcuasYt9tAQrPgglhARHMCVqW14ATko70BLtT6Qvq4WMgqHvdic+rwXxsc
         IwP3hNIpESpljw8pwY13v6UPI98q4DTHUfyKlGt/a60qWM09jjQMrTDxJK/hn9ZsVb
         kZH0HaRuLCN6i8mpL8qrRjamer6nnNAyd7BuCW2SBvSYswyCLUqj7KeuW9W6Cu4oqi
         Ixp1hC2s8iX0Mk/PTwYn7otViHkVgSTTMJqdB0f3Ao8XUzDkv8rBC/jP3YeD1nRkmM
         7Tn8Z327evJ0Xpgy+VXusqThWXE1SelJJ+slumZF3lib3LkjPFUTvu9xts/qF+tAQU
         VaCjXSMDbJSnA==
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: (subset) [PATCH 0/2] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations
Date:   Fri, 16 Jul 2021 19:31:30 +0100
Message-Id: <162646021665.47820.5826789747346391444.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210713125743.1540-1-a-nandan@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 13 Jul 2021 12:57:40 +0000, Apurva Nandan wrote:
> This series proposes fixes for cadence-quadspi controller for the
> following issues with SPI NAND flashes:
> 
> - Due to auto-HW polling without address phase, the cadence-quadspi
>   controller timeouts when performing any write operation on SPI NAND
>   flash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Disable Auto-HW polling
      commit: 9cb2ff11171264d10be7ea9e31d9ee5d49ba84a5

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
