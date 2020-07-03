Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5838213DEF
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGCRDl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 13:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgGCRDl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825DF2088E;
        Fri,  3 Jul 2020 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795821;
        bh=TMsvGHoZlNUpgbQCx+dUh8VO72CCtcWXZqXqzz1pl98=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nd424xnrD9vumRxF29mODAMvAwivMYJPIliAjueQ3dn4Iw1qRjIDwnb3BqM+sGhcJ
         QI40CsUOtIA0oM1XbVaJCkMI9nwp/FB2W7+Tyy2AdyPjf4SaqxBZJ7mPSlmnrXS+z1
         +r0p19yQtSiPgGVKBxEJ7ezuuncBzDKH1r3vTX7o=
Date:   Fri, 03 Jul 2020 18:03:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>, sre@kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org
In-Reply-To: <20200702134224.3750-1-nicolas.ferre@microchip.com>
References: <20200702134224.3750-1-nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Change Maintainer for some at91 drivers
Message-Id: <159379581380.55795.5132545032007461968.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2 Jul 2020 15:42:24 +0200, nicolas.ferre@microchip.com wrote:
> I hand over the maintenance of these drivers to my colleagues. Claudiu,
> Codrin and Tudor already have experience with these controllers and
> sub-systems.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Change Maintainer for some at91 drivers
      commit: c0dadd298faca771f749a01848fa86567c5afa35

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
