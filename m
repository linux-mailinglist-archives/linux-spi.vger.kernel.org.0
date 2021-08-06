Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476213E202E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbhHFAsY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241599AbhHFAsX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C4C161184;
        Fri,  6 Aug 2021 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210888;
        bh=/Wcd2srYPSDUl5HpYt6OXTGS7UsqdD4heAncjf2sQHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYWYnQjiHswMtMbcRCrLUed30AdR29HhaT3S56IHvCbtBbPgLKdjDplbfbxd2SVjU
         HyyjZp5r/1clHnDy8MBwZc3KhMubmuO9PLQvkmnLjj9pnr4cQvN2TKxONMQ2TIhw1e
         WWgJGXE3uZSt4X4RaZD9Kk5Pcz0sywq6Sm/t9hwAQG2G6EDlVBVyslIYk41H0cSgs8
         qwe6NQcl6aCZv1sHRaWjRcWT0+OnEta2QCB6nE67vTwvl3OlHjQPwgIAuRj90IghZI
         j6pJEKEhEEz36i0iaU44WlbUKg0nLiyaPvygJND/yQXiEzIjCqUUlDHafId++9WTaB
         /MG4IDZ5jc6mw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Apurva Nandan <a-nandan@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: (subset) [PATCH v2 0/2] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations
Date:   Fri,  6 Aug 2021 01:47:43 +0100
Message-Id: <162821082763.19049.14055996178326163404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716232504.182-1-a-nandan@ti.com>
References: <20210716232504.182-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Jul 2021 23:25:01 +0000, Apurva Nandan wrote:
> This series proposes fixes for cadence-quadspi controller for the
> following issues with SPI NAND flashes:
> 
> - Due to auto-HW polling without address phase, the cadence-quadspi
>   controller timeouts when performing any write operation on SPI NAND
>   flash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: cadence-quadspi: Fix check condition for DTR ops
      commit: 0395be967b067d99494113d78470574e86a02ed4

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
