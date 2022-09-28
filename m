Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD07B5EDFD3
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiI1PL0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiI1PLU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 11:11:20 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B82C13E
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 08:11:18 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 73E243000D929;
        Wed, 28 Sep 2022 17:11:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5A392324FD; Wed, 28 Sep 2022 17:11:16 +0200 (CEST)
Date:   Wed, 28 Sep 2022 17:11:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <20220928151116.GA13418@wunner.de>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk>
 <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
 <YzQsw8hiMTxdqZuu@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQsw8hiMTxdqZuu@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 28, 2022 at 12:15:15PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2022 at 10:43:08PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 27, 2022 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > > Sure, but since the current wrappers use the legacy names this means
> > > that we need new wrappers with more modern names hence there is
> > > something to improve here.
> 
> > So what are the more modern names?
> 
> It's unfortunately not 100% clear, and our use of controller for the
> generic thing gets in the way a bit.  There was some stuff from one of
> the open source hardware groups recently that tried to propose new names
> but I'm not immediately finding it.  "host" and "target" would probably
> do the trick?

Perhaps you mean that one?

https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/

Looks like they're replacing master with controller and
slave with peripheral.  Pity, we're using controller as
an umbrella term for either one of them.

Renaming that will lead to an awful lot of churn. :(

Thanks,

Lukas
