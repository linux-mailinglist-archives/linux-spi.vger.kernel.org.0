Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13968268E67
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgINOxy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgINOxD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4112820936;
        Mon, 14 Sep 2020 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095176;
        bh=H61Y5c2KbfDVpVIlzO6jOmJMlT2xgZI5CIQMpRI0TNA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=E6J1opgOst2BqqsC+VQLveyNjz8ISlC7EwxCzTUUE6ZzSGb6g4TipwEwD3eL49d6z
         SuMBv8PxDpQfhycJ7s3a3xjOcDcHbVW4l+CGKm7efx/rsBd9ZdoxGizeFtS8bZjgDh
         QSCm5Ozj6KYlEaa9e8nAN6/5CPm9yPsBHzC6ptDo=
Date:   Mon, 14 Sep 2020 15:52:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        rjui@broadcom.com, linux-rpi-kernel@lists.infradead.org,
        Jason Yan <yanaijie@huawei.com>, linux-spi@vger.kernel.org,
        sbranden@broadcom.com, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org
Cc:     Hulk Robot <hulkci@huawei.com>
In-Reply-To: <20200912072211.602735-1-yanaijie@huawei.com>
References: <20200912072211.602735-1-yanaijie@huawei.com>
Subject: Re: [PATCH] spi: bcm2835: Make polling_limit_us static
Message-Id: <160009511833.5702.12404789305180284179.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 12 Sep 2020 15:22:11 +0800, Jason Yan wrote:
> This eliminates the following sparse warning:
> 
> drivers/spi/spi-bcm2835.c:78:14: warning: symbol 'polling_limit_us' was
> not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Make polling_limit_us static
      commit: cbd632ea8ee4ae07d12e85ed07aa5d667a1f47d8

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
