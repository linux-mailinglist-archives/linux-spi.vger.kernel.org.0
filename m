Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCA33F152
	for <lists+linux-spi@lfdr.de>; Wed, 17 Mar 2021 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCQNl6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Mar 2021 09:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhCQNlm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 17 Mar 2021 09:41:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8340464DFF;
        Wed, 17 Mar 2021 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615988502;
        bh=YbODQsKROeQrRlteUONt+KwDn47LMp1qB7GsHBk2lgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOu55MoQzWIg3Nu0N4Wv+q/7hPk73dAZqw9OhLzaG27UHmxhyNi5Jztozo3TL/oUH
         njmmHxt/tu3RVSIIhpyvE1UPtkkySVTpdmhQixxhjoXWlyUcD3gQpuKK0C/MFYuqyu
         qqQcl8zv9vNTkRuTKp14WMx9OUVG2wJE83H2rwwdsMYYgIQocGjbyShDh98p1Uj9+k
         w/OvOVM9kxayUxU1SRj48TPU1eyffCIhrQeXLH5knm04pfLl82lmK22kwD6XG2t++o
         9Uf0r4ANB2YDa490REENGT29keNzpxVd/BjwGzwC3liczLBwjUbHKxibiA2iuyXXfF
         X8fMmlgshITgw==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] spi: Fix spelling mistake "softwade" -> "software"
Date:   Wed, 17 Mar 2021 13:41:36 +0000
Message-Id: <161598843909.8643.16208027141094463560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317093936.5572-1-colin.king@canonical.com>
References: <20210317093936.5572-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 17 Mar 2021 09:39:36 +0000, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix spelling mistake "softwade" -> "software"
      commit: 9d902c2a9a258e1e17cfcce7ea558b1c427b2757

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
