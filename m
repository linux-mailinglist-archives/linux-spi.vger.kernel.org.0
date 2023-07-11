Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5F74FA93
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jul 2023 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKWEP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 18:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGKWEN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 18:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB9170E
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 15:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0768615AD
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 22:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52141C433C8;
        Tue, 11 Jul 2023 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113052;
        bh=3kbF5IqMbiuB3gESOOg3g0MlmgrJeWd8BwM/Ij9cOo4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t/TLGrcdCuF1dy0AoTbnSyz142YRqEDwVD90jb+mnQ+ZKezGlKG2Nc59F+Ooszm5c
         Iy5H7gsDeGYyqTKHr7RLIhaAHvft/00ypnR6s/639DhbOj3isRDA5jYL+s6SoVPpfv
         Dl+9DmIwHS6zg6njfh+O6cGk2hAHC/b7cV1xTdiJv/hLRCXynTohGE/TsG0EO4xYKO
         3r5aHf1sCbWfPmWR3eQ2GZ6hIbouZ9IZ+UAjaaTFZKPd0IJp4SCJ1WufCLZxUZbIPP
         NDR8B7z3RS1hDF/r/1xmoYqSUcO4+l/8sp+iuFD5KCjwfZW33rRDLYjjLsECemyiP/
         euf6sQTYoim0A==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230707071119.3394198-1-u.kleine-koenig@pengutronix.de>
References: <20230707071119.3394198-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: rzv2m-csi: Convert to platform remove callback
 returning void
Message-Id: <168911305105.642798.4584582003945614901.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 07 Jul 2023 09:11:19 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rzv2m-csi: Convert to platform remove callback returning void
      commit: 9303331461cb63a61e598655106a088c953e5660

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

