Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872B5EC487
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiI0Ndb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiI0NdD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 09:33:03 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F61E723
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 06:31:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A7EAB30000873;
        Tue, 27 Sep 2022 15:31:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8FC6C1EEDA; Tue, 27 Sep 2022 15:31:29 +0200 (CEST)
Date:   Tue, 27 Sep 2022 15:31:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <20220927133129.GA29821@wunner.de>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:
> On 2022/9/27 19:21, Mark Brown wrote:
> > On Tue, Sep 27, 2022 at 05:45:25AM +0200, Lukas Wunner wrote:
> > > On Mon, Sep 26, 2022 at 10:29:32PM +0800, Yang Yingliang wrote:
> > > >   extern int devm_spi_register_controller(struct device *dev,
> > > >   					struct spi_controller *ctlr);
> > > This doesn't really make sense I'm afraid.  The umbrella term
> > > "spi_controller" can refer to either a master or a slave.
> > > One has to specify on allocation which of the two is desired.
> > > An API which purports to allow allocation of the umbrella term
> > > but defaults to a master behind the scenes seems misleading to me.
> > Yes, we'd need to either have two wrappers using some more appropriate
> > terminology than master/slave or have a parameter which specifies the
> > role.
> Do you mean to introduce two more proper wrappers to instead of
> devm_spi_alloc_master/slave() ?

Honestly I don't think there's room for (or a need for) improvement here.

Thanks,

Lukas
