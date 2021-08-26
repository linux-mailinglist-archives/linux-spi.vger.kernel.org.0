Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF133F89EA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHZORC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 10:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHZORB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 10:17:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5AA860698;
        Thu, 26 Aug 2021 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629987374;
        bh=DuJ2W3REU3NLJFssNU3Hkqe0EHU+JM+a4Ilo5RFXqCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5OK4Xrh544uN7uhK6/gcNaCTP6DBT/qlgPn18eJ9BFmW/20SK4b0tFv24tqdGMQh
         1oHZPMqddR1Vo3J0TMRbfponTetGbGYTRamJpVjzeCYu5ERnnjBenk71wWRACvIwYe
         rTgMAQ37Fb7e/c2mhFBdl99i8Lo7zoD6kpLnQqSYJaoTyLcG0gqk0lbPwKkUZ/oXLJ
         RGHeqDJfE8FAT8zTO/rL9zLsQ11UgMPE4mJP5TP/PyQG9GrVSnSRkU3BE83MFOhlFL
         Rzgf/sCOnn3T2rS7CFFXtQlvbhUZeQov4QMusXHXFw+OJxVQ+6NlqypzJgO3U+hjPY
         S1ksazmOusW5w==
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND][PATCH] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible
Date:   Thu, 26 Aug 2021 15:15:42 +0100
Message-Id: <162998730427.6164.15239399096939120382.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210826005930.20572-1-quanyang.wang@windriver.com>
References: <20210826005930.20572-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 26 Aug 2021 08:59:30 +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The function wait_for_completion_interruptible_timeout will return
> -ERESTARTSYS immediately when receiving SIGKILL signal which is sent
> by "jffs2_gcd_mtd" during umounting jffs2. This will break the SPI memory
> operation because the data transmitting may begin before the command or
> address transmitting completes. Use wait_for_completion_timeout to prevent
> the process from being interruptible.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible
      commit: 26cfc0dbe43aae60dc03af27077775244f26c167

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
