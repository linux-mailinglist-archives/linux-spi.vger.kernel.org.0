Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F567CC7A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjAZNnx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Jan 2023 08:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjAZNnu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Jan 2023 08:43:50 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785055BC;
        Thu, 26 Jan 2023 05:43:45 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id o5so1205852qtr.11;
        Thu, 26 Jan 2023 05:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N77UyFD9jkYHVmM/VcuVOQ1/gENkCEkFPyn91C0VC0Y=;
        b=tYK6tkngZ8KK6sb9GT8VhPH5UB0LDpd5UueeYT+4mkW43o6c+FCSyp5Qp3K8lQNGVl
         tf2V8AEnXswU4xthRUjptLduYvqJ3BpkylIpVALKPPZ97DGBpfGpQyBakFwqDwFJGy1W
         XcO35oLr9oXnpIfxayrPHWyCMFRUTXrtxFK66cStVvsxM5HaHlgyaa9ph3V9YmBS/jLq
         1rUILJAB1m7rPz0xfZNeVgGpTq+ikmDOTU+ljZPhEGvarqDGVJjrH/6WUbgUoppm24TK
         Vt2wcZ7fA1ezhvnRhAXfc+15/jnLcbNKwoq0ymsge/xTHpWgAFlZcmSjISSrU8UUFV7G
         8HcA==
X-Gm-Message-State: AFqh2koYCVkc18Q3Cz3J/E0A98dHZKPb3MWpfcdEHuxIDni726XxocmF
        QnfuerMwfsgDQ8dwn1ehpHamP0b4+UqbCw==
X-Google-Smtp-Source: AMrXdXuVZ18FcDmX7xqcAgrwxuEaZilJKBlbvy6sA3PaPmZOHYTlIJEgfS/KsPirdhhzAQXPDTvGkw==
X-Received: by 2002:a05:622a:1e1b:b0:3b6:317f:2d5a with SMTP id br27-20020a05622a1e1b00b003b6317f2d5amr50374490qtb.29.1674740624849;
        Thu, 26 Jan 2023 05:43:44 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id l3-20020ac84a83000000b003a5c6ad428asm702178qtq.92.2023.01.26.05.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 05:43:44 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4c24993965eso22794857b3.12;
        Thu, 26 Jan 2023 05:43:44 -0800 (PST)
X-Received: by 2002:a81:7e4b:0:b0:506:4f19:740c with SMTP id
 p11-20020a817e4b000000b005064f19740cmr960169ywn.383.1674740624253; Thu, 26
 Jan 2023 05:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
 <Y9J6+uoXxUIs4Bkk@ninjato> <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
 <Y9KC4Pu/AnnXOLhI@ninjato>
In-Reply-To: <Y9KC4Pu/AnnXOLhI@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 14:43:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBr+3EeErmmH_Qk+sPZfZdNsX88BK=v15wbBwsL5m7fQ@mail.gmail.com>
Message-ID: <CAMuHMdUBr+3EeErmmH_Qk+sPZfZdNsX88BK=v15wbBwsL5m7fQ@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Thu, Jan 26, 2023 at 2:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > I have to disagree here. The docs say that other values are prohibited.
> > > IMO the driver should take care of valid values then. We should not rely
> > > on user provided input.
> >
> > Then we should make sure the user cannot override to an invalid value
> > through "renesas,dtdl" either?
>
> We do. The new flag is checked after sh_msiof_spi_parse_dt(), so any
> user input will be overwritten with the only value allowed.

OK>

> > To be clarified with Renesas?
>
> Frankly, I don't think it is worth the hazzle and just stick to the
> latest docs. Yes, they may be inaccurate for ES2.0 but what is the
> downside? Will it break things or is this just a little overhead?

I don't know.
You have to try it with a real SPI device, and/or look at the SPI bus
signals with a logic analyzer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
