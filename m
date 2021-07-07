Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870CB3BED7B
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGGRzq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 13:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhGGRzp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Jul 2021 13:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7FF061CC8;
        Wed,  7 Jul 2021 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625680385;
        bh=aKtoyq39pwOFvKizStL8iuukOUTJ5NuFgMltK2HgDiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OY53sILXhAvfRyQejsUdKhzpBmfSR9fBuNRCoRm5tW6wj+I5tQRV2pbCN3ZIoOBZM
         MONkF8l7MuZTcUqjhXr82DdTlkTFCxjdu+CeyQ7oo1LOTF5fIE4+UOTLGKyM8fGdJ1
         CaTxvrmqF/GqjHIZQRD207dpAAyV0nW/9T8x60QEgZtRbGemWvBjHB0cBXc4IMWgu2
         TJiGki/m5UWUO8dW/alxhfD+snFYub/ltgOlHPgyW9+lB2UvpridBW8CkiHIl2XkGK
         +yF7c7lVHlwAMZ5HgUBDIsBVg8ZHqT1j0V4aDW7qcjdqkcVM6MdPKJrs1dFmBirCAM
         Ns0SVGDhvxUrA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
Date:   Wed,  7 Jul 2021 18:52:31 +0100
Message-Id: <162567934678.18850.1622229665696547684.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210703022300.296114-1-marex@denx.de>
References: <20210703022300.296114-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 3 Jul 2021 04:23:00 +0200, Marek Vasut wrote:
> Since 00b80ac935539 ("spi: imx: mx51-ecspi: Move some initialisation to
> prepare_message hook."), the MX51_ECSPI_CONFIG write no longer happens
> in prepare_transfer hook, but rather in prepare_message hook, however
> the MX51_ECSPI_CONFIG delay is still left in prepare_transfer hook and
> thus has no effect. This leads to low bus frequency operation problems
> described in 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK
> operation at low speeds") again.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
      commit: 135cbd378eab336da15de9c84bbb22bf743b38a5

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
