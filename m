Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1275EC21A
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiI0MJh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiI0MJf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 08:09:35 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B95F7D;
        Tue, 27 Sep 2022 05:09:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so6211081oth.2;
        Tue, 27 Sep 2022 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HfW3SUcUzN5oToVSuRjYiGdXRKLE00MUsymnMGgf6To=;
        b=N3SPoKFLMpfj4bfskmwPVsj56f5aVYv+OToP9zxYJI8aQXcPteXDnlRHnx+SXH0SQ0
         wxM6qkR74b5Is3uoH9IAMQsapQCy63srhwDriQ2ssJvEHqYvp6WexCb/jGH3ySGzhOk7
         uz3RORMsx2SVejle7velo6of3ypeaqE0cGSroV125Id9uVD7+L5a/pYRldY7UUvUuPAd
         U+oiXDIMw2Q7GCJHYvkpOMO6mwCgdzvKu7kIA0wgB/MFc2fcke5GsW4lGmpCz1XwOnbS
         r7AVdD1zaBDt4xbpoE2s/2mAHXtgse96c31UwVvJWohv6yRC6FLeKrvJjcg//+6WAEP4
         dkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HfW3SUcUzN5oToVSuRjYiGdXRKLE00MUsymnMGgf6To=;
        b=m8gftGsOy3LWM96bj+CJQ/bmGiJmwSV3dgNgxUG3uXT3dn3dMhDE0qklbn1LqUf3Xz
         c6OnLUtbUtEIACmjHn2XGmdKxkODYvYBCiCHMgLf3+gQhamZsj4Lx9JDstVz7QPkXBSQ
         eT7w91tlpHlitxsHx/rC/Xneo4eZ3AAiQZlUyf0kTVp9QSfBM/iTjZK/Ek677+gzg6+U
         EqiDi12xEoVeerlaKc/UcjH7SYDDFR8xWyfkVyU4+vYPTzDvym9lxjte5FCiLZw6AOwD
         Vrw1No4YJsjXSUibJN5FrsbPPFnK0UJUGanOi4aVy915qOcEI5BCXq1ARpkxEgaAC907
         JZEQ==
X-Gm-Message-State: ACrzQf28gdQBvbuBN5Zi1BJ64/OfbLvSnkq6Bk5FIkbWOnN+S7J5H3h3
        l19iPH5ghPRYYCEncv7xdq5KIwliWBhV20k2N+k=
X-Google-Smtp-Source: AMsMyM6FL8QQmrf+fllfLdnU+I8CtKxT3FJx/ArVJ4fYG6BveW9MVfKNAWcolaHQxh13N7PCsMvEAMvIrx8/3DSCDYE=
X-Received: by 2002:a9d:19ca:0:b0:655:bcdc:f546 with SMTP id
 k68-20020a9d19ca000000b00655bcdcf546mr12536540otk.304.1664280572819; Tue, 27
 Sep 2022 05:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
 <YzLagn9/j0w4UymU@sirena.org.uk> <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
 <YzLloE/AEdFiHsEj@sirena.org.uk>
In-Reply-To: <YzLloE/AEdFiHsEj@sirena.org.uk>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 27 Sep 2022 14:09:21 +0200
Message-ID: <CAMhs-H9+hp3yLoGyGTNLDZKX__KGwa5PwLrqiFzVP__8_nPrFw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
To:     Mark Brown <broonie@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
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

On Tue, Sep 27, 2022 at 1:59 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 01:36:04PM +0200, Sergio Paracuellos wrote:
> > On Tue, Sep 27, 2022 at 1:12 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:
>
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem, this makes it easier for people to identify relevant patches.
>
> > Since this is a binding migration change I sent the patch expecting
> > this going into the devicetree kernel tree. So I just use the common
> > device tree change style 'dt-bindings: spi: migrate mt7621 text
> > bindings to YAML' as the subject. So I don't really understand what
> > you mean above, sorry. What is wrong with this subject? I submitted
> > this v3 [0] and I was told by Rob to resend it to you and the
> > linux-spi mail list also.
>
> Bindings mostly go through the subsystem rather than the DT tree.

I thought when changes are only in the binding side DT tree was
preferred. Sorry for the inconvenience, then. Will take into account
your advice from now on.

Thanks,
    Sergio Paracuellos
