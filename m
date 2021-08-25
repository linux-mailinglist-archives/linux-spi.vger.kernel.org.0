Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783663F72E4
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhHYKX7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 06:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhHYKX4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Aug 2021 06:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1226E61212;
        Wed, 25 Aug 2021 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629886990;
        bh=b86R3glVuehPSGIAqorJ6zxBkwSAg6T+BgqVduzfR0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ou+byWjuwVLazkRMsIMTDmFoPs+jHYuoG4b9Yr9eB+6Dt9hXFZaFup+oaYp5jzfw9
         5ww4OypWXyvdeJlMmrT1p/V9KNoYl/6yfBni0zXiXJwZmICGrDknnxjAn2NlenBq42
         Tu6YjEfKlPmOld1UJkGMykscZhgEX/BXk5P9BD0YX8E2DQw1/MryoNKVvTMr/b6XvL
         zOUhWzp/Hl32VSZUTquuXT3uPjiLOh7i4p5RL57gYR4XN1dxfT4NCtbTSW/QdETOWT
         GQblx1pAtggD0wFTGXB+hTAVRfA6i72gEYsYaBpSqW5EPKOHGpL2atsDEh0upzJBb1
         3n0ivpJp6JUZg==
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-spi@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>
Subject: Re: [PATCH 1/3] spi: sprd: Pass offset instead of physical address to adi_read/_write()
Date:   Wed, 25 Aug 2021 11:22:37 +0100
Message-Id: <162988541636.8193.7086076559922137758.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210824070212.2089255-1-zhang.lyra@gmail.com>
References: <20210824070212.2089255-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 24 Aug 2021 15:02:10 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> The register offset would be added a physical address base and then pass to
> the function sprd_adt_read()/_write() each time before calling them. So we
> can do that within these two functions instead, that would make the code
> more clear.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: sprd: Pass offset instead of physical address to adi_read/_write()
      commit: 5dc349ec131c6d40aeb2545064e285f0025fbb39
[2/3] spi: sprd: Make sure offset not equal to slave address size
      commit: 2b961c51f4d35c45116b21936b563cbb78fba540
[3/3] spi: sprd: fill offset only to RD_CMD register for reading from slave device
      commit: f674aacd5005184acf3cf7b851a299573d64fdd6

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
