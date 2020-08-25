Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE412521DB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHYUUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 16:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUUW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 16:20:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BE02075E;
        Tue, 25 Aug 2020 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598386821;
        bh=GXx0JYM/PvsogyfLNpW6GWw6+4mst5NV7U5VmzZh74M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CE5Gx510w3gndR6NM9NgKH1d6sGzVtC7+Uoxk/Zhk7bxmdr8JdrWsqNBNr3jw0Ic0
         oYbUlKSnQP/a3PLshXq8oQnS6MyO//9YFtRgc6nshQuDbvx9b3jeZS5mQwCOmiRUwj
         rm0+LjDicHiGVd5hESjOKcT7+YL0zQ/BFMXclb80=
Date:   Tue, 25 Aug 2020 21:19:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
References: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] spi: spi-fsl-espi: Remove use of %p
Message-Id: <159838678623.41768.18166563089033247649.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Aug 2020 17:08:56 +1200, Chris Packham wrote:
> The register offset is already included in the device name so even prior
> %p values being hashed printing the base was redundant. Remove the %p
> from the dev_info() output.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-espi: Remove use of %p
      commit: 9442a12d16a974507738e1ca1bf62e3afa39381b

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
