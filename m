Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12430712AF0
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjEZQpC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjEZQpB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 12:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBBDF
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 09:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91726145C
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 16:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C39C433D2;
        Fri, 26 May 2023 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685119494;
        bh=zZg/xYL20iIFg4vnfaHBbxE4L+6FlHKIlod4OYwKiRU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lMQEp2AzQCzvpdKm9V9c3mjpzpddpP0knZ3BPOJDCG4vpNZGcN00YaXmF1lef/C63
         NdOaVM13PfWoFSRU8sbIxaEvc6t2GxoEf7koZstIjWmJms/GhGJsgSnHzssGpGYd8M
         JwvCTjhzTeLogPAeXKp73sHSuZFkols4VFPYd8h3CzMZdWYDpOhvx+2UsB3Z8GDDzq
         DL724RmMCCmlqaNPYyt12hUtgmcV2nPiGvwwGbPDZ6pVwCq0ZgoHmhXaEqzaUVf95m
         raQLB4a9+Qmu7FKQI1eNGpWmpaLDwRvd5zykE2g57TxWLwIWguq9saPixLjRwPgv0k
         Rqewe8dr3gT8w==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230525211047.735789-1-u.kleine-koenig@pengutronix.de>
References: <20230525211047.735789-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: Switch i2c drivers back to use .probe()
Message-Id: <168511949335.40545.1373031844188788156.b4-ty@kernel.org>
Date:   Fri, 26 May 2023 17:44:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 May 2023 23:10:47 +0200, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Switch i2c drivers back to use .probe()
      commit: 3e39448ad9b29ee1beb409210812b1a3df11de3f

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

