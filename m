Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFE2EF5C3
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbhAHQcB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 11:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbhAHQcB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Jan 2021 11:32:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04F7A2399C;
        Fri,  8 Jan 2021 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610123480;
        bh=beylbSLecDvPXdgnI3RfaEREbdQJFrqh/3A2GqloH0M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oGaWBYGXYs76zTfkP27j1OXbP5po2pIhHpOfm1ntPPchpklztEBhCnI0TgxEWj0zw
         8XeW7OkCUqYFRkCpiey3sezqwhL8yzmlu/1NB/Y6SVn0u6yKufeYHEwQrtbujf22Jc
         TGIikEbEfRhGRS+6RdQ0U4iSvJbKzisEIzA7OrmanBkW/3V6n+OxfOFaRC8BS2dYKA
         6mosD8xZRUgLn55Cwet80obYeqmZlFuDnSfrOYk4JdvpXu1dEOfxvedNS6bP8Ic/yl
         /sUQK3n+MHCLbJyr5SrY+hQ2uMIrQwN/S71fVMaIRDfB4zNZF102CcIMa2vd03+2L5
         Y/qSreVnFfedQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yanteng Si <siyanteng@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
In-Reply-To: <20210107115704.3835282-1-siyanteng@loongson.cn>
References: <20210107115704.3835282-1-siyanteng@loongson.cn>
Subject: Re: [PATCH] SPI: Fix distinct pointer types warning for ARCH=MIPS
Message-Id: <161012344968.41129.16669403915280599326.b4-ty@kernel.org>
Date:   Fri, 08 Jan 2021 16:30:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Jan 2021 19:57:04 +0800, Yanteng Si wrote:
> Fix a new warning report by build for make ARCH=MIPS allmodconfig:
> 
> drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_direct_read_execute':
>  ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
>     18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>        |                            ^~
>  ./include/linux/minmax.h:32:4: note: in expansion of macro '__typecheck'
>     32 |   (__typecheck(x, y) && __no_side_effects(x, y))
>        |    ^~~~~~~~~~~
>  ./include/linux/minmax.h:42:24: note: in expansion of macro '__safe_cmp'
>     42 |  __builtin_choose_expr(__safe_cmp(x, y), \
>        |                        ^~~~~~~~~~
>  ./include/linux/minmax.h:58:19: note: in expansion of macro '__careful_cmp'
>     58 | #define max(x, y) __careful_cmp(x, y, >)
>        |                   ^~~~~~~~~~~~~
>  drivers/spi/spi-cadence-quadspi.c:1153:24: note: in expansion of macro 'max'
>   1153 |       msecs_to_jiffies(max(len, 500UL)))) {
>        |                        ^~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] SPI: Fix distinct pointer types warning for ARCH=MIPS
      commit: 8728a81b8f1007426d8f341c5d2400da60f4cea2

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
