Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DEB6162B5
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKBM3a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKBM3a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 08:29:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEE252BD
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 05:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2EBAB8221B
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 12:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E214C433C1;
        Wed,  2 Nov 2022 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667392166;
        bh=AjjaS9jReinlRaLXiuodirsvxlPqo+smHakSiy4NA+M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sCJBj2vGP4ORHx7IMD1oggJpBfUW26/qQQJGy6BOFCacpREhmZN66aUJWFW8B00jG
         59MQj08KSE/GctBPM+f8T4rgYiyyH9Hykt4Ct++Vl/bnpJlpk6PpoICmOjHbNajUZL
         tADmIJYrnnnow9M6pMm+zu1Im23ikmjRWPgd/TelGiw9T2nXBzJ0kySFZiSWPauK4M
         txcJPr67wrhQY3kMdwEXZHsQNI81ht5gv1KGg7834QrgVDpwmqXU6QpAuYm+E/Hilo
         NmnJbUT8MAIEkaLZelW6GKq1UyJlpvxfKAvT/nPQhxIaU+qeT3L+fjqitJyc2Ogu+y
         sj/WmEk58Lc7Q==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20221025062800.22357-1-mika.westerberg@linux.intel.com>
References: <20221025062800.22357-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: Use correct mask for flash and protected regions
Message-Id: <166739216584.30778.6377407184105382498.b4-ty@kernel.org>
Date:   Wed, 02 Nov 2022 12:29:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Oct 2022 09:28:00 +0300, Mika Westerberg wrote:
> The flash and protected region mask is actually 0x7fff (30:16 and 14:0)
> and not 0x3fff so fix this accordingly. While there use GENMASK() instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Use correct mask for flash and protected regions
      commit: 92a66cbf6b30eda5719fbdfb24cd15fb341bba32

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
