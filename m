Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C1509237
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 23:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382586AbiDTVoC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382616AbiDTVoB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 17:44:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C14550D
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 14:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC213B82194
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 21:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B471C385A8;
        Wed, 20 Apr 2022 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490871;
        bh=ZJASXpwSw7EWB3yJ2BJMT6aN8Jg1dz8Snmgwr1sKRVs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FMvsoVGcPrcYM4OlyvF2c0VoWCVd9AMCEaR4+ir5agnFPA8LH1TFactw1hb1tDZhQ
         BWGY6vrEV1UGKr8rrUyWw6KUFA7eT2L075iXvOK+N6UM36KLAKwPZ/YmIEIPerQhcU
         DOHL+CUHBYHnIblLJaFBdgH5MZ2wxLYhI5jBkfo4lziTqNCwKX0w0Ipuuhlf90NbCv
         Z8wjjKaO2XolaUDzXRryJF0l4HWWjXXqbpl15rcR7CbsrXancSKeerCPeg/zrsNIWw
         8FmkyJh8EANOshDg9CFapWSmjYx5sxB/bnzd7jNzpeQO0jVtQShqRtbIVOWu5GeZmd
         XS0Ta2EuS5kYg==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com
Cc:     michael@walle.cc, boris.brezillon@collabora.com,
        tudor.ambarus@microchip.com, hongli.li@intel.com, p.yadav@ti.com,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20220420104350.19510-1-mika.westerberg@linux.intel.com>
References: <20220420104350.19510-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] spi: intel: Implement dirmap hooks
Message-Id: <165049086976.143449.15707260832201661600.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:41:09 +0100
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

On Wed, 20 Apr 2022 13:43:50 +0300, Mika Westerberg wrote:
> Currently the driver goes over the supported opcodes list each time
> ->exec_op() is called and finds the suitable for the given operation.
> This consumes unnecessary amount of CPU cycles because the operation is
> always the same. For this reason populate dirmap hooks for the driver so
> that we cache the selected operation and then simply call it on each
> read/write.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Implement dirmap hooks
      commit: c2b5a40c9e50651a29ee9d110f7ebc41b8720efa

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
