Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780186C540A
	for <lists+linux-spi@lfdr.de>; Wed, 22 Mar 2023 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCVSsD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCVSsB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 14:48:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8A69CC8
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 11:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 080F5CE1EA5
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 18:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E2C433D2;
        Wed, 22 Mar 2023 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679510866;
        bh=+2RZA89cKvOQHV5vU3irIkWRO2jJEN66Ly6duh6MRes=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aeyHvhi3v16GAU4ZexsGOcQznDRHdQgAM5HCGbYIO1SGwXOxy3LgJye+GX6GcuHj1
         mxWBRxMTH+a73tV3ThZ0fuhPr52LIykXv3JksE2g5D0TGDsLIcbXpiytSa2mTEKWzO
         AAxVQaJtR8DLEpZ5OQAgYvtCQ4950Wu4New9EH2FcUhLeUMaCNWSMJVJHXr+8UI1Lk
         zL3pdPOziOlgfQUp9Iw02opd2AsunHTfCUiPnX29Bd171TJLcVpupeHHZAv2n5UN40
         5s7cPzrUpPskyf3Rmq/jof/omU49XDYRTccBsF+N2FqURqd7Dd+ctewqo5S5QmTFJt
         zRN3bkpZAD4XQ==
From:   Mark Brown <broonie@kernel.org>
To:     han.xu@nxp.com, haibo.chen@nxp.com
Cc:     linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com,
        linux-imx@nxp.com
In-Reply-To: <20230322090451.3179431-1-haibo.chen@nxp.com>
References: <20230322090451.3179431-1-haibo.chen@nxp.com>
Subject: Re: [PATCH 1/2] spi: spi-nxp-fspi: correct the comment for the DLL
 config
Message-Id: <167951086432.1093026.7301601571841455888.b4-ty@kernel.org>
Date:   Wed, 22 Mar 2023 18:47:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 Mar 2023 17:04:50 +0800, haibo.chen@nxp.com wrote:
> Current DLL config is just to use the default setting, this means
> enable the DLL override mode, and use 1 fixed delay cell in the
> DLL delay chain, not means "reset" the DLL, so correct this to
> avoid confuse.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/2] spi: spi-nxp-fspi: correct the comment for the DLL config
      commit: 1ab09f1d070c4774175dab95e55d2b72c2a054ab
[2/2] spi: spi-nxp-fspi: use DLL calibration when clock rate > 100MHz
      commit: 99d822b3adc4f9af59cefdc6619cb3f64182efed

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

