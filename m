Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934211ACB36
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395235AbgDPPo4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 11:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633653AbgDPPow (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 11:44:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B382A20732;
        Thu, 16 Apr 2020 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587051892;
        bh=X9AeWYGILDr+vIqgFqvmc+ZvOyiF/SVk4CiVuC6R8Nc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=K7tOTLZiUW/77AV0LYGh+9QHxqaeu9b+fkTxqVApjFoc5o4GHdLZrGpYKXNimulDl
         UQCTeVStN7Z4K0r6chRIiJBV/unuJwI+ODv/NizaAgGa18sEf7BPW2Tt5kdEJWuZFa
         xIJtjzi6Xl96Bfhx/rMWK+z7GlxZSzCUN03Db4D0=
Date:   Thu, 16 Apr 2020 16:44:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     frieder.schrempf@kontron.de, Ashish Kumar <Ashish.Kumar@nxp.com>,
        boris.brezillon@collabora.com
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <Ashish.kumar@nxp.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
Subject: Re: [PATCH v3] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size
Message-Id: <158705187475.53607.18120556140108669367.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Apr 2020 17:13:19 +0530, Ashish Kumar wrote:
> Reduce devm_ioremap size to (4 * AHB_BUFER_SIZE) rather than mapping
> complete QSPI-Memmory as driver is now independent of flash size.
> Flash of any size can be accessed.
> 
> Issue was reported on platform where devm_ioremap failure is observed
> with size > 256M.
> Error log on LS1021ATWR :
>  fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x40000000-0x7fffffff]
>  fsl-quadspi 1550000.spi: Freescale QuadSPI probe failed
>  fsl-quadspi: probe of 1550000.spi failed with error -12
> 
> [...]

Applied, thanks!

[1/1] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size
      commit: 858e26a515c28df3ef542d9c09493b54a329d6cf

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
