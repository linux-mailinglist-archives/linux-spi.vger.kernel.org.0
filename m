Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9486045A964
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 17:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhKWRA4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236212AbhKWRAz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:00:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 704EA60FF2;
        Tue, 23 Nov 2021 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637686667;
        bh=xfL2L7E562FF3x3+N2H7tyXnKr6qVxl9+6ayKn54S50=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ElpECrGV629wUJ1TguarRHdDlDnVP8iX0Wp1qpV2DxEyqP3azKfuzQNVzDKhFTvH/
         +GLP55j0lH+0WkPNJJzCGWs7RLBEH3lV5glMVvIAnle3ZeAJcsiD+KIlagzuzB22oj
         aWC+PN6bBB7/GWofsdXXrm79elZm53Wo7F7JcTWwWwfcrFgKYnEf7dPQZA1VVH7EuU
         jD+mPgfAF/7KGzlGEJ1P1/cw6GEaOLnEfWZqsVYqtN1toDWPNv5OI2pyMHja9+BfSw
         WYH1/D1yrlp+19J2OSkmBqbwx8PMFdRjy9JFVsn3F88/o3MbHT8M3m/ElWSLm7Et7d
         tdieiBL6DRknw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211122171721.61553-1-andriy.shevchenko@linux.intel.com>
References: <20211122171721.61553-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] spi: Deduplicate spi_match_id() in __spi_register_driver()
Message-Id: <163768666616.1388476.14364872187119342177.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 16:57:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 22 Nov 2021 19:17:19 +0200, Andy Shevchenko wrote:
> The same logic is used in spi_match_id() and in the __spi_register_driver().
> By switching the former from taking struct spi_device * to const char * as
> the second parameter we may deduplicate the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Deduplicate spi_match_id() in __spi_register_driver()
      (no commit info)
[2/3] spi: Replace memset() with __GFP_ZERO
      commit: b00bab9d48bbb6446a5cf366f5f8e501a16031a1
[3/3] spi: Fix multi-line comment style
      commit: 350de7ce26caba5c7ec0dd4ef1802c9a50a5d85d

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
