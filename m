Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C75E737D
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIWFje (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 01:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIWFjd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 01:39:33 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F093BBB
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 22:39:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E73A8100DCECA;
        Fri, 23 Sep 2022 07:39:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B76BD4F386; Fri, 23 Sep 2022 07:39:29 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:39:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
Message-ID: <20220923053929.GA5035@wunner.de>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <YyoHjY14hSJj85oP@sirena.org.uk>
 <19da3b7e-121b-90be-7631-cdfcf8327140@huawei.com>
 <YysEH6MwNc8naD27@sirena.org.uk>
 <1288dcc5-0b48-eec5-5d2a-879d1cc14d02@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288dcc5-0b48-eec5-5d2a-879d1cc14d02@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 21, 2022 at 09:19:35PM +0800, Yang Yingliang wrote:
> On 2022/9/21 20:37, Mark Brown wrote:
> > On Wed, Sep 21, 2022 at 10:02:25AM +0800, Yang Yingliang wrote:
> > > On 2022/9/21 2:33, Mark Brown wrote:
> > > > If we're switching please update to the modern naming and use
> > > > "controller" rather than the old name.
> > > Do you mean to use spi_controller instead of spi_master? Something like
> > > this:
> > > 'struct spi_controller * ctlr = devm_spi_alloc_master();'
> > 
> > Or just use devm_spi_alloc_controller() directly.
> 
> Does __devm_spi_alloc_controller() need be changed to
> devm_spi_alloc_controller(), then use
> it, or just use __devm_spi_alloc_controller() directly.

Modern drivers only differentiate between master and slave on
allocation.  They use struct spi_controller instead of spi_master
and generally only call the spi_controller_*() functions (again,
except on allocation).  I think Mark wanted you to convert the
drivers so that they use struct spi_controller everywhere,
but that can be done in separate patches.

Thanks,

Lukas
