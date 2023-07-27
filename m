Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AB765501
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjG0Na7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjG0Na6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 09:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7802723;
        Thu, 27 Jul 2023 06:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F6B661E85;
        Thu, 27 Jul 2023 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BA2C433C7;
        Thu, 27 Jul 2023 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690464654;
        bh=LV01kr3qsrJi1EDGWuqWhLrfy7F4nZBAVqWzOvclfKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0vXmgVOAS07LL1gN3Y8D3UAEZagkSeUNGNX3FPmVe85eyY6IGwd3Lj9hB8pa78ly
         41fOE2jetCyxStXoxb3iH2SKpk0MRQ0ffnhqMY6f2616tWdRstMZekrOWKR3KghJ76
         XdpytBMSq1NxhNVTj3GW0p7PgjX/smTfQpkr0lXFbqZ1lCSRExmm606y0gO78kyfO+
         VzKvM0w4rYWb3PWHInv7Zu2Kpg5OOQ51PJPLwdLv/JEaCAskxaf/6CZ/LR0YgxCpZ0
         7D621aE4wcD3I6cW/bdRe8aFqoC6p+h9RJd91ETimDhKgY/g/1qYBpS3oadY4KBMAA
         zbKFnUSHlWDLQ==
Date:   Thu, 27 Jul 2023 15:30:51 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] spi: s3c64xx: Clean up redundant dev_err_probe()
Message-ID: <20230727133051.jjngbtdqvclfyolk@intel.intel>
References: <20230727131635.2898051-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727131635.2898051-1-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chen,

On Thu, Jul 27, 2023 at 09:16:35PM +0800, Chen Jiahao wrote:
> Referring to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
