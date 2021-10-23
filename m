Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77E438514
	for <lists+linux-spi@lfdr.de>; Sat, 23 Oct 2021 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJWUAa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Oct 2021 16:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhJWUAa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 Oct 2021 16:00:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D80B60F46;
        Sat, 23 Oct 2021 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635019090;
        bh=COjl22/rY2BQ/OgeeXf9s3EB7nrpB6IfxOTmSZf301M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyXTM5RLL/ZvlgR/gvrmchnEeG8NoGFEolfIWQYLMSGR6+qBJPLn4lUM5vv6MvbuH
         oK/RcoNYnh3aDf/KxcI5dERWgrdoWOlSscPUeInsFFHARpW9he4GFtaLr+1yxWOrit
         zlayhLnclawo7aVoeZPwsUlnirMWB7imxuYmJLUm76aTEfFQayWa9xCrVkmRlNsXuT
         qUPnYa0/lk7MaOS77HPy+vxUfuHCUzE1m5vCddxE9hfXSFPNdJFJVcOa5/ZVmce/ds
         4NBZpL8MYLxjlzNmn3V6/Tg/so/kLDfMCqPkvFZD2kEQvay1Yt/21rTst9FEvU/qMG
         PINDK2vc12RHQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, kdasu.kdev@gmail.com
Subject: Re: [PATCH -next] spi: bcm-qspi: Fix missing clk_disable_unprepare() on error in bcm_qspi_probe()
Date:   Sat, 23 Oct 2021 20:58:01 +0100
Message-Id: <163501903283.919250.3449151714260187451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018073413.2029081-1-yangyingliang@huawei.com>
References: <20211018073413.2029081-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 18 Oct 2021 15:34:13 +0800, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from bcm_qspi_probe() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: Fix missing clk_disable_unprepare() on error in bcm_qspi_probe()
      commit: 0204bdeb3df79a5c78d9e76119a7f04e3dcb1258

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
