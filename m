Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD831A042
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 15:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhBLODg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 09:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBLODf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC76664E36;
        Fri, 12 Feb 2021 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613138574;
        bh=kUwdJtqutN1Y8vivFBVWnaXW5KlfUyHYtKAdl9LJ8Z4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RDEgxOa7pGvR8TR468bOpzC6A9Adb+oDezAz+g+eFIV8LL4i4oluz1FTlRK++phsP
         YM8fZQXKnWCAxkmYsJA5iZsa4jpEVxYR4PI75ErW0zqY2fOlQegscJtbKXegrojV4l
         70BkGtBvylKzPIzS9nLKbnfKs0Fe4Ky+Q+fxFXzb9DtX+FPddjKOzH8YVL5sN9RmI8
         hGCd1WeLLlEr63yO6xTegYJXxEvHP9R2pUFSNifIQUBJN5musT2m7Btzb+Z4JF646o
         10G0xCWFSSEQdYKsSpIiYOKZGgCFF8mdMeGfHPCr/LFb1V71N8ycSNZOhrQ9fwyJCM
         GrnhZW8n3jYQA==
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20210211203714.1929862-1-keescook@chromium.org>
References: <20210211203714.1929862-1-keescook@chromium.org>
Subject: Re: [PATCH] spi: dw: Avoid stack content exposure
Message-Id: <161313851920.18278.11236023694636938013.b4-ty@kernel.org>
Date:   Fri, 12 Feb 2021 14:01:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Feb 2021 12:37:14 -0800, Kees Cook wrote:
> Since "data" is u32, &data is a "u32 *" type, which means pointer math
> will move in u32-sized steps. This was meant to be a byte offset, so
> cast &data to "char *" to aim the copy into the correct location.
> 
> Seen with -Warray-bounds (and found by Coverity):
> 
> In file included from ./include/linux/string.h:269,
>                  from ./arch/powerpc/include/asm/paca.h:15,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/mutex.h:14,
>                  from ./include/linux/notifier.h:14,
>                  from ./include/linux/clk.h:14,
>                  from drivers/spi/spi-dw-bt1.c:12:
> In function 'memcpy',
>     inlined from 'dw_spi_bt1_dirmap_copy_from_map' at drivers/spi/spi-dw-bt1.c:87:3:
> ./include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset 4 is out of the bounds [0, 4] of object 'data' with type 'u32' {aka 'unsigned int'} [-Warray-bounds]
>    20 | #define __underlying_memcpy __builtin_memcpy
>       |                             ^
> ./include/linux/fortify-string.h:191:9: note: in expansion of macro '__underlying_memcpy'
>   191 |  return __underlying_memcpy(p, q, size);
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/spi/spi-dw-bt1.c: In function 'dw_spi_bt1_dirmap_copy_from_map':
> drivers/spi/spi-dw-bt1.c:77:6: note: 'data' declared here
>    77 |  u32 data;
>       |      ^~~~

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Avoid stack content exposure
      commit: 386f771aad15dd535f2368b4adc9958c0160edd4

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
