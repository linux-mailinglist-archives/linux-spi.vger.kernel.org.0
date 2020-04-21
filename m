Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E591B2EE8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDUSTu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSTt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 14:19:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F0C0610D5;
        Tue, 21 Apr 2020 11:19:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so16039367iof.0;
        Tue, 21 Apr 2020 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxQpwQq8B/XSdgKzbh2ahosuLBgTHXKsqcO5uWxCwRw=;
        b=UN3S42+kISuAL0JElfgUijnqMegdzpd3S5HIX6vcUNGFk8y3zllJ43MfIEkhQUCFic
         Tku1lzpC75lZwS4Zyjp/0RTKrcuf3aHXJiTmWbrRzyYhJbISG2In4Df9UmYUAdmBmRPm
         OAPl0zSXkxLKlJ9+PKLU18qkkCYvDRU2jOlRHZSt3OwlWsfCG1Pa9o+PEF4MkrvWxRIW
         fQXPeaObIL65tZjiQhJ1Cc6y6I1NIHRyyrowBpi2Ao/6PXU7XTTwdRSRBRZM17F4DdWB
         UJJzJGwVFkmFZrxWklU5D5kNM24V+xUdPaOmL+IOYvr6a6DTQzHHQiTX1mF8n8YjwS8X
         8lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxQpwQq8B/XSdgKzbh2ahosuLBgTHXKsqcO5uWxCwRw=;
        b=LEjej7dp2zAlVIcuRWVBZmlL/tQxmrYATpyCNVuXpntbRt5mPTHDc8zy/Sg0cv+ptv
         tfnfk1xHv5z1zz25HdH2L6Vi0J4DDFMr9rF9bOfHKHfU9jNg+pkImcyFXVilZHn8De5x
         LcZN/zKHUid2o/7KcuV73unRfZkBSOMa/r6U2Tk37ZBudtdXTmaxdS7/cCtyXXAj1Lox
         FLGG4AfW/0JJVJ+9wjaGK1QZwdwbZyxzehYKgDItrpGlBO6qLK4Zmo41Bm54BMpNbx6/
         ovaFwoBelXHai87DjGQwFCjgEcuRDHjVimYSTfG1t1S2TExdn+Ef319w7fZqM7AAX+bU
         FI/Q==
X-Gm-Message-State: AGi0PuZrKiWKqU/nVoDEpDSxapadFVu7rmYH3YyP86SbTxQi+TwurJB4
        mTocE3eAc2u33x5alXUgFKQfFoKAcj00gdxm9/g=
X-Google-Smtp-Source: APiQypIQH0s4O6zPIpOdsnG/1oem9N6RoPEneIiwVs6RC+JfDHwt2zPz+dHBF1bl2/OdqYNtiSGxbvV6KNK7M6VFA+s=
X-Received: by 2002:a05:6638:4e:: with SMTP id a14mr20610719jap.108.1587493189031;
 Tue, 21 Apr 2020 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190853.45614-1-kdasu.kdev@gmail.com> <20200420190853.45614-10-kdasu.kdev@gmail.com>
 <20200421125025.GB4540@sirena.org.uk> <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
 <20200421145927.GC4540@sirena.org.uk>
In-Reply-To: <20200421145927.GC4540@sirena.org.uk>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 21 Apr 2020 14:19:36 -0400
Message-ID: <CAC=U0a1oMy-RLdCTJ9=Wkn4o8ET8USL4euU-a6meaCJexRgzTA@mail.gmail.com>
Subject: Re: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only
 on legacy controllers
To:     Mark Brown <broonie@kernel.org>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 21, 2020 at 10:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 10:53:57AM -0400, Kamal Dasu wrote:
> > On Tue, Apr 21, 2020 at 8:50 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > If this is a fix it should have been near the start of the series before
> > > any new features to make sure that it can be applied cleanly as a fix.
>
> > Yes it could can be after [Patch v3 3/9] spi: bcm-qspi: Handle lack of
> > MSPI_REV offset
>
> That's not a fix though, that's adding support for new devices?

Since its dependent on knowing if the MSPI_REV register exists on a
given SoC and path 3/9, maybe I can remove the fixes tag for that
commit.

Kamal

Kamal
