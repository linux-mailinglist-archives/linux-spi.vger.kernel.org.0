Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31D1E848F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgE2RSv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RSv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:18:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB852074D;
        Fri, 29 May 2020 17:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772730;
        bh=a5S1gx+JJjYPO8/mi+Gcgzo3QS58fT7hT71d61WRYqY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fr3b99EKpWX6dNiBPw7VavMlT7GriqwmdJIPGhfIMPclSFt3svBQ+4tI6fWQ90ct2
         ux78Dcs4U0fu896v258Aup5J1T495R63lJH5K7WGmMOnz/c1jBJ+UruRGE6+O91nAG
         uKEGDpzO80C/Q23LkPLZ3VSJqY94VGd97iPWWdME=
Date:   Fri, 29 May 2020 18:18:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ray Jui <rjui@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>
In-Reply-To: <20200528190605.24850-1-f.fainelli@gmail.com>
References: <20200528190605.24850-1-f.fainelli@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: Implement shutdown callback
Message-Id: <159077271266.17043.15897964625717364519.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 28 May 2020 12:06:05 -0700, Florian Fainelli wrote:
> Make sure we clear the FIFOs, stop the block, disable the clock and
> release the DMA channel.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Implement shutdown callback
      commit: 118eb0e52eb74b899053a0f46dfe7e178788d23b

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
