Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8277621AA21
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jul 2020 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGIWAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 18:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWAz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 18:00:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E45F20672;
        Thu,  9 Jul 2020 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332055;
        bh=1PFSEGc+foXXdVrYwsMwilVyDe9tohxX7XD+gWDPsIE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FTYda62CL0xkdH28OV5/tE7oANNJ4E/93Qoo4O710wZJW92OMn5yjLnLtGVwmDGXy
         k4muaEKZopJHpgolOckbmjlbJItegk8BTUWpPkLPFX2bUQFWD9pokDNuYuRyzVlqS7
         Yj2cUxtE08l4JgNoYALWYG/550IRo8QeXhbMEfwo=
Date:   Thu, 09 Jul 2020 23:00:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Colin King <colin.king@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Peng Fan <fanpeng@loongson.cn>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200709101203.1374117-1-colin.king@canonical.com>
References: <20200709101203.1374117-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] spi: atmel: remove redundant label out_free
Message-Id: <159433204447.479.12927777803570869971.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 9 Jul 2020 11:12:03 +0100, Colin King wrote:
> The error exit label out_free is no longer being used, it is redundant
> and can be removed.
> 
> Cleans up warning:
> drivers/spi/spi-atmel.c:1680:1: warning: label ‘out_free’ defined but not used [-Wunused-label]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: remove redundant label out_free
      commit: 50f06cb1dd82f13a1d3897a327dcd7963ea75707

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
