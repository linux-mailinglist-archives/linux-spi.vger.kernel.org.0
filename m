Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017594D47D0
	for <lists+linux-spi@lfdr.de>; Thu, 10 Mar 2022 14:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbiCJNPN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbiCJNPM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 08:15:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C33B8D683;
        Thu, 10 Mar 2022 05:14:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F2A2B825DB;
        Thu, 10 Mar 2022 13:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30FAC340E8;
        Thu, 10 Mar 2022 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646918044;
        bh=998PEMbF12m2v2E5Wc4oqi+ST2tEgniPYPGUEtiGWOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UHL5yUfFP1gj4upC7sC5uIJnHlGgbGNekIBT6EhTGo8qxzlX74cND+8ULQUmoqtRU
         Lt1aSVoynOgq6OxiU2A+kOdpJ7DJeX7Lfce6oUIitPczvmz9r4BHgaVurX+ymtuCY2
         0u+1EhjI/ac2EiwW/EKkHPnqTK2TP83lK+4E4TZuU7HN4Wm5AKsmGr+UeQ99TEF7Ee
         ik/YzBAZMKBvKvz7qT0JtOSviGD2MekAO74wn/M1E49EC9hzKpDqLPnvAJRU/k1SiY
         O2Z7swgXzMm2iI5e8Rmk4zSnt6kKHpYcWTGcV1e1xAvrgHk5KsdcAdcZKl39+cB3Xq
         LLidYPE7LtE6Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Yihao Han <hanyihao@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
In-Reply-To: <20220310094806.13734-1-hanyihao@vivo.com>
References: <20220310094806.13734-1-hanyihao@vivo.com>
Subject: Re: [PATCH] spi: rockchip-sfc: fix platform_get_irq.cocci warning
Message-Id: <164691804258.2018710.17609029778468697922.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 13:14:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Mar 2022 01:48:06 -0800, Yihao Han wrote:
> Remove dev_err() messages after platform_get_irq*() failures.
> platform_get_irq() already prints an error.
> 
> Generated by: scripts/coccinelle/api/platform_get_irq.cocci
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: fix platform_get_irq.cocci warning
      commit: 2cfdf0b4441aa918c3b18142740c92407b3c35a2

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
