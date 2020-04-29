Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413E1BE5A6
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2Rwl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 13:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Rwk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 13:52:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01343214AF;
        Wed, 29 Apr 2020 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182760;
        bh=ES/AC49kG70DIeBoUFCj6k0/eXWr5dZhz6D6I3bt4SM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wRyAaHr5GrGTXM5UgLJZIGl01uLgXsmF67jImQIB4jOhTJmsonSizjobNcp41Ubsc
         M/j/qsxZVe1RjDctWECoOEuEOm32HimXfyI/9cd6udD2f98MTRrMpZ97ss7wc2u8JY
         zkjYThF72UP0xDNodhG0kqbJzuo7JIsBeXaezpLM=
Date:   Wed, 29 Apr 2020 18:52:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "patrice.chotard@st.com" <patrice.chotard@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200429102625.25974-1-patrice.chotard@st.com>
References: <20200429102625.25974-1-patrice.chotard@st.com>
Subject: Re: spi: stm32-qspi: Fix unbalanced pm_runtime_enable issue
Message-Id: <158818274449.17408.18085895262432291085.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Apr 2020 12:26:25 +0200, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Issue detected by unbinding/binding the stm32 qspi driver as following:
> 
> root@stm32mp2:~# echo 40430000.spi > /sys/bus/platform/drivers/stm32-qspi/404300
> 00.spi/driver/unbind
> root@stm32mp2:~# echo 40430000.spi > /sys/bus/platform/drivers/stm32-qspi/bind
> [  969.864021] stm32-qspi 40430000.spi: Unbalanced pm_runtime_enable!
> [  970.225161] spi-nor spi0.0: mx66u51235f (65536 Kbytes)
> [  970.935721] spi-nor spi0.1: mx66u51235f (65536 Kbytes)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: stm32-qspi: Fix unbalanced pm_runtime_enable issue
      commit: be6ef160840f23d9723d9bd008ca08e864ce4745

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
