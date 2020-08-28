Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515A6255DD5
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1P2A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgH1P1t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Aug 2020 11:27:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE7C061264;
        Fri, 28 Aug 2020 08:27:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g13so1664716ioo.9;
        Fri, 28 Aug 2020 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2zmhYfnTOjlCp7ra2OX3q7ngPbsdndePp/+MPwLm0U=;
        b=mOK87iFMfQJ9TetCoD1ZZEd3Gk9eSNPPllmpQeO6U2ZsRm0lNnzQ5ZRXVIPiGncq22
         i7VOrvP90lKo0C72DYh3xhHjlZxSQiQWMoEfZcRyf0P6fCviuLYU+hra5w5xeBdk7Ral
         f5UqYdhHhnj3b14aks4eeuTOxDYd0QEYiPkHDLBa0CHZbk7AEOXyJ4/o42s9Otlp+1W7
         2fx+awoDW3pwdE1Ns1dJrJSAl2cdZpGtHhD/q4Yvuw9wLBC7FmlrIbsOqJffUeSZ1+xe
         ps2xs7MPh4QNKDixWqAD4tCTy5bLoJAmpJsT/3Tq1xPZjJJoWjy8b9Ei5Gyi14AycRDr
         uKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2zmhYfnTOjlCp7ra2OX3q7ngPbsdndePp/+MPwLm0U=;
        b=Cxh6NgJsb4acZQIBxxPlVr1pDen/K1TNTAt0Uj7BhPOqkazQyYEBR6gbFZdljk2f7W
         yBN0MpBVXDRmbrxKArEeLmCv5aDIVEv9REZab9bYRhJL2y4dHM18J4w6ng0yAIY0JMR0
         kn9k98TMEm45kXhpmDgUQ2s7xywD2/NUIZXPoVozlQDAW/+ld9jLTwtpSL7gQ/doEI77
         XfgoRhfqvMU0rfjbM5HV1dTonCxxmKIQ335bMkdHNxYBre9vdn2cEoxVOX+kLcqQAzOf
         iWu95iUYhgM1QH6dqYup3b/Bs0ReWX2NWbj5fRjSzuhVbwzGAMrTM4BI5RAqg68C2cYE
         G2cg==
X-Gm-Message-State: AOAM530BllSNN//01wMBcgJ1pVaAUKEdygeYsYBZHP0ap6fY3p31Cg3e
        8yLVDWBRJOfP/+NcypA8u2j2ZaiVop4Pi0vhMUg=
X-Google-Smtp-Source: ABdhPJzgUFbW5K9VQXTgxAOChCuEdEYjVCRZKxYaY9ONaicsREP1FfFEyVeVlPAclR9W9HFB4nKRjf+XFCmKrCGEadU=
X-Received: by 2002:a05:6638:594:: with SMTP id a20mr1658187jar.127.1598628467885;
 Fri, 28 Aug 2020 08:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200827181842.1000451-1-f.fainelli@gmail.com> <5afe8762-c0a3-ff10-5946-0eb2e7ddc0e5@broadcom.com>
In-Reply-To: <5afe8762-c0a3-ff10-5946-0eb2e7ddc0e5@broadcom.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 28 Aug 2020 11:27:36 -0400
Message-ID: <CAC=U0a3JwZr5tpNZ1ba63ORw5gfiBPAhOqYo4UZTOE-eJm8mjw@mail.gmail.com>
Subject: Re: [PATCH 0/5] qspi binding and DTS fixes
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Looks good to me.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

On Thu, Aug 27, 2020 at 3:30 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> Patch series looks good.
>
> Acked-by: Scott Branden <scott.branden@broadcom.com>
>
> On 2020-08-27 11:18 a.m., Florian Fainelli wrote:
> > Hi all,
> >
> > This patch series fixes incorrectly defined compatible strings for the
> > Broadcom QSPI controller which resulted in the strings not being
> > ordered from most to least compatible.
> >
> > We will need to apply some changes to the spi-bcm-qspi.c driver in
> > the future to assume no revision register exist, and these patches
> > are a preliminary step towards that goal.
> >
> > Florian Fainelli (5):
> >   dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
> >   ARM: dts: bcm: HR2: Fixed QSPI compatible string
> >   ARM: dts: NSP: Fixed QSPI compatible string
> >   ARM: dts: BCM5301X: Fixed QSPI compatible string
> >   arm64: dts: ns2: Fixed QSPI compatible string
> >
> >  .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
> >  arch/arm/boot/dts/bcm-hr2.dtsi                   |  2 +-
> >  arch/arm/boot/dts/bcm-nsp.dtsi                   |  2 +-
> >  arch/arm/boot/dts/bcm5301x.dtsi                  |  2 +-
> >  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |  2 +-
> >  5 files changed, 12 insertions(+), 12 deletions(-)
> >
>
