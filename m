Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6631A044
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 15:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBLODy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 09:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBLODm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D386D64E25;
        Fri, 12 Feb 2021 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613138581;
        bh=VuqkFaZKHwNoY6ayATlulBlks2L7rIdSyE0iZde9Ji0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pnfqD28M/wUvoL5jJbWHzvQVZhqVVptV6wi4jztcYbcbbxFxEjOBw4fmlYMJknxqb
         7SugWdCJucriHzzJPYnf2A05zETc+T7rLE7DBTYuh/5eyJ9zy+2LkW1vRzy4luUKxy
         8q45+es95h7rQWKPX26qw7pn3lcJmNsgDq5d1VuQPmcTFfazaJ6p2sdg/Py881i5GL
         AKDuV5n1JDuZeB115d9grCj0iBW6MT0ej4fjAZ+eeJSfBwObQcNAUD5RV5mlHpJ+eE
         s5SYxdPBidWgLmayw1Lrd9EiaettiOaVT+mfMde/xnkNwAcHF2gBcDS0uvaiRpF1eN
         3wf5/DUbY+oYw==
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <20210211180820.25757-1-nsaenzjulienne@suse.de>
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH] spi: Skip zero-length transfers in spi_transfer_one_message()
Message-Id: <161313851919.18278.11191076448081876020.b4-ty@kernel.org>
Date:   Fri, 12 Feb 2021 14:01:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Feb 2021 19:08:20 +0100, Nicolas Saenz Julienne wrote:
> With the introduction of 26751de25d25 ("spi: bcm2835: Micro-optimise
> FIFO loops") it has become apparent that some users might initiate
> zero-length SPI transfers. A fact the micro-optimization omitted, and
> which turned out to cause crashes[1].
> 
> Instead of changing the micro-optimization itself, use a bigger hammer
> and skip zero-length transfers altogether for drivers using the default
> transfer_one_message() implementation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Skip zero-length transfers in spi_transfer_one_message()
      commit: b306320322c9cfaa465bc2c7367acf6072b1ac0e

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
