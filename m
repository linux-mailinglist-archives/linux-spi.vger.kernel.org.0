Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9224A4C4F
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380553AbiAaQjx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:39:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40498 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380554AbiAaQjw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:39:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B07B82BB6
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 16:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A64C340F0;
        Mon, 31 Jan 2022 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643647190;
        bh=R22zzEUANd9Zwc1u+cfqq9GwP7RqrhaSLvlJDzEWGcg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UdGJZAL/WmUI3fX6L42KreFlUlpHq9Rl+ldM7ch1UOUuOpXUdKCMZF9MlP6kn/+Uc
         WIWIMdr1S/vg1ShcKyyYg6fykJPtK3rYuUEXITyhEU2MEfACiO1G3vsmCAPlzdhpvH
         bWkweC2Hn476B/39fOOLsl5HaqTod6WwiP/woqpWajVoEDrEakSVfAF+zUN/na3RzS
         VsSxkow5qKyuRFOuvNuJofl4zYZ1oYLuUwT1yg43FrXEO29V2vxAaYBosOJtdD6CEn
         kKqSOyjCfn0SRQrS+xneNxJGaZMwz+Ae6M78RVXirjoSJvRG4Qz5XLQkCEkXZUcQj5
         R2E1VQrF0L9JA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Purna Chandra Mandal <purna.mandal@microchip.com>
In-Reply-To: <20220122004846.374930-1-linus.walleij@linaro.org>
References: <20220122004846.374930-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: pic32: Convert to use GPIO descriptors
Message-Id: <164364718984.1030816.11109974068346084925.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 16:39:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 Jan 2022 01:48:46 +0100, Linus Walleij wrote:
> The driver already relies on the core looking up GPIO lines
> from the core, so this is trivial to switch over to using
> GPIO descriptors.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pic32: Convert to use GPIO descriptors
      commit: 99407f11b5657cd66625c6b55a73d38b67803a8c

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
