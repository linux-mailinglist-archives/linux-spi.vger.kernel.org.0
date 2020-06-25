Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2220A1C8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jun 2020 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405689AbgFYPWk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 11:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404580AbgFYPWk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Jun 2020 11:22:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57EC207D8;
        Thu, 25 Jun 2020 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593098560;
        bh=f8XVlhdkzMimSNU+e5Z1dU8+6WoXdY2by+l9r5UI6DQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cinwhLQC0Ziml5cFPhQaO285gCXMEAVFSz4np2WWgevIgtV4jcA4JpocRaQ8Ic97r
         IJQMG8uSPfXgi7X1dNgR4dHTJM1JLqtouOD2EE781wsrhCtrDXGNSVPpHyYgQ5UwX/
         yu9nvOJLg0J9/vHvbCN5HaddZTS7gTYfpoXPBdTg=
Date:   Thu, 25 Jun 2020 16:22:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>
In-Reply-To: <20200625140041.745804-1-jarkko.nikula@linux.intel.com>
References: <20200625140041.745804-1-jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Tiger Lake PCH-H
Message-Id: <159309855807.31108.14136345854725277749.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Jun 2020 17:00:41 +0300, Jarkko Nikula wrote:
> Add Intel Tiger Lake PCH-H PCI IDs.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Add support for Intel Tiger Lake PCH-H
      commit: cf961fce30f8269d0c2662c48b2618005b67dfd4

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
