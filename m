Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28E3E4613
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhHINGq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 09:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhHINGp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 09:06:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9721960F93;
        Mon,  9 Aug 2021 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514385;
        bh=kx5VyV+TpRrZyrIL28QsMZwP91UZ6vRMNFeO/rlAjVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOFYFkkglCu8mWUPeZg7qEsrkjjhFWVVWnJCgUgxaRtbUkkU2gTNrmk92kJzXojs6
         GdG5L1mXawZ3yjtftHT07mMX7rv7yuIrzt5lxq60W8+ZXg3Z1XFOL9SZT88GhDKjD7
         psTNtbXRN1yjBDQ/oABASwrwpOgEX/o5t4/0ipdrbnF5uyjLgw/zwOIgYnvJxH3ejr
         7RXCsOaRzOKmeYuFRFqT/y/vluR0+HXXCgKTL0KhBsTO9ogMKCKhrRizQluhHkvO0t
         lDZiM4HlUY75XtAmIS3z/obqe2sHJZm5f0JZhNQ6+3aW5ol3gWku8JetW9IAh0PJ2a
         bnLL8IauMZG5A==
From:   Mark Brown <broonie@kernel.org>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] spi: mxic: patch for octal DTR mode support
Date:   Mon,  9 Aug 2021 14:06:03 +0100
Message-Id: <162851432638.51983.16192986198023092592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1628054827-458-1-git-send-email-zhengxunli@mxic.com.tw>
References: <1628054827-458-1-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 4 Aug 2021 13:27:07 +0800, Zhengxun Li wrote:
> Driver patch for octal DTR mode support.
> 
> Owing to the spi_mem_default_supports_op() is not support dtr
> operation. Based on commit <539cf68cd51b> (spi: spi-mem: add
> spi_mem_dtr_supports_op()) add spi_mem_dtr_supports_op()
> to support dtr and keep checking the buswidth and command bytes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxic: patch for octal DTR mode support
      commit: d05aaa66ba3ca3fdc2b5cd774ff218deb238b352

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
