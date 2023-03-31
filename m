Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670D6D239D
	for <lists+linux-spi@lfdr.de>; Fri, 31 Mar 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCaPIe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Mar 2023 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCaPId (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Mar 2023 11:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25244B2
        for <linux-spi@vger.kernel.org>; Fri, 31 Mar 2023 08:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B8462A22
        for <linux-spi@vger.kernel.org>; Fri, 31 Mar 2023 15:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6EAC4339C;
        Fri, 31 Mar 2023 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275312;
        bh=vNtjPaHNUNU6oqdT77Lk95DBSAp3jzqhvU6+DrsGW5Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L6fnZ+sw7WvZ6DtEjF/rDx3MRlw1L4wCMFUU8gYgYdU5W394+xBC9w6JLcYDTTPYP
         n4w58sFALNJ96NKDDbpGYMDUv2p/vSR4Hq+qEzyuDFJK94ep1i5bMYPfIQC/wj8xcq
         gfcLutIUT68Ur7fsdu3h0m81HZRrUIu9uhKheKn1lFFEZRfVHbybwyhKQGOo+tLSS7
         p2Pwyv2t0RwGt3nzjAlJpKYZ+gJtxmREwl55ODq3ecG+iD69NoummztHsmV0fRUteC
         tBjqjNhlZOUVGpj40KmLG+SgwZwGNHliUm/SQoEJpJ53UDRRN9Y4tibLogGW6S9fCy
         EbhG+3pOuKFXA==
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230331052812.39983-1-mika.westerberg@linux.intel.com>
References: <20230331052812.39983-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel-pci: Add support for Meteor Lake-S SPI
 serial flash
Message-Id: <168027531129.3368485.17296810564519156990.b4-ty@kernel.org>
Date:   Fri, 31 Mar 2023 16:08:31 +0100
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

On Fri, 31 Mar 2023 08:28:12 +0300, Mika Westerberg wrote:
> Intel Meteor Lake-S has the same SPI serial flash controller as Meteor
> Lake-P. Add Meteor Lake-S PCI ID to the driver list of supported
> devices.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Meteor Lake-S SPI serial flash
      commit: c2912d42e86e494935722669e4d9eade69649072

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

