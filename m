Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1092A45485C
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 15:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhKQOVO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 09:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhKQOVN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 09:21:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82DC061570;
        Wed, 17 Nov 2021 06:18:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v64so8017758ybi.5;
        Wed, 17 Nov 2021 06:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKmu7HqClDPfAW/KPYXmYV7MKJHnHVcWDjB0/hF1xw8=;
        b=PBeVZDrOlwkuTprP+rnTkf9goyQlSrzdgEhfE8/fqQofrGbWlExJnsG1/wvTYFsrCR
         YtBBMFY4ezgL2Du9NufECbBuYv++ofZbTrwu5bVhCe/FgpWmYLRFkDhxUSY2VJ4j5gZP
         kzj0Ybc4NxIYWwWJgIYOogyR7twDQlWwdduF1zNmGy8BBnrTFqr70vE+UMdshIoYo25B
         rukBhaZYY0SySYBlK8NxcZRjrk5/7dhWeWuci7XpV1Gx39vnVMkIQ18aKFu7Wady4AQg
         n0nYKbNsoNzBNcPIkSwdXYKNO6iQ+oi3NxW1353fVdHCM9veFWtSYR+FrwevD9c9cW2P
         lsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKmu7HqClDPfAW/KPYXmYV7MKJHnHVcWDjB0/hF1xw8=;
        b=7KudRnuWwSegrnsuy5kLTrR8kUibtrQ5DMFnc7lYAMjszozzvK5LOAhBu2GzMYM6/n
         vwPx15Kygz0Wkx55M0x+WYaGuAfeKL8QafNH2oWZ8EwET+aMGDfhg8pzIOgX2qIDeBCY
         oenOoehSJBK6pO6WAuIneph0nqGTICdaD3890A2VTp0IX6SJylRKF5Or+8CfPGC+48SB
         E4lHkySSnCGW+VclAHMzgoNSh4+hcQ8dA+nqktB0AOpovVlsnDdz5eK/5H26KFpzIzUJ
         vZtf3EFGmQN0LMqqjpwGTT/+mii3O40Am4G+n7chU8WjmkUDe7dmVRY6SfnER4JsgRnr
         ND3g==
X-Gm-Message-State: AOAM532zKW/68GTPhgW1Kh6SqjhFBvMXQ55cgf/rWrAgeXjUqsidqm6C
        gKhCLSVoMo2fnHp+TL53zXmKGGvaACuHl28KOcs=
X-Google-Smtp-Source: ABdhPJyzrfXj737b4n0md6i/+FpCUd9X5qky5KKOjDVUy1T1FiOVGc6U7lj1/OYEg51bksg+1Qype+wmNWUV+K21wII=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr17393513ybe.422.1637158693784;
 Wed, 17 Nov 2021 06:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <YZT7suWucdD+FU6k@sirena.org.uk>
In-Reply-To: <YZT7suWucdD+FU6k@sirena.org.uk>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 17 Nov 2021 14:17:47 +0000
Message-ID: <CA+V-a8u1xb2A3RZX2-VCM10m3htpzzyDzhoLX1dkFnjFFGMVhA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: renesas,rspi: Document RZ/G2L SoC
To:     Mark Brown <broonie@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thank you for the review.

On Wed, Nov 17, 2021 at 12:55 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 17, 2021 at 01:05:25AM +0000, Lad Prabhakar wrote:
> > Add RSPI binding documentation for Renesas RZ/G2L SoC.
> >
> > RSPI block is identical to one found on RZ/A, so no driver changes are
> > required the fallback compatible string "renesas,rspi-rz" will be used
> > on RZ/G2L
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

My bad will update it to "spi: dt-bindings: renesas,rspi: Document
RZ/G2L SoC" and re-send a v2 along with the review commented by Geert.

Cheers,
Prabhakar
