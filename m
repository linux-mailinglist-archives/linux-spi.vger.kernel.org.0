Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA92E66B9
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgL1QPg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 11:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504328AbgL1QPf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 11:15:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E64C207C9;
        Mon, 28 Dec 2020 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172094;
        bh=SjTOfvdTbeT9UQH8q0dC6X35wF/SUQA6aVCDZ1IiYqs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JrGt34BYsnLL+jfXvagmnPlLX4n8crGZ2/nbNt6Kd9WoEZo/Dk2yx4KKmcfNctX13
         Pim8ZxehGMjU0yvQjAdf8oID0eyApEt5EOdCjiR8uf0Qfx8tKmwKHQngcqKQMQlPcz
         PbdYqH64kC4WBRIKF3vh33GfbvH1ntOQ95Nyjj89ufvEvYRt3n8dJhWxK2iAm1hT4D
         YV8ZezNNybEzBXhEcanfDf7JNEYaAxhX42iywnpr9wLYajkbBj9iX7s61RFzWoPXL6
         aRcAmdzwzuW4GoOhQ1i1VDEeQnIwlwbNMLI+iQntKkUGXK0zrWmYuPzYyEkDfgxOgL
         V7IbQzZBWEFjg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        andy.shevchenko@gmail.com
In-Reply-To: <20201221152936.53873-1-alexandru.ardelean@analog.com>
References: <20201221152936.53873-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v6 1/3] spi: uapi: unify SPI modes into a single spi.h header
Message-Id: <160917206867.51989.3925365729353031411.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:14:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Dec 2020 17:29:34 +0200, Alexandru Ardelean wrote:
> This change moves all the SPI mode bits into a separate 'spi.h' header in
> uAPI. This is meant to re-use these definitions inside the kernel as well
> as export them to userspace (via uAPI).
> 
> The SPI mode definitions have usually been duplicated between between
> 'include/linux/spi/spi.h' and 'include/uapi/linux/spi/spidev.h', so
> whenever adding a new entry, this would need to be put in both headers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: uapi: unify SPI modes into a single spi.h header
      commit: f7005142dacea1769fba0152c493aaa61b33205c
[2/3] spi: Add SPI_NO_TX/RX support
      commit: d962608ce2188a1d46ec9d356d6fad5cd6fc0341
[3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
      commit: ffe9819b6766b9a623822f3427df4953ab448127

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
