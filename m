Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F33551933
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jun 2022 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiFTMpE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jun 2022 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiFTMpD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jun 2022 08:45:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5EDF56
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 05:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81719B81106
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 12:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC14C3411B;
        Mon, 20 Jun 2022 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729100;
        bh=RsdCd3FiHNcQ5tno9UF3jziAQg+Voq/29i9XXmGLxBk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rADoB87FI7SzMh7rm02OfhuDkClA57JnAimUrKTRONu4zmeSW99OkITl1ETtQLens
         +nuq/c77QVly4XYmNQvr13eAxW/qrd34gyyeMZECdd4xQ+4whP7b/X4BjaXLkqHqf9
         joJuBIbojW9S2VVfR+KsXsqgAidzw/rZFuuYNsNEERrdOH3Za4bBHgCJLEyRPG45OY
         hPG79UKs/FIpO4c2gi3LZnAoU/XhsGKFc4jJI4NEYcV2euO7r/vOsUIz70MVAEuT33
         gSMi6ViSfn9/f7+p3XeBqZWxMq2O+onH1Mjz6ihJTdOMaGGM3YgEr3pz0RLC3gYpKa
         ApRasd9zZ1Udw==
From:   Mark Brown <broonie@kernel.org>
To:     tomoya-linux@dsn.okisemi.com, tomoya.rohm@gmail.com,
        broonie@kernel.org, masa-korg@dsn.okisemi.com
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220615174138.4060912-1-broonie@kernel.org>
References: <20220615174138.4060912-1-broonie@kernel.org>
Subject: Re: [PATCH] spi: topcliff-pch: Use core message validation
Message-Id: <165572909874.491338.2709444284747372130.b4-ty@kernel.org>
Date:   Mon, 20 Jun 2022 13:44:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jun 2022 18:41:38 +0100, Mark Brown wrote:
> The topcliff-pch driver requires TX and RX buffers on all transfers, open
> coding checks for this. Remove those open coded checks and instead rely on
> the core functionality, which has the added bonus that it will fix up any
> transfers submitted by drivers as needed rather than erroring out.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: topcliff-pch: Use core message validation
      commit: 26f30e3ee1bf120af1bde22d890e46a0c8dbeca0

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
