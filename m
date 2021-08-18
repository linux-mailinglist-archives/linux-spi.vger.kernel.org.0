Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CA3F090F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Aug 2021 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhHRQ1e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 12:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHRQ1a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Aug 2021 12:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96F5060EFE;
        Wed, 18 Aug 2021 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629304016;
        bh=Zc28l2D3Fup6mmSxzhQY/pdcEWXV3MA2UhBv7/tJRC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S923qVXloQ1LosSG8b9U5jG8Io9ZjO91C7GCds6+Onc2dtRjc8EO8hGR0dX9fyheb
         22fBpfrSyFeZmvCbIEWBJ4NMjsQg64YniDaFGavGR4kjiWQVLu/jdpYWVFXqVu47/Z
         MljkszJ22f5LGdFbwecUMWmu2OxLhE7EkTGAuc3nXmpc8J+CFaz8iS/g6xM385DFK7
         3ZcpoYGrNqJWxfqFHU88jVwyIqWbA9I7uGbQ7O+ka+ONKkNQexzO4ya+DHOrVRWmkJ
         rdnMn9LYRqH7Ww+o74q4dfkAoxpeaSmiih7H3ubS98Lik/wOFWkmyAURCXDb/zCuzF
         30TeSzUxQgftw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, ldewangan@nvidia.com
Subject: Re: [PATCH -next] spi: tegra20-slink: remove spi_master_put() in tegra_slink_remove()
Date:   Wed, 18 Aug 2021 17:26:30 +0100
Message-Id: <162930380184.11247.17073107281539539270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810142230.2220453-1-yangyingliang@huawei.com>
References: <20210810142230.2220453-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Aug 2021 22:22:30 +0800, Yang Yingliang wrote:
> spi_master_put() is already called in spi_unregister_master(), or it
> will lead a double decrement refcount.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: remove spi_master_put() in tegra_slink_remove()
      commit: 02cea7039ad52593ee05824c19233366914df9b2

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
