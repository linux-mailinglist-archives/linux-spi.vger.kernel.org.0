Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7740896D
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhIMKzb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 06:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238223AbhIMKz3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F5561004;
        Mon, 13 Sep 2021 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530453;
        bh=dIYTnI73qGqPtN3DyGN5x/Fohi8Aer6EGEqC7QYbie4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOjTgIvXuEcBrCPuWNBh66nE/mt9TBtE2qUR3Zpgnrc7aewO/PK2aYsI9BfYgIOnM
         qHeLe3Mxn4Dexha3ygrptmFjir7HyGUJWMfwpulk7ZUBgd1GtjZVLrFJrpiIFXflbR
         s3u/OSeTQN9DzS20vx38h0tZHvHctaLV8OfLasuCAzGrOkXxdZlCy+m22kDJt/6rb1
         KLXTfgY3WC5C/ED8adEYJD+Pcpm5MlGVier3WvVjiTXl79H7zx0S6UNFCRbR9GXHd6
         HaE1RuWgBKGLxPIpkULValX2xPEpfewRGbsVT5f1qnxjG3zfAFX5LqMR2tFtHZkd3+
         xiRquiG6lm2zQ==
From:   Mark Brown <broonie@kernel.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/4] spi: amd: Refactor code to use less spi_master_get_devdata
Date:   Mon, 13 Sep 2021 11:53:06 +0100
Message-Id: <163153017122.45927.15918447354098819726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 9 Sep 2021 12:10:02 +0100, Lucas Tanure wrote:
> Get master data in the start and then just use struct amd_spi
> as it has the needed variable
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: amd: Refactor code to use less spi_master_get_devdata
      commit: ca8e8a18272e7b57b62db5db8fcf1f5218b89a98
[2/4] spi: amd: Refactor amd_spi_busy_wait
      commit: 356b02f9ec3a7304d6c54c4df20cd37b0a22021e
[3/4] spi: amd: Remove unneeded variable
      commit: 3b02d2890bc5eb974346cc287e1732f62a096598
[4/4] spi: amd: Check for idle bus before execute opcode
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
