Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28A5811C3
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jul 2022 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGZLRK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jul 2022 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiGZLRK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Jul 2022 07:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DE30F49
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 04:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A256612D4
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 11:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C409C341C0;
        Tue, 26 Jul 2022 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658834228;
        bh=DW2on7dZVQwK3PwZ9Vgnbg8fpf0M6Ks8WeYNbZL/vSM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oExBHHrAUqsdvX+lpoU5iWwX4+zPLaA/LAXGOdiD14bG2kaa7nBDfbowzYM1Z9Fqn
         OZvUefcyvPYCP5tJFTfAno2KQzCMY3pfxO0Y/a3XfAngPBlOTQrVCwiJrsYp2KhDZ7
         rvTfrY2RAwNKupJ+Lp1Q71+EZWUwwktqC92kXEaEDIFf2n8FdC8qRSV99AC3ZQvA0C
         +ToUNjVlYn4fbAoj7rWt6Ahpygph+pkSyLhA7m49yg+U41TS+TmSnLN3caK7tT/89n
         bF93ZAmSj4ZGkqZW+nMyeLnhqwmVK9U2bXTHkocQOkAqMh3njhOH4nwStAMFHsM9ay
         BwqfhfKHJ1joA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Lukas Wunner <lukas@wunner.de>,
        Phil Elwell <phil@raspberrypi.com>, kernel@pengutronix.de
In-Reply-To: <20220719105305.3076354-1-mkl@pengutronix.de>
References: <20220719105305.3076354-1-mkl@pengutronix.de>
Subject: Re: [PATCH v2] spi: bcm2835: enable shared interrupt support
Message-Id: <165883422708.68856.17207191707677465295.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 12:17:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 19 Jul 2022 12:53:05 +0200, Marc Kleine-Budde wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> BCM2711 shares an interrupt betweem 5 SPI interfaces (0, 3, 4, 5 & 6).
> Another interrupt is shared between SPI1, SPI2 and UART1, which also
> affects BCM2835/6/7. Acting on an interrupt intended for another
> interface ought to be harmless (although potentially inefficient), but
> it can cause this driver to crash - presumably because some critical
> state is not ready.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: enable shared interrupt support
      commit: 89fcdd53c2528b8f0ed34553aaf9826fe63848b5

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
