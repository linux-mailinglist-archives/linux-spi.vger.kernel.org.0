Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6606426309D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 17:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgIIPdM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 11:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbgIIPb0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:31:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBFA218AC;
        Wed,  9 Sep 2020 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665387;
        bh=iaxL3HEU+cBabmuk8z+IP+XmfUbX5MoYwJnbPV6NtJQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=anGxX1UXNy/Et78TTGsP8AaxvbA8M4nYhCYNKsBH/NlOvMei1b2I1ylRKIEYtB9w0
         XdOrisVwKh+fEE72/mhANbBGLN9zALQYlh28PIOlVmY2IUlMcCviM21oP+dOXyGXRZ
         tzwPGwkjVhjK4oSZXnl7LVuIyaSj1EKOzfXWATiQ=
Date:   Wed, 09 Sep 2020 16:29:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-spi@vger.kernel.org, Alain Volmat <alain.volmat@st.com>
In-Reply-To: <20200909094304.GA420136@mwanda>
References: <20200909094304.GA420136@mwanda>
Subject: Re: [PATCH] spi: stm32: fix pm_runtime_get_sync() error checking
Message-Id: <159966533166.54485.8003134450461101966.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 9 Sep 2020 12:43:04 +0300, Dan Carpenter wrote:
> The pm_runtime_get_sync() can return either 0 or 1 on success but this
> code treats 1 as a failure.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix pm_runtime_get_sync() error checking
      commit: c170a5a3b6944ad8e76547c4a1d9fe81c8f23ac8

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
