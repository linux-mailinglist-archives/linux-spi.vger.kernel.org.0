Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6437A1BF
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEKI2C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhEKI15 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:27:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93B4D613CF;
        Tue, 11 May 2021 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721611;
        bh=fbL+mrDfjrI9qf9MzaJgYZbK83Y0UsK5f0jejXFbTIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beWBa9va8imOqsCzaV3R3b1SgHU/blgkz+7IA2oo3xiFwjvdYoU9Q9afOfvqXImFB
         tNz3wEbDpHZMCi/pA4LuuqHq3HkawXbgdGcJhUyEgz6NrY9fx84gQkEjCZIigG6MEP
         micJdO9JRCPMAKD2EunphRrLtnWn4Hbh7OWGcn6BO/6kQRxe2vVdFbWK/JWgeSnNiP
         suA3Mzer/Vw69xAyE/mvw/UCB+QDYt41INIxERH4KaWr11ornSR8fsptMw3yftkrv8
         y8Tm9PzY6LqAp+KkEptADxW5CBhgrwc/vfynBNIes5W3TTsk7l263zbQt2Ro5ev2an
         y6LlHB+S41rjA==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        huangdaode@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/4] spi: Set of cleanups
Date:   Tue, 11 May 2021 09:25:32 +0100
Message-Id: <162072071982.33404.13833923477423826663.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
References: <1620629903-15493-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 14:58:19 +0800, Jay Fang wrote:
> Some cleanups of SPI drivers. No functional change.
> 
> 
> Thanks,
> Jay
> 
> Jay Fang (4):
>   spi: ppc4xx: include <linux/io.h> instead of <asm/io.h>
>   spi: omap-100k: Clean the value of 'status' is not used
>   spi: delete repeated words in comments
>   spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: ppc4xx: include <linux/io.h> instead of <asm/io.h>
      commit: 66fe740317c82b0caa68ed8d756536d4ff7e910c
[2/4] spi: omap-100k: Clean the value of 'status' is not used
      commit: 856a9260e17129303102a7d4a5f71b7a8739e5b9
[3/4] spi: delete repeated words in comments
      commit: db56d03049524114696aa7158560d8f0e064c487
[4/4] spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'
      commit: 9e37a3ab0627011fb63875e9a93094b6fc8ddf48

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
