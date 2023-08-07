Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C147731B4
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 23:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjHGV5e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHGV5d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 17:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD9B3
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 14:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 960FE6223E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 21:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8DDC433C7;
        Mon,  7 Aug 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445450;
        bh=dW5uG1HSVmUAqZ1GgM9+74p4RHlWKXIwvURreli0GDE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=p7I6IAsk/PkJiR7jHg1nBr/XA2HsNC3hd7nSC9CeHkcuTpbVDEmVjtFs0DU/t4H26
         9VSiczl9CYfdUw2+tk7jPNCrsK27tCMofvR+mn5dir8cSaKOAMToyCjTR1bqZQmXOp
         YebI1D9ukLIkaOrWiShs9XKjTs4tYqj4YRl1aKEsdi71liq/Wfd2Ac4hQg6u0U8P/T
         83TH3JGx/ZvzajwNI/SfuWIo6giJcSU+UWETnraAD53zsrggxF0LccWrcpmi+tEK0e
         nJi8W8SSbP8AiiU0DaGg24Uqm0fsBfHlfp50jam5EFSLoV+78r6SPgQQuQhlCNpqKN
         Pc+AskBWJsdlA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Zhu Wang <wangzhu9@huawei.com>
In-Reply-To: <20230801135442.255604-1-wangzhu9@huawei.com>
References: <20230801135442.255604-1-wangzhu9@huawei.com>
Subject: Re: [PATCH -next] spi: omap2-mcspi: remove redundant
 dev_err_probe()
Message-Id: <169144544923.329334.11971424668619291344.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:29 +0100
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

On Tue, 01 Aug 2023 21:54:42 +0800, Zhu Wang wrote:
> When platform_get_irq() is called, the error message has been printed,
> so it need not to call dev_err_probe() to print error, we remove the
> redundant platform_get_irq().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: remove redundant dev_err_probe()
      commit: 142c61a5fddeb755c420cb2e23b4bc0c0901308f

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

