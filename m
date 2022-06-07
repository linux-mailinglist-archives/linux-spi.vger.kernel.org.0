Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C339453FBFE
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 12:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiFGKsa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiFGKro (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 06:47:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73BF45DE
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D48BB81F06
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B83C34115;
        Tue,  7 Jun 2022 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598804;
        bh=2qY3kAUABVA8K7okrNXIQpRerxJUU1AHSXybhcsPBsA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hzxdQMEmwVczmOKQKN3xDJTyHvYEwzF7tYbnQPjdjmzazJFbIyXT02kz671fHI780
         ki5r/WccpY1LjnY1NbSMQIdxPkpbcWqg+s7qD9gMLK0CzP4T69DPclLU4elmAi9OM4
         GvOHOq96vvZErtraXqnrcL+NCKv91+44ob2E5qdjtQGxqlN0y2wFCjr49mL1NULSZO
         QrZkCGM1kCHnH01hA3E2Py8L8WXocE3w8akFQnw4MtCbyK6iCJFWViNBXdlj5bkyE5
         cc161Om1fLN8RmPKcoMyAfqJ2b/JXY2+Rf2g8oYKHwWN3X3eHhhXMDCaN6Fv/MFAaH
         iQduJzGYS0/Mw==
From:   Mark Brown <broonie@kernel.org>
To:     david@protonic.nl
Cc:     mkl@pengutronix.de, andrew@lunn.ch, linux-spi@vger.kernel.org
In-Reply-To: <20220524091808.2269898-1-david@protonic.nl>
References: <20220524091808.2269898-1-david@protonic.nl>
Subject: Re: [PATCH v2] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t
Message-Id: <165459880311.302078.9081830520879005991.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:43 +0100
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

On Tue, 24 May 2022 11:18:08 +0200, David Jander wrote:
> This change gives a dramatic performance improvement in the hot path,
> since many costly spin_lock_irqsave() calls can be avoided.
> 
> On an i.MX8MM system with a MCP2518FD CAN controller connected via SPI,
> the time the driver takes to handle interrupts, or in other words the time
> the IRQ line of the CAN controller stays low is mainly dominated by the
> time it takes to do 3 relatively short sync SPI transfers. The effect of
> this patch is a reduction of this time from 136us down to only 98us.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t
      commit: 6598b91b5ac32bc756d7c3000a31f775d4ead1c4

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
