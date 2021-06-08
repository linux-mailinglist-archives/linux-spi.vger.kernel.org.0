Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4D39FBE2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhFHQJZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 12:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233032AbhFHQIp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 12:08:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D43E610A2;
        Tue,  8 Jun 2021 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168412;
        bh=Trne5PSLFIXdUQlc3ISX2r+nTa2XMYIx4lId5HleE10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsqEU3/KwKPr+Tnzn5dyV+0sJRiabmnEhBUFV7chlC5+70s8yTQZnRKgRn2nFuCfP
         q9Xk8B9vuJf0FMiruHXPb5SsrWDncp/w5KcdQvPcwmz5js8yKnFdCwNWdnmjVoLcbu
         ghAfsxwxJSW+APno96CNplCTxZPJhmxwas+diPY2/RA718YWkL5CH/HCiIMLik/hwz
         I3f+xFgRqaQU/Nlree4qQRLuS7wWeeT7AcB8RuAJ7iD3nzUEn1XHvusVar5Odo37NN
         82VyyarFVIbnn+W5AnGmpPd5+mtXg1bK7klZQaosx+1RnV/08GB40I2k31li30ClY7
         P2dqtnzLJjC0w==
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is deasserted
Date:   Tue,  8 Jun 2021 17:06:30 +0100
Message-Id: <162316838385.20882.12302385130544935534.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608071518.93037-1-jonathanh@nvidia.com>
References: <20210608071518.93037-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 8 Jun 2021 08:15:18 +0100, Jon Hunter wrote:
> Commit 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling
> clocks") removed some legacy code for handling resets on Tegra from
> within the Tegra clock code. This exposed an issue in the Tegra20 slink
> driver where the SPI controller reset was not being deasserted as needed
> during probe. This is causing the Tegra30 Cardhu platform to hang on
> boot. Fix this by ensuring the SPI controller reset is deasserted during
> probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: Ensure SPI controller reset is deasserted
      commit: aceda401e84115bf9121454828f9da63c2a94482

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
