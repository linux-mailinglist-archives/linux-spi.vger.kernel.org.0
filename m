Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9E1ACB3A
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442540AbgDPPpF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 11:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395512AbgDPPpE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 11:45:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E06521D91;
        Thu, 16 Apr 2020 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587051904;
        bh=uEzT4afH5aAvqU9GRUEUOIDgK+mWSReRCNYeDa+GX54=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pcpz6ct4+maiiBtZd9rtrSScBUwuNgkpbamj//4pqaThgCwa0dSZd/zmWQvxvCsfV
         RUQLLXo3E1W4BwlUALnGCD0TatfyNXlKArys+HNonhkcuogXDJYnW32hGvnB1VRJei
         17ozwOeaEnJrH+S9jb9dJ176cvZXOo5GU7EQOPbU=
Date:   Thu, 16 Apr 2020 16:45:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200410122315.17523-1-colin.king@canonical.com>
References: <20200410122315.17523-1-colin.king@canonical.com>
Subject: Re: [PATCH] spi: remove redundant assignment to variable ms
Message-Id: <158705187474.53607.10568254080085770802.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Apr 2020 13:23:15 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ms is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Addresses-Coverity: ("Unused value")
> 
> [...]

Applied, thanks!

[1/1] spi: remove redundant assignment to variable ms
      commit: 49686df5b874e5ed6249bc622b73ad9a9e71cd99

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
