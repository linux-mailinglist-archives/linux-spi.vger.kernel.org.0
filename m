Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CEC67CC0F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjAZN1c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Jan 2023 08:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjAZN1a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Jan 2023 08:27:30 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637916AC82;
        Thu, 26 Jan 2023 05:27:06 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id z9so1188732qtv.5;
        Thu, 26 Jan 2023 05:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZ9JUre01V/XktkNIYENGU++GJYrSJzRsdq2Q/zUM5U=;
        b=fLf0oszdAzgmL/aNuBB96/jljY9qZsL/0EglULABdvTBY4ukbhLNxlG7WH1WbfPw69
         60XXgPAQa53Z8uitbkPLSjaZNRUJHWJ9WIK1NjAVC/Zo3DqN9ECd/48yR08v15gMyNzp
         JngSrHB44o6sE28Cci8qMAUYfLRCgxfhPfGY+Rr9Vrs6I2h8WsLINqRwixgO0Dn15gEb
         kuBDkhb2PTziId+Wqne7X6INiH+Q95V1kebTGUdc3oKUQq5BeqnPc0Vbr8brSnEyIaGG
         /OeOoMtDNKdBJgTKW7OpOeC2JstT1FQMGm2CRKMQQBG18n3eyNJLTL52lVCfepgiFbqn
         mATA==
X-Gm-Message-State: AO0yUKVNp2eHXFG4hK3Acm7CA216GGNIWsExd1ma8jPUxKJE3ZOBUkz1
        mXRmr7LPUcENpc85jKG0a1OB9XFdbTbVGA==
X-Google-Smtp-Source: AK7set9uyjUgqkhpmtFD3ZkeQcUgaZ07x6ZN/WD4c6T9/kbfzadwZeb9vMioHmNpEk9EAd4fN/fQAw==
X-Received: by 2002:a05:622a:1447:b0:3a8:dae:d985 with SMTP id v7-20020a05622a144700b003a80daed985mr10562527qtx.14.1674739625333;
        Thu, 26 Jan 2023 05:27:05 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id br9-20020a05622a1e0900b003b62e8b77e7sm699563qtb.68.2023.01.26.05.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 05:27:05 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id c124so1887509ybb.13;
        Thu, 26 Jan 2023 05:27:05 -0800 (PST)
X-Received: by 2002:a25:dd8:0:b0:80a:6a1c:7c3b with SMTP id
 207-20020a250dd8000000b0080a6a1c7c3bmr1715624ybn.89.1674739624911; Thu, 26
 Jan 2023 05:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com> <Y9J6+uoXxUIs4Bkk@ninjato>
In-Reply-To: <Y9J6+uoXxUIs4Bkk@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 14:26:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
Message-ID: <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
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

On Thu, Jan 26, 2023 at 2:07 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > Documentation says only DTDL of 200 is allowed for this SoC.
> >
> > Do you have a pointer to that?
>
> Yes: Gen3 docs Rev.2.30 from Aug 2021, Section 59.2.1, Bits 22-20:
>
> "[R-Car H3, R-Car H3-N]
> 010: 2-clock-cycle delay
> Other than above: Setting prohibited"

Oops, I looked at the 59.2.4, which describes the receive equivalent,
and which does not have this limitations.

> > We already have "renesas,dtdl" to configure this from DT.
> > Iff this is really needed, perhaps it should be added to r8a77951.dtsi?
>
> I have to disagree here. The docs say that other values are prohibited.
> IMO the driver should take care of valid values then. We should not rely
> on user provided input.

Then we should make sure the user cannot override to an invalid value
through "renesas,dtdl" either?

> > I suspect this is a leftover in the BSP from attempts to get MSIOF
> > working on R-Car H3 ES1.0 (which it never did for me, as CLK starts
> > and stops too soon, compared to MOSI/MISO).
> > On R-Car H3 ES2.0, everything works fine, without touching DTDL.
>
> The BSP originally has this patch for ES3 only. I extended to ES2 as
> well because that is what the docs say.

This limitation appeared in Hardware User's Manual rev. 1.50, which
is also the first version to document R-Car H3-N.
So I wouldn't be surprised if this applies to R-Car H3(-N) ES3.0 only.
Remember that rev.0.53 was the switching point from R-Car H3
ES1.0 to ES2.0.
To be clarified with Renesas?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
