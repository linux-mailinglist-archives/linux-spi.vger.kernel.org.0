Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097D59C348
	for <lists+linux-spi@lfdr.de>; Mon, 22 Aug 2022 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiHVPnx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Aug 2022 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiHVPnE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Aug 2022 11:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB2205F7
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 08:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10A2CB8105D
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 15:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEAEC433C1;
        Mon, 22 Aug 2022 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182978;
        bh=a3p1vMRdC2YIuYJ3ayp0wYUh8zQ+ovmVinCaj4fh+pY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rhb0tgfphz0aV/D5nAaB7EJZ1wBjOPyATxShm6LbtVxgv8/EObtaWaKqOM/GN4VbD
         k1SCH5H3ot04uiDeK8raE6UX+8EUPy+IeIv7tpt29jqMokWLn04XW3zVF/AEMFc99i
         8JZEXRXWJIzrWY3H4iQgOUVI2vU28NfRZMEmi/EZXPcgv9wOP9dnjaONYin6Jocw+W
         k3DesVVL5KKAy2nFkxcuK16ITcxAJQKEAPPPJNlS6xAS1FHYIC88hhbNk9yam8IE83
         9ss/Za42dRZaFnQ6LV+URZfsKax8coeUlYsJqW7S82z8iJtVzj8EpnCd9AKKqlUYJy
         kWddjgha1UIMw==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20220816125537.89389-1-mika.westerberg@linux.intel.com>
References: <20220816125537.89389-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel: 64k erase is supported from Canon Lake and beyond
Message-Id: <166118297797.188530.18199252098703597074.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 16:42:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 16 Aug 2022 15:55:37 +0300, Mika Westerberg wrote:
> The hardware sequencer in Intel Canon Lake and beyond supports also 64k
> erase command. The SPI-NOR core uses SFDP (Serial Flash Discovery
> Parameter) to figure out what the chip actually supports and only issues
> 64k erase if it is supported.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: 64k erase is supported from Canon Lake and beyond
      commit: 1d895be13af0d962bef67ba0ceaefbdc6954fe67

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
