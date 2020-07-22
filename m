Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9490229980
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgGVNpl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgGVNpk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91872065D;
        Wed, 22 Jul 2020 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425540;
        bh=DJzLYVwtNuppflcaHLmw9mFMgYCtcykftb7fRjlWlm0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SzjFT3hkeqbjgRgrIoxvB1PLfyh40sXaslD8w7Wsl0SfYZ8d2whl0pn+8N0n6RXKw
         HS17B7cOSGgLykrAVrncY+N7r8AC3lADkVv0nA83exSMF1ypPwInBEgIuukWLf5hdF
         T1QAmC89EQ6180SPISoVgUrLGZHohiuGJcrpAKSI=
Date:   Wed, 22 Jul 2020 14:45:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200710211655.1564-1-shreyas.joshi@biamp.com>
References: <20200710045140.458-1-shreyas.joshi@biamp.com> <20200710211655.1564-1-shreyas.joshi@biamp.com>
Subject: Re: [PATCH] spi: spi-cadence: add support for chip select high
Message-Id: <159542550175.19884.12018594280597810727.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 11 Jul 2020 07:16:55 +1000, Shreyas Joshi wrote:
> The spi cadence driver should support spi-cs-high in mode bits
> so that the peripherals that needs the chip select to be high active can
> use it. Add the SPI-CS-HIGH flag in the supported mode bits.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: add support for chip select high
      commit: ce8e60fe4f517b3b2b1deb44cf364a9080521567

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
