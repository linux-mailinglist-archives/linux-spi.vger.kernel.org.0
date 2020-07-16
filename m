Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2B222F8C
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGPX6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 19:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5E120760;
        Thu, 16 Jul 2020 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943910;
        bh=hL9StoL59LGX+FSw0B9UyBQWcz8tWkWETkZwc3d/NkU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=028T5a0A2PlSOc48XjH3zto4uBkbYJHvsAx54DsSIzQv60E5T6jqD/0rRnXTDONUW
         wcszi9K875me7luuanrbyhXwkc9ZAR9tTPrjkhPigApHCpJRp782y2rjTdo2PVrQf8
         27e6mPlkOUI/EzI4hHi0jdF3karUaaOgGr5ZlwHU=
Date:   Fri, 17 Jul 2020 00:58:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi <linux-spi@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <40354d64-be71-3952-a980-63a76a278145@infradead.org>
References: <40354d64-be71-3952-a980-63a76a278145@infradead.org>
Subject: Re: [PATCH] spi: fix duplicated word in <linux/spi/spi.h>
Message-Id: <159494389042.42455.2742817158233925285.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jul 2020 18:30:48 -0700, Randy Dunlap wrote:
> Change doubled word "as" to "as a".
> 
> Change "Return: Return:" in kernel-doc notation to have only one
> "Return:".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix duplicated word in <linux/spi/spi.h>
      commit: 2ae3de10abfe0be40c9d93ebc2f429b969abf008

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
