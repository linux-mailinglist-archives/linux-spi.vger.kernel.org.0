Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992B6E694C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDRQVv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjDRQVr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 12:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD831C678
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 09:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5195B6366C
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B4BC4339B;
        Tue, 18 Apr 2023 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834902;
        bh=+ZuI46+CuIgF6FJHUtrC5/wGkWgwIgdaAh5yxRrN97Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iQ3dJvqErwLng/DiLYi+/6k52aBCIZXMLzdbPEMPo1gM+6evePQseOq8Ms8y5d+Lk
         VbDJGfVqhGJAR92rzldVxJ1uH7VxtvealOftxv4X+ZuXjAkb6eUqMfVy0MtDQRrgM/
         dQ+kt2HcrG8iig6kukvTLH61TTrgttM0vdwg34ZvcNL4t2Im4/6V1oxcgtjGqoS2CK
         DJya4WdGFfQbRNs2KqaFXvtmOJOQbIxRbPmnrUYO2PNDHFY7Vedwv5aRsO6m0LUz/M
         65Qp8v7lyqgq1ADkSSXTRpx2DqyLXPVwNzSTG2fqJvZYDSHW7FBqFgp8SLAXE/lx56
         2Io8zbdmn70Xw==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20230417091027.966146-1-d-gole@ti.com>
References: <20230417091027.966146-1-d-gole@ti.com>
Subject: Re: (subset) [PATCH 0/2] Fix PM Hooks in the Cadence Quad SPI
 Driver
Message-Id: <168183490111.88110.17630787888959100348.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 17 Apr 2023 14:40:25 +0530, Dhruva Gole wrote:
> This series adds fixes to the Suspend and Resume Hooks of the CQSPI Driver.
> Earlier, the ltp-ddt test "OSPI_S_FUNC_DD_RW_ERASESIZE_UBIFS" failed
> post system suspend resume. It is now passing as shown in [0].
> 
> Tested on top of linux-next (next-20230414) on an AM625-SK-EVM. For logs,
> please refer [0].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: cadence-quadspi: fix suspend-resume implementations
      commit: 2087e85bb66ee3652dafe732bb9b9b896229eafc

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

