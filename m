Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A412FF4E5
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAUTnU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 14:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbhAUTmr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 Jan 2021 14:42:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DC023A56;
        Thu, 21 Jan 2021 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258126;
        bh=rAgkYszEJz9W4BMbxLbBcrUeLlnFsko4ChyAd3HIxyo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u1rmMPo/4QX07QvFkBlynU4YL2LzHu5B1HWmHrUeEBQEqWQwqlsHjM4RqcYZYmD66
         uwu2SlcQt3UL/Bs8bYTStZl9/5obekZHzbiC9GH/Q4qRBNUmvQZQJRIiJn65JviVQj
         SWQAl1mfyoBT5rQzsFqgu+gxgK4RqJyrXMiq9oFeLE3VAT/Y41kBk5wsAoac6MKVOr
         UMwdZkIwJfD8czrjhF9SeZxbSbH1eXLCLOBtpul05MtXM2ab/XKxES1KItslcqwZb5
         dcYHvZyOic8+zoB+wPoGjNTqwXuAkr/IVC1c5/fb3LpT1C05dbiikSF6xMGvHRutdQ
         zDOSeEnvT67iw==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Barry Song <baohua@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20210120161658.3820610-1-arnd@kernel.org>
References: <20210120161658.3820610-1-arnd@kernel.org>
Subject: Re: [PATCH] spi: remove sirf prima/atlas driver
Message-Id: <161125807796.36053.17088209626222757814.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:41:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Jan 2021 17:14:00 +0100, Arnd Bergmann wrote:
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: remove sirf prima/atlas driver
      commit: 181997b4940880b6ebc317b34dca38a17f107318

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
