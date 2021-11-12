Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884B44EE98
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhKLVa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235780AbhKLVa1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B6C76112F;
        Fri, 12 Nov 2021 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752455;
        bh=nSzppo/zQOzAljnSnMyyglQiDa62SKiLlA8cgFuJliA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eZTZzX0sudySsgdHSApdn1Oe9FfcE6OeZCshkC9opKNIWa5TgrbZin5ezJrsW6ko2
         4f5FFwIjLh5HJ8q+9ZB6YAPbVWIUz6iJ1oYnwt8LVUetjXFGluizjoSGEIu8swdULz
         zxIs3YQxZ19VmrIoHSQwC23dynYdDDpY4fpGGnZX5tyKyFxamagwPaBeXnzs4PzNjf
         wgXPsRwtkhkrGTer2RvboG+4f0hfNYFQqW3Iz06N81xWkv3oDL2OTDlQisBS+kITwv
         iswwJhif0PdTyXG8V39irl3V/NFwaj+9LmhR4A9c13dfcFaiRXpXOAQNdVBmwFfiaJ
         HG8Zpw/TWGw+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     a-nandan@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211108200854.3616121-1-dinguyen@kernel.org>
References: <20211108200854.3616121-1-dinguyen@kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: fix write completion support
Message-Id: <163675245484.742446.14041471157109637944.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Nov 2021 14:08:54 -0600, Dinh Nguyen wrote:
> Some versions of the Cadence QSPI controller does not have the write
> completion register implemented(CQSPI_REG_WR_COMPLETION_CTRL). On the
> Intel SoCFPGA platform the CQSPI_REG_WR_COMPLETION_CTRL register is
> not configured.
> 
> Add a quirk to not write to the CQSPI_REG_WR_COMPLETION_CTRL register.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: cadence-quadspi: fix write completion support
      commit: 98d948eb833104a094517401ed8be26ba3ce9935

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
