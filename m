Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30467440494
	for <lists+linux-spi@lfdr.de>; Fri, 29 Oct 2021 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2VE2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Oct 2021 17:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhJ2VE2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 Oct 2021 17:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBA4A60FC1;
        Fri, 29 Oct 2021 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635541319;
        bh=MlwnZcKiRgzEiBHOgFW2/VGDn4G5xMER7IIzb2ZL4OU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CM5Z3E+Q5LJzMBminhbfGv/FZ+poEnlyTLN5ov6iEwfA21qnmFXQoXPL4yX2/KTTB
         xVS0mg619X4khp4oPhRMDYputo4fD4Ery6IlJ3DC56pCfRcIKPdU9u/jWWXepRbH/N
         LUBlUT3bRfWGEuBlEkOrzA9ZGvdRnyRKMGcaOI0Cy3dTVQFROS3WGONaGEDRklqbkt
         wpQRjFy9dpWDmytPIHUBzfWKMng1u9lEZCTrIA0iJQ5TZHZxdhulYyaqXbXv+Jkg2g
         V0dPgtZpZFmI3wFKPityxqxeoGUPsuqM6d7pk3Pgd1sjHvER2Iam/uyI92li4Iqq8I
         gZkdQ2bkwSiBw==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211020060954.1531783-1-vkoul@kernel.org>
References: <20211020060954.1531783-1-vkoul@kernel.org>
Subject: Re: [PATCH v5] spi: spi-geni-qcom: Add support for GPI dma
Message-Id: <163554131757.1998521.12811308342203469073.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 22:01:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 11:39:54 +0530, Vinod Koul wrote:
> We can use GPI DMA for devices where it is enabled by firmware. Add
> support for this mode
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> --
> -Changes since v4:
>  - Fix the kbuild bot warning
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Add support for GPI dma
      commit: b59c122484ecb1853882986e04d00bd879cfc051

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
