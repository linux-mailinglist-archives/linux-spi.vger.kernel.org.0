Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2E311229
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhBESgm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 13:36:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhBESfN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 13:35:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B795564FDC;
        Fri,  5 Feb 2021 20:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612556217;
        bh=L89irc7kubpj8fG6KjNnFLp+C8E3d91kIby1JkgGdVw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RMJWBHUtcxFaPY/CKkHCfLqlkXdvHFzoZPtkRpKDvwAMgaOqN75fl2RKBudGqFQK5
         TPMFoX674ae4V1E+yr+3Ipb1tLIA3a0HfSUWjuzdwZM6eImml16bJ/BLzE/kagW5n0
         HeP+rsAFae6whB/Ju17J/LgrMDaRYRaPQxedKto4bBb87kSiZInOo6xfLPi5ILT0f4
         eNWgEGvYpqLh5enGNsL4UoRO1wEbU+ovfplAY0Byf5gec+rnkb8WHrWkX3SU7ynb0G
         U1sBrwucKnyUxeU/e+6dvGLyFMGzeiHPLQUVnF2qdGNvUgTYBYfEafp0hfagUf4gkm
         Bs/WVTLHvqaKA==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        fabrice.gasnier@foss.st.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com
In-Reply-To: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
Subject: Re: (subset) [PATCH 0/8] spi: stm32: fix and enhancements for spi-stm32
Message-Id: <161255616019.56748.10125284929138523865.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 20:16:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 5 Feb 2021 12:08:54 +0100, Alain Volmat wrote:
> The serie provides a fix for the spi-stm32 driver, allowing to properly
> handle 0 byte transfer (and thus being able to run spi-loopback-test).
> 
> In addition to that, important enhancements are implemented, among them,
> supporting transfer larger that what the IP can setup in one go or
> allowing to use the SPI bus without cs_gpio.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/8] spi: stm32: do not mandate cs_gpio
      commit: 8f8d0e3e33e36ba63416cad64b9a9ad6b0129eed
[3/8] spi: stm32h7: ensure message are smaller than max size
      commit: 084de5232820c9e857ccc2282c3d94f33f92a381
[4/8] spi: stm32: driver uses reset controller only at init
      commit: 1c75cfd53e213044523141b464eb06813e39ecea
[5/8] spi: stm32: defer probe for reset
      commit: c63b95b76e69b679b9b95014552db099eb77a4fa
[6/8] spi: stm32: use bitfield macros
      commit: 5a380b833ad437123dca91bf900a696709d9b6ab
[7/8] spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC
      commit: e1e2093b16cb1cefe4dc483b00e73d1333260784
[8/8] spi: stm32: make spurious and overrun interrupts visible
      commit: c64e7efe46b7de21937ef4b3594d9b1fc74f07df

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
