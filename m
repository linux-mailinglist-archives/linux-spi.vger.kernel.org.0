Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EA9351320
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhDAKQr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 06:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhDAKQr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 06:16:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18AF160FDB;
        Thu,  1 Apr 2021 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272206;
        bh=7SS/q28coQNtVo7mGOuXXjbKNHD/niJXvmB6B1NFGOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQgyTylLlzHUDyMo1fE5jrfZaC9P/iA2N/W+5R40NmQfFi4U4fhm1n3MZtbq05Cr/
         pMEExeGQijARnwmFRmrYf1CrgS3zfXR22te8w9haci0jOJ1FRZ9Ge1+W0GURHT9uNf
         MbcxZL6C+mY9wQ6kiP0cMCWsI7z3WNTVNPGDwhnCFNwiaqh3FT9QvVGEBnPgmZTQWi
         fgZmsXcBpi7ckJlzXY+o5xGYPTGJ6VwCpop5jWjb6N7WqpE/JLvsgvUryuSdTGPLeT
         1xVmCfOXfsYxvekJUJCT+CieayOfPz3E6gK44CAvvnmS3H05OwFllrTmqy/PZoqqUG
         7edMbN1A7eE6g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxarm@huawei.com,
        huangdaode@huawei.com
Subject: Re: [PATCH V3] spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs
Date:   Thu,  1 Apr 2021 11:16:15 +0100
Message-Id: <161726952255.2486.8853737882622064782.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616836200-45827-1-git-send-email-f.fangjian@huawei.com>
References: <1616836200-45827-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 27 Mar 2021 17:10:00 +0800, Jay Fang wrote:
> This driver supports SPI Controller for HiSilicon Kunpeng SoCs. This
> driver supports SPI operations using FIFO mode of transfer.
> 
> DMA is not supported, and we just use IRQ mode for operation completion
> notification.
> 
> Only ACPI firmware is supported.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs
      commit: c770d8631e1810d8f1ce21b18ad5dd67eeb39e5c

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
