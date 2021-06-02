Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E62398FBF
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 18:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFBQSx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 12:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBQSw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Jun 2021 12:18:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08EBD6161E;
        Wed,  2 Jun 2021 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650629;
        bh=hLVsttSHNzEi+OOUFgJXz3mHAnM8a7joO298eDLG5UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUVxPwi1tF0horYJ42jJh0jiJ3xFSuryfZ7HojfdnUDEOIsFrJzfxiHadD+ebRVp0
         VkTsoWU/CpIurBq+SXKpYr5/ogm+z8mWn2fji6eyV/Z7pCfA/ojoEvNvtgKAWE2lem
         4mahlmqwYVSlOZ8F0vOQV2G41T81NYkrVHMT4kbUJt9cvgzF7Iuc2h8xL4BwGaKd/x
         wjxKB6UkdF1ROwIDysf2iS7XuwhAhWbALhnFz43OdQEpu903iuH5HFtTTcjAZb6pBE
         hcz/arvZR8RWk4NfPFSNTU9XJc3t7T7La0OfLgfDcZTgCZapZN6KbIiDa85Fmg3NPR
         RTtthDsHFjLbA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, zpershuai <zpershuai@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-zynq-qspi: Fix some wrong goto jumps & missing error code
Date:   Wed,  2 Jun 2021 17:16:47 +0100
Message-Id: <162265058628.22666.9665445837542581247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622110857-21812-1-git-send-email-zpershuai@gmail.com>
References: <1622110857-21812-1-git-send-email-zpershuai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 May 2021 18:20:57 +0800, zpershuai wrote:
> In zynq_qspi_probe function, when enable the device clock is done,
> the return of all the functions should goto the clk_dis_all label.
> 
> If num_cs is not right then this should return a negative error
> code but currently it returns success.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynq-qspi: Fix some wrong goto jumps & missing error code
      commit: f131767eefc47de2f8afb7950cdea78397997d66

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
