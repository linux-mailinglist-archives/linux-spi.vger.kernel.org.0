Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E153372023D
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjFBMiv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Jun 2023 08:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFBMia (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 08:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2201B1;
        Fri,  2 Jun 2023 05:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0FB65006;
        Fri,  2 Jun 2023 12:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F366C433A4;
        Fri,  2 Jun 2023 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709498;
        bh=IPU8TLmU2hYJoTc9TwVSKxHzByBu50xs7lBkNTi4cSw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AsEVNsZGTXzzYW9mTh7YQ2Js8obgyqsQJs5t+Dmf9YA42Pa/YQTzd/R6k4et8rqA5
         gWZlQdLzUDUGNnlYP13S1OuefMWK1uX+Y866MywVC0xTkz2e8y1A+y0iXyN8K1kGbU
         PwV3rdFAl/n1bkHCVoPbd7iqZ9sobHqWl+LWN6aLdxTzs+jqh+XMIimz0CPM/d5CYN
         i3fUOoti36dL2rY1HBDrBvcpyayaCh5B3Cs+1qFkjoY4Nse8cEa+HmWs5f7La+8t/c
         rORXS3QqRjmNr+jmjrWd1RMusLUXUhClPGDks6IfT9zmSxJOKE+O52dm2pVryujWY8
         0L1vElL7DRjXA==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20230531205550.568340-1-andi.shyti@kernel.org>
References: <20230531205550.568340-1-andi.shyti@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: Use devm_clk_get_enabled()
Message-Id: <168570949723.29417.13931671044967003727.b4-ty@kernel.org>
Date:   Fri, 02 Jun 2023 13:38:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 31 May 2023 22:55:50 +0200, Andi Shyti wrote:
> Replace the tuple devm_clk_get()/clk_prepare_enable() with the
> single function devm_clk_get_enabled().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Use devm_clk_get_enabled()
      commit: 20c475d21ed9326f7b1396c9bb8991b375cb6c50

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

