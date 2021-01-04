Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960BF2E9C42
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhADRmT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 12:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbhADRmS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 12:42:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAB73206B2;
        Mon,  4 Jan 2021 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782098;
        bh=DZlUi3P2nOehcJAFK3kCJp9endzedKfjdeaUrPBvfZw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DkeF9eERjOQ2YLAh4vVuWsDbOK55WIiXlgoWKLUyOudb6a1tsaI0ekUxbANMj7xCY
         cnBZIfyHVknBKE3BLtCCUPdueBnfq8qXeKcZ9Ink3IF0xKCjKZP3LUjUTVn+Dmj3u3
         BPnk+6JPONuNd+CmsFAorO4LUVqGs87CP5mf4XEyg9i0sAC4HMfK9X0i5zEqQ1kQg5
         xo2cZVzWpqs+T8Oj1wTBvQwxkYmILxJxp3hLjAphF0wsccHvMbe/pn7Dk/DzbjIeXW
         KPRvI38Zxnfgt0uO5HVgWVCRkfAP2stj4CHTJbPWw4bcc2iZYeCq7WE+bk8xOx702q
         yoBfPi6bCywxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>, linux-spi@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, lgoncalv@redhat.com,
        russell.h.weight@intel.com, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1609723749-3557-1-git-send-email-yilun.xu@intel.com>
References: <1609723749-3557-1-git-send-email-yilun.xu@intel.com>
Subject: Re: [PATCH v3] spi: fix the divide by 0 error when calculating xfer waiting time
Message-Id: <160978207205.14552.6743738820178961736.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:41:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Jan 2021 09:29:09 +0800, Xu Yilun wrote:
> The xfer waiting time is the result of xfer->len / xfer->speed_hz. This
> patch makes the assumption of 100khz xfer speed if the xfer->speed_hz is
> not assigned and stays 0. This avoids the divide by 0 issue and ensures
> a reasonable tolerant waiting time.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix the divide by 0 error when calculating xfer waiting time
      commit: 6170d077bf92c5b3dfbe1021688d3c0404f7c9e9

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
