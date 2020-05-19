Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520171D97FE
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgESNkb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 09:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgESNka (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 May 2020 09:40:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B908F20709;
        Tue, 19 May 2020 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589895630;
        bh=xgjx8xogAH731ZHJgHv7xLks1L9WzwU7sDvFVg09hJo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uFDg1pDAhWihmR/ptRncxIs+hoJV6kY491+wYa6gJs326RN1E4iVKZWfTvtRkbBrm
         NLPNWa+KRmrJXJVbs63p7EwgmGyuzfRPDMU+wxlhUJXWzv0cW/lwKntbFiqK9+Swj8
         jf9p1w6zeJG7WKvAooVh0XmH/IWx7gdAeocSSbLw=
Date:   Tue, 19 May 2020 14:40:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
In-Reply-To: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-Id: <158989562178.37683.14611239067434533356.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 15 May 2020 20:48:54 +0300, Serge Semin wrote:
> If DMAC register is left uncleared any further DMAless transfers
> may cause the DMAC hardware handshaking interface getting activated.
> So the next DMA-based Rx/Tx transaction will be started right
> after the dma_async_issue_pending() method is invoked even if no
> DMATDLR/DMARDLR conditions are met. This at the same time may cause
> the Tx/Rx FIFO buffers underrun/overrun. In order to fix this we
> must clear DMAC register after a current DMA-based transaction is
> finished.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/2] spi: dw: Clear DMAC register when done or stopped
      commit: 0327f0b881dc5645c7ba670331e822cdaa8c5e09
[2/2] spi: dw: Fix native CS being unset
      commit: 9aea644ca17b94f82ad7fa767cbc4509642f4420

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
