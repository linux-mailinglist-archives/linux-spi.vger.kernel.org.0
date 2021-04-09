Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93BA35A307
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhDIQXv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhDIQXu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B19161074;
        Fri,  9 Apr 2021 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985411;
        bh=tI7eVBrB/MCLoZhFb0CZzo3rY7WtHeLAiDdnaKfw8Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJMKlDJdDYI/HEyGe/s9/67pkNiQ1BH7my8989JCy9Da6vpYdyzJ+wGUpHIgfcSwn
         +J51TZfl9YEzbeBV8huxR3yXDzwZcfkA7nZBnMmgT8jDk0NxJ3+zTG2IGb+WE3AFtO
         PYHwtdjA051Ah5WvBc+tCyl/y4oG8GW7P/vUvJnKpxOA/EF+4uZerXgCN/E19TLRrd
         ypqVEZhc7i3niq0Y4uoaOSJB7kVoIpqiygOdpc9wtnvT3Ovx2qydZRizzTJnspKuEk
         5xV+HLBGZ/pWatSmmzGBfpNGRZQI3pVAsccx4IQKug0bmp2b14HllEcJEBhp3gmI6e
         E/ekHw11EXGHw==
From:   Mark Brown <broonie@kernel.org>
To:     xiaoning.wang@nxp.com, Wang Li <wangli74@huawei.com>,
        frank.li@nxp.com, han.xu@nxp.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: fsl-lpspi: Fix PM reference leak in lpspi_prepare_xfer_hardware()
Date:   Fri,  9 Apr 2021 17:22:44 +0100
Message-Id: <161798356988.48466.17209848169059258349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409095430.29868-1-wangli74@huawei.com>
References: <20210409095430.29868-1-wangli74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Apr 2021 09:54:30 +0000, Wang Li wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-lpspi: Fix PM reference leak in lpspi_prepare_xfer_hardware()
      commit: a03675497970a93fcf25d81d9d92a59c2d7377a7

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
