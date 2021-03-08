Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3B331303
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHQKH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 11:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhCHQJ4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Mar 2021 11:09:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D67865210;
        Mon,  8 Mar 2021 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219796;
        bh=g9EyKfsYRqVbOXlteLRR15Bn9zOHc3c4i5cWelXXwFg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kcjssyaM/IPILcuHQ7ohp12HS1wZ2Db/nmaUwEHlTaWkqYinonuAPlCphTV4B1436
         JNHNaS20PLe0pCS5wy54uO6RIwmApsn0q6aRM5vRwfiV1FHANoa+kOLCi9tzQ7BFyo
         jUtwpoJ6Zs2TJeXBd1XRW6rqnpQqodP6VM8sXKIrfxAr4vyd5zv8TbcyuEmZkK/MRu
         AhatraA0PSZfxnapuPInuVRgez1xxS+dxMhSJ2u8cSOMKl7NO8hY5g5//YcZ9Vo/Ca
         7ffLpz6BLcsUODviG8tuYnuaL+/gObuxoGl6eP+uh3sAalCFa7HwbJv8MNpmk0I90i
         +pBf9uTVz5L5Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Jay Fang <f.fangjian@huawei.com>
Cc:     huangdaode@huawei.com, dan.carpenter@oracle.com
In-Reply-To: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
References: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Silence shiftTooManyBitsSigned warning
Message-Id: <161521972632.10046.6571535354886838464.b4-ty@kernel.org>
Date:   Mon, 08 Mar 2021 16:08:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 4 Mar 2021 18:47:52 +0800, Jay Fang wrote:
> drivers/spi/spi-cadence-quadspi.c:267:18: warning: Shifting signed 32-bit
> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>     return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
>                     ^

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Silence shiftTooManyBitsSigned warning
      commit: 55794b1d8623f73d9a4bf12e4343bc8fc96024e1

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
