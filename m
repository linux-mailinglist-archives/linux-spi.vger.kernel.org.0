Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36685E7A07
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiIWLyo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 07:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiIWLyo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 07:54:44 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540722C11A;
        Fri, 23 Sep 2022 04:54:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 77C4D3000CACB;
        Fri, 23 Sep 2022 13:54:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5F1DD4F386; Fri, 23 Sep 2022 13:54:36 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:54:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
        corbet@lwn.net, broonie@kernel.org
Subject: Re: [PATCH -next] Documentation: devres: add missing SPI helper
Message-ID: <20220923115436.GA17203@wunner.de>
References: <20220917122639.1896965-1-yangyingliang@huawei.com>
 <20220923055518.GA17668@wunner.de>
 <a61fd394-978f-1a12-b38e-2f3ab8ad02f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61fd394-978f-1a12-b38e-2f3ab8ad02f7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 23, 2022 at 02:32:42PM +0800, Yang Yingliang wrote:
> On 2022/9/23 13:55, Lukas Wunner wrote:
> > On Sat, Sep 17, 2022 at 08:26:39PM +0800, Yang Yingliang wrote:
> > > Add devm_spi_alloc_master() and devm_spi_alloc_slave() to devres.rst.
> > > They are introduced by commit 5e844cc37a5c ("spi: Introduce device-managed
> > > SPI controller allocation").
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   Documentation/driver-api/driver-model/devres.rst | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> > > index 76cc256c9e4f..1bd6f38dd7e3 100644
> > > --- a/Documentation/driver-api/driver-model/devres.rst
> > > +++ b/Documentation/driver-api/driver-model/devres.rst
> > > @@ -437,6 +437,8 @@ SLAVE DMA ENGINE
> > >   SPI
> > >     devm_spi_register_master()
> > > +  devm_spi_alloc_master()
> > > +  devm_spi_alloc_slave()
> > >   WATCHDOG
> > >     devm_watchdog_register_device()
> > Putting the alloc functions above the register function would
> > probably be more in line with how they're used.  Apart from that:
> 
> Do I need send a v2 to move up alloc functions with your review tag.

I'm not seeing v1 of your patch in linux-next, so apparently it
hasn't been applied yet.  So yes, if you could respin that would
be great.  Please cc me both on this patch as well as any
devm_spi_alloc_master() conversions you make.

Thanks,

Lukas
