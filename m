Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483AF35A300
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhDIQXe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233864AbhDIQXd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5836103E;
        Fri,  9 Apr 2021 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985400;
        bh=t/mPNhJnazVKhkpQ+lIGCQRQb6zXqF/fPgfGi1ncm2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQm/etGXAnEujvh+/dzXTiy768Bx/c//aOsGu0CqNBXC8shGA2NDOOObHV8uQoWjc
         a+PMXJjIFYxOMJGa2drU+uQdjnVbf1iOVi5bEsFHsfjr5N0Fmu68+vGahis9merDGH
         79xZQD2hUHuMWspG9mbftkLD1AU4gUuHockEpDFtMHx55hLmts89PyvayxGcJz2yOu
         q8Q0Cyt5lPkE95vRBfSaTb65nL4GQoF6+O6WhAWTXvQFPnM9xoU+7u9LQWNNeA027S
         ez4/63MjjZ51NJ5CgFY3Lt7anhdBkpYkwmRaYd1q5+wWX5qnTHcqHzwqfC0+lyrpqr
         r3HaEx1m1nLng==
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: omap-100k: Fix reference leak to master
Date:   Fri,  9 Apr 2021 17:22:40 +0100
Message-Id: <161798356987.48466.14490964027332718844.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409082954.2906933-1-weiyongjun1@huawei.com>
References: <20210409082954.2906933-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Apr 2021 08:29:54 +0000, Wei Yongjun wrote:
> Call spi_master_get() holds the reference count to master device, thus
> we need an additional spi_master_put() call to reduce the reference
> count, otherwise we will leak a reference to master.
> 
> This commit fix it by removing the unnecessary spi_master_get().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap-100k: Fix reference leak to master
      commit: a23faea76d4cf5f75decb574491e66f9ecd707e7

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
