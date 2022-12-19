Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A25651433
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 21:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiLSUpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Dec 2022 15:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSUps (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Dec 2022 15:45:48 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329BB26EF
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 12:45:48 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9F8B91286;
        Mon, 19 Dec 2022 21:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1671482746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MNliq0OtPSniUfJO4z6mKTNJG9hQrMZSCk6h9pWkYM=;
        b=AO/TdFYvX3nPeYrEribwe+99kBHPB3pEH+3Gx+++M7UJBFHkKPyW+XWym3ZWxyf/dXhScg
        aTm3kvLA7ZVyVo1IzBnc555PyU6lsC9ZCr1MzhVRxdwcY5tAs4AWJdulu7VNTTbMxzjeKa
        9Zzss6nW7DMhA37uNTot67PFmrNY0cwkoFCua0gl7pXSDooDa70zqfeUEVzsE8WiFAI6He
        nwjpoDhDUjWd1VvBbM1mJCjbccP77EWmJG/cBgCsfdgluITxDH/r0a9RSIfIZTcCZ0n1vC
        wePWXMih7XNDLYaOMllU1GdBe3b3CTknvgI7ba/eU6fYPV90R1G/QH3zmBJ+hw==
MIME-Version: 1.0
Date:   Mon, 19 Dec 2022 21:45:46 +0100
From:   Michael Walle <michael@walle.cc>
To:     Han Xu <han.xu@nxp.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: DMA support for FlexSPI driver
In-Reply-To: <20221219204140.ppbgpgze25jvuxxh@umbrella>
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
 <7c42628489ab90b545a8d86ba2e46696@walle.cc>
 <20221219204140.ppbgpgze25jvuxxh@umbrella>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <82c388d7f14b718512fe5b25c07e047a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2022-12-19 21:41, schrieb Han Xu:
> On 22/12/19 09:21PM, Michael Walle wrote:
>> [+ Frieder and Boris]
>> 
>> Hi,
>> 
>> Am 2022-12-19 21:09, schrieb Han Xu:
>> > On 22/12/19 02:08PM, Fabio Estevam wrote:
>> > > Hi,
>> > >
>> > > Currently, there is no DMA support for the
>> > > drivers/spi/spi-nxp-fspi.c driver.
>> > >
>> > > Is there a technical reason that prevents DMA to be used on this
>> > > driver with the i.MX8MM?
>> > >
>> > > Also checked the NXP vendor driver, but DMA support is also missing.
>> > >
>> > > Does anyone know more about the reason for this?
>> 
>> flexspi is a copy of the spi-fsl-qspi driver and I'd say the
>> latter just got the basic operations polled IO or the memory
>> mapped access and nobody cared :)
>> 
>> > We are working on that, both flexspi driver and sdma driver need to be
>> > updated,
>> > and will upstream all once done.
>> 
>> Are you also working on the DMA support for the layerscape
>> architecture which is using eDMA?
> 
> Yes, we will update qspi driver as well, it's almost same as the fspi 
> one. But
> almost everyone is on vacation in these two weeks, it probably can be 
> done as
> early as in Jan.

sure, but I was talking about the lx2160/ls1028a which also have the
flexspi but a different dma controller (edma) than the imx.

-michael
