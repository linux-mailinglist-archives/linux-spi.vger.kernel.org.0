Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7D2D176F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLGRW4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 12:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGRW4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Dec 2020 12:22:56 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1607071357-33378-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607071357-33378-1-git-send-email-zhangchangzhong@huawei.com>
Subject: Re: [PATCH] spi: dw: Fix error return code in dw_spi_bt1_probe()
Message-Id: <160736172965.53398.17276094803307700525.b4-ty@kernel.org>
Date:   Mon, 07 Dec 2020 17:22:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 4 Dec 2020 16:42:37 +0800, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Fix error return code in dw_spi_bt1_probe()
      commit: e748edd9841306908b4e02dddd0afd1aa1f8b973

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
