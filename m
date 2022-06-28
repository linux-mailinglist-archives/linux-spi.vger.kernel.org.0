Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4355D6A4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbiF1Kbd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbiF1Kba (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 06:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141B2F664
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 03:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E281F61917
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 10:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2C7C341D0;
        Tue, 28 Jun 2022 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412288;
        bh=EOdzdVvs5lidv4ZE+GozhHdEo8G5inqyDzh7kCsq+hc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dR8KMk399zkWSz+V4v64FkBus9EnXP/js48ZUYIgXmRUQNmSv3Xf8FdPRXzc96BjE
         UHvPzwyPGlPV3uh4LROb3YXs+URy6kDRrke1HQ5AharTiuVmEi6BaXOUT3ezoqImf7
         dSPwygT9DqFysDJDnPPnOT7K7y6AiplfDcR69l+OcyMng5NkANTiDHVp4X530W5JY2
         PXLvE1mrHukbMGZ1Y9Wa1ovSWs4n4StBZnR9IG992Zfb1nozqsbGOblNIk059xZR3o
         7dTlXNk6MGw6D7L11UaQ4LbiZZ2cvgwgIkppzPT8NxqFQD1rPuU6P4EcBlTCO18bnw
         Rk2UKxv0V0kYQ==
From:   Mark Brown <broonie@kernel.org>
To:     david@protonic.nl
Cc:     andrew@lunn.ch, mkl@pengutronix.de, linux-spi@vger.kernel.org
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-Id: <165641228722.254742.17050234071076458852.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:27 +0100
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

On Tue, 21 Jun 2022 08:12:23 +0200, David Jander wrote:
> These patches optimize the spi_sync call for the common case that the
> worker thread is idle and the queue is empty. It also opens the
> possibility to potentially further optimize the async path also, since
> it doesn't need to take into account the direct sync path anymore.
> 
> As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
> controller attached (MCP2518FD), the time the interrupt line stays
> active (which corresponds roughly with the time it takes to send 3
> relatively short consecutive spi_sync messages) is reduced from 98us to
> only 72us by this patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: Move ctlr->cur_msg_prepared to struct spi_message
        commit: 1714582a3a087eda8786d5a1b32b2ec86ca8a303
[02/11] spi: Don't use the message queue if possible in spi_sync
        commit: ae7d2346dc89ae89a6e0aabe6037591a11e593c0
[03/11] spi: Lock controller idling transition inside the io_mutex
        commit: c1038165fbbf83967f29b3bb38872faa780b3a72
[04/11] spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
        commit: 8711a2ab51dd47b2bcb3880403add25dd7fc7c13
[05/11] spi: Remove check for controller idling in spi sync path
        commit: d5256cce1f50ff4c8fad6b8eb7b4ec9e47d38925
[06/11] spi: Remove check for idling in __spi_pump_messages()
        commit: 049d6ccc4da8d34f382949ebec6d4fb318a9c7c0
[07/11] spi: Remove the now unused ctlr->idling flag
        commit: 66a221593cb26dd6aabba63bcd18173f4e69c7ab
[08/11] spi: Remove unneeded READ_ONCE for ctlr->busy flag
        commit: 1a9cafcb57b70fc1439d4a5cb28963122568967a
[09/11] spi: Set ctlr->cur_msg also in the sync transfer case
        commit: 72c5c59b659d54d0c824d0333a211f373316361d
[10/11] spi: Ensure the io_mutex is held until spi_finalize_current_message()
        commit: 69fa95905d40846756d22402690ddf5361a9d13b
[11/11] spi: opportunistically skip ctlr->cur_msg_completion
        commit: dc3029056b02414c29b6627e3dd7b16624725ae9

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
