Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85F77DEF1
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjHPKjL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbjHPKis (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:38:48 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA552123
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:38:45 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qWDvC-0004fW-Fx; Wed, 16 Aug 2023 12:38:38 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Subject: Re: [PATCH -next 13/24] spi: rockchip: switch to use modern name
Date:   Wed, 16 Aug 2023 12:38:37 +0200
Message-ID: <2351422.atdPhlSkOF@diego>
In-Reply-To: <CAMuHMdXfov+UhdpapX4h-nANByUc9hAJY5aQmQB5+j4iFLyPgQ@mail.gmail.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
 <20230816094013.1275068-14-yangyingliang@huawei.com>
 <CAMuHMdXfov+UhdpapX4h-nANByUc9hAJY5aQmQB5+j4iFLyPgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Am Mittwoch, 16. August 2023, 12:20:55 CEST schrieb Geert Uytterhoeven:
> Hi Yang,
> 
> CC Heiko
> 
> On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
> > Change legacy name master/slave to modern name host/target or controller.
> >
> > No functional changed.
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/spi/spi-rockchip.c
> > +++ b/drivers/spi/spi-rockchip.c
> > @@ -104,8 +104,8 @@
> >  #define CR0_XFM_RO                                     0x2
> >
> >  #define CR0_OPM_OFFSET                         20
> > -#define CR0_OPM_MASTER                         0x0
> > -#define CR0_OPM_SLAVE                          0x1
> > +#define CR0_OPM_HOST                           0x0
> > +#define CR0_OPM_TARGET                         0x1
> >
> >  #define CR0_SOI_OFFSET                         23
> >
> > @@ -125,7 +125,7 @@
> >  #define SR_TF_EMPTY                                    (1 << 2)
> >  #define SR_RF_EMPTY                                    (1 << 3)
> >  #define SR_RF_FULL                                     (1 << 4)
> > -#define SR_SLAVE_TX_BUSY                               (1 << 5)
> > +#define SR_TARGET_TX_BUSY                              (1 << 5)
> 
> I assume the register bit names come straight from the hardware
> documentation, so you cannot just change them without making future
> maintenance harder.

Not necessarily. I.e. the TRM up to the most recent rk3588 does talk about
that bit as master/slave, but the bit itself is just named OPM.

----- 8< -----
opm
Master and slave mode select.
1'b0: Master Mode
1'b1: Slave Mode
----- 8< -----

So I'd call that a grey area. I.e. grepping for the field in the manual
won't work directly, but when reading people need to make the connection
every time that master in the TRM means host in the kernel etc.

If that is the way to go is a call for someone else, I guess


Regards,
Heiko


