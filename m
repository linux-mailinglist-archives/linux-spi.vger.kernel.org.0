Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AC1D776A
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgERLi0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgERLiZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:38:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E6C061A0C;
        Mon, 18 May 2020 04:38:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so5011955pjb.4;
        Mon, 18 May 2020 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFYbOS9O2Ltwi9wFSOezvo7kaD7sfz92gMvItxnnShM=;
        b=NXMQfkf2JjFCUAex4KRSqSyb1zZG9+lbZ8xVO4CeS037zxqs7aomMFCIYlpeW3sImx
         XkzoyJhhdsNP/UPSybb/FvWsgsd9o4QwKLhcgzE5jThKXARHk17wvO2Nrpkvtatamd6T
         eIi8GPXjgouP9M+SBTBrpfn0iHp/EjDr8eVt61m1T1Wm7eYEEQ1ew5rem5iyN2JgpAmY
         HtaiGQslZ2n0rVoh+Siu3tOJUKJMviRsbz9HEMvCLryUqNUq/V5B8kBQ9IOcaSii+8TI
         +HKvnKBUumta0nugBBjmBO0DL/J9AxtiGyAzyvGO/telkWEIXOyJb1hzylG0q2AJMiAB
         jlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFYbOS9O2Ltwi9wFSOezvo7kaD7sfz92gMvItxnnShM=;
        b=q+f5qGJsS71FHi7WhpM2vtWfp2dMGtPXR+rhBQbq/AR1yysGHIt/Uk39F9MirIZYDc
         7ks/lJaUze/FHrmCLQETABo8KTDr1O8mHsCV29848ohbTUfEZaYHi2SKQJ2yPqIjNXZU
         JX9cbbmU6DkPJ80WwkZN83IMEU+nbb3wCo1shxPsnY3I5WWaogh0EZKO1oZ05TN2j5YM
         F508zSfHi+dYY+yTY84Uy2L+gl/qLsUO17PkmgvzE6BOm+WoIXFwV1BzN/7Wf80ZmAuc
         UaMslS1BIIozaMTlt5VH3DFmXcg7qyn3vSNNRtfEFEHAsMywOW1XDhMYDTAnS32DoUPN
         16yw==
X-Gm-Message-State: AOAM533Tm9SRnsrzcpQx1xnp+hRMJyeyXUDKufWSqpibfpglQfm7s9ea
        MQAViMZnDOh1D9NDIFAp8QQMAMW8tcuSA+ieJXo=
X-Google-Smtp-Source: ABdhPJynIdw8n9smtcUVVt1+xFJ7nfgBacpNT7rwXVcqHEAHNqbO846my5bVMtqSHbfVdZ6g8cgfW4hm1KY+nSJ1EA4=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr19706098pjb.129.1589801905266;
 Mon, 18 May 2020 04:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru> <20200515104758.6934-7-Sergey.Semin@baikalelectronics.ru>
 <20200515123422.GZ185537@smile.fi.intel.com> <20200516142030.kburieaxjg4n7c42@mobilestation>
 <20200518110004.GW1634618@smile.fi.intel.com>
In-Reply-To: <20200518110004.GW1634618@smile.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 14:38:13 +0300
Message-ID: <CAHp75Vf268nfwJ4Bm+A+-CsqjBSHgKVmiiON=ffUd79DCOcE8Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] spi: dw: Discard static DW DMA slave structures
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 2:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, May 16, 2020 at 05:20:30PM +0300, Serge Semin wrote:
> > On Fri, May 15, 2020 at 03:34:22PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 15, 2020 at 01:47:45PM +0300, Serge Semin wrote:
> > > > Having them declared is redundant since each struct dw_dma_chan has
> > > > the same structure embedded and the structure from the passed dma_chan
> > > > private pointer will be copied there as a result of the next calls
> > > > chain:
> > > > dma_request_channel() -> find_candidate() -> dma_chan_get() ->
> > > > device_alloc_chan_resources() = dwc_alloc_chan_resources() ->
> > > > dw_dma_filter().
> > > > So just remove the static dw_dma_chan structures and use a locally
> > > > declared data instance with dst_id/src_id set to the same values as
> > > > the static copies used to have.
> > >
> > > ...
> > >
> > > > -static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
> > > > -static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };
> > >
> > > > + struct dw_dma_slave slave = {0};
> > >
> > > I really would like to leave them separated and as in the original form, i.e.
> > >
> > >     struct dw_dma_slave tx = { .dst_id = 1 };
> > >     struct dw_dma_slave rx = { .src_id = 0 };
> > >
> > > those src and dst IDs are put in that form on purpose...
> >
> > As long as you don't tell us what purpose it is, my position won't change.
>
> It's not the way when your changes makes this the older (upstreamed) stuff's
> issue, it's an opposite. But I will help you here...
>
> > These structures declared here just hold the static memory and nothing
> > else. Allocating them on stack is better.
>
> I'm not talking about stack, it's fine for me, what I'm talking about is *how*
> they are being initialized. Read my message again carefully, please.

And to avoid additional churn around this, the purpose is to show what
Dreq number is in use actually for these transfers (that's why 0
assignment is explicitly there and no counterpart Dreq filled).

-- 
With Best Regards,
Andy Shevchenko
