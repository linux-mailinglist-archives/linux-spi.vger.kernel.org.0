Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453C3311223
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 21:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhBESfa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 13:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233184AbhBESfF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 13:35:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81BD264FD4;
        Fri,  5 Feb 2021 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612556210;
        bh=TW5sax6toZxgcvGW6CkeLa+wpYzcbGpP5G0uPmTyGpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZXY+qw45N/aT6D+fdKLdJAiqeoip3CY8NPEReiTqSNjmUswblItrouOqQPxHeiOHG
         9F/74wYMTx1qfYYLXLrRSrlCpuLOEXYdC64e3ncJFmOTg1ed/FxY/1Idwd14yW7CA5
         7yD/pKofWeQfD6R+79OBJy7zatCgx9zwEOVFAvwqEDXFEHYvQ+KcsDcMzsGqIQj7uW
         35w61e9kicTU3QG6acd8Lkg644k8d5pkrn4drp63MlllkHQgPfIlSyIKXbUqWGT0+o
         y9CpZ5Zkicfm05pvzXMXga8yFLnpI9z0HL51YzczPQPSPAVLagqMK8oQWjdwt+v0h4
         AUSX4+Bjj1M+g==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        fabrice.gasnier@foss.st.com, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com
In-Reply-To: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
References: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
Subject: Re: [PATCH v2 0/8] spi: stm32: fix and enhancements for spi-stm32
Message-Id: <161255616019.56748.1388196714207020895.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 20:16:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 5 Feb 2021 19:59:24 +0100, Alain Volmat wrote:
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

[1/8] spi: stm32: properly handle 0 byte transfer
      commit: 2269f5a8b1a7b38651d62676b98182828f29d11a
[2/8] spi: stm32: do not mandate cs_gpio
      commit: 8f8d0e3e33e36ba63416cad64b9a9ad6b0129eed
[3/8] spi: stm32: use bitfield macros
      commit: 5a380b833ad437123dca91bf900a696709d9b6ab
[4/8] spi: stm32h7: ensure message are smaller than max size
      commit: 084de5232820c9e857ccc2282c3d94f33f92a381
[5/8] spi: stm32: driver uses reset controller only at init
      commit: 1c75cfd53e213044523141b464eb06813e39ecea
[6/8] spi: stm32: defer probe for reset
      commit: c63b95b76e69b679b9b95014552db099eb77a4fa
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
