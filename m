Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D465BFE0E
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIUMiM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIUMiJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 08:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5483D97EDA;
        Wed, 21 Sep 2022 05:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0E162AD6;
        Wed, 21 Sep 2022 12:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76467C433D6;
        Wed, 21 Sep 2022 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663763887;
        bh=P+mPZ/llILL7rEcJihn0JR8FNwNBVrST0YhEVDpBzBk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=As4YAFHAo0Dab3JLcs/lg26p0WOpRCXmnTEy5QkNgB2wAzvJlauQ2K9SBYLi1Kdr2
         h4dOoFwknYwey+UDfXROHNrOlX4CViWtitRzeYG+YWZig0QsA9Y2nITOrODoEJ9G0a
         2gf3lb5lMU4rH2b0AKgqSdJGP5q5xNvToz3YOM/K93a1mS1NdfGRKf2uCypZWOAAs7
         rxbFbutbhF0G9nHkwEG//CNIqneqUNa0A96YzUkjWgnFXdrhitR5AaY6qzBm2OgJdD
         i4R896e1Ol4dSzmYld5JrC98kUqCGxjVWQaQWO62z4O8EDEKVC67OQQLndr0huYnPt
         t/ssc8w9DNFtQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <Yyq8Q/kd301wVzg8@kili>
References: <Yyq8Q/kd301wVzg8@kili>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix probe so driver works again
Message-Id: <166376388002.569739.11707892942114727902.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 13:38:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Sep 2022 10:24:51 +0300, Dan Carpenter wrote:
> This condition was accidentally changed from "if (status < 0)" to
> "if (status)".  The platform_get_irq() function returns non-zero
> positive values on success so, unfortunately, the driver could not be
> used.  Change the condition back to how it was.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Fix probe so driver works again
      commit: e0437512081282559f5c50591f487149c31f867c

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
