Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9AA30FDCB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbhBDUHs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 15:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239610AbhBDT42 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Feb 2021 14:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A43E164F53;
        Thu,  4 Feb 2021 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612468547;
        bh=oCAfEDqK5fhG/0SFPnrM86Z/CklCFpIuJ5gAUVjlhd4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=LN+C4ZMSwWEvZW8ys3PDw9XZfwxXlQ4VyyPl43G8vVFx5/mcCGm7AQfoF4uFe/fjD
         IOdr76Lz14zA7ICcFDQ0+4/HQ2dYZY3jHLhmSCyjln7FOU8rGU1Am+Z+gdLWhUJIbg
         A4Ti3vnV2PgCo0CAMgLSULBM362U2vRK5G5t3DXSD+2+1kcJIhZCVi8hvO5JNQsDVe
         41a/CM1fLjnj2dl2NDscoswvWJOd6HcxwgRjBf28ywr4KRWO9zcKGe4+xhDIP6pSJf
         f9gnJAx9wnAF/Dkv3eaqs7+W3/KvVdBjAaCPQZbmndQDHwENPCduhTfIAHG2X17ykP
         sg7vZUsnJhzeA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, Bert Vermeulen <bert@biot.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20210120135928.246054-1-bert@biot.com>
References: <20210120135928.246054-1-bert@biot.com>
Subject: Re: [PATCH v5 0/2] spi: Add support for Realtek RTL838x/RTL839x SoC SPI
Message-Id: <161246849215.26351.5239275196969035314.b4-ty@kernel.org>
Date:   Thu, 04 Feb 2021 19:54:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Jan 2021 14:59:26 +0100, Bert Vermeulen wrote:
> v5:
> - Changed SoC compatible to list exact models
> 
> v4:
> - Added SoC series-specific compatible matches.
> 
> v3:
> - Added cpu_relax() to busy loop.
> - Dropped .remove callback from driver struct.
> - Use (variations of) realtek-rtl as prefix.
> - Dropped Kconfig entry, and use MACH_REALTEK_RTL setting to build the
>   driver, since there's no point booting without the SPI-connected flash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
      commit: 6acbd614c2c8d3b8de5fb7605d6e24b9b3a8a17b
[2/2] spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI controllers
      commit: a8af5cc2ff1e804694629a8ef320935629dd15ba

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
