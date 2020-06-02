Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48A1EC2D9
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBTf6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBTf5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 15:35:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70DC08C5C0;
        Tue,  2 Jun 2020 12:35:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z2so74824ilq.0;
        Tue, 02 Jun 2020 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaeDmvwutMFDkhGXN+aSrIZ/aqZNZQqgehXmm4OU8WQ=;
        b=saHbz83DdIX3HLPmbOrEnGy96gXDa2LqsBe3j+qnBclnC0O60/LkTiWXVukocvudeF
         qu6gwtDugAsZ5QnsvW8SIPWsXhv2lLTcmo5RzkoWhfclb7ZFhaSwvAoT7AF6DI01TJ8t
         oHWcKllVoMI6sGMUbiwW6IPkt6/p8SwyWr2B1p788jWcu1HkoL3ja8ofpv7VKd3ovALh
         BV7/3tjW62EE0k8wUTOpwpe4jI/5ryrpSpKFN5CbQHYZaYKR2HRyR/xCR065a7WjIVUQ
         xXvBlIiY0+b900oIjjP7MiObfTXF1O7e3D9p2LgFFSsikadCqryBWtLGWwvJYg409SPu
         DVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaeDmvwutMFDkhGXN+aSrIZ/aqZNZQqgehXmm4OU8WQ=;
        b=tniaLj3pgfTy9hGlLRNJuF2qbUw90wuvtghLopRe7umNMdAggU3ftOTdg5UnGvd8IG
         Fh5V60A9FkvOIaLIHQ4zXqT7rA4qg3JWp+2IMTM+x5tRYbFueELRsV8NRuRNl0S+9K5p
         Mw0ArXt7dbqDyfZ7pEDvO8MeDE9axskXjYBqFBOzDwFPM5eJN0jt7iA+yD3BdvTqiWUr
         A1OMVpTQjqB3xaiDQXSa9NWPk3yPcNfzB8vPYPGLF61/1pimC9FqBHVqxmENrOOjcpzj
         tXDYqMXU/ph1sne+R9d06YdANtdXTG28gdqoOEO3WXbYQTstuOi8A0HsLmVJV07ocTUG
         uNww==
X-Gm-Message-State: AOAM53225w9tKZ3aSJtpDuVXsLU35xAvasICx0AeW/gsZ17IuyoRCs5j
        3mqx4gKCV2P0n0StmkIVjW+lqZMr9B5TXmNsKMk=
X-Google-Smtp-Source: ABdhPJx1p0jA7a00DSqjH4OmXarnO4ZgAmj5nti0GovjrHRIcvLw4r4uKb5TwNy6QqWtc6HiS36n2m7891sCmNXfgog=
X-Received: by 2002:a05:6e02:13f4:: with SMTP id w20mr865871ilj.294.1591126556726;
 Tue, 02 Jun 2020 12:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de> <20200602094947.GA5684@sirena.org.uk>
 <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de> <20200602141306.GH5684@sirena.org.uk>
 <cc8e1397-c605-d73e-363e-9d2ddfb9ae16@web.de> <20200602183644.GI5684@sirena.org.uk>
In-Reply-To: <20200602183644.GI5684@sirena.org.uk>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 2 Jun 2020 14:35:45 -0500
Message-ID: <CAEkB2ETDxZ3hgDtC_=Z_AG2Gsd3DO1HApcOzdJf5T0EeJ5DLPQ@mail.gmail.com>
Subject: Re: spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-spi@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 2, 2020 at 1:36 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 05:05:18PM +0200, Markus Elfring wrote:
> > >> I find this commit message improvable also according to Linux software
> > >> development documentation.
>
> > > Causing people to send out new versions of things for tweaks to the
> > > commit log consumes time for them and everyone they're sending changes to.
>
> > Improving patches (besides source code adjustments) is an usual software
> > development activity, isn't it?
>
> Your updates were not improvements.  The formatting was worse and to my
> native speaker eyes the grammar was worse.  With this sort of stylistic
> thing it's especially important that any review aligns with the needs
> and practices of the subsystem, there is opinion in there and multiple
> opinions just makes things harder for submitters.

Thanks Mark for your constructive opinion,
In most cases, such stylistic comments become confusing and
discouraging to those who are trying to chip in. Personally I think as
long as the patch does not contain typo and is not ambiguous from the
maintainer's perspective, it should be fine to let it go forward.



-- 
Navid.
