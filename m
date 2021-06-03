Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB52439AA38
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jun 2021 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFCSoE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Jun 2021 14:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSoE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B76BC613F8;
        Thu,  3 Jun 2021 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745739;
        bh=g1/r4tEGhtCj6lkdxd0L3N8YRbkPXi360LES2CfwFOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBRCnf4GPNeS8yf7UcWVMo+BtBm0a5n/daCHJ+ca3f0PNjN/ltDOrBq4a748B3brS
         tHUK8rdhchXiHTpB/OU6+PTQuqMGX++SPwIGeWHKQL9T+v9Yz6gZJdwVMZUz6bN2+L
         9vfuQ+CJQyrYLvnprtUyTZjHNDMo8mQqNO8b4+N8lWlGsyWS3mYyxAWSzHkfSAlQfG
         czb3Gs8QwJ3lWHlE7L9zq/+mCUHLRVi0+48FxWwk+ExuMDR5c6hbzjn3J+i5GEAO+7
         PS/n4KjxouY8M5WaJ1DLqvqd+sAdTqJRRZyKjsP2EjnmtYVUjVzKydcqBIIBd+MdVs
         UC9oYSOZCeuPw==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>, christophe.kerello@foss.st.com,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd()
Date:   Thu,  3 Jun 2021 19:41:45 +0100
Message-Id: <162274571327.15050.1265263305930790161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603073421.8441-1-patrice.chotard@foss.st.com>
References: <20210603073421.8441-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 3 Jun 2021 09:34:21 +0200, patrice.chotard@foss.st.com wrote:
> In U-boot side, an issue has been encountered when QSPI source clock is
> running at low frequency (24 MHz for example), waiting for TCF bit to be
> set didn't ensure that all data has been send out the FIFO, we should also
> wait that BUSY bit is cleared.
> 
> To prevent similar issue in kernel driver, we implement similar behavior
> by always waiting BUSY bit to be cleared.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd()
      commit: d38fa9a155b2829b7e2cfcf8a4171b6dd3672808

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
