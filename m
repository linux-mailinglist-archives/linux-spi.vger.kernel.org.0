Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C780169959F
	for <lists+linux-spi@lfdr.de>; Thu, 16 Feb 2023 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBPNXq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Feb 2023 08:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBPNXp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Feb 2023 08:23:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6765456B;
        Thu, 16 Feb 2023 05:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59E07B827F7;
        Thu, 16 Feb 2023 13:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DCEC433EF;
        Thu, 16 Feb 2023 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553822;
        bh=QoC6w+W5+IjPC7lXTWwpGP9CeD1GjolKIUfcqf2VQAU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gv+SoxJGxFb5KKAY2Tq3LNIU0gJRm0sv2857l/HvuqvEkOTlK0kHdxUfWE13v9Deq
         2+oDkiS1XWNVnnj5iB9JoRV7WW/Jw8trlk2y0imA3tn7Xg+hZiTooDFurbDzdDCLSj
         nnrp7n5eg5WwUxEWUJIgLRp1K5893RHY0m4QuH36Fupl5WUFp5ucUTzDYJwmQoegEC
         hA2kP2d9Q/m+u7bQ0SHGFIzuZzYR2Deul+uL7RQFyDsWDFadrCT+kttrNi2tA21MRu
         6xLqC7Cyd9/R4/0vpPzJpZD6btSwQvXsVpZf6zDOaXzef8lklnJbVz/hO/QtSR/CIW
         Kr8DqeQCwkgoA==
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <Y+zmrNJ9zjNQpzWq@kili>
References: <Y+zmrNJ9zjNQpzWq@kili>
Subject: Re: [PATCH] spi: bcmbca-hsspi: Fix error code in probe() function
Message-Id: <167655381929.3676429.15587417251493299810.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 13:23:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Feb 2023 17:05:32 +0300, Dan Carpenter wrote:
> This code accidentally returns success instead of a negative error code.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: bcmbca-hsspi: Fix error code in probe() function
      commit: 0696532e12524855fa8044590d374079f271f216

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

