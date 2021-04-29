Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAC36EEAF
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhD2RRL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 13:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240894AbhD2RRL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 13:17:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C939461453;
        Thu, 29 Apr 2021 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619716584;
        bh=Bs2DkvTjvBhYZrCWK9wUuP3xTjP49b6oGWKDrTsofZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiYRwEZcvzd9yjZyGyOFHYtyv34FaaejXuZoK6roYnvJLPMXzbXL8XWHmium0A3Cv
         azHzmg+fCzc9oh7hEusXV0foeFK+CkPGoefMA7kxU1b+IIAWFcs11Dy2yrisGDvFf3
         kiJbbfNFwUs8WqC3jUu5q14aVW4Zb6e/63S2JXtt3P7hCFx95ZzgbfSQzlRTFGwJBC
         dYykW+GnqTkpqIQ1WU2tw5os8K0ntkJBzi/l5qZ7o/HUxYCHEtHbs37YkexuyxADJI
         8r5fyLzrK7gSJ06fbwrMK924seXYa7SYF4qMRmuHU3lHlhUOxFLL6xlfBBqx2Saszf
         8ewIfdVM8SrBg==
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2]spi: spi-zynq-qspi: Fix stack violation bug
Date:   Thu, 29 Apr 2021 18:15:49 +0100
Message-Id: <161970928183.41765.11956133765398420405.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
References: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Mar 2021 04:24:44 -0600, Amit Kumar Mahapatra wrote:
> This patch series fixes kernel-doc warnings and stack violation
> issues in Zynq qspi driver file

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
      commit: 121271f08809e5dc01d15d3e529988ac5d740af6
[2/2] spi: spi-zynq-qspi: Fix stack violation bug
      commit: 6d5ff8e632a4f2389c331e5554cd1c2a9a28c7aa

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
