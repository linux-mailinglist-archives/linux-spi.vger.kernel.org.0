Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90A9365BDD
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhDTPHi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 11:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhDTPHh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 11:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A3F760FF1;
        Tue, 20 Apr 2021 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618931225;
        bh=xNMcMUsfGio6rPsrbelG3fNcGLs63Q8YwKi3OLjPnPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+yY3Q0l9TIsa9rvbhDYFMT94L+nJvaK+YStTueNISG0ZYzsUOpstWhhUnS+jEb+E
         EaXoh2q/+iNoBAFDDZ2JXTchwWORAdOc2M86DpiuoKvuuqprHl81+ClJ0y+ux64VGi
         q6CajxjMH70EtBvTWhZnerNoclorMJdvMkGGCz+SZSJ7EalCc0bDmIRrTu4P7lvDMN
         OqckAQeyV8m7Sv3uK2w7cCUdZkAtGJkYv49ucm8UB3U4u/gGDQvIjdHg50NeAh8gdP
         lngyl6dv8JcINEB85wTiBeKx8QEkpCZV32lPbs+wpB2o1tjgQrUW3ikv28VS4160/H
         b6qhsOEIOBvGg==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        christophe.kerello@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
Subject: Re: spi: stm32-qspi: Fix compilation warning in ARM64
Date:   Tue, 20 Apr 2021 16:06:37 +0100
Message-Id: <161893071088.55669.5165788447992164184.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420082103.1693-1-patrice.chotard@foss.st.com>
References: <20210420082103.1693-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Apr 2021 10:21:03 +0200, patrice.chotard@foss.st.com wrote:
> This fixes warnings detected when compiling in ARM64.
> Introduced by 'commit 18674dee3cd6 ("spi: stm32-qspi: Add dirmap support")'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Fix compilation warning in ARM64
      commit: 1b8a7d4282c038b3846f2485d86cb990c55c38d9

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
