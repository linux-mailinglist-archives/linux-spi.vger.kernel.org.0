Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24C507CBD
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 00:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358294AbiDSWs0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 18:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358283AbiDSWsY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1C237D4
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 15:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DBF617F4
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 22:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6B2C385A7;
        Tue, 19 Apr 2022 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408340;
        bh=rV50n0uTCGCXYgFr8OF+/p5wQ7DUshqQmQOk+OEuVgk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VBfWdwOlB3oCEqBno0WthwD+hoiBJSQAKRiLy5SMMhpgLRLZGolC2IGH5wWf+35Qw
         h0XVhQF6xWUcZsM9DJYm0Gkwigo+9uqb0BonEaXiFolh2FhSdlE70nXGvbm4c4IjO9
         0/N3VpuyqwH4wjXtQ0mNkFsq9/8cYnQnQfcdl15D1p8whO+mcHWCH685Ts3E9klfec
         Up3242B3iAIopR4IFNrHxj/N0c2F+kt2NFEm0SP39nfUV+/tJqANp4/Y74EpK4Q91u
         mTOX4NUg8ZLVRgZkVurtVw9GAKDw/endjApLkUAarp6Twfxb2z61s8Sy7L9zKvuPck
         E5beWU+EPmSpw==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com
Cc:     tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        p.yadav@ti.com, linux-mtd@lists.infradead.org, michael@walle.cc,
        boris.brezillon@collabora.com, hongli.li@intel.com
In-Reply-To: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
References: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: intel: Fix typo in kernel-doc of intel_spi_probe()
Message-Id: <165040833836.1910395.16344107154371585691.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:38 +0100
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

On Mon, 11 Apr 2022 14:31:57 +0300, Mika Westerberg wrote:
> Should be 'specific' not 'spefific'. Fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: intel: Fix typo in kernel-doc of intel_spi_probe()
      commit: 4bbaa857e9af76d8cc346bd57fbaa50d357ae132
[2/2] spi: intel: Implement dirmap hooks
      (no commit info)

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
