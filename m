Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEB268E90
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgINOzl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgINOxQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1888720829;
        Mon, 14 Sep 2020 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095196;
        bh=7bA7Uf4XNmR2MAh5lVxRN9Wzg8nOUry/7ZmGA2rZ4Eg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WRzD/wx2B1ra0lEhTC3oRG+WOk3NenC5UihgY79GTR6NzTAdgYZzU2+c7xcUpejLM
         hpEUaTmChA8cZXCq2hOBukexSgxC6GnLjjdAEkCsegRbYg7AtNqrsFdqy0EqqXkxyG
         tvAltjTBnyRi53hKalIkQRPLNJMYF9plUqja1MYA=
Date:   Mon, 14 Sep 2020 15:52:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        linux-spi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>
In-Reply-To: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
References: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't wait to start 1st transfer if transmitting
Message-Id: <160009511834.5702.17733666248248913789.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 12 Sep 2020 11:17:25 -0700, Douglas Anderson wrote:
> If we're sending bytes over SPI, we know the FIFO is empty at the
> start of the transfer.  There's no reason to wait for the interrupt
> telling us to start--we can just start right away.  Then if we
> transmit everything in one swell foop we don't even need to bother
> listening for TX interrupts.
> 
> In a test of "flashrom -p ec -r /tmp/foo.bin" interrupts were reduced
> from ~30560 to ~29730, about a 3% savings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Don't wait to start 1st transfer if transmitting
      commit: 6d66507d9b5507e26c5350d5a014b82c704124b8

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
