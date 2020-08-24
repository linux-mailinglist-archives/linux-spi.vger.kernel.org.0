Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673FF24FEFB
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHXNdx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 09:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgHXNci (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA123206B5;
        Mon, 24 Aug 2020 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275953;
        bh=OkM1CgobEPEgoXlFv1ir40pY8SmpwF/0RPyzxTAy2fY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zzU2yVPEyJ3hJVbI9BbeilshR37bgjIEFj9+eNsYOGjWshVoXHQmHwv1gCbJBm5Os
         ZLzeIO6t0XFExymqIbR4M2DgMyFaHU0l7YF5WR3/AHviUHiq7GmHJ+P26PWuhNw/AC
         WJHZU//vCnVxmkc+Fp7XATPcNLsL0dsIn8fkPlu8=
Date:   Mon, 24 Aug 2020 14:31:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200821213753.3143632-1-olteanv@gmail.com>
References: <20200821213753.3143632-1-olteanv@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer for spi-fsl-dspi driver
Message-Id: <159827591891.48232.12411148869647579934.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 Aug 2020 00:37:53 +0300, Vladimir Oltean wrote:
> Since I've introduced a fairly large diff to this driver since tag v5.4,
> I would like to avoid breakage for my use cases by getting a chance to
> be copied on newly submitted patches.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: add myself as maintainer for spi-fsl-dspi driver
      commit: 3cb5fcf1f3a5dfb7bc0305bb15971db04a0e51d4

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
