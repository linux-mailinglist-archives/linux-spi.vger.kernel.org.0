Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C146DDDF9
	for <lists+linux-spi@lfdr.de>; Tue, 11 Apr 2023 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDKObS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Apr 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDKObF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Apr 2023 10:31:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC655593
        for <linux-spi@vger.kernel.org>; Tue, 11 Apr 2023 07:30:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q5so11164336ybk.7
        for <linux-spi@vger.kernel.org>; Tue, 11 Apr 2023 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681223435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhZDKAKLAWGqCJBxTZUcUQG85cdkTJ5f9dPKGGpJSYU=;
        b=impGA6PnoheZ3/kNSdj48madwyqtSp8uwFpVqXaHo4fJYxur1yrek3rD0q43T4Ylmb
         +Zy/RLj4cE79Jx23sy64iCtVvzaqZBglEH6XxBrKzT344sUgGtMemT3C5tVXzFOgcgPm
         8pGWq29bArxe1i9ka94yUiAdJgU8LwKY9dHATG4ekhxY2axPudXqSuBw/EE2tkwcdgTx
         DjG9l5rDYfeRoG8BlO6wtCZpL+j4GDTNNwTBwuMhh8P+lyyH90+0u9pkXml6lOQvI2Iv
         zENVQVgIEfD6LbqI4LZNKjTykwAFY24oASOWFcnMUwL8JhDABE9G8iNJ0upmIX5uVSMX
         GEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhZDKAKLAWGqCJBxTZUcUQG85cdkTJ5f9dPKGGpJSYU=;
        b=CTE2mz9zYaOUmdQHDZpRoLZMhCzqYyyPTYJzh4djC5da8c3vHdUJnbn4bv5r9p04FJ
         cooMWcWoJ+rdFFxJEse8pdYx75nsS0FKL+GcBgtfRS066QE0SEeNEDqeCZ9D1qqP4R+m
         zr30UXwv8i5nJlUlSjxCZJRlMIg7fj2ACjAfNeVZBFeQvmB8+XtsMVXOV7yZg/lfLm0w
         ySqpKQgyfJMmvQiy3CIpP5ZZeAVQf4e08PjVZK9GyQaLFmEcuOFh85GffkeyCBS5yk+3
         Wf8ncgExP0a2yxG4zUxPgxunatPdW9IXRkxLolz1t+3PyfIAFcIYw/8We0woCIrKPBXs
         iYmg==
X-Gm-Message-State: AAQBX9d1lFSJSUO5Q9hQ4o5t1WZ81p169mYToscgtvI1EYam09rAOs8E
        HlqN2wJreMNJVVqzVrGw4SdEf3rYm2pmaZ7erb+91g==
X-Google-Smtp-Source: AKy350aSUHNDMEBQHFG51I1T55aiT6TeeXEf5g5emI6PyKSBf+xqjNfWYf2DETRlgxuADXZLz5MoJiKdsU4AV2xlJQA=
X-Received: by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr11984613ybb.3.1681223435308; Tue, 11
 Apr 2023 07:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com> <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com> <20230411141115.vrfd6sud66u6xeog@mobilestation>
In-Reply-To: <20230411141115.vrfd6sud66u6xeog@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 11 Apr 2023 20:00:23 +0530
Message-ID: <CAOSNQF3MM6BLi=xs6VJFn9gWHU_00M--akcpsA=Jm=6U=3LZnQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andy,

On Tue, Apr 11, 2023 at 7:41=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
> >
> > First of all the Subject is wrong. You are not touching DMA controller.
> > Needs to be rephrased.

Sure, will rephrase this to "SPI DMA Driver" instead of controller.

> >
> > > Add Support for AxSize =3D 4 bytes configuration from dw dma driver i=
f
> >
> > SPI DMA driver
> >
> > (or something like this, note capital letters for acronyms).
> >
> > > n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > >
> > > Number of bytes written to fifo per write is depended on the bits/wor=
d
> > > configuration being used which the DW core driver translates to n_byt=
es.
> >
> > ...
> >
> > >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> > >  {
> > > -   if (n_bytes =3D=3D 1)
> > > +   switch (n_bytes) {
> > > +   case 1:
> > >             return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > -   else if (n_bytes =3D=3D 2)
> > > +   case 2:
> > >             return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > -
> > > -   return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> >
> > > +   case 3:
> >
> > I'm not sure about this.
>
> This actually makes sense seeing the function argument can have values
> 1, 2, _3_ and 4:
> dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> transfer->bits_per_word =3D __F__(master->bits_per_word_mask =3D SPI_BPW_=
RANGE_MASK(4, 32));
> ...
> dw_spi_dma_convert_width(dws->n_bytes)
>
> The spi_transfer.bits_per_word field value depends on the
> SPI peripheral device communication protocol requirements which may
> imply the 3-bytes word xfers (even though it's indeed unluckily).
>
> This semantic will also match to what we currently have in the
> IRQ-based SPI-transfer implementation (see dw_writer() and
> dw_reader()).
>
> -Serge(y)
>

Will keep this as is to be similar to dw_writer() / dw_reader() as
explained by Serge(y).

> >
> > > +   case 4:
> > > +           return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > +   default:
> > > +           return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +   }
> > >  }
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >

I shall create another patch series with the same.

Thanks
Joy
