Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA936730B
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbhDUTEm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 15:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239751AbhDUTEl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FCEE6145A;
        Wed, 21 Apr 2021 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031847;
        bh=z4/GPDUKpT7VDjqnMBqYjsGYvZ05rXY0DGFPEFp+NU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxZHJAhBi/TNcWYsPkSSyiGo2xBscBV2ij+ztdPl9UFQwINOjruz+GGXQZjaHw01f
         bbs+BVkPjVmlhR+O4p5g3X3wM2/moArti4JTs73rSfUA9mv2Y47pB010asRye2LNO0
         qCbjTiR4e4u3+MoFBr3rvziIPf3xmV4OnNWAgFuOu3JN83L7f9Z9SwaO5WdevSB2q4
         qMQGEjLhrbGt7BIz/NSodz/VHKL0r91/GCJYZMw15JpwVG2O0oKo9YjjlM1yyHtlqG
         gWZTPy0ZpwgH4rcE4tbq+US4/+6GjmXDiJ7T2SuwgFWUPlp6W1Zw+1Y8GXZRmb8qDc
         BMAE0o3FlVIEQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] spi: Make error handling of gpiod_count() call cleaner
Date:   Wed, 21 Apr 2021 20:03:25 +0100
Message-Id: <161903040536.13608.2514437013522557183.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420164040.40055-1-andriy.shevchenko@linux.intel.com>
References: <20210420164040.40055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Apr 2021 19:40:40 +0300, Andy Shevchenko wrote:
> Each time we call spi_get_gpio_descs() the num_chipselect is overwritten
> either by new value or by the old one. This is an extra operation in case
> gpiod_count() returns an error. Besides that it slashes the error handling
> of gpiod_count().
> 
> Refactor the code to make error handling of gpiod_count() call cleaner.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Make error handling of gpiod_count() call cleaner
      commit: 31ed8ebc7a27c1937184b956727bf71d4adc7df3

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
