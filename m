Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD12541B3C1
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhI1QZj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 12:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241523AbhI1QZe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Sep 2021 12:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7743160462;
        Tue, 28 Sep 2021 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632846235;
        bh=TDRbxwBj/2W9pDd6B9PBVOmmKA862fSHrFNZCrzr+J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0RRuno3aURqpeAXIT7vrsGoSqhyX9JHrXn6Ske/uBliN+5BncnR1ZMsuaVRxBycC
         Nig4YI2Cx6MjbWe8h2c0ryYilV1uSPTI6yEdFQQSjQAsZkzKX0RIcjj2xD2usw9z/P
         Kd+bFtHbyxnU9VZ/fLI+NDf0c8zxS/VEzWzEY9S5SKovr29VizlJBRLPzY50LETVl5
         /cI4mvh83XKXJMP4stVKWfQ5qUHXzfwEEth2DD1iN/iuPU7Le+5xQf8eYTIY96o5ui
         EB97bO9YNq57f/OLGRiVLHSIq/RWhjJOmYVMZmPO05QDknKieRVY32PrGieY0OxgyP
         F98PQkDhLSbNg==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>, linux-spi@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] spi: cadence: Fix spelling mistake "nunber" -> "number"
Date:   Tue, 28 Sep 2021 17:22:58 +0100
Message-Id: <163284597895.17677.3059104552866813432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210928130712.990474-1-colin.king@canonical.com>
References: <20210928130712.990474-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 28 Sep 2021 14:07:12 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Fix spelling mistake "nunber" -> "number"
      commit: 5c258a8a9cf987b254c4ebdb6481a4d76bcf490b

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
