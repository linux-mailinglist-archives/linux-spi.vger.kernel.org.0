Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1C3E7BFC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbhHJPUv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 11:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241851AbhHJPUo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 11:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CB7960F13;
        Tue, 10 Aug 2021 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628608820;
        bh=OVckzb/m+ZougMoYM30K8HbSf93MLAOD0SvTvtYFDrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HItbALSTuVpy0rIXDmHAIugcuC14X2XIlKi0yWU2OSBX5v+onDw76B1jbMLFCGDdi
         s/JMx7G5npjIS0BGdLBrmG6exCN8FbVykS6OgktTUGT5lAv/VYYm2enAWb0LxNSZev
         a8Ie/tclPSjuob79EjV3wpEGpis1p2wtoCRfWt5okbVJDNiSDcHtjij6QY9GVehzD0
         1JXlgiLprbQUFoYARMBo+VRs4d1BDHd83rjzYJOAawxVxr6ZYdF2NaOWEyVJYZbA8I
         4FnjoCBH6oSUjFog6ZM0Onbw6IsHRiDHDxW6ueyTKrKETyC9Dxk69CZgNpKrLa5srS
         iZkw/6i1DI5aQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: Fix issue with uninitialized dma_slave_config
Date:   Tue, 10 Aug 2021 16:20:00 +0100
Message-Id: <162860634017.6228.8342307288968790170.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810081727.19491-1-tony@atomide.com>
References: <20210810081727.19491-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Aug 2021 11:17:26 +0300, Tony Lindgren wrote:
> Depending on the DMA driver being used, the struct dma_slave_config may
> need to be initialized to zero for the unused data.
> 
> For example, we have three DMA drivers using src_port_window_size and
> dst_port_window_size. If these are left uninitialized, it can cause DMA
> failures.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-fsl-dspi: Fix issue with uninitialized dma_slave_config
      commit: 209ab223ad5b18e437289235e3bde12593b94ac4
[2/2] spi: spi-pic32: Fix issue with uninitialized dma_slave_config
      commit: 976c1de1de147bb7f4e0d87482f375221c05aeaf

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
