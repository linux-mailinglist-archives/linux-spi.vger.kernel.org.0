Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394F3EBB6C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Aug 2021 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHMR0u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Aug 2021 13:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhHMR0u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Aug 2021 13:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC23960F51;
        Fri, 13 Aug 2021 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628875583;
        bh=FNN6mBHCMTkjdP5X3toqTBdl9AYPY2/K4P7dwNzC9lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1SZcZa9g/vpfP3Oj3TIjsMwgcPtZwRykBae8Aunjeb3buYgOtU3z60mgCwCK7V92
         0pP99io+iU6A057I4G5HedJtpxx8ofLp6x+qVVk0tCwEDB1EB+71KtCZmk2N74wTcw
         VuHL5xkpuvSzrwb0jd+m6Hi2MBVzFfZEoSCx7r5OdAGLzyvY00GWp2SsFzkTiveDGH
         LjKrqXDAd6XPOzjywduCdlvQnoVQM2WnBEhI39YrY3ZWBlakW4eVfSTSN4sE54y1Qs
         a4HPgIVm+/HW6l02YTrUa9hr8wV1PkHTKOLjsoUEI4x1000SP6fRBjqSz5gm8ICSKE
         Pj7apYXyNIguw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, zhengxunli@mxic.com.tw
Subject: Re: [PATCH -next] spi: mxic: add missing braces
Date:   Fri, 13 Aug 2021 18:25:59 +0100
Message-Id: <162887483202.19992.2868965211824266055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810142405.2221540-1-yangyingliang@huawei.com>
References: <20210810142405.2221540-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Aug 2021 22:24:05 +0800, Yang Yingliang wrote:
> Fix the following waring:
> 
> drivers/spi/spi-mxic.c: In function ‘mxic_spi_mem_exec_op’:
> drivers/spi/spi-mxic.c:401:3: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
>    if (op->data.dir == SPI_MEM_DATA_IN)
>    ^~
> drivers/spi/spi-mxic.c:403:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
>     if (op->data.dtr)
>     ^~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxic: add missing braces
      commit: aca196842a9729a198af57c417725c3ac9ca05db

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
