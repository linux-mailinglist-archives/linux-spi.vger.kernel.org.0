Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59C5EFBE2
	for <lists+linux-spi@lfdr.de>; Thu, 29 Sep 2022 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiI2RYJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Sep 2022 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiI2RXm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Sep 2022 13:23:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F921F44D0;
        Thu, 29 Sep 2022 10:22:48 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w13so2283889oiw.8;
        Thu, 29 Sep 2022 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oML0lesbLZNwdQ5fehk6s2daxEgvPhRDh/+lofYjbqM=;
        b=UjVmnbnZArEarTWIBG2mGn6/xad7/V+PKS6pT79JAoXkINbenBF6yH3fUTa6/wPaSX
         j4IJaEz+36gx09+ivAAlamVtU2qKYtUWmgfG7hygspic+6FBsKpt3vZ2HsxCyjVQ4uRq
         GVGqrWsl/k8C5uAlH3cQ5Rsxvh+ABClgXAlod8NiQcG7fazSb8nR9cgqASgCjSAWnS9h
         FOZqcqXrQPn5MeKDqgV0QLwFwWaOEDvQ1xm3ez8RriP4KVnyFAFOODJYle48MbVgD35w
         0boXbzdkQj9OLP+Nl67RtVaDPCJnniEtfqBw60HjgvPCf2qZdaCAxTqHpsAsFsKVQ5LO
         wAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oML0lesbLZNwdQ5fehk6s2daxEgvPhRDh/+lofYjbqM=;
        b=ZGsiM0Cn7oU/I1karI1g4IBC9lKAvc48GVb1+iEOlGGXceG3vHd2vftdNdnuWy0rpk
         4QTCw1bQn3dFSyetlEfyHSdfUycHXSzFoub843bm0ulgDsJtW5RKviaK921Br5OYxk4g
         lHXWblrvLv65aD3znxyPXfY2fgAB0ChiNp7w02xRdN8y5Ondmj34+ZVxtit9rhboD4pU
         qUJwA4HZqME0yOCEzR95vjwq6tgTQrJKCxpDHrNUx+6HMnYWUVri63CmxS2aU1/Gn76z
         MC5MIZThMGGrvqV5963A7UD5wgF8unFR+wmeNisMsPmk83YuEEjkmeOQsmTavRj6LqgL
         MWYw==
X-Gm-Message-State: ACrzQf2njLtz2WhiDiWSt0Wr7xn5vEjnyRdOw9rnYeevNmMpDGT9xlRm
        b9Zjod0Uo37wAIvZaeO95QvGp2pgSG+DxyL72Tg=
X-Google-Smtp-Source: AMsMyM57l04X4qryFVpDzl3vpgv4SiLKsym9dnt1kSc8IUgjDTpt5498fecpA0KDw80chdvsW6rnWiJbQ6Nzj8DZcv4=
X-Received: by 2002:a05:6808:23ca:b0:350:92c4:3422 with SMTP id
 bq10-20020a05680823ca00b0035092c43422mr2124630oib.144.1664472166706; Thu, 29
 Sep 2022 10:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
 <YzLagn9/j0w4UymU@sirena.org.uk> <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
 <YzLloE/AEdFiHsEj@sirena.org.uk> <CAMhs-H9+hp3yLoGyGTNLDZKX__KGwa5PwLrqiFzVP__8_nPrFw@mail.gmail.com>
 <20220929164836.GA2297514-robh@kernel.org>
In-Reply-To: <20220929164836.GA2297514-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 29 Sep 2022 19:22:34 +0200
Message-ID: <CAMhs-H_abY9aPYWnRQ+cMwvL9zrhGrxHFZfHJ=aDKrxH7ATEog@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 29, 2022 at 6:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 02:09:21PM +0200, Sergio Paracuellos wrote:
> > On Tue, Sep 27, 2022 at 1:59 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Tue, Sep 27, 2022 at 01:36:04PM +0200, Sergio Paracuellos wrote:
> > > > On Tue, Sep 27, 2022 at 1:12 PM Mark Brown <broonie@kernel.org> wrote:
> > > > > On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:
> > >
> > > > > Please submit patches using subject lines reflecting the style for the
> > > > > subsystem, this makes it easier for people to identify relevant patches.
> > >
> > > > Since this is a binding migration change I sent the patch expecting
> > > > this going into the devicetree kernel tree. So I just use the common
> > > > device tree change style 'dt-bindings: spi: migrate mt7621 text
> > > > bindings to YAML' as the subject. So I don't really understand what
> > > > you mean above, sorry. What is wrong with this subject? I submitted
> > > > this v3 [0] and I was told by Rob to resend it to you and the
> > > > linux-spi mail list also.
> > >
> > > Bindings mostly go through the subsystem rather than the DT tree.
> >
> > I thought when changes are only in the binding side DT tree was
> > preferred. Sorry for the inconvenience, then. Will take into account
> > your advice from now on.
>
> Sometimes they do, but that's more the exception. The ones from you I've
> picked up don't have a subsystem really or the subsystem maintainer
> isn't too active or doesn't pay much attention to DT only patches. Mark
> is responsive and pays some attention to binding patches, so he takes
> them.

Thanks a lot for clarification, Rob. Much appreciated.

Best regards,
    Sergio Paracuellos

>
> Rob
