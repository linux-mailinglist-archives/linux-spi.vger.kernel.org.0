Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237A7A4E17
	for <lists+linux-spi@lfdr.de>; Mon, 18 Sep 2023 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjIRQGn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Sep 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjIRQGd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Sep 2023 12:06:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833459FD
        for <linux-spi@vger.kernel.org>; Mon, 18 Sep 2023 09:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE607C4936D;
        Mon, 18 Sep 2023 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695051953;
        bh=GZTqHOiPs5fmkPwS/dirjp1SSLMAZJzfpXM8BiVGAPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AOIegqWJLWFVmY6dIroguyYUCq//vMnwM2qB5zZZ9Ddk1NvOgMGFhDMLxhNgp8gmJ
         I+AjOV6as6b8Yji3RUPPcI+wyHuzq5791zkqmWvb7RUYfQPg0OBk7vQF2jMpxy6hry
         Xp01d6QgPwNiYDwRe2UDI8xiQPesufV5rsCgA7ii/H3zxZQfRsAUb1ijzY6Pcyt6YM
         fM1RpT/W7XTXIL5y47NdXYSukIncuDgtLQnk52pthykvHyc+JNvc4RV3HbI9HBHPzz
         EHh1pL0lkyeTMHVbc6EBlTzXVW4tHQV6mXpuvQ6TT/l70qiPLBT4DfUYTTvId5nPUk
         lqkNUlUb4KMDg==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
References: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: Drop warning from spi_stop_queue()
Message-Id: <169505195250.72731.12879463651694407487.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 16:45:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 16 Sep 2023 18:12:35 +0200, Uwe Kleine-König wrote:
> Both callers of spi_stop_queue() (i.e. spi_destroy_queue() and
> spi_controller_suspend()) already emit an error message if
> spi_stop_queue() fails. Another warning in this case isn't helpful, so
> drop it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Drop warning from spi_stop_queue()
      commit: 9386c958beb77aee0d95d5fd0c79babd06a86c7d

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

