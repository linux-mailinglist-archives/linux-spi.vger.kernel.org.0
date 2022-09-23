Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5515E8096
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIWRVt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWRVs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 13:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551311DFED
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 10:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B45561898
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 17:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42D7C43141;
        Fri, 23 Sep 2022 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663953706;
        bh=CN3w9Rsw+bVoi2KMziPzkjpfLTi7U7wwmVXFbAB+bQI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Mjb3AsQqb3GaViOVu3ofe0cWU6og2wNsKGM21RN0bXeTQGQsJuFIq9X0sAfb3wBIi
         eqQTasneDLH8jvo0k0P1vxmqjee4Crv6YJQzBzeizKIVqBOsFst09Jcqq+ybpz8n+N
         JCoOfZOrXS90gXRzD/ZKm/TXKV4ZDUiLDTXHV3AtNwIJLdeBkwR8DT9NdojbfUZuC/
         +1Rp0JJxiF9giCtn4gc8JNXEfIYtBvAzwq3O/gBfEwhbHg2an6jacfKuLok+P0Ypkl
         Yuvtc/ehEO3a2SGZ8mAmQpBR0PWYFUSLLiXSA3810ssSCumTPRxc6TstUyboqgMiS3
         tKHjdJoCYOVOw==
From:   Mark Brown <broonie@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>,
        linux-spi@vger.kernel.org
In-Reply-To: <20220923101726.19420-1-shangxiaojing@huawei.com>
References: <20220923101726.19420-1-shangxiaojing@huawei.com>
Subject: Re: [PATCH -next] spi: cadence: Remove redundant dev_err call
Message-Id: <166395370566.637404.13656459333088824812.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 18:21:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 23 Sep 2022 18:17:26 +0800, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Remove redundant dev_err call
      commit: 9671847f93a5291ad85f88210fb56e1a946b757b

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
