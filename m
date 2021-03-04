Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D752632D97C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCDSdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 13:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhCDSc4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Mar 2021 13:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93F4264F62;
        Thu,  4 Mar 2021 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614882736;
        bh=H1MGf+9DPpMfGJa2izpM3w8GZ1XcL+dT9Sxx86sYOc4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GohWxrr9kwfjDxKuv5navLQvLk8COE/3Mu74Qzg9NjmXVkCyNxFnUxL0G7VftjvUz
         JzRM2RwhXYCfj3re5K5C4540BfPlZYa6GkcVvKOQvhmnV3eN8zA9DlLv86BzjW1+7Z
         nVaojxuX4JliLy3NNv4pAdIHASGrP1d11pfP8HH7yZbX7m4W+3qoPDhGDaCXUZsGRn
         iHHBPNz5KBK9pBDtwzYdzHTVc6N3fDmd3XkSmSza61ZjToVcPM05nQOLO56S8sP7hG
         VqJBPFNqCPFnVq62bTP+/aKDTnvphvpqdHhY71e526G4c6Cu07Hnh5y333hrF5MpK8
         ocpMBb7UC4VoA==
From:   Mark Brown <broonie@kernel.org>
To:     David Bauer <mail@david-bauer.net>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20210303160837.165771-1-mail@david-bauer.net>
References: <20210303160837.165771-1-mail@david-bauer.net>
Subject: Re: [PATCH 1/2] spi: ath79: always call chipselect function
Message-Id: <161488266862.55981.13951450710640989938.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 18:31:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 3 Mar 2021 17:08:36 +0100, David Bauer wrote:
> spi-bitbang has to call the chipselect function on the ath79 SPI driver
> in order to communicate with the SPI slave device, as the ath79 SPI
> driver has three dedicated chipselect lines but can also be used with
> GPIOs for the CS lines.
> 
> Fixes commit 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: ath79: always call chipselect function
      commit: 49fb4b971bac8e88070d8b6ea34fbdb57ca80cf6
[2/2] spi: ath79: remove spi-master setup and cleanup assignment
      commit: 6a7e4db6eb8930a26469200a8b2e5bda7ca773fb

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
