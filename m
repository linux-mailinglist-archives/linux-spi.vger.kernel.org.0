Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50C280A80
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgJAWsh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWsh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 18:48:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581E420754;
        Thu,  1 Oct 2020 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592516;
        bh=pYP7DI+yGcbscFvM4CV4Bd3lt9gUMxkhAvfyokv+EkQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fm1aOGvZ7/lWDdLWdXUtgSLCmUfdX9KBLZoAib21yB7U1EBjG8NZZp2+PIdfZp55n
         iykyB/iz2KXXOPh84bsIXXQp3/OuG7KPmLjvNwrSGIUOFF7HBB9m8Crjww5XxnAgI1
         Ls76W0eoI5aann42qf6/UdUqM96Ebtw/rT6J8J0A=
Date:   Thu, 01 Oct 2020 23:47:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>, linux-spi@vger.kernel.org
In-Reply-To: <20200926001616.21292-1-song.bao.hua@hisilicon.com>
References: <20200926001616.21292-1-song.bao.hua@hisilicon.com>
Subject: Re: [PATCH 1/2] spi: spi-tegra20-sflash: remove redundant irqsave and
 irqrestore in hardIRQ
Message-Id: <160159244787.45030.576053799968755990.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 26 Sep 2020 12:16:15 +1200, Barry Song wrote:
> Running in hardIRQ, disabling IRQ is redundant.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-tegra20-sflash: remove redundant irqsave and irqrestore in hardIRQ
      commit: 69544f2c15926379d6fb182b142e044b7378b5cf
[2/2] spi: spi-stm32: remove redundant irqsave and irqrestore in hardIRQ
      commit: e236893387f8fcace3660d7785b6fb05cf3bc209

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
