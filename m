Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A043CFB4
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhJ0RcE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 13:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243259AbhJ0Rbz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6FF76109D;
        Wed, 27 Oct 2021 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355769;
        bh=4u6JqQsIN87tNoFbs5p+FQuuo/VW1aS9VWMCdQOpY5I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cHlk8my+EU1NqLhkugDNjQN5eeuC/7eu25hJA+AzdNe/zUh038f5dfnqtmUqOvzud
         Yl+vLh7me0UHExOAkaBVqWqpR24ldkNqT1MxiBbZ0kDckOwuRSUG6qdlpUPFOYMf3T
         KcMeozdzOfDfaXl2gb6ztiynjXktKhmnM+bELiqXTm2gy7Bu9kh02XxjnxjbxYnATi
         Zby0SNkmu12ZDgHIA3SAyoFxTADIxbZehWgszxeIvRSmRp1VkzSgzemh1/qkckYKVQ
         5YdtAw5zG1NNpWLWNiGbwoXPuIm3SzJ7BGjFLYI5BYsiZ3lxXTQhsbTP9tKsymqOHz
         ylYx0wQ8uI/HA==
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20211026193327.52420-1-eajames@linux.ibm.com>
References: <20211026193327.52420-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Fix contention in the FSI2SPI engine
Message-Id: <163535576865.4012316.16041752826043259627.b4-ty@kernel.org>
Date:   Wed, 27 Oct 2021 18:29:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 26 Oct 2021 14:33:27 -0500, Eddie James wrote:
> There was nothing to protect multiple SPI controllers on the same FSI2SPI
> device from being accessed through the FSI2SPI device at the same time.
> For example, multiple writes to the command and data registers might occur
> for different SPI controllers, resulting in complete chaos in the SPI
> engine. To prevent this, add a FSI2SPI device level mutex and lock it in
> the SPI register read and write functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: Fix contention in the FSI2SPI engine
      commit: e954af1343f6334bf7e081f2631cc2902d07a0ee

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
