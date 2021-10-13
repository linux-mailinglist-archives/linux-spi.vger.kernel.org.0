Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14AE42CA7F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMUCB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 16:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJMUCA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCDDE61168;
        Wed, 13 Oct 2021 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155197;
        bh=guV5k9aRybh4NsBcwDg2U/suiOr6a2BSJY5RxnvN/OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQigam4uttKRwDjxtLwPKF8ogiobyz3lz86MsUhZmESU6mkOVS7jK6igZsQJ6Kqtg
         mlYvdoSt5qSzL2LdhnWE1hA66JtqLPfWJBtDC4dfCJDzzrZX1eEEJOSFBOwGK8VtBa
         K7KoWzWXZOQia4naJr0Eat9znE1uoWGqDLwzU3eGW1uj2C3jdyhBnmc/8tJOsK2OOo
         ABxxqzrJtAmdmjFAliiq0IboE2eP+CA9KqunC0P1EvCiQPfxhq8LoVcScbESUoeVPC
         OhqHbN1SEvf9R16Y7+/1DBMYeL9D6WlR+6CI2YFz7tV5HAntgCG8C8B8dWM7tTTwSs
         BQMrX3bRwv5ag==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Apurva Nandan <a-nandan@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH] spi: cadence-quadspi: fix dma_unmap_single() call
Date:   Wed, 13 Oct 2021 20:59:45 +0100
Message-Id: <163415517425.1358430.1757429758117005137.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013144600.2378037-1-arnd@kernel.org>
References: <20211013144600.2378037-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Oct 2021 16:45:55 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are separate constants for the dma-mapping API and the dmaengine
> API, mixing them up causes a warning in some builds:
> 
> In file included from drivers/spi/spi-cadence-quadspi.c:12:
> drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_versal_indirect_read_dma':
> drivers/spi/spi-cadence-quadspi.c:950:55: error: implicit conversion from 'enum dma_transfer_direction' to 'enum dma_data_direction' [-Werror=enum-conversion]
>   950 |         dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_DEV_TO_MEM);
>       |                                                       ^~~~~~~~~~~~~~
> include/linux/dma-mapping.h:407:70: note: in definition of macro 'dma_unmap_single'
>   407 | #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>       |                                                                      ^
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: fix dma_unmap_single() call
      commit: d9c55c95a3eac8536fbc6ef39dee69d3716aeee2

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
