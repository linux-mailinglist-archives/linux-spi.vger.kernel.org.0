Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3436490C
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhDSReq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 13:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhDSRep (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33295611F2;
        Mon, 19 Apr 2021 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853655;
        bh=htNNx7uBOidFypvXGwoCYr9UZZ2Sg1E6sIsSdEnYbN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASDjUDEYW8rujcLm+wJLZFz9u9jxfhs1zXPs8NZ+MvFysLfPnsshvzNMJWx5RMHOw
         +dLLK952CW9d7u1wLYxnrZvmJoVelJtwpQiIcz4Mn3fvlycS/vCX5fS+D9dvFTEngz
         +LPbcwlUUFZ3ggC69Z3/zu4bc3PdtyetQuHmgHidd07ZvPitNTs5clryLQyy5jzCLG
         G5Z3sAH75LXVR45lYOqPCr+vIGHs9kI8QJzQ1QjsNjOTT7cHJOWqmDkY2zcyzgNuDc
         FUw3tQfHEel0LlUwtI0hFYbk3eTABRYkRAMqNmm/deGCulL1XlcG50z9wdkRk84W1F
         Y2z+oEVkdtUNQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, David Bauer <mail@david-bauer.net>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sync up initial chipselect state
Date:   Mon, 19 Apr 2021 18:33:44 +0100
Message-Id: <161885314931.4710.17119271938651822220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416195956.121811-1-mail@david-bauer.net>
References: <20210416195956.121811-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Apr 2021 21:59:56 +0200, David Bauer wrote:
> When initially probing the SPI slave device, the call for disabling an
> SPI device without the SPI_CS_HIGH flag is not applied, as the
> condition for checking whether or not the state to be applied equals the
> one currently set evaluates to true.
> 
> This however might not necessarily be the case, as the chipselect might
> be active.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sync up initial chipselect state
      commit: d347b4aaa1a042ea528e385d9070b74c77a14321

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
