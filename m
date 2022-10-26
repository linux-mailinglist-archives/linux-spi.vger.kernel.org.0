Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1652A60E6FA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiJZSHk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiJZSHj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 14:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28A8F275
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 11:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFAF962020
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 18:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635CEC433D6;
        Wed, 26 Oct 2022 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666807658;
        bh=polzen8u7BtRGEDgsOoWDDarlMQ8J9m3QWOMOLwe69o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=snYOBtKxz78gMpdu3Ec76oAOGpzXLXtObQIq8TZ3yoYVq2blfUvlKUFSLCPjvTDP9
         PJZiXFPp/TY3HFEkb+LodkuO9mDaGjERZ/DxGKPMnea0IKHJGYV/1CCrqnocMxyswl
         3FeyToaJ5oFoToqyl3ZliUSJZS/FbmVLA0j7V9BPUDFz9g0WL3SFO0JQJrh4AoCdyQ
         tSwrYQcr4syBy9b0i6sTFd3G2cZ6JYiOaJHZrpyDlSnFaEHoE0O0rgXyjwLuUKUSVd
         xy78oXBerCsUxWvGjIPzaedkK3rH21h6AhYQSfc+gtIzBMlf1PN18SX4X5k9qMbxda
         2NQr67ggO9Hyg==
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-spi@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20221026122951.331638-1-bigeasy@linutronix.de>
References: <20221026122951.331638-1-bigeasy@linutronix.de>
Subject: Re: [PATCH] spi: Remove the obsolte u64_stats_fetch_*_irq() users.
Message-Id: <166680765713.867963.5145895651436078636.b4-ty@kernel.org>
Date:   Wed, 26 Oct 2022 19:07:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Oct 2022 14:29:51 +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that the 32bit UP oddity is gone and 32bit uses always a sequence
> count, there is no need for the fetch_irq() variants anymore.
> 
> Convert to the regular interface.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Remove the obsolte u64_stats_fetch_*_irq() users.
      commit: 93cc2559d3fdcd28b1a7972ab519a6cd8ba20f9d

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
