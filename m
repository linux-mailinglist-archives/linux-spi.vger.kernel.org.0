Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355096977BD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 09:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBOIDE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 03:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjBOIDE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 03:03:04 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50A17CD0;
        Wed, 15 Feb 2023 00:03:01 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id g18so20942864qtb.6;
        Wed, 15 Feb 2023 00:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNxqpv7kCLuATv+HCdURPo1681kgwVFn50TSKFoQ90s=;
        b=rVvvtjMTEF4M6XnDjI/QdFk3b31BNKuRPc8z+aYXm7iZ90dwTRb+YexcsyoUZATCgK
         s4GBSzuyMEYG/C80HiqAxqGrxC9NyfZhERHMIfKjOhUiPr1XbPaEifcJ0g2/Jf+6BTl+
         CfAzoBAZWkcrDQAytLVZbhDz1hToF0isXcXgEwY/yLeJFDIG/oU6n3eAFvLuGteeSmw7
         R6xPfEmkAz9TuVDnb7/gy1Trej6Yl5rB5Qr3dOlEI0G9dVd/kwQ8VVvDtdReRIHiMRPP
         HCxSx5W/0UgxoV6go9j1mn1qVPGIvu0/KgTYt22yc3QNcDMO7cyPCjEi9QcKrRM5p4Qk
         Altg==
X-Gm-Message-State: AO0yUKXlherXpbb064+Qy1owwhqfBoE6cZso10Ebwy6gi7sygWmkX+jK
        m/wVuC2wOeo/Ge36hCfqeOihrIA4u2IIFuW2
X-Google-Smtp-Source: AK7set+M09TTn9nLtx/1Qq/cl+qhJw4V0nuArAfVlirVI99/DWU+Oz22gWtT89awjVyoT1lLPqu+7A==
X-Received: by 2002:a05:622a:1b9f:b0:3b8:385f:d72e with SMTP id bp31-20020a05622a1b9f00b003b8385fd72emr2053893qtb.48.1676448180235;
        Wed, 15 Feb 2023 00:03:00 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a149600b003b323387c1asm12887218qtx.18.2023.02.15.00.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:03:00 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-501c3a414acso248889207b3.7;
        Wed, 15 Feb 2023 00:02:59 -0800 (PST)
X-Received: by 2002:a5b:491:0:b0:86e:1225:b335 with SMTP id
 n17-20020a5b0491000000b0086e1225b335mr183907ybp.455.1676448179541; Wed, 15
 Feb 2023 00:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
 <Y9J6+uoXxUIs4Bkk@ninjato> <CAMuHMdXRBYhR+_+r+akZ5nKYPgpVKMNEHB5KCP_pnPJYtHvU=A@mail.gmail.com>
 <Y9KC4Pu/AnnXOLhI@ninjato>
In-Reply-To: <Y9KC4Pu/AnnXOLhI@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Feb 2023 09:02:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuyQtXbmVdD4F-FPjzriXirb_ZPoFhpWDg4piyzTVNvA@mail.gmail.com>
Message-ID: <CAMuHMdVuyQtXbmVdD4F-FPjzriXirb_ZPoFhpWDg4piyzTVNvA@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
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

OK.

> > To be clarified with Renesas?
>
> Frankly, I don't think it is worth the hazzle and just stick to the
> latest docs. Yes, they may be inaccurate for ES2.0 but what is the
> downside? Will it break things or is this just a little overhead?

Given the recent clarification from Renesas that this applies to all
revisions of R-Car H3 (ES1.0, ES2.0 and ES3.0):
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
