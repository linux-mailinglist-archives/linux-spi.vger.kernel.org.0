Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FF1E8495
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgE2RTF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2RTF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:19:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B54B2074D;
        Fri, 29 May 2020 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772745;
        bh=VHVB3ZEMfoIWVXNsm9ILDnKy8ezRAfAuuDIi/779PI8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Hkc+ylfCfo/AEO4hHSf9XaKOsw1Py/vnQqh9Dt4ITxfxh3RF414V2yZ2GwboWfluz
         yJMbB1s6N8dEDqhtl5leOXb2KeFu+40XaHb0OChUWFrazUb621x65p9D3dLtiTRLOZ
         eDAezfM2xGi2p1RQ3giv0loFCOp0n26XvRe0hFqY=
Date:   Fri, 29 May 2020 18:19:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru,
        Liang Jin J <liang.j.jin@ericsson.com>,
        lars.povlsen@microchip.com, andriy.shevchenko@linux.intel.com,
        fancer.lancer@gmail.com, robh+dt@kernel.org
In-Reply-To: <20200527204110.25676-1-dinguyen@kernel.org>
References: <20200527204110.25676-1-dinguyen@kernel.org>
Subject: Re: [PATCHv3 1/2] spi: dw: add reset control
Message-Id: <159077271265.17043.9965324824608502053.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 27 May 2020 15:41:09 -0500, Dinh Nguyen wrote:
> Add mechanism to get the reset control and deassert it in order to bring
> the IP out of reset.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: add reset control
      commit: 7830c0ef26cb73b653c2db2f3ca7be08f44fa046
[2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property
      commit: 2604d48702fe14fb3e97701269dd5e66b392b904

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
