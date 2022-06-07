Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC853FBE4
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiFGKrq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiFGKrQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 06:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876FED8EC
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 03:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FD861578
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 10:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6EBC385A5;
        Tue,  7 Jun 2022 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598794;
        bh=XJSvNxP/cCTuGJd8rGeLIDzzinZCcilSQsaKZwfDgbU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LKQqg7Q1jOw5iG/+r4I81P/diLCtBeoghHsnMNMX9QbckhBzmvlCRvExswc3QPFxn
         4bc+sUIhphtiGDAa/ctB8PQrN41fq3F7e4/O8dfU7p/jMaSlpDbWkMqemXfq9cRKg8
         XZYTE2VjRG0MzH1YI9eabT5b6jjNZwG8PjemVUoLo/GzazPHAztD6a5ce6MjdYEt5R
         vbQkMp585yHQJzVfQqAiipy9i9UiPGo/z/XLxrzqztI8+F8Llxn9z3fsmPyMd6TOsy
         lYijmRABeMTyquii3P5zuGssFHiAjt/w+WEmJTgpO6Yca6N3OE8GVOU9AkW2e7emZn
         6JZtSaCpygtOw==
From:   Mark Brown <broonie@kernel.org>
To:     atsushi.nemoto@sord.co.jp, linux-spi@vger.kernel.org
Cc:     vigneshr@ti.com
In-Reply-To: <20220519.084604.966119051165023533.atsushi.nemoto@sord.co.jp>
References: <20220519.084604.966119051165023533.atsushi.nemoto@sord.co.jp>
Subject: Re: [PATCH v2] spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings
Message-Id: <165459879309.302078.14745978315135953159.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 19 May 2022 08:46:04 +0900 (JST), Atsushi Nemoto wrote:
> The spi-ti-qspi driver initializes its spi clock by the
> spi-max-frequency property from the controller node, and ignores
> per-transfer (and per-slave) speed_hz settings.
> 
> Isolate clock settings out from ti_qspi_setup() and call it from
> ti_qspi_start_transfer_one() and ti_qspi_exec_mem_op(), using
> per-transfer speed_hz and per-slave max_speed_hz settings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings
      commit: 8d0b512844fdee83b6299647aa178828a4ebfc3b

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
