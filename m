Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76397EA3E5
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKMTku (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 14:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjKMTkq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 14:40:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4D172A
        for <linux-spi@vger.kernel.org>; Mon, 13 Nov 2023 11:40:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB68C433C7;
        Mon, 13 Nov 2023 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904442;
        bh=UBVmv/ay6J9uJy8HdA/+nOLWVanCMLDV6eSWFpVPcSg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pa6iNev9AL1l5Wv7YKibC1ixZVJNLRiga3cAOGGJpdU96MYx0euQ0PqZNWUTLKVMX
         kDu8iymExX4f6DbK3BG/64KKYHhKCgumYK9A/bFfLg6jzB3hgwAz67pWx2wif0tAil
         99jkaisnoSZJbNeEr1Oq6kP3qB7JVFuXYspP/xIdoRivXn2bbP1LQcI33zhowUkVQe
         sH3mvKvZZe4/e7xdP0sScMR0RUeiCSZvp+3mFe4ZrdIid8YEK05qjWfXBZB+99a1mO
         GZ4Lz9ts2abiHXWPDKi0NaAd7fJOJ7LEW4uBMOzMF4lOjAcmL5YLth8xV2vZvaAcSx
         oUmVKmwqwX7Kw==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: cadence-xspi: Drop useless assignment to NULL
Message-Id: <169990444127.3294163.8325267071614429149.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 05 Nov 2023 15:39:33 +0100, Uwe Kleine-König wrote:
> Static structs are initialized with zeros for unspecified fields. So
> there is no advantage to explicitly initialize .remove with NULL and the
> assignment can be dropped without side effects.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-xspi: Drop useless assignment to NULL
      commit: dfa8121a6ca7725576f71f7b505f711e1148f151

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

