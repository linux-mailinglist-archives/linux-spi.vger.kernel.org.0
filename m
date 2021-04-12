Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A835D0B2
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhDLTBo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 15:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhDLTBl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 15:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 004126105A;
        Mon, 12 Apr 2021 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618254083;
        bh=WV3yG0JIeWibxa+TnFdzSVFNjMcLNlewIaFA/P4El2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT6fDdLNigZ9oUu70L/OzEOZtMHHqWr0br1hYad9hkciJ5Z93aOdWhjp2Qfi3pKAb
         z07m5Fi9LewC/r6HR/QBXCcIXprCVMm953ZGgxpuEXOYOgHVsuYg/iJHJi4FlsjKX6
         SCJN3oxLcpPxqz4uC9nM/lJJboTRFxweET6k6qd6cFC3DrjDogSDxr9pDXgdDLJOkD
         J+5jsDMPHzaFoqDNb4ukDuBpi5t41O9pncdapZ3N4onYsTklRb2Du45q+q+fovtOyb
         7Y5wgx8ATkxGRf6sZDEhwM0HcT/UXg6C2jYNyO2o1uzwoWZ0Ju67wq2bOux+1EW8E1
         0Z7QrPByvmQjg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Yicong Yang <yangyicong@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxarm@huawei.com,
        john.garry@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH v2 0/2] Minor updates for hisi-sfc-v3xx
Date:   Mon, 12 Apr 2021 20:00:57 +0100
Message-Id: <161825405874.52313.3360773736432660713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
References: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 12 Apr 2021 19:58:26 +0800, Yicong Yang wrote:
> This series fix a potential interrupt race condition and
> cleanup the ACPI protection for the driver.
> 
> Change since v1:
> - reword the commit in patch #2
> Link: https://lore.kernel.org/linux-spi/1617881505-51552-1-git-send-email-yangyicong@hisilicon.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: hisi-sfc-v3xx: fix potential irq race condition
      commit: 4c84e42d29afa3dce201a4db747db2a5ba404604
[2/2] spi: hisi-sfc-v3xx: drop unnecessary ACPI_PTR and related ifendif protection
      commit: 4a46f88681ca514f9cb33b39312d0ec4e2ec84da

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
