Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962F3A6F85
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhFNT4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 15:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhFNT4a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3678C611EE;
        Mon, 14 Jun 2021 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700467;
        bh=uYSb6i6xWcdo2crsGhUalmIeQ/J0nRJkM9GD0E2xNng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJRmo7eZiB0eMmwUjEviy5GQji0jZxzEl6HhefwrMwS5t+lc7hgQwNVkrjpqKI06L
         QJnM/QRru34D5W1/lndMziL7G7mGob9GvwnzWR5Uwdi2uocKahZVKp4v7sEfmdeZss
         g8pKVp63XnRyBHcnPLaKUVIL+URut9ON536mZnyMWc5wRc0BA0OwFdcjyGdnnKHx1j
         flNT0dHr3DOL/08ORYu3auT+V6i0RvWmLLCvwruvbOjbpsRgA2s1Y6UUCP/qTbL1gV
         TGM1/rgRgBpZjOJuw/SVctDi4KFFWoK4lwTBT62ZefAPkYhZMgDxkykBSQaufm1JSh
         pZyHE+X9WOArg==
From:   Mark Brown <broonie@kernel.org>
To:     ashish.kumar@nxp.com, haibo.chen@nxp.com, ran.wang_1@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, yogeshgaur.83@gmail.com,
        linux-imx@nxp.com, linux-spi@vger.kernel.org, han.xu@nxp.com
Subject: Re: [PATCH] spi: spi-nxp-fspi: move the register operation after the clock enable
Date:   Mon, 14 Jun 2021 20:53:34 +0100
Message-Id: <162370043177.40904.9243267469890500156.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623317073-25158-1-git-send-email-haibo.chen@nxp.com>
References: <1623317073-25158-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Jun 2021 17:24:33 +0800, haibo.chen@nxp.com wrote:
> Move the register operation after the clock enable, otherwise system
> will stuck when this driver probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-nxp-fspi: move the register operation after the clock enable
      commit: f422316c8e9d3c4aff3c56549dfb44a677d02f14

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
