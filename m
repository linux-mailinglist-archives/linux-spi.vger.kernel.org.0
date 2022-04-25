Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48C50E720
	for <lists+linux-spi@lfdr.de>; Mon, 25 Apr 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbiDYR22 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Apr 2022 13:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiDYR16 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Apr 2022 13:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0340E74
        for <linux-spi@vger.kernel.org>; Mon, 25 Apr 2022 10:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F2F614C1
        for <linux-spi@vger.kernel.org>; Mon, 25 Apr 2022 17:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA96C385A4;
        Mon, 25 Apr 2022 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907492;
        bh=g8NIjo21CsHDLLyAqS3h+bSlHjGHhsZK+djTW10anZw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=gDXaaO7E9uycpcysffLIQ5AsxkUoyzmFlZq8deeqY+Z2Fv16sDTC+SL2c0dfzpMQw
         M4dPMyWeA03XzuJvuEUu4AMLUNxmuiwXCCr5MNRaswJUM1ooODNViQ0SOKkFscizA4
         7I0EaJhrHDdIVieIaPXviJjKdA3o4JOfHjTU2GLFCMAtOaSWncCS9mICQHzBHuZOKl
         4ToTdaliwmBTv8eRmyvGjDXr4cCGHwI/DpXt66bqOpGRn6qdoSvMNMBGelMSf5QZdw
         FBUUMWcvM3b4FnorfrDSQwuB5j5110g5LpPfHY8sSXGoR9XbCPy6JyKkwXO4Ap8HYN
         QpWDrsm8h8WzQ==
From:   Mark Brown <broonie@kernel.org>
To:     eagle.alexander923@gmail.com, linux-spi@vger.kernel.org
In-Reply-To: <20220420061038.22570-1-eagle.alexander923@gmail.com>
References: <20220420061038.22570-1-eagle.alexander923@gmail.com>
Subject: Re: [PATCH] spi: clps711x: Use syscon_regmap_lookup_by_phandle
Message-Id: <165090749122.584172.16806085856476442518.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Apr 2022 09:10:38 +0300, Alexander Shiyan wrote:
> Since version 5.13, the standard syscon bindings have been added
> to all clps711x DT nodes, so we can now use the more general
> syscon_regmap_lookup_by_phandle function to get the syscon pointer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: clps711x: Use syscon_regmap_lookup_by_phandle
      commit: b0ceb62125155c1f8e67d3a944af9536d93609c7

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
