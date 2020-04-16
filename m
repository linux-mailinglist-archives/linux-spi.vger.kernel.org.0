Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A71ACB39
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442537AbgDPPpD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 11:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442532AbgDPPo6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 11:44:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9AF20732;
        Thu, 16 Apr 2020 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587051898;
        bh=+Vay01ywk95oY8ZaSD/jO0QAJ43NfYaz6kW2ziIsFGY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yK0s4s6mg0QYX8WHzD/cvpNZLZ2rKEvkFqJvCkNTbTPXzWfbaCk5gzGJ+tPBbFidf
         R3UR6Mqy6l6Yf8OH2dQrpk0OkSYYEuwb58xOSs7pQ4gsobWH9i6nv99ZYBeN4LEGO1
         wum2wRN70qqv7pE3uhnU39LqBHQmeaW23WnqUZ/s=
Date:   Thu, 16 Apr 2020 16:44:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200416101835.14573-1-geert+renesas@glider.be>
References: <20200416101835.14573-1-geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] spi: spidev{,_test}: Add support for Octal mode data transfers
Message-Id: <158705187475.53607.1496662320898233112.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Apr 2020 12:18:33 +0200, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch adds support for Octal mode data transfers to spidev and the
> spidev_test tool.
> 
> Note that this was not tested with Octal-capable hardware.
> 
> [...]

Applied, thanks!

[1/2] spi: spidev: Add support for Octal mode data transfers
      commit: 66ec7b3bc9c043518da828cd84aefe6242943a97
[2/2] spi: spidev_test: Add support for Octal mode data transfers
      commit: 896fa735084e4a9160f8f17d75d2899fb38a6215

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
