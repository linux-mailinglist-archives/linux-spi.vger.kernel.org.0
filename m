Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC839AA35
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jun 2021 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCSoB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Jun 2021 14:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSoB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07DA5613EE;
        Thu,  3 Jun 2021 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745736;
        bh=WQrPHRQ4Uy6mv7zGw5EJ9wsQksZq35+9fQzYLsvFDgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1XTFevauO+76U45l2+gkVxOyE8b+lA2ZEG8V1VwuxLFozPpkdsltBw1qcnFjAa1e
         wQCDGKOq7A4slp3QfctGw+BtbnHJQ8Zt/OQtLNvLTMBUKf+D5VcSdmgo+uj3nqUKFu
         mtiKfwRoDljhf1UoAIZN0F0cA4ehR2K4VvAXd7PJXP3l3ETy9+SYIfd2Em2DCtIHU5
         bfEsyYei9fe7c8ckUkMZQSXsFg+XukcLIFyj1K74uBQXdwUtvkp2tEgs/nFtNEQGTc
         68oIJq2uFpnlgjM4/x80vHZMoDxsDGchA4javhUp0yRGrHyXrohc0lrLEpvy2h8IrV
         C+VC2hnmQi7Aw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        patrice.chotard@foss.st.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, christophe.kerello@foss.st.com
Subject: Re: [PATCH v5 0/3] MTD: spinand: Add spi_mem_poll_status() support
Date:   Thu,  3 Jun 2021 19:41:44 +0100
Message-Id: <162274571326.15050.6494166618231849468.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518162754.15940-1-patrice.chotard@foss.st.com>
References: <20210518162754.15940-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 May 2021 18:27:51 +0200, patrice.chotard@foss.st.com wrote:
> This series adds support for the spi_mem_poll_status() spinand
> interface.
> Some QSPI controllers allows to poll automatically memory
> status during operations (erase, read or write). This allows to
> offload the CPU for this task.
> STM32 QSPI is supporting this feature, driver update are also
> part of this series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-mem: add automatic poll status functions
      commit: c955a0cc8a286e5da1ebb88c19201e9bab8c2422
[2/3] mtd: spinand: use the spi-mem poll status APIs
      commit: 8941cd8d295e40f8ea1c0a5045d6d068b8e33eec
[3/3] spi: stm32-qspi: add automatic poll status feature
      commit: 86d1c6bbae32122c5f703b2d8acccf5d4258f2bb

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
