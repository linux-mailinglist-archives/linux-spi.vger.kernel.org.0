Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176F637A1CD
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhEKI2P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhEKI2J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CF8661184;
        Tue, 11 May 2021 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721623;
        bh=sW8t9qNlIK9OmcRLrNQOM9jF1uYptGzhQvXE6gsvRIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RViu5voKGyRNSobBICB59ZtoIWDuKa5KaaWiyuItfy1SraCfZAqh8Nc6JTSzsbOjP
         dzLdTQHdLPasSO1AerI4m1mmFaqUyrFv7kDrpFcrHgoPlav2conYGO28bykKqdxGgH
         yzlD42u7ecJEkDZltl1PsovOU/54Sqky126TClk1ywsumII0xN2SLyaD0WovrPiWjw
         GCwR1PBeLcLPMLGMhkJTZ22cdPdKCwUejZbJYpOMQgF98R0RJS8kAaQDl12n/pjWGa
         QoWFdGdcam2ZJAS/1ebiDAzBB4/lsiLwAg4+CZYu0UPp3dDWhLSl6vWaFL8G6TOV4X
         Byj0XzkiqY/yg==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, huangdaode@huawei.com,
        linux-spi@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] spi: spi-topcliff-pch: Fix potential double free in pch_spi_process_messages()
Date:   Tue, 11 May 2021 09:25:36 +0100
Message-Id: <162072071981.33404.7089523352618373174.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620284888-65215-1-git-send-email-f.fangjian@huawei.com>
References: <1620284888-65215-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 6 May 2021 15:08:08 +0800, Jay Fang wrote:
> pch_spi_set_tx() frees data->pkt_tx_buff on failure of kzalloc() for
> data->pkt_rx_buff, but its caller, pch_spi_process_messages(), will
> free data->pkt_tx_buff again. Set data->pkt_tx_buff to NULL after
> kfree() to avoid double free.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-topcliff-pch: Fix potential double free in pch_spi_process_messages()
      commit: 026a1dc1af52742c5897e64a3431445371a71871

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
