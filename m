Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399D11F9B76
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgFOPGP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 11:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbgFOPGK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 11:06:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42842074D;
        Mon, 15 Jun 2020 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592233570;
        bh=32mGLgYeAMGgaRSoAeCwO7730ZOfLL8siowtJXDcS3w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sttW7DnBrwnqtFEHHwphmaaAObmg1hFSHnVXukWkqkYIppRzfCG23XTgQNWn2qrBu
         m8mPGPROszsdjoDpJhZuHRMASh80QdxppZvbh5LX9c6hGTWeCchFjXzPveYv7/0ibm
         QCexx4NsZcw9VUCRFUE7Y4KQn5P0RIAEkh0AKSqo=
Date:   Mon, 15 Jun 2020 16:06:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200613073755.15906-1-geert+renesas@glider.be>
References: <20200613073755.15906-1-geert+renesas@glider.be>
Subject: Re: [PATCH] spi: uapi: spidev: Use TABs for alignment
Message-Id: <159223356731.9113.3752587156978383062.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 13 Jun 2020 09:37:54 +0200, Geert Uytterhoeven wrote:
> The UAPI <linux/spi/spidev.h> uses TABs for alignment.
> Convert the recently introduced spaces to TABs to restore consistency.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: uapi: spidev: Use TABs for alignment
      commit: 27784a256c2a453d891c0aaff84c3ac3f2e8a5a0

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
