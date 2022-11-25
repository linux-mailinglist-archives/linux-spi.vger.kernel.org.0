Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2A63913F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Nov 2022 22:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYV4A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Nov 2022 16:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKYVz7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Nov 2022 16:55:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37957B64
        for <linux-spi@vger.kernel.org>; Fri, 25 Nov 2022 13:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAEB860F0F
        for <linux-spi@vger.kernel.org>; Fri, 25 Nov 2022 21:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E604C433C1;
        Fri, 25 Nov 2022 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669413358;
        bh=5ABaQn/xOs+lKFDK660UjQHafd/vAXm+9Bqn2sM1c3g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bhW7qu36m/arWsTDrwMX5XmP+l7Xdb5sAsK2cjXJek8NZspCuv3sy0DCtfNAP4bis
         TgMw688kU/2yoSIkfXN9ROYe9zDPeeIHxnZqrScceydU91GjRkabxN+1ksy59jk4jF
         eiI2Bai3ft93MAaw+4AUadQRB9TjRE8LFJuCtKAJadShMSYbOz8DXukvByp+hhuQda
         E7j8m+s8V8+Z7WCPjK/r7El4vRc4XIWUe5ES3y9y2wqPUkH50IkSWRlaEGZjoUjiHW
         HjBIBqmhGXuc4GO00AOz/8crUA18Mk6V8z+g9e1COd+RSu1L8lHaiHFgReZWUg88N0
         LbL+Uf6yPLVZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/4] spi: intel: Add support for SFDP opcode
Message-Id: <166941335730.2110296.14100805304174015669.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:55:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 25 Oct 2022 09:46:19 +0300, Mika Westerberg wrote:
> This series adds support for SFDP (Serial Flash Discoverable Parameter)
> opcode to the Intel SPI driver. This allows the SPI-NOR core to query
> the flash chip what it supports.
> 
> Mika Westerberg (4):
>   spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
>   spi: intel: Implement adjust_op_size()
>   spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
>   spi: intel: Add support for SFDP opcode
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
      commit: f73f6bd200c399d52d7147f66b956a01c93d7606
[2/4] spi: intel: Implement adjust_op_size()
      commit: 8a9a784fb337cfd07f305faf5358335d4c12a788
[3/4] spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
      commit: 43f173e7e508ede3d6f5411b9ffbb33d6d284211
[4/4] spi: intel: Add support for SFDP opcode
      commit: ec4a04aa6962fff3cfa63d70536537844f7446d2

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
