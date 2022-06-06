Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B453E9D7
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jun 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiFFQNk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jun 2022 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiFFQNh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jun 2022 12:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E31248EB
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 09:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A11760C84
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 16:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2B8C385A9;
        Mon,  6 Jun 2022 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532015;
        bh=+xr80Vpbs2TijbS81n9+0qPVzBZaewSLO14zypLYQPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JSgnIK6ZQhTG9oU8IS4y9rxs4fQMf8Myh/Vt7sN3rV5CfXNgCbFOSJAT4UG0ePLK7
         9VwsE6SstNvZ/VlhvM/+TxllV2+qkhFVyim/0RqJMAgmnjUv/cstPjgJ4Hb+8T36L+
         t6YVpKO6DqKEd0F0u38JZMUjcp9RaXzqNgv6xyFwydB0i4N3qd1Yddtr8mGrk6akee
         BC/N278VRhBwLWXlWTGrd/4QNCv31q3geWo9NEeNjGtMHQ4LBPjClXGUeLO46MRL/c
         GeVdIjZyiS2BgTQ6wrhn0Sa1mZnoMaCFTZ0IyOECpnIRKR19XtpCGXTqoJ5MRQigpu
         xEZI3cwPilh6Q==
From:   Mark Brown <broonie@kernel.org>
To:     lars@metafoo.de
Cc:     linux-spi@vger.kernel.org, jank@cadence.com,
        amit.kumar-mahapatra@xilinx.com
In-Reply-To: <20220527091143.3780378-1-lars@metafoo.de>
References: <20220527091143.3780378-1-lars@metafoo.de>
Subject: Re: [PATCH] spi: cadence: Detect transmit FIFO depth
Message-Id: <165453201441.2010189.9671814020789329583.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 17:13:34 +0100
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

On Fri, 27 May 2022 11:11:43 +0200, Lars-Peter Clausen wrote:
> The depth of the transmit FIFO for the Cadence SPI controller is currently
> hardcoded to 128. But the depth is a synthesis configuration parameter of
> the core and can vary between different SoCs.
> 
> If the configured FIFO size is less than 128 the driver will busy loop in
> the cdns_spi_fill_tx_fifo() function waiting for FIFO space to become
> available.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Detect transmit FIFO depth
      commit: 7b40322f7183a92c4303457528ae7cda571c60b9

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
