Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B7598751
	for <lists+linux-spi@lfdr.de>; Thu, 18 Aug 2022 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiHRPXQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Aug 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbiHRPXJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Aug 2022 11:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB90B56F9;
        Thu, 18 Aug 2022 08:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2794611D2;
        Thu, 18 Aug 2022 15:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21788C433C1;
        Thu, 18 Aug 2022 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660836187;
        bh=P7CtgSx5YHgcTgxx/fr42kFzQ+hTMnSl8R1LHlSJRmM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FcTQmlRTZ+UvOR88PryUwtmvA0reoXBbCBkSq3pZo8JV8nHOk6rgL+IwzcBuyjBkr
         ClaFocuMu8+o6d9Hogm8mBQU6GV4b1UWhIdMB4bADjlJxMonFNvz4890QKid9MqLnK
         YeAxLF/0B2euHYCVM8g2Z9EPbnu7DDjUs9OtZrOKfbqMgfv7nwztVWSOH73x4uLteE
         vls+nbzYaeEwGH06K3LDzf198398vodM+6DELIY3KpmSbfsb/u040+JxSr3dwgKZP7
         1pH0ylgefYlZbTZ5Fle8kkeA1k08r8RP9iIQnPYZFZYd/Cn7Mq0zYGJDdkn80hiiDT
         JYnu5LWdwE1RQ==
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     kernel@collabora.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818010059.403776-1-cristian.ciocaltea@collabora.com>
References: <20220818010059.403776-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] spi: amd: Setup all xfers before opcode execution
Message-Id: <166083618586.142781.17878622622780104083.b4-ty@kernel.org>
Date:   Thu, 18 Aug 2022 16:23:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Aug 2022 04:00:59 +0300, Cristian Ciocaltea wrote:
> The AMD SPI controller hardware seems to expect the FIFO buffer to be
> fully setup with the details of all transfers in the SPI message before
> it is able to start processing the data in a reliable way.
> 
> Furthermore, it imposes a strict ordering restriction, in the sense that
> all TX transfers must be handled prior any RX transfer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Setup all xfers before opcode execution
      commit: 9d08f700ab78fd96cbe5922c261051743cb9c86e

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
