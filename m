Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A592B0E32
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKLTjv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKLTjv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:39:51 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B9820B80;
        Thu, 12 Nov 2020 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605209990;
        bh=3wRxF1uEpB5xoGxJcTugPFI5tcNs8hynn259ny5LDNE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=C7ObXenxZ7x4YpXzQf8IOGwcRlmBCmnuAEIyWT+9u21NfTautkbrwWl2yF3qJ9t4C
         3zJSZdk1GLMq49G9VITUT/o8vYmHGCuoPjOiiSUBz7owGmWv555xHJ0xghS9uBxWkx
         9FH0wJXovo9pJwv+KKnRPr7Vgi4xV9O/aELB0NxY=
Date:   Thu, 12 Nov 2020 19:39:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kernel@pengutronix.de, David Jander <david@protonic.nl>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20201027095724.18654-1-o.rempel@pengutronix.de>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] SPI/ Input: ads7846: properly handle spi->mode flags
Message-Id: <160520996934.38820.11231057129543889479.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Oct 2020 10:57:22 +0100, Oleksij Rempel wrote:
> changes v2:
> - add SPI_MODE_X_MASK macro
> - ads7846: clear SPI_MODE_X_MASK bits to set driver specific mode.
> 
> Oleksij Rempel (2):
>   spi: introduce SPI_MODE_X_MASK macro
>   Input: ads7846: do not overwrite spi->mode flags set by spi framework
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] Input: ads7846: do not overwrite spi->mode flags set by spi framework
      commit: 376ccca853fdb9959f7ac5185a428a9f91e71e86

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
