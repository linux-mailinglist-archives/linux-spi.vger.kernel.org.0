Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54B1E8978
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgE2VGY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 17:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE2VGY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 17:06:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F32212071A;
        Fri, 29 May 2020 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786383;
        bh=Wy32Z11enfRl2KS7dq0clcGeQmDTMJt0DxAuc8UMLDk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2FY1qCqLdddLXI3huvTHI+TN4vr16TVqR5EArwbWgK5KLDNdklkZ79ON6W5ZK2oDq
         7iA+ckpsRF/7IYOpfPng95tMXdMjjpvsv5unHGqGz/w7pB0yvU/b/cZTMKfiGSjdZj
         ZiParSY2qFWC0Sdfj0YQRfYSGRgtALYhJeGVIqbQ=
Date:   Fri, 29 May 2020 22:06:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mips@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200529182544.9807-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529182544.9807-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v7] dt-bindings: spi: Convert DW SPI binding to DT schema
Message-Id: <159078636491.21150.10991273309807336688.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 29 May 2020 21:25:43 +0300, Serge Semin wrote:
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces two DW SPI legacy
> bare text bindings with YAML file. As before the bindings file states
> that the corresponding dts node is supposed to be compatible either
> with generic DW APB SSI controller or with Microsemi/Amazon/Renesas/Intel
> vendors-specific controllers, to have registers, interrupts and clocks
> properties. Though in case of Microsemi version of the controller
> there must be two registers resources specified. Properties like
> clock-names, reg-io-width, cs-gpio, num-cs, DMA and slave device
> sub-nodes are optional.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Convert DW SPI binding to DT schema
      commit: 164c05f03ffabe36564cb8959c1fad7c56f294dd

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
