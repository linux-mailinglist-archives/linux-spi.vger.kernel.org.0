Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013F34DDA0A
	for <lists+linux-spi@lfdr.de>; Fri, 18 Mar 2022 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiCRNAr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Mar 2022 09:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiCRNAr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Mar 2022 09:00:47 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109752D0B26
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 05:59:27 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 485C2300002A8;
        Fri, 18 Mar 2022 13:59:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3BD702D2CC4; Fri, 18 Mar 2022 13:59:25 +0100 (CET)
Date:   Fri, 18 Mar 2022 13:59:25 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Miguel Angel Ajo <majopela@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-spi@vger.kernel.org
Subject: Re: bcm2711 / RPi4 not functional after d62069c22eda
Message-ID: <20220318125925.GA21543@wunner.de>
References: <CAC3B9fn9DWezr3rspLbomuRLtRjSvW89cLMWR9TTCYsX=PDM_w@mail.gmail.com>
 <CAC3B9fkpO13QhCgVO-qyynbwdh_z60CKgpUhn-40NyGNGz_q8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC3B9fkpO13QhCgVO-qyynbwdh_z60CKgpUhn-40NyGNGz_q8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[cc += linux-spi; please do not write developers directly without cc'ing
relevant lists]

On Fri, Mar 18, 2022 at 11:54:35AM +0100, Miguel Angel Ajo wrote:
> On Fri, Mar 18, 2022 at 11:47 AM Miguel Angel Ajo <majopela@redhat.com>
> wrote:
> >     I wanted to share a regression found after commit:
> >
> > d62069c22eda spi: bcm2835: Remove shared interrupt support
[...]
> > After this commit I get:
> >
> > [root@rpi4-64 ~]# dmesg | grep spi
> > [   18.781250] spi-bcm2835 fe204000.spi: could not register SPI
> > controller: -517
> > [   19.134138] spi-bcm2835 fe204000.spi: could not register SPI
> > controller: -517
> > [   19.895147] spi-bcm2835 fe204000.spi: could not register SPI
> > controller: -517
> > [   20.400137] spi-bcm2835 fe204000.spi: could not register SPI
> > controller: -517

Those are transient errors, -517 is -EPROBE_DEFER.  Probing fails
because a resource is not available (yet), to be retried again later
if/when it becomes available.


> > ecfbd3c introduced support for the bcm2711 SoC that shares
> > one interrupt over multiple spi controller instances.
> >
> > Do we have a more detailed description of the exact issue for
> > which we reverted?, is there a plan to re-introduce the shared interrupt
> > support while fixing the issue?

See here for why the commit was reverted:

https://lore.kernel.org/linux-spi/20200529174358.som3snunfxch6phi@wunner.de/

There was a second attempt to introduce shared interrupt support,
but after a lengthy discussion, it was not pursued to fruition:

https://lore.kernel.org/linux-spi/20200604212819.715-1-f.fainelli@gmail.com/

So I believe shared interrupt support only exists in the Raspberry Pi
Foundation's downstream kernel, but not yet in the mainline kernel.

Thanks,

Lukas
