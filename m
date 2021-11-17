Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3F45508D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 23:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbhKQWel (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 17:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241378AbhKQWek (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 400B661B72;
        Wed, 17 Nov 2021 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188300;
        bh=wSj1C+qFtDqnb5ng+qoFHyUgT5FmgBcJnVyvX2uXSak=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JMMc19+XPu/4oyIGA2pqtRGj2oUlFzwoS0QunWuF8TTwursI1H0Gc4sS6xKq/93lu
         MVqN4mSx/Cb1wJy/s7/A323No+WFHt+YyAXC7rdmvsaVAYRzF/25nAnJH9F/itDqGP
         fXaZdGVb6ZvBrh76oD7caP1naX6Jdx8++ypw/uMVuCz/wVYWrvrtvOVlal7tTBzQEb
         kjsn79loH3TkHqofoNgV6sWwKd/SBtWEwvAmXN+A3/uHmdKX2l+lhR2/1MStMA0hOV
         73HN4n5Qy3DVJ//1KcpqEO3y6fQ8pZfCRG1p5LPInWlW22x4TzOupXJDtrZu2/IX9P
         mtkHPQuoQ5RcA==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, huangdaode@huawei.com
In-Reply-To: <20211117012119.55558-1-f.fangjian@huawei.com>
References: <20211117012119.55558-1-f.fangjian@huawei.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Fix the debugfs directory name incorrect
Message-Id: <163718830000.137069.2810055581116731204.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 17 Nov 2021 09:21:19 +0800, Jay Fang wrote:
> From: oujiefeng <oujiefeng@huawei.com>
> 
> Change the debugfs directory name from hisi_spi65535 to hisi_spi0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Fix the debugfs directory name incorrect
      commit: 40fafc8eca3f0d41b9dade5c10afb2dad723aad7

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
