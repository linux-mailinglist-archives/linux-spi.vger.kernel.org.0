Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839AA450918
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhKOQCi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 11:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhKOQCi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 11:02:38 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE49C061714;
        Mon, 15 Nov 2021 07:59:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e7so22018995ljq.12;
        Mon, 15 Nov 2021 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzUIYcTDeu7AABPbQcjXh6JIQXphQGEMy7nbkxcrjJA=;
        b=KbSslb+9UE5qfEOdmCWAMaI5UlDWuLQ78L/FXMwh3HEqZA3TWV7Ko7DuD8+0+bHdbZ
         gv1cFNK7XgaOaV8Ed4+y1avedzPv/WbT/ktEtuFDAkjk4UDtr3hMe+lZ4qlWTjopHw09
         qDt+iy/mi3fmfQNGNHpGK4WJZ1zm2AHfXVIhMMLdNsfUbNAyGaehm/pSW5aMO172ZDcq
         NCpM3NJAA8EwpeKtMC26cRRL6FKU5VlMqX+D1dh3/Wp4G1YxlGW95Ah67ebPs9azrY96
         AiYwE6HulCWPTLJkFtx+3PlU5WONEbzKRPBceMfnpSaPwrV3nA4etTZUhKfmCZ53Zmb7
         R3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzUIYcTDeu7AABPbQcjXh6JIQXphQGEMy7nbkxcrjJA=;
        b=g6iCQEv++0w24LCUl1PKjHc19pYaLdkzICeQBM6M+nfyme4M8qoPIlmbtDgcd2ocOK
         qhGeH8BL779IX3dVi1CX8iY2TU7fS1vej0T7eZewOszJxUTwf6y4hjI+jAGsC4pP+5vj
         2REc2wQrM88U8GfCv29X3GLn3Rr5i7YLInfF05UtnWe1uXXJjcSoVgMM+iBEhHyX0zs8
         Xd8PUQP4WnU9eD9r1tevurNdFwFnNVlQ4R4x39cJf1YzSRo4ATsy3alkezUONmH47LJP
         d4ockVH1woLxcws3BtXXLT7+O6fiT23o5iMdoOgoYIDoASZNfNmDghRtSxNdphBBNtVk
         PBuA==
X-Gm-Message-State: AOAM530To9fLGuHFEpL1L2LSxVuF1IsetegWYjSoGzeulrw/V/imonZo
        gcmKk5kgiLxFzFgjGaZ0hIA=
X-Google-Smtp-Source: ABdhPJzdlK9tvsO7ov7NVTwvGE2wpeq1+BGMgQHa6DQaiLwmVBMweiq1NqUrBTigvjHxfnscsctkAA==
X-Received: by 2002:a05:651c:2123:: with SMTP id a35mr40416450ljq.285.1636991980338;
        Mon, 15 Nov 2021 07:59:40 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id t1sm1527341ljd.43.2021.11.15.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:59:39 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:59:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core
 version checker
Message-ID: <20211115155938.xicjyjxmy4hfk2xf@mobilestation>
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-7-Sergey.Semin@baikalelectronics.ru>
 <YZJwTgAPZYVvzGpi@smile.fi.intel.com>
 <20211115150856.ma2wjg2ev5wylspg@mobilestation>
 <CAHp75VdsAzpUiM7U+f69PguGAa4QV+izM0p5DNNWp=d9yNT0eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdsAzpUiM7U+f69PguGAa4QV+izM0p5DNNWp=d9yNT0eA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 05:19:28PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 5:08 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Mon, Nov 15, 2021 at 04:35:58PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 15, 2021 at 01:30:26AM +0300, Serge Semin wrote:
> 
> ...
> 
> > > >  /* DW SPI controller capabilities */
> > > >  #define DW_SPI_CAP_CS_OVERRIDE             BIT(0)
> > > >  #define DW_SPI_CAP_KEEMBAY_MST             BIT(1)
> > > > -#define DW_SPI_CAP_DWC_HSSI                BIT(2)
> > > > -#define DW_SPI_CAP_DFS32           BIT(3)
> > > > +#define DW_SPI_CAP_DFS32           BIT(2)
> >
> > > In one patch you move this in the file upper.
> > > Here you reshuffling it due to dropping one bit.
> > >
> > > Now I'm wondering if you may split these two into a separate patch, which
> > > brings us to simple
> > >
> > > -#define DW_SPI_CAP_DWC_HSSI          BIT(3)
> > >
> > > here.
> >
> > I can change the bit-numbers assignment in the previous patch, which
> > moves this block of macros up to the top of the file. Thus we'll
> > have just a single
> > -#define DW_SPI_CAP_DWC_HSSI            BIT(3)
> > here. What do you think? Is that what you meant?
> 
> I think that reassignment doesn't fit the previous patch per se, hence
> I proposed to have yet another one,

> But in any case it's a minor
> thingy.

Since I have to resend the series one more time I'll do as you
suggested and unpin the bit numbering change into a separate patch.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
