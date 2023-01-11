Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74A66657A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jan 2023 22:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjAKVTo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Jan 2023 16:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjAKVTm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Jan 2023 16:19:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCEB57;
        Wed, 11 Jan 2023 13:19:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA31AB81D73;
        Wed, 11 Jan 2023 21:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40444C433EF;
        Wed, 11 Jan 2023 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673471978;
        bh=MPlb+QHocflpiJ0Q3JQrEliJMD8CbH2Y/klzRCc5T7Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dk2jyBMvwl+s7sljuzsQkfK/9/zC7d474L6znon0/CTWl4mW5CrquyW0dZ5PMxE9P
         DOJ6cx1/fE1+uQuLd4fRf/cERpq8w84bmkw4xAigop4lK6gNSrlnqrSXk5e+0dG0Q7
         wtEnmKlu/BMlmAv5jBB7VnjVe9aWj7PrEAA9xFdNLGkEwhbVyo7pkLQVPkEgBjndbS
         kr124r5lKeXevOevfjyxiqNz2DJRpmj2r8sUlcyQOVv/hO7jJn9/zj0yI54tQkQywO
         rrU66W7RceiLykQzmGQWvKbdiWlxvvEEi/c2SJEhIkPP0T9UgKsgzkpCC/gEuvb3tf
         WdEX06ktsjaaw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7c1b2700f3727e94600f5f7e10beef16f8dc64ed=2E1673425?=
 =?utf-8?q?053=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C7c1b2700f3727e94600f5f7e10beef16f8dc64ed=2E16734250?=
 =?utf-8?q?53=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove trailing whitespace
Message-Id: <167347197698.2692547.6376053519061876224.b4-ty@kernel.org>
Date:   Wed, 11 Jan 2023 21:19:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 11 Jan 2023 09:19:53 +0100, Geert Uytterhoeven wrote:
> Remove trailing whitespace that hurts my eyes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: trivial-devices: Remove trailing whitespace
      commit: f66804bf7665f9d2db04791496ba2c7f4173941c

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
