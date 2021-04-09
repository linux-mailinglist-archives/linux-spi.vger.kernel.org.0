Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED7635A302
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhDIQXh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233577AbhDIQXg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0119D6108B;
        Fri,  9 Apr 2021 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985403;
        bh=Of3ySWlR/2RwBK3RGmzzdyGN4qP9uOE2nJVqqN9CwlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhsOttHYVP2nOm94c/vEgdfq3St5g0WfEBTRxsBoHwJMxwv8h/+soHzw8UoV25k/G
         Jiiuw7Guiyf1rY7c1JR/LroQRB1Y5q8U6PDzf4M9ZBF6k/wlBlJJ6JY378yIk1dgxB
         Pl7LNx/WzfxEx6Twb0OOWWSMXcQWUzRbFxjd+RpjEZu+gthilUT6zwvtZJ/69DXXTn
         +ijrSkTFJ1a1ZLCTHr9bd3oHVbFaBAYZgkNfkKcj5r+y51QslvYc7Scif/ofU0LjNh
         plyRBJPUzP4b6wHe8vITfhcBGshARvjkxmcr/m3oCXb1RLAbnpOaLCI7UYdOWusnjT
         IoT1A0cJszq0w==
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: dln2: Fix reference leak to master
Date:   Fri,  9 Apr 2021 17:22:41 +0100
Message-Id: <161798356988.48466.14335938900773090714.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409082955.2907950-1-weiyongjun1@huawei.com>
References: <20210409082955.2907950-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Apr 2021 08:29:55 +0000, Wei Yongjun wrote:
> Call spi_master_get() holds the reference count to master device, thus
> we need an additional spi_master_put() call to reduce the reference
> count, otherwise we will leak a reference to master.
> 
> This commit fix it by removing the unnecessary spi_master_get().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dln2: Fix reference leak to master
      commit: 9b844b087124c1538d05f40fda8a4fec75af55be

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
