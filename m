Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAB2C4190
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 14:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgKYN64 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 08:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKYN6z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Nov 2020 08:58:55 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4243206F9;
        Wed, 25 Nov 2020 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606312735;
        bh=o7d9fgU6mXGwYGbLFIRYfmgfnb1HDJ7zjumgwpqARWY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aQ6aa79R8DU5b7+nisqI1fjMhRLxU0cT2zvnWXEnMs6Omaq1SeGuiZ/lt6L0LUM9Z
         dhRKwvyj/K37RZkarmhvHFa+PeFLZJXyiJeJfiOro1W+P6ZJAQTQOCbMvJAfPhlimn
         R8pdUWCXWhdFJ3eURsdXRVo6haUvVR1T22fbCYfI=
Date:   Wed, 25 Nov 2020 13:58:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20201120213414.339701-1-lars.povlsen@microchip.com>
References: <20201120213414.339701-1-lars.povlsen@microchip.com>
Subject: Re: [PATCH] spi: dw: Fix spi registration for controllers overriding CS
Message-Id: <160631270511.29611.7697782706321282080.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 20 Nov 2020 22:34:14 +0100, Lars Povlsen wrote:
> When SPI DW memory ops support was introduced, there was a check for
> excluding controllers which supplied their own CS function. Even so,
> the mem_ops pointer is *always* presented to the SPI core.
> 
> This causes the SPI core sanity check in spi_controller_check_ops() to
> refuse registration, since a mem_ops pointer is being supplied without
> an exec_op member function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Fix spi registration for controllers overriding CS
      commit: 0abdb0fba07322ce960d32a92a64847b3009b2e2

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
