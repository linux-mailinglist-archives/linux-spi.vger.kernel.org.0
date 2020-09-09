Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C726341C
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgIIROl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgIIPaY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:30:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911CF22272;
        Wed,  9 Sep 2020 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665382;
        bh=gxE3ui3erFuhnG/K5IRsWZHm67oJxM7qIJtlKXllmyw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kcCBlV0XuQD8mjBr3DvzJsF7H3c7OtiJzELIApI0adlVfq/JjCoMh9MMUTbPRra/3
         I0TEf6713FHQfMk3T590z8223M3f3QPg3FLwARtKV7k9J3VfEQq9fSKJn7LJdOzvga
         cShT+IOK/Jdam9TkmBnYrKgER6J6BU71LLxrnhe0=
Date:   Wed, 09 Sep 2020 16:28:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org
Cc:     huangdaode@huawei.com, linuxarm@huawei.com
In-Reply-To: <1599631704-53232-1-git-send-email-f.fangjian@huawei.com>
References: <1599631704-53232-1-git-send-email-f.fangjian@huawei.com>
Subject: Re: [PATCH] spi: spidev: Remove redundant initialization of variable status
Message-Id: <159966533166.54485.5655144984479859087.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Sep 2020 14:08:24 +0800, Jay Fang wrote:
> In spidev_read() and spidev_write(), the variable status is being
> initialized with a value that is never read and it is being updated
> later with a new value. The initialization is redundant and can be
> removed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Remove redundant initialization of variable status
      commit: 4ebf8816e35d63db723d95f8e49d8455be926c36

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
