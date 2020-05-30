Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA441E8CC7
	for <lists+linux-spi@lfdr.de>; Sat, 30 May 2020 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgE3BMO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 21:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgE3BMO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 21:12:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CFD206C3;
        Sat, 30 May 2020 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590801134;
        bh=h9LxrfR6I7vH9zdY481mn7hV7P6LBN2vCCPYBSfH8T8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zlQgzrI4dbE85svrc5lhZAPIE3CeYuEJ43r7Jr+QIeWyPk0u5MdDqXwo9E5/Zb1TI
         r/1eu6cUQSJryjjJitTzi1+sKvW9cl0fsYUaV3SDcU2MGcbY/8XgWScYpbMHGUpC+Z
         T4CSG3ex3hgnmpn1SmVlhpoJBib/aVfNt2OEVr7M=
Date:   Sat, 30 May 2020 02:12:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     vladimir.oltean@nxp.com, linux-spi@vger.kernel.org
In-Reply-To: <20200529195756.184677-1-angelo.dureghello@timesys.com>
References: <20200529195756.184677-1-angelo.dureghello@timesys.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix native data copy
Message-Id: <159080113154.41587.5027676527363259810.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 29 May 2020 21:57:56 +0200, Angelo Dureghello wrote:
> ColdFire is a big-endian cpu with a big-endian dspi hw module,
> so, it uses native access, but memcpy breaks the endianness.
> 
> So, if i understand properly, by native copy we would mean
> be(cpu)->be(dspi) or le(cpu)->le(dspi) accesses, so my fix
> shouldn't break anything, but i couldn't test it on LS family,
> so every test is really appreciated.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-dspi: fix native data copy
      commit: 263b81dc6c932c8bc550d5e7bfc178d2b3fc491e

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
