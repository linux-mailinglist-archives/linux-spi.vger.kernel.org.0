Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4F35A2FD
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDIQXb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233864AbhDIQXb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE8C6105A;
        Fri,  9 Apr 2021 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985397;
        bh=AtMxuAc0rwMUJsKBsJmtUeCRyl8bAabZIwT9Uehu7Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIMfGDncmDxz4CzhaLYP43ccv+bf8F20uwitMuVe1kIpdOtT3mHlkgMqReY0G55SW
         wRBQXDInzUSPqQkzTecUsTnlr9TTA8L+wJVasrdTGJv5+LonihTyx+p8lQ5N2Bvk+v
         H6rFjlNsXq72HKwOylEX4lX//0JemTP0pV2Tu+iBxzJieoCR8mQiu+dg3B0//XmJqF
         VslgB9AndrumMls3xqyZVx6FqWyOjhLiYQ23kXoX3pecDxlQSeSjwJYNiA976+Jid5
         UHH7oceyclz7ip9K0pG8+0C0AidLFKcwwLtlvDX7y5h/Wl1kNm8/cIqFeTFt6++YtA
         0aOL1p2WGriyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Subject: Re: [PATCH] spi: orion: set devdata properly as it is being used later
Date:   Fri,  9 Apr 2021 17:22:39 +0100
Message-Id: <161798356987.48466.7574385472200837460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195718.GA3075166@LEGION>
References: <20210408195718.GA3075166@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Apr 2021 00:57:18 +0500, Muhammad Usama Anjum wrote:
> If device_get_match_data returns NULL, devdata isn't being updated
> properly. It is being used later in the function. Both devdata and
> spi->devdata should be updated to avoid NULL pointer dereference.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: orion: set devdata properly as it is being used later
      commit: e980048263ba72dcdbbf45d59e84c02001340f75

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
