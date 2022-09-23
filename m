Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8685E822B
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIWSyf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 14:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIWSyZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 14:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCEF12204E
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 11:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8855C62865
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 18:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FDEC433B5;
        Fri, 23 Sep 2022 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663959257;
        bh=cUhfw9cC40lJSh/N9STV50cq2QWgTnsJJ7FL+KqnXfc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ryAik/xjveeqrdwhlXqPwr5YspAJFs5GY07EFEn5XFrrQntkyj8G4Bklr8m7NMsai
         VG9o1BP3fx1nGMV4g8P3TJhLhg10Ongj6869OEdIdiO9yIuoGj5D3p73JktXoSxrQX
         hM646OZ5jljkIuXXpq2oox2sPLwAQxaySgr3ciL8Aua7KgfbNNSZzZX5gFVXSfPANg
         4do7vminsfsaCKtb9a6u86pDg4Z+fVFvdW4uP+pHJfOi7ANLXy0k2E+QJpk6dJRRIt
         5dxKm6PCFdH5RhORBPqBKsnj8YTjIM5pF8+ZyI6Ymsp8GKnBTloyWOZQ3L7RpIN8pS
         oFSNZpeeXa/hg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     michal.simek@xilinx.com
In-Reply-To: <20220920114615.2681751-1-yangyingliang@huawei.com>
References: <20220920114615.2681751-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] spi: xilinx: Switch to use devm_spi_alloc_master()
Message-Id: <166395925688.804455.10147554808856145235.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 19:54:16 +0100
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

On Tue, 20 Sep 2022 19:46:15 +0800, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: Switch to use devm_spi_alloc_master()
      commit: 2d0645817436ed2e527d967701ee354630d43e94

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
