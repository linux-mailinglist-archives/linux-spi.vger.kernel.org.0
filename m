Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BA91FA4A3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 01:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgFOXls (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 19:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgFOXls (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31274208E4;
        Mon, 15 Jun 2020 23:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264507;
        bh=KW8OwXmOxLlBVkwoLa3rLCxr1DR6gy95eELwEQ1pDgc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ql0aKDmtQXUOIuKffz0vUTICCaPO4YmWqN1pHK6klPkQbOCUU15TEr2nyeFALaTVh
         usPN9UkUxAQSL5Gni4ozGpvUrCRpWs+amQ9PCP6RXC1mtUiHzvzYAYgmC9ckeDE9/q
         HsDiGA4pHX33kXURqZ2JGDb9jSgnv5iU/d4Td69k=
Date:   Tue, 16 Jun 2020 00:41:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>, linux-spi@vger.kernel.org,
        Robert Richter <rrichter@marvell.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <1590680799-5640-1-git-send-email-tharvey@gateworks.com>
References: <1590680799-5640-1-git-send-email-tharvey@gateworks.com>
Subject: Re: [RFC PATCH] spi: spi-cavium-thunderx: flag controller as half duplex
Message-Id: <159226448569.27735.14957300459470061468.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 28 May 2020 08:46:39 -0700, Tim Harvey wrote:
> The OcteonTX (TX1/ThunderX) SPI controller does not support full
> duplex transactions. Set the appropriate flag such that the spi
> core will return -EINVAL on such transactions requested by chip
> drivers.
> 
> This is an RFC as I need someone from Marvell/Cavium to confirm
> if this driver is used for other silicon that does support
> full duplex transfers (in which case we will need to identify
> that we are running on the ThunderX arch before setting the flag).

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cavium-thunderx: flag controller as half duplex
      commit: e8510d43f219beff1f426080049a5462148afd2f

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
