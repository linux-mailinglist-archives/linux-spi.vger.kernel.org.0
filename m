Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BF68C8E7
	for <lists+linux-spi@lfdr.de>; Mon,  6 Feb 2023 22:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBFVs4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Feb 2023 16:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFVsz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Feb 2023 16:48:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0E2C64C;
        Mon,  6 Feb 2023 13:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126E06101A;
        Mon,  6 Feb 2023 21:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9996C433EF;
        Mon,  6 Feb 2023 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675720133;
        bh=4BmwbqRZz8fBV5STtlvsWsmzGtmvBvkwghaDNmFeCuo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PJv+UDVe0qxWzdFOwTrYU4pvj6CnmhokZ9n3VCxaOdXJNVdpPSgUAxwomDDxrqfq4
         GCeP2ptFwN/+2QL+gdRnSdd9meza8Phn+iNX4MogFgZwgeILKhrMIoMsOeoo+ti1SO
         jetntcJuqC93/6N9aQIExSIhWFlPfLj6BXRXA0sxIa2ZZKPpDCzP8Ek1cevi5HEhRP
         WKPJhil1ZuFMrbP+IF2jjrdqQcdtv/rVdu/twjUGnh8j1gslWBrB2SwazqOY+4Mrg7
         WORDaJXR5mSrtuAv0TArwKcgvfy7jxar9PHzWFlsmndB1KosBoS7F6Bjrs1EALAWzG
         7X/eIap7adXdA==
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <Y+ETCk7XKfAy8yWQ@kili>
References: <Y+ETCk7XKfAy8yWQ@kili>
Subject: Re: [PATCH] spi: spidev: Fix double unlock in spidev_sync()
Message-Id: <167572013247.1380048.6557352141669503571.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 21:48:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 06 Feb 2023 17:47:38 +0300, Dan Carpenter wrote:
> This unlocks twice due to a merge issue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Fix double unlock in spidev_sync()
      commit: 941811980df00161fe639c252dabe6488875887c

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

