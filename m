Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F911B760F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDXM4t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 08:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXM4s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 08:56:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F0C20728;
        Fri, 24 Apr 2020 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733008;
        bh=ojIIWy9JMfPmCa27HaUOYJ4aM7y3il1Wr3U8tAfe1Ms=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QJnbDw300nTHFCRGaYItbiKss+Kh2oHLJKUgQn47TQ+IlgEptn8wjpY0A/AdG9cD5
         Dr4JkFq6yyqqN1dqp/69MmeOnyDPUtQe0zpqGXGoBwYrnU1ShLRrv8gDlXwV8OFe+B
         oonNabw+xoces6sFqU6ku/7jLD8Lnyjm3t58CtJU=
Date:   Fri, 24 Apr 2020 13:56:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     leoyang.li@nxp.com, Peng Ma <peng.ma@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200424061216.27445-1-peng.ma@nxp.com>
References: <20200424061216.27445-1-peng.ma@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Adding shutdown hook
Message-Id: <158773300537.30241.1154325901954580764.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Apr 2020 14:12:16 +0800, Peng Ma wrote:
> We need to ensure dspi controller could be stopped in order for kexec
> to start the next kernel.
> So add the shutdown operation support.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: spi-fsl-dspi: Adding shutdown hook
      commit: dc234825997ec6ff05980ca9e2204f4ac3f8d695

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
