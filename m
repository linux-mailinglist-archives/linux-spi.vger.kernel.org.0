Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8662C141
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKPOqK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiKPOqJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 09:46:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AE3F05A
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 06:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F6FB81D9C
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 14:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8813CC433C1;
        Wed, 16 Nov 2022 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668609966;
        bh=v3HpvHpJVomdvbJxt/gV40DgO5WOFh9zEdu74EvhTpQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G0FwN+HTklYG+6ssLiUA7IekuVIWbrsY0kuWpY3Z5C8LyhhTVrTAXuRVKoZFtSwZx
         auy5cWg7IUjyqnaXEhEEeVDQH5AZeIo0tMXi6b375Stom70DQ1ef6ORoQczUXPEyta
         qZiLfBAgkKe9aivV+/TtaGgVLejxdLktgw+8bf8KSQL3P8ZiGW43TnhwQBlv/fcolf
         XfnK5nFBRXBR5YD7ECDaBRam23lPWosW+4g1MrpxonGUUi/zqeooPtB4NqbND4HZtl
         QqRRKLvHTPW/0HKtjYi4f2+mQ8KDr2ecEOuRb7OFp7bSod6MwyUYuGE8jM+yyzeRqy
         TtPRkUiF7hb9Q==
From:   Mark Brown <broonie@kernel.org>
To:     feng.tang@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linus.walleij@stericsson.com, fancer.lancer@gmail.com
Cc:     linux-spi@vger.kernel.org, yangyingliang@huawei.com
In-Reply-To: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
References: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()
Message-Id: <166860996429.526539.15589221652649718177.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 14:46:04 +0000
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

On Wed, 16 Nov 2022 17:32:04 +0800, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev. Since 'dma_dev' is only used to filter the channel in
> dw_spi_dma_chan_filer(). After using it, we need to use pci_dev_put() to
> decrease the reference count. Also add pci_dev_put() for the error case.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()
      commit: 804313b64e412a81b0b3389a10e7622452004aa6

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
