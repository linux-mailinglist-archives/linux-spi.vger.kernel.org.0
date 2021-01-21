Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9912FDEEC
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbhAUA5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 19:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392399AbhAUAKV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Jan 2021 19:10:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB50223770;
        Thu, 21 Jan 2021 00:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187728;
        bh=2ZvbxO+hDvOsNJSnxR5ocwNTkj8bY7sQyaY82zAU/9U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DfVOjo8b9H24h1xJH9cbeTQK14bzSj6EdR+V9ms/n7giM0WRmVtWZORfySnXnq+zB
         eAD5WtfpqHSxmzs+QT3CEccVzTZNXjyOju+HHQ850B8wMUNHzsGgCs1Z2FOYGbtPgf
         pAbqgxBtTma/D9kpKUFWZ7JSni13U7q2C/j0l+A2wqJ5cHtLhV8UbIRXjnCktQ+aSI
         wQshWdCCQTDLnO7DCCNHQ/UyLnSpi8oYifY6oPT0jFgl6AEKg5xqJ1vPZfO2ktUPvp
         MesF+gggXO+wZtjts2/8Uhi78TB+0d4E6pLdJXoXzzBEo8YiJiOU81u+gXMv4Kp46b
         pra33Exk1LaWw==
From:   Mark Brown <broonie@kernel.org>
To:     Pan Bian <bianpan2016@163.com>, Tom Rix <trix@redhat.com>,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20210120082635.49304-1-bianpan2016@163.com>
References: <20210120082635.49304-1-bianpan2016@163.com>
Subject: Re: [PATCH] spi: altera: Fix memory leak on error path
Message-Id: <161118769043.46123.10913866540297886121.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 00:08:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Jan 2021 00:26:35 -0800, Pan Bian wrote:
> Release master that have been previously allocated if the number of
> chipselect is invalid.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: altera: Fix memory leak on error path
      commit: 55a8b42e8645a6dab88674a30cb6ed328e660680

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
