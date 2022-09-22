Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA665E69FE
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiIVRyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiIVRyV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 13:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8744106504
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 10:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D3B63701
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 17:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC336C433B5;
        Thu, 22 Sep 2022 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663869258;
        bh=k017GrdbgsBhj9lK2zwnWl+jpRSespv4ciMXHMOCUEc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l4CZq5KjRMM04tjWffdcTYlPugzIcsEuSwrAya7/Nbje7OQOiBfBP7BPc8+qzBJQq
         nzzmJoCJxzLKXUAxwYlAi89r0rjq+q69QtduojzY8imULP0TwXNrsk3ss4+M4l+rsG
         Q75toxFXl3q2VQu0sTTeDyW2tzxDCLaQF1lNUlxC9WdwOkEnwqjDTH4tzPCb6Z3WAr
         g+jJlhO6Cya+iefrpWheOeXhz9XP1KWA7eDqLSsGvbByMXNY6768W5Z1pEPmBRUc2T
         RBHv+54EYA0WIj39V8w2ZnBoodBJjNqqJqTCk4d3HWEiPVhSn/w0hqrdJQEitdW22M
         CH5v73OtjABfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org
Cc:     jcmvbkbc@gmail.com
In-Reply-To: <20220920114448.2681053-1-yangyingliang@huawei.com>
References: <20220920114448.2681053-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
Message-Id: <166386925472.727991.10531908902956154500.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 18:54:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Sep 2022 19:44:48 +0800, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
      commit: 478cc2fc3dd782f7935bc0ab84c198691ea83fa3

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
