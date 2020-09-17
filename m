Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF60F26E503
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIQTFp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 15:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIQS7Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43684221EE;
        Thu, 17 Sep 2020 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369147;
        bh=CwPFDpeGZ7s3PDVG9JY+RFjjpHuVL86kwUgyhbBQP1A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OpuTuV5WI4tEO6rsS7ufsvi3e3V0SDRcrc+LQNZyqsP3ufIdK6rkyGjJ6nyUFWVfT
         ZjZU8kqtzcbwc9BBIgHN8IQSOW7Z3UlnQ18O59SFEgYCO14oMu3Wdft5syW708Nucj
         YxksC805W7RweduiMwzMuNrIIpJjbqLzrxLkDhAE=
Date:   Thu, 17 Sep 2020 19:58:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>, linux-spi@vger.kernel.org
In-Reply-To: <20200916101042.21860-1-song.bao.hua@hisilicon.com>
References: <20200916101042.21860-1-song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] spi: lantiq: remove redundant irqsave and irqrestore in hardIRQ
Message-Id: <160036909795.20353.11646112561416430259.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Sep 2020 22:10:42 +1200, Barry Song wrote:
> Running in hardIRQ, disabling irq is redundant.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lantiq: remove redundant irqsave and irqrestore in hardIRQ
      commit: 7349201d9dfe0420489aa551c2dcc80fd6364799

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
