Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41C41F89A
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 02:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhJBASc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 20:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhJBASb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9C6161A02;
        Sat,  2 Oct 2021 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133806;
        bh=mmDjWWi+TkT/WSERjV05zbbQ8vJ54Y+MPbjST5V3/bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESapNYJo380amxE8fyDJ8oeFNL1ir6rqc9SXrv7VFTnOYqVbGuu4rVWiMLKDKIpnX
         meCnvTayveV2a/d6gy+GR47kgaxVrtKVMS5BRmUfgyWklVNeCg2zCpyOPo0DtS0J78
         GAYPI0Pxa6as7ipcqI92XM+TGIaIexofEpMmQeFpCqN1i6TtNjqaplhitLtGgWrg3z
         WuzQ4YnwnNKnWJ9xodRPo2eLUzDYk6lM7J/Abf+JjE60MiRRyKPJJB+2keFtoqzPFO
         tjLnFE/7Oh9uEUnJNCLm06dcNIYdKiVW0dioq/8CIZENVAd4uVSwT4mdX//WKS74gV
         0Z09qqnTWRScQ==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        Ville Baillie <VilleB@bytesnap.co.uk>,
        ludovic.desroches@microchip.com
Cc:     Mark Brown <broonie@kernel.org>, dan.sneddon@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Date:   Sat,  2 Oct 2021 01:16:25 +0100
Message-Id: <163313375301.13893.52482775381403027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a86bf8dcf3154f6bbf7e1ae21c073ea1@bytesnap.co.uk>
References: <a86bf8dcf3154f6bbf7e1ae21c073ea1@bytesnap.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 17 Sep 2021 07:46:11 +0000, Ville Baillie wrote:
> From 7f796c2004407f848f9ed97f406e24b9eadd74be Mon Sep 17 00:00:00 2001
> From: Ville Baillie <villeb@bytesnap.co.uk>
> Date: Thu, 16 Sep 2021 14:16:46 +0000
> Subject: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
> 
> Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
> method") refactored the code and changed a conditional causing
> atmel_spi_dma_map_xfer to never be called in PDC mode. This causes the
> driver to silently fail.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Fix PDC transfer setup bug
      commit: 75e33c55ae8fb4a177fe07c284665e1d61b02560

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
