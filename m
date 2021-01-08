Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA42EF5C5
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAHQcG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 11:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbhAHQcG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Jan 2021 11:32:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9010C23A03;
        Fri,  8 Jan 2021 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610123486;
        bh=UZHtqX2avN1aYbZ2VEwMU1ZtcqGgOsud+qpCubDtJrI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SSj8041J6nOOMC6EeP34iQ8/arvh4DhlH4WnEpoCviJR2KtMp8uJ+ypDBZLlAJdus
         RBpLVoG9AvqHQg/W+MRSg8sa1iX+OnwZwQXCh4+TcYsdbKcV1YIq0VUeiiGGW5rpE+
         KHibd+6Xe1wLG3tOWLcHek7f917kINOcHA3/V0uZG4fPUKt4hI2JpSczF/A/ElCuhU
         lYnnRlP1D9sBJtxU0pLlxygZ1I/GZ6Tgz5xmgoHDx52CqggxEPnf+NhWSpmUh0YEWg
         bVWSZE5TSlGldF7wRZpUkPs/HO55ZC2APtj6UOGeFnHBeIPLpP/AKxXCRjHw3gJKSC
         ike1M/tsYK16g==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20210108103522.2025880-1-geert+renesas@glider.be>
References: <20210108103522.2025880-1-geert+renesas@glider.be>
Subject: Re: [PATCH v2] spi: renesas,sh-msiof: Add r8a779a0 support
Message-Id: <161012344969.41129.2926375483711684581.b4-ty@kernel.org>
Date:   Fri, 08 Jan 2021 16:30:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 8 Jan 2021 11:35:22 +0100, Geert Uytterhoeven wrote:
> Document R-Car V3U (R8A779A0) SoC bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: renesas,sh-msiof: Add r8a779a0 support
      commit: 6be69293196c1700de2df3b32417c6eda2b12009

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
