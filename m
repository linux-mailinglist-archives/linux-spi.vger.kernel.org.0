Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A477E630
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjHPQRR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbjHPQQr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 12:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23928271D
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 09:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60B062579
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 16:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B59FC433C7;
        Wed, 16 Aug 2023 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202597;
        bh=XAWwIxT0ic4hoOj1N3TtsNoKTELwd3VIY2VtzSaZ8oQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XxbrkcmMBBqEbSCSPcFENtBnTmOZRAey20uMwml0fqhqmTEAhEQ7BpNEDdxNqf3xx
         cY4f3V2qKe/CQzeCy8YXPzEEWtMYsl94Gwn++N5SalLbiTx+ZLwblrsZxQjvSojE9I
         uuMrwt1Wp+InC+Bhk3L5UUTKfTgrdfhj1hNZWO300Rq6ZQb4/+anoKPkNa232vdw4D
         9qOCw0fxVhjiCfQZFO7qkP0KlJfGlcWAOveHN0SBQ3PKvVU566gqs+uQSKvHdGbw8N
         i9tHOaWFx570jaNLV37nIsiBuxD7Wu1GlNVmwZwspI5fS4FYmAgIa+SgTaWeuTXCIY
         UPwrsKdh+O7ZQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de, fancer.lancer@gmail.com
In-Reply-To: <20230816093938.1274806-1-yangyingliang@huawei.com>
References: <20230816093938.1274806-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: dw-mmio: keep old name same as
 documentation
Message-Id: <169220259583.817565.3022901800932980623.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 17:16:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 16 Aug 2023 17:39:38 +0800, Yang Yingliang wrote:
> The documentation has not use the new name(host/target),
> so keep the comment words same as documentation used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-mmio: keep old name same as documentation
      commit: ecd02b6dee29b3d3a180cfda39d989752d0e913a

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

