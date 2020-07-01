Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405062115E3
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGAWYQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 18:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgGAWYQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Jul 2020 18:24:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AF8207E8;
        Wed,  1 Jul 2020 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642255;
        bh=HguEhSuy+TQJwfPgAmeSVzUPU4XvdrCi4pUBHZc9nX0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QnDFizlnL7MCgV5wrTnsU7SP536qZzWl81Skg2dTtNoDE1mD7h8OkeeTLzU+zJIp6
         Ri5j2qRZuyWrNqSwLQASaB+PC7B8in5SjMeG/RzbZjDCQZnZgQ21GezocLLm6GZsQ8
         /DyYPtilrzyb3VVFGimpzp+hCIE2HPamV7xBCMhM=
Date:   Wed, 01 Jul 2020 23:24:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        devicetree@vger.kernel.org
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org
In-Reply-To: <9969c8a1-e6be-38a9-ced5-ce8c5ff07046@cogentembedded.com>
References: <9969c8a1-e6be-38a9-ced5-ce8c5ff07046@cogentembedded.com>
Subject: Re: [PATCH v5 0/2] Add Renesas RPC-IF support
Message-Id: <159364224814.10988.6815822575560386098.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Jun 2020 23:00:20 +0300, Sergei Shtylyov wrote:
> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC
> to be accessed via the external address space read mode or the manual mode.
> The memory controller driver for RPC-IF registers either SPI or HyperFLash
> subdevice, depending on the contents of the device tree subnode; it also
> provides the abstract "back end" API that can be used by the "front end"
> SPI/MTD drivers to talk to the real hardware...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: memory: document Renesas RPC-IF bindings
      commit: ab1c362061d92556bd96fd2c0b188f8e4223e3e3
[2/2] memory: add Renesas RPC-IF driver
      commit: ca7d8b980b67f133317525c4273e144116ee1ae5

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
