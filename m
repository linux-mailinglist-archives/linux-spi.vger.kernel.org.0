Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1A26E4EF
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIQS72 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 14:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIQS7W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71100221F1;
        Thu, 17 Sep 2020 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369153;
        bh=jgfxIwQ3buaDWwgfrTvZ/q+CtMCIqzy4zsJMZH6k0zg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rOAzfqWdN9+rFhm7LDq9dTKiu6sl7I7bzD3Ihw5ZKLGf2a4/1SyW5EX8X5isGh8m2
         oOivUXzNfuqBlmZMxBfmFsrsEA4dZYdB16MS8e7alW7ST1yvu99js2ciqAtRrbM0nT
         EcstC6m2OMB6QCZM8ZpUa1j9F4T3tATFoFNfNuiI=
Date:   Thu, 17 Sep 2020 19:58:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <ashish.kumar@nxp.com>, linux-spi@vger.kernel.org,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        linux-kernel@vger.kernel.org
Cc:     Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Varun Sethi <V.Sethi@nxp.com>, Paul Yang <Paul.Yang@arm.com>
In-Reply-To: <20200911130331.6313-1-kuldip.dwivedi@puresoftware.com>
References: <20200911130331.6313-1-kuldip.dwivedi@puresoftware.com>
Subject: Re: [PATCH v3] spi: spi-nxp-fspi: Add ACPI support
Message-Id: <160036909795.20353.12392603785811661559.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Sep 2020 18:33:31 +0530, kuldip dwivedi wrote:
> Currently NXP fspi  driver has support of DT only. Adding ACPI
> support to the driver so that it can be used by UEFI firmware
> booting in ACPI mode. This driver will be probed if any firmware
> will expose HID "NXP0009" in DSDT table.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-nxp-fspi: Add ACPI support
      commit: 55ab8487e01d18466ddf596acc7a11e8c53b2812

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
