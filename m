Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549ED4A6230
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 18:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiBARSq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 12:18:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53128 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiBARSp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 12:18:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5031861253
        for <linux-spi@vger.kernel.org>; Tue,  1 Feb 2022 17:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AB9C340ED;
        Tue,  1 Feb 2022 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643735906;
        bh=rbnfU9D6632sWyTUP1nZLyvi+tmNxmpn5UcwN9dY0ks=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sd10T3zTkC7JYYaUFH8LtOljuuGFJovB97bYTTJIWoDN+SImN4d3NYNGVUiiS0axV
         CnRUwUPg5h6sbeQsd66GfUgw/HpqjqcvjnQfPLcYdmDximOGzfZM77IIch9tIBR6z+
         7GTMTOp8S+Dt5+YOWYFF5nQBNpCxhkMIOe1HjoMeRCQ4/MC+3nubaXKw7yV+syYWUu
         Sb/cKC2vKi8+KbDDA2SOc2pxNohhaidIkyN/JEYL48c4xI0xxnZH9AZftZ+L//5Zen
         xFWOBLkFbtbzyX182qRr7ueWVVcglI6JCqEdJeh0W676mjyZRvUC/hpvozqkuHehnq
         Lx7hhKsYE8TXw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20220201012654.562578-1-linus.walleij@linaro.org>
References: <20220201012654.562578-1-linus.walleij@linaro.org>
Subject: Re: [PATCH v2] spi: st-ssc4: Covert to use GPIO descriptors
Message-Id: <164373590574.2398858.9254366892078454980.b4-ty@kernel.org>
Date:   Tue, 01 Feb 2022 17:18:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Feb 2022 02:26:54 +0100, Linus Walleij wrote:
> This switches the ST SSC SPI controller to use GPIO
> descriptors from the core instead of GPIO numbers.
> It is already using the core parsing of GPIO numbers
> so the switch is pretty straight-forward.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: st-ssc4: Covert to use GPIO descriptors
      commit: 321599693213c81b2ce8530abb27e39528e969f9

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
