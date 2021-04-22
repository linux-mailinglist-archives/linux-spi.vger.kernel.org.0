Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1848368527
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 18:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhDVQty (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 12:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236236AbhDVQtw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 12:49:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4747D613C3;
        Thu, 22 Apr 2021 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110156;
        bh=c5nRaByBV7G7KEgEhv5zB2ZbyxszwbwZAjjx76FFUlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmrZ+MAXNb8bIXpisAPILE3UlkGtF0tHpm1YOXmtfxmDqjOzm6AWk9OCTngkdAhlR
         rP4SA/n7g1miWo93o45DeT+3keZJxu/PalCiKxGyIifjOfg9hpTXO09z9t4q0UJSd3
         4LRImAh0TpRb5N8ykJL9Lz8WTezbM1hPOJpaHtrOPXfR0SZ5dHabgyF7gh6AK5fPuQ
         A3OdQ3RSvLJyChcjdRQkCSRu9kvwZOhWTTVcgwIpPsMkuD5bpn/wKZpfohZQZEf9PY
         c9OM0HHjY6SQlRBa+qkylBj679sFAHdLfq9BSIceR22Xe8vUzY3Es3lVCyZaAOTlvu
         6wgGSOw+5h93g==
From:   Mark Brown <broonie@kernel.org>
To:     quanyang.wang@windriver.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tools: make a symbolic link to the header file spi.h
Date:   Thu, 22 Apr 2021 17:48:44 +0100
Message-Id: <161911005747.37738.13792341162405861105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210422102604.3034217-1-quanyang.wang@windriver.com>
References: <20210422102604.3034217-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 22 Apr 2021 18:26:04 +0800, quanyang.wang@windriver.com wrote:
> The header file spi.h in include/uapi/linux/spi is needed for spidev.h,
> so we also need make a symbolic link to it to eliminate the error message
> as below:
> 
> In file included from spidev_test.c:24:
> include/linux/spi/spidev.h:28:10: fatal error: linux/spi/spi.h: No such file or directory
>    28 | #include <linux/spi/spi.h>
>       |          ^~~~~~~~~~~~~~~~~
> compilation terminated.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tools: make a symbolic link to the header file spi.h
      commit: bc2e9578baed90f36abe6bb922b9598a327b0555

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
