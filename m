Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551B36490F
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhDSRew (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 13:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhDSRev (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCDE6127C;
        Mon, 19 Apr 2021 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853661;
        bh=yFFk46DO5amezDf+PMue/f7vFugbJyZHOR5kFpvNVvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwzbBTsyXYyKcCxNhYBeFVC1mMQTnVCUmT79NezM+aZf9gV20qJCtkNKQBf9BmDcr
         WV2iyofys6X79k4SJDYYWiHc2vZZO8XvbXK7FI3/O4G1UucHvLdU6jNX/tTQTmsVC7
         aaSF0TjQ208aOEWr9KI/BI2GNit6UgVN43sdzQ11PCopfOqW+92QHadcQ5HCNjgQqN
         vRJbqldUE9Kz0NCWsLF/yMuOSWFk97rroXcFZ00CQ3DHYaB8us0RUyA4mfueoa9tzg
         gJ9NR1VfShfoDDF5+4nKoolLRoOWT4GiSz5O61KgJzr+AXv08oey41SxXE7DX+r7QB
         H8oX012mzwp4w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Handle SPI device setup callback failure.
Date:   Mon, 19 Apr 2021 18:33:46 +0100
Message-Id: <161885314932.4710.14482969340567578006.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419130631.4586-1-joe.burmeister@devtank.co.uk>
References: <20210419130631.4586-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Apr 2021 14:06:31 +0100, Joe Burmeister wrote:
> If the setup callback failed, but the controller has auto_runtime_pm
> and set_cs, the setup failure could be missed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Handle SPI device setup callback failure.
      commit: c914dbf88fa8619602e0913e8a952a19631ed195

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
