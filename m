Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1645645FB31
	for <lists+linux-spi@lfdr.de>; Sat, 27 Nov 2021 02:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350533AbhK0BhC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 20:37:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56604 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhK0BfA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 20:35:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A67B829B6;
        Sat, 27 Nov 2021 01:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D36C53FC1;
        Sat, 27 Nov 2021 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637976611;
        bh=vwRpw/vMG7BMpy94vMwEdfDk2R9azx4kXEPJdSzmuV8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=McCDfVkTf+1hcvQYRvwKZAVm3p/xeTmiJUgHJ9F5Q14tLCOyM1d/1PJoATaz6rwre
         Ax2DAQ53Crk4JkrkLBhqOa3Mvofxb7UmdWhFLJWFm4uTE1tujDIjvl7WTMYZXdyzYG
         70qUI0aWwwLj06vB8zF+sOTQ8Gk/TRA1TbyK2+bNeQZp4/iSxuwT4lLX6UFp6jPJJQ
         eedgFdykBzJWW0V7vGnMd32L5f6uL2+Hd78e5WbE0hepO55GVuxaT3dogHOXWgUqLT
         t/1EZBqlZz/k3ua9MCcVT4BAFBsmIVBa3JCFTWd5816gS5OkV6hdyVtQC8c4eor/xp
         veXPlpqyXuFfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
Subject: Re: (subset) [PATCH 1/2] spi: tegra210-quad: use devm call for cdata memory
Message-Id: <163797660965.2988146.12328673256786092886.b4-ty@kernel.org>
Date:   Sat, 27 Nov 2021 01:30:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Nov 2021 15:25:51 +0530, Krishna Yarlagadda wrote:
> Use devm alloc call to allocate memory for spi controller data and
> remove free calls from cleanup.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tegra210-quad: use devm call for cdata memory
      commit: f89d2cc3967af9948ffc58e4cc9a1331f1c4971a

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
