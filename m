Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896A239E6FD
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 21:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFGTCx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 15:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFGTCx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Jun 2021 15:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77137610E7;
        Mon,  7 Jun 2021 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092462;
        bh=q/6zCxs7z1agffzeSnodIVy/QqCZoMUeb1yXDuUqJ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBDp3IwmxoV71mITERLUOPS3ReZcgGZok0EjnmWmwHUPoEHYvAY6l2eLdp84m99kV
         3oBdfiv+kKS3xoFTD81w9M9VYENegn+Xj/MVUtB6Me2h+1vNTVCmtI/riJtpFmAuCi
         d/tQ0o2+TZKWl4uIctFJRjSJSaWwBPt0bnt1AbD8uwvqJwLqw+nxMVu2JIxGkMw8fT
         5+gtfeU5MViX3o3ZIeQkOxIwKOF6nTHK/Orc9yj8z/S8UPAqaUUywWAGVmusgIhSD2
         IPcEPLn2+zTpO7ZQMo12cVwW94QUUG7VmBKUCzHiNG6694ZT8K5U6PRc7nh0Qs7oGa
         JxSYJQdDSArBg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, huangdaode@huawei.com
Subject: Re: [PATCH] spi: hisi-kunpeng: Add debugfs support
Date:   Mon,  7 Jun 2021 20:00:40 +0100
Message-Id: <162309242715.30805.13917758606581747697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622789718-13977-1-git-send-email-f.fangjian@huawei.com>
References: <1622789718-13977-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Jun 2021 14:55:18 +0800, Jay Fang wrote:
> This patch uses debugfs_regset32 interface to create the registers dump
> file. Use it instead of creating a generic debugfs file with manually
> written read callback function.
> 
> With these entries, users can check all the SPI controller registers
> during run time.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Add debugfs support
      commit: 2b2142f247ebeef74aaadc1a646261c19627fd7e

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
