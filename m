Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA132408973
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhIMKzf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 06:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239227AbhIMKze (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D5861004;
        Mon, 13 Sep 2021 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530458;
        bh=gytxiplUW9FSk4LWVCI2P+9l37LUjmf5IMH0ahG2m+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhGe7UaCBEnD2shSR8Q9KfdwznmRX2iPfrqOUVs5bokbWiH75mzKy8FicTxhZiQgb
         iuxOMOV/7KzjWzadmTf3THbaizz4+VU0nSg2dHqBCon4uAV4T9nbGtcyuqCDhtKuIh
         iTrFRRhdmY5iMN2Hz/5uL0YeFchyG6lThx+1nflf1En944yirkXYuu8/S5lJweJ83A
         pAenSGhIjTrcuzZeNypl8xGyL5/AWw8GdZc+bZhLHlMrk0T6G3Fw5/RWLYiB74C/3/
         FvBqmuRKjqTPio50hX5mMGJW29yi8sSjtSelc06yIq2rKJNzuqkNt7Y/vFyNahQV0t
         /NQh8NOUiEgkA==
From:   Mark Brown <broonie@kernel.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/4] spi: amd: Refactor code to use less spi_master_get_devdata
Date:   Mon, 13 Sep 2021 11:53:08 +0100
Message-Id: <163153017122.45927.4388352721413778030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Sep 2021 12:15:26 +0100, Lucas Tanure wrote:
> Get master data in the start and then just use struct amd_spi
> as it has the needed variable
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: amd: Refactor code to use less spi_master_get_devdata
      commit: ca8e8a18272e7b57b62db5db8fcf1f5218b89a98
[2/4] spi: amd: Refactor amd_spi_busy_wait
      commit: 356b02f9ec3a7304d6c54c4df20cd37b0a22021e
[3/4] spi: amd: Remove unneeded variable
      commit: 3b02d2890bc5eb974346cc287e1732f62a096598
[4/4] spi: amd: Don't wait for a write-only transfer to finish
      commit: 777a2cbbaf1c6685ace7e2ce846796e9425ab320

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
