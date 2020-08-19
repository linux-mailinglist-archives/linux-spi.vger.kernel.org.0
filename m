Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084A4249D9B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHSMQd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgHSMQa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 08:16:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DD720738;
        Wed, 19 Aug 2020 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839389;
        bh=HL1sY9ZL/L8gEr0S6BJjZ29q12mvXZwmxKX4jRLSnsA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kFNMf5JDfQJeBUuGl7F2Nnfsm5cXg5lPpgWmV+0QE7+F5cRPJwtYl8Rk+BUHC8/Kw
         o4Ow185yzOBgBFvJTvMF0gXPetepBzYxErpM1Yu+HOGGzmCZW9QwLdEp5KO8chWH2D
         c6Zb4xClVIcx6BFOXG4s5HAnn3KKgyuE2M277QVw=
Date:   Wed, 19 Aug 2020 13:15:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200818223519.8737-1-festevam@gmail.com>
References: <20200818223519.8737-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] spi: imx: Do not print an error when PIO is used
Message-Id: <159783935793.17826.1969324810589678429.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Aug 2020 19:35:18 -0300, Fabio Estevam wrote:
> There are cases that DMA is not used and the driver gracefully
> falls back to PIO mode.
> 
> Do not treat it like an error message and move it to debug level instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: imx: Do not print an error when PIO is used
      commit: 0ec0da744bbb11ebb49790e991171a13bf114f9f
[2/2] spi: imx: Remove unneeded probe message
      (no commit info)

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
