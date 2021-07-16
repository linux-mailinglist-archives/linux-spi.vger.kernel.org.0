Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460F93CBB35
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGPRfF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 13:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGPRfF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 13:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96DA2613F7;
        Fri, 16 Jul 2021 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626456730;
        bh=vDZVWlfbmxiRjGKfummSrKLwVkUlIL6GveWMuV3leqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRHA4iUbUIUNCoDLgcGmVH9ZgJQZB6iKUM6otb8VtftisJKew3G61IScku20zgNmd
         B3u3ssL917Yj3oq5Mp8CFd8XUlaz92k0MRgtR9gQn6XT5///i4QPWuWjJAIR43Ym7b
         sXq2HStTrOkGhQFDe8xEt2cCk7WmWLavrdt90mk5h1zEZx4fF57mTmQqH/jqiOyTYS
         LknuJnhFg349/0WZap4XGmknP28L9NYhD4IoY+Z3kwMPB+8Pjv2PWsqQzpyS9/Pfm/
         CBP8FP1NGeeVzZjxDymR3L638TVCFKZIZBjKE1fINt9dtrT3QHbSc+HjMwDEUAahsh
         7MKJKCcwc1oGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Mark Brown <broonie@kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Pratyush Yadav <p.yadav@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v5 0/2] spi: spi-cadence-quadspi: Fix division by zero warning
Date:   Fri, 16 Jul 2021 18:32:06 +0100
Message-Id: <162645612392.26766.7752507436545897343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
References: <bd921311-5896-b228-ea6c-20e11dfe62e3@nskint.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Jul 2021 14:31:24 +0000, Yoshitaka Ikeda wrote:
> v5:
> - Added Signed-off-by and Reviewed-by.
> 
> v4:
> - Changed to better code.
> 
> v3:
> - repost.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cadence-quadspi: Revert "Fix division by zero warning"
      commit: 0ccfd1ba84a4503b509250941af149e9ebd605ca
[2/2] spi: spi-cadence-quadspi: Fix division by zero warning
      commit: 0e85ee897858b1c7a5de53f496d016899d9639c5

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
