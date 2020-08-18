Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A228D248C41
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgHRQ7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 12:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgHRQ6N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Aug 2020 12:58:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09545207DE;
        Tue, 18 Aug 2020 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769876;
        bh=q7GHGm9c21lI15iiqdFoBfoi140sZ9N2QyzIbIqI6C4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cKOOh4OLI2c9ZvpeJ9CywkkuTDEpsXeU2Ykynmr+G183gfpd/YkNCxfUVbZl32u6d
         Xgh6PvmZjBGTvndlmX1PoJS8ax/ybbEe8EsA85BnccZfzzSRqe3wAUHMQytLqw3PEv
         WZBVXO28ur/eQRiwZ42iCcW/KpT4n3OgExwXhnwI=
Date:   Tue, 18 Aug 2020 17:57:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>
In-Reply-To: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/2] r8a7742 add QSPI support
Message-Id: <159776983047.56565.6592409588140078778.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 12 Aug 2020 16:00:46 +0100, Lad Prabhakar wrote:
> This patchset adds qspi node to r8a7742 (RZ/G1H) SoC along
> with updating the DT binding.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: spi: renesas,rspi: Add r8a7742 to the compatible list
>   ARM: dts: r8a7742: Add QSPI support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,rspi: Add r8a7742 to the compatible list
      commit: 08f9793efd3decae75e60bfec2e6068f2d4180df

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
