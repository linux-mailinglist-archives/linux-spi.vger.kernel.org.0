Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345B2A8717
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgKET1W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 14:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKET1V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 14:27:21 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB09C0613CF
        for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2020 11:27:21 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id c18so2316902ybj.10
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2020 11:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEJCPZbEVHfia1Epohqphy6Yj/smF64D3n/3+kypg8I=;
        b=OQqCNHtf8pBE8qWazz/H5tigbyp3ReGtnojBVAU00we9GFG+Kcj36jZiUw5IyMElzC
         huQq6/xWdiIFb7LxYniPB7g7MnWIqrmwD31l/b19exLeoUJpo3Eb5I8P71SKDMVPekSA
         15iEsPQJnsEFHpMNYCh30nF1mJ/CoiF96J0jdlHyrgvhlxCgztRQyQz/JtQ6nNa6Bhy/
         60W3FjBnys/p+nIf4Yp2fE1/NtxZG48chR23r1QKiAmsRpT+2rlF/YkZcX3K9s0u1RYB
         xt2FbD7lCfGt6OBTRRigrztWvQ52AFMJbJgEEFEJ+zMPrTSSr/RkRj1ygcXW2Hatfqbz
         v/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEJCPZbEVHfia1Epohqphy6Yj/smF64D3n/3+kypg8I=;
        b=QV9NaQm8SaCuOzQa9NhrB2OMLWS5hjmQdv48S5ytTewFyrYbJbtgVVbm3XTpzyEra/
         mKiIhuXp7pOzY3/aVl1hywRS3pSfQMtcqP4cdmTWX5mQQ8gvK81bDjRLXqGfnLDCY+iZ
         JOxQgIUXOiHoJX06Rm8aNyGaEIg9zNmC75EDDAMKGL3WCm5ya4spRzntNqzgo2QIGXCB
         ZWZ/QWElDGgHtCxvyPILE6IoA+lRO2xkqJWrxWHNQ+Y0z6czccX12r+aVo1Dmw+++ujO
         W6UhQoxcswiw3fQjMTmmiOXAtfqG9Gf44MEp+RiTPZhBTA4NOt045yFGWJs684j3+TgO
         d4+A==
X-Gm-Message-State: AOAM532gvw4NStlESakQU4z8cPRiHh90gPAMabZa7mWb9BhQ62F4bZqc
        eY+UN678DPNfnQtTKdhQ+Op/cRLNiUw0H5ByUVJOWA==
X-Google-Smtp-Source: ABdhPJwlnGJOo1LG7y4K+S2hBDh8YtqWL23pmaubXW/KQdP2prs3xkbdAYxyo5drnjSES2ecA8NUXYNNDVjbT/yPuF0=
X-Received: by 2002:a25:3:: with SMTP id 3mr5833833yba.412.1604604440845; Thu,
 05 Nov 2020 11:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20201104205431.3795207-1-saravanak@google.com>
 <20201104205431.3795207-2-saravanak@google.com> <20201105171201.GF4856@sirena.org.uk>
In-Reply-To: <20201105171201.GF4856@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 11:26:44 -0800
Message-ID: <CAGETcx9_En10j0DwktXtPDrx=Aqdr2iWEuHmYB-=SnfODTmMfg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] spi: Populate fwnode in of_register_spi_device()
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Cheng-Jui.Wang@mediatek.com,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 5, 2020 at 9:12 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 04, 2020 at 12:54:31PM -0800, Saravana Kannan wrote:
> > From: Daniel Mentz <danielmentz@google.com>
> >
> > This allows the fw_devlink feature to work for spi devices
> > too.  This avoids unnecessary probe deferrals related to spi devices and
> > improves suspend/resume ordering for spi devices when fw_devlink=on.
>
> >       of_node_get(nc);
> >       spi->dev.of_node = nc;
> > +     spi->dev.fwnode = of_fwnode_handle(nc);
>
> Why is this a manual step in an individual subsystem rather than
> something done in the driver core

It can't be done in driver core because "fwnode" is the abstraction
driver core uses. It shouldn't care or know if the firmware is DT,
ACPI or something else -- that's the whole point of fwnode.

> - when would we not want to have the
> fwnode correspond to the of_node,

Never.

> and wouldn't that just be a case of
> checking to see if there is a fwnode already set and only initializing
> if not anyway?

Honestly, we should be deleting device.of_node and always use
device.fwnode. But that's a long way away (lots of clean up). The
"common" place to do this is where a struct device is created from a
firmware (device_node, acpi_device, etc). I don't see a "common place"
for when a device is created out of a device_node, so I think this
patch is a reasonable middle ground.

-Saravana
