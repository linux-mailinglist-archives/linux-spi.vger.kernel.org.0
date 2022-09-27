Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2014F5ECE4B
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiI0UTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 16:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiI0UTO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 16:19:14 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADC4C60A
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 13:19:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 667CC300BA6FC;
        Tue, 27 Sep 2022 22:19:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4815E2E576; Tue, 27 Sep 2022 22:19:01 +0200 (CEST)
Date:   Tue, 27 Sep 2022 22:19:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <20220927201901.GB24652@wunner.de>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMsc1IM/73CMEeg@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 27, 2022 at 06:01:39PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2022 at 03:31:29PM +0200, Lukas Wunner wrote:
> > On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:
> > > Do you mean to introduce two more proper wrappers to instead of
> > > devm_spi_alloc_master/slave() ?
> 
> > Honestly I don't think there's room for (or a need for) improvement here.
> 
> The issue here is that we're trying to get rid of the master/slave
> terminology.

Converting drivers to use spi_controller everywhere in lieu of
spi_master is fine, but drivers need to specify whether the
spi_controller is a master or a slave and Geert's design is
to specify that on allocation.  Which makes sense because
that's the moment the spi_controller comes to life, there's
no earlier moment where one could specify the type.

Thanks,

Lukas
