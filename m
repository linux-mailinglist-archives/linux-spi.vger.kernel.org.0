Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2852B0E31
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKLTjp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKLTjp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:39:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C7C20B80;
        Thu, 12 Nov 2020 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605209985;
        bh=TEYDezBpUH8gxqPYKUmlWpNVrZP/rdjiUKdqj7I/hVY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=15RLuCaAfr86eoB68dUgJCDjND3GyT1q1HResFOMJE7iyicdFLqgrEHEKzerw0Xys
         ar5WCKvDcP5m2APVz5Ut0RwnHQOwc3FXK5RjuuVl6JU0lO7FpRqF7/zUa5rNLfRrTZ
         iEVYrVHxanYdUxc/AXW3jnIuOxohdeDFQ4XCupTA=
Date:   Thu, 12 Nov 2020 19:39:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>
In-Reply-To: <9624250e3a7aa61274b38219a62375bac1def637.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de> <9624250e3a7aa61274b38219a62375bac1def637.1604874488.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: pic32: Don't leak DMA channels in probe error path
Message-Id: <160520996935.38820.1215064738670745424.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 8 Nov 2020 23:41:00 +0100, Lukas Wunner wrote:
> If the calls to devm_request_irq() or devm_spi_register_master() fail
> on probe of the PIC32 SPI driver, the DMA channels requested by
> pic32_spi_dma_prep() are erroneously not released.  Plug the leak.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pic32: Don't leak DMA channels in probe error path
      commit: c575e9113bff5e024d75481613faed5ef9d465b2

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
