Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330292F1AF2
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbhAKQah (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbhAKQah (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 11:30:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2588C2250E;
        Mon, 11 Jan 2021 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382596;
        bh=sBz4Ipd+9rer8wbKvcY9vmCEahmCvzueI9fuZ8Fv1nc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X1Xsg4rLRaRWNTKPIC46HncpPCfwl1Ki30CRnshfig1WZuFflF9PACZmj9GIHAWQ+
         pT37eu+Ur2b45NDxHCRfjbJPF8KaTcrSeShjKEUm2rEOPX8YYR+sLeS53QLtXxTk0l
         Dgk3Wh8lw6kd+EWTI70MzMNFXTWok8wa3ceSZqNONWMnZULC7imc+fEh8nQ3Rg5rzu
         o2ALN6M0+WL6UX8wCbL/+o+mUfjWzqZlKOe/1pb426UCOHFWvXOaAx7W5WRPZ7Fz9w
         H5AYzm0XaXY8gBe54kj/bV3lMbdPMGtHuPah0ug5/GlwCBMM4Rt1R1uzZOIENzS7FB
         2idqaRrG3sYiw==
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20210108181457.30291-1-p.yadav@ti.com>
References: <20210108181457.30291-1-p.yadav@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix build warning on 32-bit platforms
Message-Id: <161038255868.32886.16994603160405632637.b4-ty@kernel.org>
Date:   Mon, 11 Jan 2021 16:29:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 8 Jan 2021 23:44:57 +0530, Pratyush Yadav wrote:
> The kernel test robot reports the following warning.
> 
> drivers/spi/spi-cadence-quadspi.c:966:24: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (500UL) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
>                                             msecs_to_jiffies(max(len, 500UL)))) {
>                                                              ^~~~~~~~~~~~~~~
>    include/linux/minmax.h:58:19: note: expanded from macro 'max'
>    #define max(x, y)       __careful_cmp(x, y, >)
>                            ^~~~~~~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:42:24: note: expanded from macro '__careful_cmp'
>            __builtin_choose_expr(__safe_cmp(x, y), \
>                                  ^~~~~~~~~~~~~~~~
>    include/linux/minmax.h:32:4: note: expanded from macro '__safe_cmp'
>                    (__typecheck(x, y) && __no_side_effects(x, y))
>                     ^~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:18:28: note: expanded from macro '__typecheck'
>            (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                       ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>    1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix build warning on 32-bit platforms
      commit: 2ef0170e90391f1adb31c449059b8efdc923707c

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
