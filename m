Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8802E2F6657
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhANQuA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 11:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbhANQuA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 11:50:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10D7523B2F;
        Thu, 14 Jan 2021 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610642959;
        bh=65pHwfEnxIO+KB+8lFvkgezdzPtnmMUdO//94olI6vI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jHfHFDrkdgJpDwQVRHeWH7b30XpaXrfdc82v4IFN913LRBw0YvDm28IVCZClxBv0L
         l7LUzN1ljXzazxofxAQZ5MJYb00sqpIAvYqGSdQbkHXVwUM25k+1TkkzhD66+oIAY+
         95aMx6p1Opg1xcRBLduZ/ST/jTvH2066akpcZvnzYPm8FxfNSe0uH9gWrKL13G8vgI
         d7nurpcITHiVvedCfSIF0ox6wSYRJxF8q+88fj5bLADaXXFgcjAz89kAGc5FB9TlQy
         IAFlMGOvUHhEKGTzSywqhiqlF/UlcFaM9oQKdBDF+I2un/Iqrg4UelvIF9VHwtX8v2
         QcnNQGduZPXSg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org
In-Reply-To: <6b51cc2bfbca70d3e9b9da7b7aa4c7a9d793ca0e.1610629002.git.christophe.leroy@csgroup.eu>
References: <6b51cc2bfbca70d3e9b9da7b7aa4c7a9d793ca0e.1610629002.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in spi->mode
Message-Id: <161064292109.43781.3127571598832303421.b4-ty@kernel.org>
Date:   Thu, 14 Jan 2021 16:48:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Jan 2021 13:09:37 +0000 (UTC), Christophe Leroy wrote:
> Commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO
> descriptors") broke fsl spi driver.
> 
> As now we fully rely on gpiolib for handling the polarity of
> chip selects, the driver shall not alter the GPIO value anymore
> when SPI_CS_HIGH is not set in spi->mode.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in spi->mode
      commit: 7a2da5d7960a64ee923fe3e31f01a1101052c66f

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
