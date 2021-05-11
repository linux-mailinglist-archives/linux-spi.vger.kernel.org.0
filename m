Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0837AE54
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhEKSXV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhEKSXU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE7A061264;
        Tue, 11 May 2021 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757333;
        bh=tY+DyOll1ID/TuAyNQeRTBvujHiXuMnT1EX9dNVopOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgcnNHeORTWT88XTjG1nd4GNQzBeflXwWnjsz8OY82TwfyD89+nxc3AJx4FvRhtOD
         aq29tJLug6y1YGFk6AdezQawlyV2VceaMsLW5scbyOQ/L9meItMYJq8evVz7l2c6l5
         6daMhFue1L1dtd1i7OKwBjV6HIb5joug9yCPy2OUC7Kpf0PzPpwo50C47MkVAM/27F
         sCRapmd208Q24uhO8tHtPG8AmcfJ6LBrCFLClYkYp8/YyedZdnDrdu/orJMC897HQ1
         +X0DCP9NawUZUSFGh32+tvETO7PJ0sWWWOnLvja4BytxRmeMFH0a6eCtR5wSeZ0F+/
         WMIdXCTPg3LCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Switch to signed types for *_native_cs SPI controller fields
Date:   Tue, 11 May 2021 19:21:23 +0100
Message-Id: <162075727216.18180.15052614228876859060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510131242.49455-1-andriy.shevchenko@linux.intel.com>
References: <20210510131242.49455-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 16:12:42 +0300, Andy Shevchenko wrote:
> While fixing undefined behaviour the commit f60d7270c8a3 ("spi: Avoid
> undefined behaviour when counting unused native CSs") missed the case
> when all CSs are GPIOs and thus unused_native_cs will be evaluated to
> -1 in unsigned representation. This will falsely trigger a condition
> in the spi_get_gpio_descs().
> 
> Switch to signed types for *_native_cs SPI controller fields to fix above.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Switch to signed types for *_native_cs SPI controller fields
      commit: 35f3f8504c3b60a1ae5576e178b27fc0ddd6157d

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
