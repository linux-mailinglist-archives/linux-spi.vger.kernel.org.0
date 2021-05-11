Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F137AE59
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhEKSXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 14:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhEKSX2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 14:23:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CDF46187E;
        Tue, 11 May 2021 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620757341;
        bh=cr7gC8WwNqFaHCL3JVeks8AJlg/tFjzGHUyOOSxXbMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuCpKosVo094FA9RIQNtl4oIKlJ93TKaf05jVYhbMyPetUcDzocgNVmTP4GgfkQ2J
         2cpSZ36/UTZo3Tz5wIz3SMSxbmmnoaUNK+Cg5cdI/UXLGiz89t2QWeEbGaeRiXd+Ad
         bO0nuTH36WZMvyyT5CVpT9p4W7u3t2nDtAZvN4Yr921ulya7HhNUhjUjy6MAASYco9
         vpyS2JsMSB62IvWUDuEoMBwLUf3orJFEBpOvQ1aF/UXGaT9Gf6whYloTH+nv8W5s+n
         J5Xf9x4xku67Y+tvRqLI/RocugXFUDwCFYDFzF/2rwsOR6Gt1/rNwsM+A+N1dcQYxP
         OlCU5bI+iWg1A==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Convert to use predefined time multipliers
Date:   Tue, 11 May 2021 19:21:26 +0100
Message-Id: <162075727215.18180.2366517564277179335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510131120.49253-1-andriy.shevchenko@linux.intel.com>
References: <20210510131120.49253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 16:11:20 +0300, Andy Shevchenko wrote:
> We have a lot of hard coded values in nanoseconds or other units.
> Use predefined constants to make it more clear.
> 
> While at it, add or amend comments in the corresponding functions.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Convert to use predefined time multipliers
      commit: 86b8bff7e3ac6775113639d88db7448a8b47f0c1

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
