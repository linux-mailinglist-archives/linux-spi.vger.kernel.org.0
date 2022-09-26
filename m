Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E185EB525
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIZXJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZXJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 19:09:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D2AA4DA;
        Mon, 26 Sep 2022 16:09:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B402D6D9;
        Mon, 26 Sep 2022 23:09:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B402D6D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664233761; bh=2p/EPuoFqvaDv4uqMLHwlAFSCdcJ1ybk/XDKdDwtX2Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M52sr2DDaEuWhakEVDGyrUP6LL+fWLDM0JGmao5OoWT+kEsOWTs8JRaPWcEyXxeNb
         rhIXAVeH80jWMCQHLSymcxxwDDXgqOFZ0BlLpnwCtY5P+SO7J0Cr7OC2cb+QlkMEfU
         1SlQobuyrBUfcEPIz5O/xenn9m2MTm31yCsvgyUE5EI42M/9niDiHJVVIAa9/t0jQn
         z5XSUxHlusj5fm+y1M372RhgRN/Eb6/04JBHmfXnC5Ar6bxiFixKy70ue158zrjIkD
         0jrbuV7VT4QszqQmbwi92prZdAbFN6TA1vmmcxIGWKAUkILXnN7/2h1XW3QBVHdo0k
         N4QcXzGeauWag==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, lukas@wunner.de, yangyingliang@huawei.com
Subject: Re: [PATCH -next v2] Documentation: devres: add missing SPI helper
In-Reply-To: <20220923141803.75734-1-yangyingliang@huawei.com>
References: <20220923141803.75734-1-yangyingliang@huawei.com>
Date:   Mon, 26 Sep 2022 17:09:21 -0600
Message-ID: <87leq5pwbi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

> Add devm_spi_alloc_master() and devm_spi_alloc_slave() to devres.rst.
> They are introduced by commit 5e844cc37a5c ("spi: Introduce device-managed
> SPI controller allocation").
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> v2:
>   Put alloc functions above the register function.
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 2895f9ea00c4..7a3c34214c4c 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -436,6 +436,8 @@ SLAVE DMA ENGINE
>    devm_acpi_dma_controller_register()
>  
>  SPI
> +  devm_spi_alloc_master()
> +  devm_spi_alloc_slave()
>    devm_spi_register_master()

Applied, thanks.

jon
