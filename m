Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D85A0B07
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfH1UBa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 16:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1UB3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Aug 2019 16:01:29 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5613E22CF8;
        Wed, 28 Aug 2019 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567022488;
        bh=MD4qcU/RNuQWBhQQ01cICuFkYluzMOqVUuTE6FPZ0IM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iFfeQDhnrzVMUj4H9FCZIGJEVCdmUoJdFOJqH0nNIMzHq+sMuN7d0E/8e4AMSnVtC
         7MVGmzqlFmzUS63rAQNUJjQdW0qwa87B1DdQhq1z0vsDdXRF4aSG1YgvLlybgwRoQb
         8M19RIEIXpDElPoZ3O4OZ4pJwThIcMXQWQDipfuo=
Received: by mail-qt1-f177.google.com with SMTP id g4so980662qtq.7;
        Wed, 28 Aug 2019 13:01:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUp9VezRVwUfVlbLWU2fWju0bUz/wwgtg+3u4Fa489Jpdf4Lz/5
        UBukcuG9fU7gdhlwQ3Gsf151owJyzj+NxHzN6A==
X-Google-Smtp-Source: APXvYqzh6lclUqux/vGx4y8IrMqxuIi7axYVYygQGUBgHesfvCn92IkyHi3rsied4shlJPCDpAw75irc/7RIpvqF21A=
X-Received: by 2002:ad4:4301:: with SMTP id c1mr4283774qvs.138.1567022487474;
 Wed, 28 Aug 2019 13:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk> <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk> <20190827155005.GA18581@bogus> <20190827195606.GA28879@sirena.org.uk>
In-Reply-To: <20190827195606.GA28879@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Aug 2019 15:01:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
Message-ID: <CAL_JsqKnY1ucejpaSUYu_dGZ=uHMybsW4ryJAtEgimUXB+ozbg@mail.gmail.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 27, 2019 at 2:56 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:
> > On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:
>
> > > Drop the dt-bindings:.
>
> > If you do 'git log --oneline Documentation/devicetree/bindings/' you'll
> > notice that SPI and ASoC are the oddballs now. I don't really care
> > except it does add to tribal knowledge needed regarding maintainers'
> > requirements.
>
> Well, you have been pushing people to change over to using
> dt-bindings: so I guess you do care :(

Well, yes. In the absence of any sort of pattern, I have pushed for
some consistency. And to get rid of subjects like this:

Documentation/devicetree/bindings: Add the DT binding documentation for foo-bar

If subsystems are consistent with their own standard as you are, then
as a maintainer I don't really care. My point was in regard to what
submitters need to know and follow.

> It really does cause me
> to miss stuff, especially where people don't even include the
> subsystem name in the header.  I get quite a lot of CCs for
> things where I once reviewed a patch for a subsystem that made
> use of some subsystem I do maintain or where one patch in a
> series (perhaps even an already applied one) was relevant at some
> point so I'm doing quite a bit of triage that's purely based on
> the subject lines.

I can't imagine filtering on subjects will ever be that reliable
unless we add subject prefixes to MAINTAINERS and have checkpatch
check commits against those. Filtering on the diffstat is the only
thing that's kept things to a sane list for me (MAINTAINERS for DT
used to tag of_* functions which just meant getting copied on *every*
driver). This is done on the patchwork server side for me, but I
imagine one could do it on the client side too.

Rob
