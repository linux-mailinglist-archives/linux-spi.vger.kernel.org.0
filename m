Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695734DDE51
	for <lists+linux-spi@lfdr.de>; Fri, 18 Mar 2022 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiCRQTR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Mar 2022 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiCRQSl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Mar 2022 12:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 308F4FD6DC
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647620241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evNG11U7kcmkPBKguoiUTkaJR2X1vekT5/YiNVRdEd4=;
        b=ePI9cNzERLjEtozVupZxxenR5vReSJgzxxMkzEEJV1RpWRDS2sY002QVZrR7fy+0BIitg7
        jHV5i/NJls1x4lOcwTUkjRUPTMxUEfFZ4j3ulMAmTdjqfXpUkGvjTzeIn47p4Ha9qh0LsR
        DdZCHO7uFqoVBx54V1faG7g/IuD1TaM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-uDufJuABPyGs2M-3xDbPMQ-1; Fri, 18 Mar 2022 12:17:20 -0400
X-MC-Unique: uDufJuABPyGs2M-3xDbPMQ-1
Received: by mail-qv1-f69.google.com with SMTP id g1-20020ad446c1000000b00440c9327221so6586922qvw.6
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 09:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=evNG11U7kcmkPBKguoiUTkaJR2X1vekT5/YiNVRdEd4=;
        b=YaLwLE23k848/nxeUT8Xjp8j8bOGU/onfvUgU0YNI40a1v4iG1eXowKNT+ykF4tO5C
         +iPanLNSKfVIh9xzG1nqGdDtMQE5FlK5ChNkQnksYDFR/gqL0hrG1lpfDDKE6E7t06h7
         dDSPROPo604AA5jmqCTtXihE8C0cUbK7bRdExESLcFL1hcjnxa4Vk/IuI5mRy8xp4hSA
         cvSXiqqFRx6IOXIST0KjUc/O4wbrUFQtlfWKg/oPirt8WSx2lOMt0y1kKIHX3uwqBIg6
         n/vUhdnRWNt0bGOiauidPhNxHIeC8vKSobLhYp1NQqQ9+47EEm9dmyIX2BGMtCRo9SOt
         Jz4g==
X-Gm-Message-State: AOAM530wgDoCTa4Qe1My+ECYzBET4Kiwo0/uR/K+xpKidX/8jocZ2Ty8
        o//txHBlCXT3mOKCEQ3Ui7WgM1XJuaWMvuom3A0gI/nQS3etybRfYqdvDvIg1GsPxD6/G7KcnYn
        wdrkwR87rDSwRp5fpkw2JPYi8c1itCfAUZpDM
X-Received: by 2002:a05:620a:21ca:b0:67b:4efc:486f with SMTP id h10-20020a05620a21ca00b0067b4efc486fmr6434986qka.356.1647620239303;
        Fri, 18 Mar 2022 09:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCirfCTwW9Y0mH3pmLIIkbtuSLbPXhsXb2mBBmMDX3/YLE9UczxOL8ATyTwr/rA86jpdEou7xOtiQfBX0TdCg=
X-Received: by 2002:a05:620a:21ca:b0:67b:4efc:486f with SMTP id
 h10-20020a05620a21ca00b0067b4efc486fmr6434964qka.356.1647620238935; Fri, 18
 Mar 2022 09:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAC3B9fn9DWezr3rspLbomuRLtRjSvW89cLMWR9TTCYsX=PDM_w@mail.gmail.com>
 <CAC3B9fkpO13QhCgVO-qyynbwdh_z60CKgpUhn-40NyGNGz_q8Q@mail.gmail.com>
 <20220318125925.GA21543@wunner.de> <f3e046b0-9afa-c0dc-8e60-eb9723ecfc99@gmail.com>
