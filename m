Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496C1CB589
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEHROH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgEHROG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:14:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B404F218AC;
        Fri,  8 May 2020 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958046;
        bh=xJpBX49Nndw+pJN9+D6u8WDxXHkJRRUTyGdc9YJD67U=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=F1wBzsU5ffIeWVi4UPj1N4MWX38z8ebAJYZcVOgGNDcDhDGRAlR0NOdPtVRUUkJsy
         m9eFejbV+v//CJjPWT5QouhKL1L4CMrER4gRG9x7VXp2qK1N5U/Eg8Lc0RUu7uW/ja
         /kw5pr+4GSHWPvTDqYYQb/9QJq62q7yAuUyKVA1w=
Date:   Fri, 08 May 2020 18:14:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
In-Reply-To: <20200507115550.139457-1-weiyongjun1@huawei.com>
References: <20200507115550.139457-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] spi: spi-amd: Remove spi_master_put in amd_spi_remove()
Message-Id: <158895800278.30774.17228690037210292718.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 7 May 2020 11:55:50 +0000, Wei Yongjun wrote:
> The call to spi_master_put() in amd_spi_remove() is redundant and
> may causes user after free since the master have been freed by
> spi_unregister_master(), so remove it.

Applied to

   local tree regulator/for-5.7

Thanks!

[1/1] spi: spi-amd: Remove spi_master_put in amd_spi_remove()
      (no commit info)

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
