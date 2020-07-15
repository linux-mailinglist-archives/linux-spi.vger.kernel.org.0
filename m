Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A90221016
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgGOO7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 10:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgGOO7q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 10:59:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C697820771;
        Wed, 15 Jul 2020 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594825186;
        bh=Ol+skO8vaJ82IbSH0BbWqj32R+0+d6V0xznUOOv6rtg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Nw0INyNbmV7wApNTWXqeiHG9uWwEdeJquZslkoJGvNUUTa7Sf0t3T5Ivnu4bTB8v1
         hG0VFTt7tzKZlgAHD3BDwQtec5IKoZpjK7SjarzeJ0FOodDU5sGP7kFNB3i9Fk9PmR
         LyT6hmblWbZuOZIu0X8MXl1+OuMp3eP9HRsNj+uY=
Date:   Wed, 15 Jul 2020 15:59:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
Subject: Re: [PATCH v2 1/2] spi: omap-uwire: Use clk_prepare_enable and clk_disable_unprepare
Message-Id: <159482517674.44770.10991348795912093074.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jul 2020 13:26:46 +0800, Qing Zhang wrote:
> Convert clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare() respectively in the spi-omap-uwire.c.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap-uwire: Use clk_prepare_enable and clk_disable_unprepare
      commit: badfae429b13ef173fe4627714894cb629aa1bc6

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
