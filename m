Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2E3F72E3
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhHYKXx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 06:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhHYKXx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Aug 2021 06:23:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ACC660F58;
        Wed, 25 Aug 2021 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629886987;
        bh=0d4GjumQbi6Pfjk1IVIfHfWfCsQwz/r9LDjdqfZxj/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrPJd0vlu7ndd8KUq13eTx9odbB8zLb3lPu3E7rEtiwxvy7kSEIHssnNeHjC4p1PR
         gTewb/odvIyCAym10FYTyNXjxzqRk0/FtVFt6fMaUKkfhcaSyUi+6IguGwEdN7vQ/v
         vAmZWXcR2ONnA1bfToJxpPf5Q/G782pVPaXOiTpAFmZFtvUs9AWZeRmLciOKlZ1Fzi
         ASgLKB4V5c/r7wEhAWyuFQ7tzUHHHW3TmVsghvHBX0SXZHVqwY4K+oljTq6uuiXGp+
         2krip9oI2uZzN1EV4f4KVLBDl9pPADtoGPSOf1/5g9BSGQuikJ9ZdOvtvp6Zh83WKq
         8RHTtv/pIpv5g==
From:   Mark Brown <broonie@kernel.org>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] spi: davinci: invoke chipselect callback
Date:   Wed, 25 Aug 2021 11:22:36 +0100
Message-Id: <162988541636.8193.10589507555090132739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <735fb7b0-82aa-5b9b-85e4-53f0c348cc0e@nokia.com>
References: <735fb7b0-82aa-5b9b-85e4-53f0c348cc0e@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 24 Aug 2021 11:25:56 +0200, Matija Glavinic Pecotic wrote:
> Davinci needs to configure chipselect on transfer.
> 
> Fixes: 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: davinci: invoke chipselect callback
      commit: ea4ab99cb58cc9f8d64c0961ff9a059825f304cf

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
