Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AB313DCE
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhBHSlx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 13:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233190AbhBHSlt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 13:41:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B6164E6B;
        Mon,  8 Feb 2021 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612809668;
        bh=vTFLaxAADKzqZc3O8+8IiHG0JWSrmHu6qXQlxma2p2s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZmkGSdhxUHUJBSxqe2iKZd637miKPxZjxuDvfB7197CFkyYclmXzT5fWsJ0+KVpLY
         UoF1RRE23KT6/UIIuKLZtqsuqkfS1UAMc8mH+OcbjHu65HdtAQH0IlVFEHzN6c8+kx
         a39ASd4l9BKEQReMmF+AFwKJ1+egkylrZ4b34dp13nQWx46S+n8Pf7k9aAWcgYB4B9
         XPKizKyB1kbZdSxg0TKc9lH/ZbbLs95HCMvD49fzxnySC3/tYp1mb5nkXg5mw0hQnZ
         5goYxClZnEZMsTxHfyFiPPjpmwIxR3+gPKdVqrRceidyiefPShvBZSe0qmiNVAMgmc
         sh3DP89JwA8KA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rdunlap@infradead.org
In-Reply-To: <20210208114928.32241-1-unixbhaskar@gmail.com>
References: <20210208114928.32241-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH V2] include: linux: spi: Change provied to provided in the file spi.h
Message-Id: <161280960942.11009.15341072593194758573.b4-ty@kernel.org>
Date:   Mon, 08 Feb 2021 18:40:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Feb 2021 17:19:28 +0530, Bhaskar Chowdhury wrote:
> s/provied/provided/

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] include: linux: spi: Change provied to provided in the file spi.h
      commit: 883c36a32fc031046218ef5802023d5aa54d6cb0

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
