Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BC368528
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhDVQt4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 12:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhDVQtz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 12:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 791D661409;
        Thu, 22 Apr 2021 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110160;
        bh=axWE37eq5CgD/yuWEg0pILGXxgQdLfIdnB2oGBaHdjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PydCb0ZkiH8Vug2p+NgUgK2XQGK4GIEjhCevOYXkJIlwY07CBN0W6xg2IlYgnC7vv
         3zB73nBNUT1d65y9IdQa9z0CelRgXLKy2MH14N/HpH0jB+UqWTrslFAyOBax6AveIj
         WcMqjynBqDfy2FkITW8Nh6k59DyDuVqldh9ROB4OyxRiiEUD8aANEEcUYtoOFga9Rr
         f9/xzvUm4V4b5Pck3zsMsoJXWC37EyM3/EWlUtuXFyHjM+diRRrg4aj4dSL4eCCmCl
         KB7PexgKhNw0NueBldH2upC2yu+mp7NXXUk1Zi3ewYvLeM0OC79PTPYemqbX/+qIW9
         heEhPiZNrA7EQ==
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v2] spi: stm32-qspi: fix debug format string
Date:   Thu, 22 Apr 2021 17:48:45 +0100
Message-Id: <161911005747.37738.3439795331125402090.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210422134955.1988316-1-arnd@kernel.org>
References: <20210422134955.1988316-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Apr 2021 15:38:57 +0200, Arnd Bergmann wrote:
> Printing size_t needs a special %zx format modifier to avoid a
> warning like:
> 
> drivers/spi/spi-stm32-qspi.c:481:41: note: format string is defined here
>   481 |         dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
> 
> Patrice already tried to fix this, but picked %lx instead of %zx,
> which fixed some architectures but broke others in the same way.
> Using %zx works everywhere.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: fix debug format string
      commit: 14ef64ebdc2a4564893022780907747567452f6c

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
