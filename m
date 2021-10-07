Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76427425F32
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhJGVjb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 17:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhJGVjb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6302B610C8;
        Thu,  7 Oct 2021 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642656;
        bh=jLuZvpJmYjG6xaNeAv3qn+YTOybD2FBU6G7FRPWTbZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YThNxDZN9TwSmCfSXfKy6QXkWItJSjPONp2aEy/nEXVUpiTImPd50xTc+dEB3P+OK
         Pq9UfekfsXHDwW33KwpAcPV2kl0pi67/tGcuYUfmjkyGYJo7VohrNnQoCeH6SkkQj2
         dbB4KrQ2VoYekkoBJLTTvmlFUekX3j32dpxLiMux9U7slrUNNq7LR1PaMbbDq42OZB
         mOyBVLvKsWX3ZIyhvDpKacjohpxroQteiKTJCxjss/ktQpGb25i2paCI0rrBjQ8u8U
         4Buu42L4ltm6sZGu4GwrO8Wf3IyUICRy5SAdA+tBtXk7AET1H5dq9HaYCACEbMdUwm
         lAAtE85Z3or6g==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/4] spi: Various Cleanups
Date:   Thu,  7 Oct 2021 22:37:21 +0100
Message-Id: <163364264937.649954.11489762989707343828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
References: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 Oct 2021 14:14:11 +0200, Uwe Kleine-König wrote:
> while trying to understand how the spi framework makes use of the core
> device driver stuff (to fix a deadlock) I found these simplifications
> and improvements.
> 
> They are build-tested with allmodconfig on arm64, m68k, powerpc, riscv,
> s390, sparc64 and x86_64.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Move comment about chipselect check to the right place
      commit: 6bfb15f34dd8c8a073e03a31c485ef5774b127df
[2/4] spi: Remove unused function spi_busnum_to_master()
      commit: bdc7ca008e1f5539e891187032cb2cbbc3decb5e
[3/4] spi: Reorder functions to simplify the next commit
      commit: fb51601bdf3a761ccd3f3d9dc6c03064f10f23aa
[4/4] spi: Make several public functions private to spi.c
      commit: da21fde0fdb393c2fbe0ae0735cc826cd55fd46f

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
