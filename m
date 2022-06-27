Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055F55DD02
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiF0UdP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiF0UdO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 16:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D525FBF
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 13:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45579B81ACC
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 20:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F879C34115;
        Mon, 27 Jun 2022 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361991;
        bh=4iih5GiysBnCT4LuiGSFIxKF2TVl03T4o2QWjY/cXig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UbFwNZMi4Fn5jrR8AsXkwsHtHXtqT0T/uDypxaE1u/FGqRRL3HOGxbxwf3eFlKMqd
         BVtFjplv0m8HuGIztYZhIwRy7OcfOc/qXwRE/6qgEsZ1Rgxm8BU67r2rpIrsenly/E
         uonYogdfvdVlqCJ9dsciC61kjZmtbRTZlvrWDawcibXcQqvJqjgNLhOeiFQ+liw6r9
         /jg/532ZrHQZxRdKySXhcW1M5nd24NAhW696uqyUuLvRxju3lWDAn7vh9+SLqrtmOJ
         q+IsWYEOSBe1wQuVY+bW5dzF52E6Ulp3LGV8J44NhAsvzqVgXk3ohy9y51umYVsWGg
         3vY6hMUV31kvA==
From:   Mark Brown <broonie@kernel.org>
To:     yoshihiro.shimoda.uh@renesas.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220610154649.1707851-1-broonie@kernel.org>
References: <20220610154649.1707851-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: sh: Switch to using core message queue
Message-Id: <165636199001.4094756.11519086979266942759.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:33:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jun 2022 16:46:49 +0100, Mark Brown wrote:
> We deprecated open coding of the transfer queue back in 2017 so it's high
> time we finished up converting drivers to use the standard message queue
> code. The SH driver is fairly straightforward so convert to use
> transfer_one_message(), it looks like the driver would be a good fit for
> transfer_one() with a little bit of updating but this smaller change seems
> safer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sh: Switch to using core message queue
      commit: e2185072a4a4786eb46be046cf20494c08dcc78f

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
