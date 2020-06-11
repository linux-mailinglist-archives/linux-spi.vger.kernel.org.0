Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AE1F6AF8
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFKP3E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 11:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgFKP3E (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 11:29:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7662206C3;
        Thu, 11 Jun 2020 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591889344;
        bh=FoB4qlXpNa9Jq3CpcDqd5Am3rilkKxrERk3Z7T04uzI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dcNPq8YAslgSZMPrrsegf57WoCSxdHEfpHKfF6GNBbaOIX7N8U7ER2PPactcjvfy7
         1eUQ9IkSx9WHVQUjLHBGqLEuAKj8Wxt9Rq99lN/+l9R3IuYbwEFkaGPo+KgGd4RigT
         6kRyMVsZcP8z3fYozvskoJmLNrXBAgq8HF5N6FxI=
Date:   Thu, 11 Jun 2020 16:29:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-spi@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
References: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
Subject: Re: [PATCH 1/2] spi: tools: Make default_tx/rx and input_tx static
Message-Id: <159188934188.47269.11106977185978190240.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Jun 2020 11:42:26 +0800, Qing Zhang wrote:
> Fix the following sparse warning:
> 
> ./spidev_test.c:50:9: warning: symbol 'default_tx' was not declared. Should it be static?
> ./spidev_test.c:59:9: warning: symbol 'default_rx' was not declared. Should it be static?
> ./spidev_test.c:60:6: warning: symbol 'input_tx' was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tools: Make default_tx/rx and input_tx static
      commit: bd2077915bfebf6965480753f9dd6a8319d06d14
[2/2] spi: tools: Fix build errors
      (no commit info)

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
