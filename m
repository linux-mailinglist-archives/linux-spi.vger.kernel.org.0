Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3473F34D8B0
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhC2T6c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 15:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC2T6X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Mar 2021 15:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4FA561494;
        Mon, 29 Mar 2021 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617047903;
        bh=5O1xzKEeKhJKKETgkMvMLGoEytUUVVJ32w/7i5OShcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOLzsgi9x239srGFJlkLOwDroya5KcjaHjcD1mwpv8/JmEGmg3yumzIjroRoP2Bdq
         1rDgG45D4d1YJPzCpfVZ6uGp9EXMgd0tAm+SYoyTPghPYwCellDW4jJLKXa9Mqe6mK
         y72fPdoruwdsrUrTIWkFks4WnF9iAHWt/tptRi8ITCZVLUyHoaMtKOr+U3P7uN+jf/
         QgzVAdVGvs6Y5F4cbU0hx7KKSdRfAfZJn6wruOqlJQd9Xptq9ds4jAMCATzZyatRFA
         +eJDPCbcVGvGwGnyOoJD/QcfQlFP92KAA85VTaHQ597FwWIYun/k8GXZKcU1F7NxAH
         CWZH2dAzmYX0A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: pl022: User more sensible defaults
Date:   Mon, 29 Mar 2021 20:58:06 +0100
Message-Id: <161704736962.10244.18297173746207251580.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210328121530.1983081-1-linus.walleij@linaro.org>
References: <20210328121530.1983081-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 28 Mar 2021 14:15:30 +0200, Linus Walleij wrote:
> When using the device tree, which must be considered normal
> these days, in order to get some kind of normal functionality
> out of the PL022 users have to actively go into the device
> tree and edit the SPI clients like this:
> 
> spi {
>   compatible = "arm,pl022";
>   num-cs = <1>;
>   cs-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pl022: User more sensible defaults
      commit: 413c601e8fd0e4adab67e0775dd84e63be6d803e

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
