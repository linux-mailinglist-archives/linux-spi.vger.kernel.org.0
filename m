Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED14410B09F
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfK0NwU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:52:20 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42873 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0NwU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:52:20 -0500
Received: by mail-ua1-f67.google.com with SMTP id 31so6973403uas.9
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LntB4fqzagpM5IcIiBImapoYobXWqqoMQBDgqeQw+Vo=;
        b=VjcSI9X7YzTDGVYE88ru4wviQfT0x910/5N7cPcA+BBzXt5PHDj5ytmpJGOo3tMw5C
         dHfz4yyIaPhuEN0kAKjXNJ2djvcQeHPzPAN18TCj93e3WYPDUSw1EKG5j/9BOpDwIMR7
         hcdMDD6ARN9ZEFATpcNr0mHR0c33PjOVTZHRXDwGHdmpRm7B/RtEQzRyL6AAa7hr7CUy
         jXxoOOs1wGhUhMuYEQbgKKcWdkKSyIZ7UcTOouaDi33rCYPWlul4Jb55qKgThWxVz7tp
         W31r5FwT9PX36M18YM3OGsOeADen1I6gW5CHIbsA/oZk7EKD2i55Kdlo607eegad/sMF
         7YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LntB4fqzagpM5IcIiBImapoYobXWqqoMQBDgqeQw+Vo=;
        b=EixWCvcffm9avH91RwmeKPRKGtuGdztCbxCJnxtv16CLa9EKc88fYo1NVAcWq/R8SE
         9bpNTl4WKWWDx/nwH8F4RPCmr2Erdr7fRpQivQp/LRIyyxy8vrACHb59FppjQhsxalj2
         QmURvhLEOjBGdxE4By/1FBkf/d9U5uXmpHI45nzSIZ7e8WYx9VktOeyIkvsE5MbwPRV/
         Q5+CYqC9eHPsz+rNtICHEVSWkUoiW0ox0+k8SVvZtRveiOBmlo4CL6+xn05gAX8UkzR5
         DBm3BpEsejXD4N3i5FPrImi66R/Y74adL64xKfyL7Kw2pS45vhj6J4Bc7mXB78+oxOAC
         J8Mg==
X-Gm-Message-State: APjAAAWxaaRPmHrQABI//hlvr+f5Z5ohfEh1ITVe6R3O66xAzA6gOOk/
        sJD1j8pG7FtmTr+1YSAECOQ4PFt2QU/IWMp4tD8U+Q==
X-Google-Smtp-Source: APXvYqxJwbG1hsbUHaj3OB1IIX09a44fffFV/LiEAsz/JqiLdk+YVhgNf7jeJsh7uwehoDDNfjuGEejzSaMw8ClEDqw=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr2690910uan.140.1574862738259;
 Wed, 27 Nov 2019 05:52:18 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr> <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr> <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr> <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
 <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr>
In-Reply-To: <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 14:52:06 +0100
Message-ID: <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 2:45 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 14:00, Linus Walleij a =C3=A9crit :

> > Try to remove the "spi-cs-high" bool flag from your nodes,
> > because it seems like the old code was ignoring them.
> >
> > Does that solve the problem?
>
> Yes it does. Many thanks. I let you manage the packaging of fixes.

OK I will send a final batch of 3 patches fixing this.

Do you have these old device trees deployed so that we
also need to make sure that old device trees that have this
ambigous syntax will force precendence for the flag on the
GPIO line if both are specified for the "fsl,spi" instances?

Yours,
Linus Walleij
