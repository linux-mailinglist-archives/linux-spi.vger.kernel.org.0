Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E271E2762
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEZQqJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 12:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZQqJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 12:46:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C409207D8;
        Tue, 26 May 2020 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511569;
        bh=T9Ezc7a1r4TivHOwjldsbyoxjBD6NDs54wx5Hd/nAUw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=icoQ2hIogxa6UBGwFV5F6Lcz4MR1dDM/ZWl1u4SPtQsRaFSXt5aMAKLJqLc67uLYc
         utHegEFlgjwO7vGIMkGBpBDlU4mj1A+mrfSSFObTmrMphWbdqAjCvtfD3SNZpuykRk
         mREjprM+g/wX37zzFT5QafmEVZY9HO62nMp+7xSA=
Date:   Tue, 26 May 2020 17:46:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200523133859.5625-1-dinghao.liu@zju.edu.cn>
References: <20200523133859.5625-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Fix runtime PM imbalance on error
Message-Id: <159051156064.36444.17809778699218535545.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 23 May 2020 21:38:59 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Fix runtime PM imbalance on error
      commit: 8d728808194a12186ce5af0b72c8a47b42476bc3

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
