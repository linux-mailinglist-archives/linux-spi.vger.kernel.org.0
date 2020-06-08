Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5C1F190A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFHMqr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 08:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgFHMq3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Jun 2020 08:46:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79812076C;
        Mon,  8 Jun 2020 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591620389;
        bh=ONluiJ8oQLM3qtcMZTMic/kGCf+Fn+CE/gyALIhPRjY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hpkjlgndMCdWPhv198K59q1Zxewcf3OdvqpVHp9we+1a/PQljAwRNTqUcPvnwsXO6
         TTBx5azzX9giOclzeFG4kWv+Jj97Gy4lAfLMYy/I627SNP209lpUHR44EouMURqyPn
         k/MbTA28adzGTS5KeXP9uynirHJZhP5vABS2pS84=
Date:   Mon, 08 Jun 2020 13:46:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20200608100049.30648-1-geert+renesas@glider.be>
References: <20200608100049.30648-1-geert+renesas@glider.be>
Subject: Re: [PATCH] spi: spidev_test: Use %u to format unsigned numbers
Message-Id: <159162038705.23443.2166760909334372902.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Jun 2020 12:00:49 +0200, Geert Uytterhoeven wrote:
> Consistently use %u to format unsigned numbers.
> For "bits" this doesn't matter that much, as it is "uint8_t".
> However, "speed" is "uint32_t", so in case people use "-s -1" to force
> the maximum, they would see:
> 
>     max speed: -1 Hz (4294967 KHz)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev_test: Use %u to format unsigned numbers
      commit: 9ec8ade812240f3ef553b5e8bfc74deec3f14339

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
