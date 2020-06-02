Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2D1EBA12
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgFBLJZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 07:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFBLJZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 07:09:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741E2206C3;
        Tue,  2 Jun 2020 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591096165;
        bh=SvnG3MX1pS2cJY3VDBImI5zNwO3nA9jNbq46CSMD4qk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QYURD/A+Jm8ez9GgU0TCA6xuj2bl0Tuj9U74fnJKivSKGmpwmKQQrQaoj9JRiA4w1
         F+tIlXT8qD4al0tCgGL0MSt8x/qqEP4sxYZ05kcUB+VTj0l/GtCTmaPrH6s6BCpMxR
         HCkDgQ1VJF+zUiuLUE/eF2aTZzX0L4Ptu5mKf9kM=
Date:   Tue, 02 Jun 2020 12:09:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        linux-spi@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>
In-Reply-To: <20200602082415.5848-1-zhang.lyra@gmail.com>
References: <20200602082415.5848-1-zhang.lyra@gmail.com>
Subject: Re: [PATCH] spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH
Message-Id: <159109616277.3792.15192935924986477544.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2 Jun 2020 16:24:15 +0800, Chunyan Zhang wrote:
> The watchdog counter consists of WDG_LOAD_LOW and WDG_LOAD_HIGH,
> which would be loaded to watchdog counter once writing WDG_LOAD_LOW.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH
      commit: 8bdd79dae1ff5397351b95e249abcae126572617

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
