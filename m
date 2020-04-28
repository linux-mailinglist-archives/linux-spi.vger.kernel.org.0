Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09D51BC5CD
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgD1Qww (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 12:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgD1Qww (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 12:52:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AE92063A;
        Tue, 28 Apr 2020 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588092771;
        bh=0/0dr7lgt59h1aDndEmcZ8tPFwwyq/XvxrTDDHPHfhY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GE0ill2MvHEskkxZeoOaDirspkUBA6DF1/oSgNBtHrYj7QQ0N7FHS8WLY7GNnqDm/
         c0/m93IvG1DwzCAua68i/ViClYX4x0roD+b7St3fKf+MZ4EuZ4Jcbe7ZZ9KoQM8Kg9
         +vRaaXA1YXfbjkl+GATOfIDo3xacS/qq7KPgdJBQ=
Date:   Tue, 28 Apr 2020 17:52:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Nehal-bakulchandra.Shah@amd.com
In-Reply-To: <1588049801-37995-1-git-send-email-sanju.mehta@amd.com>
References: <1588049801-37995-1-git-send-email-sanju.mehta@amd.com>
Subject: Re: [PATCH] spi: spi-amd: fix warning
Message-Id: <158809276904.31667.15808663213387050904.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 27 Apr 2020 23:56:41 -0500, Sanjay R Mehta wrote:
> remove unused variable "opcode"
> 
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-amd: fix warning
      commit: 68d047cb0a20f612506c6cf3a98e3600a7d4371f

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