In-Reply-To: <f3e046b0-9afa-c0dc-8e60-eb9723ecfc99@gmail.com>
From:   Miguel Angel Ajo <majopela@redhat.com>
Date:   Fri, 18 Mar 2022 17:17:03 +0100
Message-ID: <CAC3B9fn6_BoaW+nUXoJDbXie5ZCD412rsXp8Q+hchyM6S5JtqA@mail.gmail.com>
Subject: Re: bcm2711 / RPi4 not functional after d62069c22eda
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-spi@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=majopela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thank you for the feedback, and sorry for not posting to linux-spi in
the first message.

On Fri, Mar 18, 2022 at 4:31 PM Florian Fainelli <f.fainelli@gmail.com> wro=
te:
>
>
>
> On 3/18/2022 5:59 AM, Lukas Wunner wrote:
> > [cc +=3D linux-spi; please do not write developers directly without cc'=
ing
> > relevant lists]
> >
> > On Fri, Mar 18, 2022 at 11:54:35AM +0100, Miguel Angel Ajo wrote:
> >> On Fri, Mar 18, 2022 at 11:47 AM Miguel Angel Ajo <majopela@redhat.com=
>
> >> wrote:
> >>>      I wanted to share a regression found after commit:
> >>>
> >>> d62069c22eda spi: bcm2835: Remove shared interrupt support
> > [...]
> >>> After this commit I get:
> >>>
> >>> [root@rpi4-64 ~]# dmesg | grep spi
> >>> [   18.781250] spi-bcm2835 fe204000.spi: could not register SPI
> >>> controller: -517
> >>> [   19.134138] spi-bcm2835 fe204000.spi: could not register SPI
> >>> controller: -517
> >>> [   19.895147] spi-bcm2835 fe204000.spi: could not register SPI
> >>> controller: -517
> >>> [   20.400137] spi-bcm2835 fe204000.spi: could not register SPI
> >>> controller: -517
> >
> > Those are transient errors, -517 is -EPROBE_DEFER.  Probing fails
> > because a resource is not available (yet), to be retried again later
> > if/when it becomes available.

Whatever it's looking for doesn't become available.

I have noticed that upstream kernel with the device tree provided by
raspberry/linux
master downstream it works ,and I'm trying to identify what's missing or wr=
ong.

At least to my understanding we should be able to start at least one
SPI controller
without shared interrupt support. But it's not the case for me.

>
> You would want to check whether you have these two commits in your tree
> as well:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D266423e60ea1b953fcc0cd97f3dad85857e434d1
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De8f24c58d1b69ecf410a673c22f546dc732bb879
>
> or neither, because the first commit forces a lockstep update of the DTS.

Thanks, I checked and both, the rpi/linux master, and the kernel I'm
working with ( 5.16.9-200.fc35.aarch64)

>
> The SPI driver does not uses that many shared resources besides
> interrupts, clocks and chip-select overs GPIOs, the first one is
> unlikely to be the problem, and so is the second, thus leaving the third
> resource as a candidate to defer on.

Thank you, I will continue with the investigation.

>
> >
> >
> >>> ecfbd3c introduced support for the bcm2711 SoC that shares
> >>> one interrupt over multiple spi controller instances.
> >>>
> >>> Do we have a more detailed description of the exact issue for
> >>> which we reverted?, is there a plan to re-introduce the shared interr=
upt
> >>> support while fixing the issue?
> >
> > See here for why the commit was reverted:
> >
> > https://lore.kernel.org/linux-spi/20200529174358.som3snunfxch6phi@wunne=
r.de/
> >
> > There was a second attempt to introduce shared interrupt support,
> > but after a lengthy discussion, it was not pursued to fruition:
> >
> > https://lore.kernel.org/linux-spi/20200604212819.715-1-f.fainelli@gmail=
.com/
> >
> > So I believe shared interrupt support only exists in the Raspberry Pi
> > Foundation's downstream kernel, but not yet in the mainline kernel.
> >
> > Thanks,
> >
> > Lukas
>
> --
> Florian
>


--=20
Miguel =C3=81ngel Ajo  @mangel_ajo
Office of CTO EDGE team.
ex Submariner (ACM) and OpenStack networking

