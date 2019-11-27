Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCAA10AD25
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 11:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0KDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 05:03:06 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43709 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK0KDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 05:03:06 -0500
Received: by mail-lj1-f178.google.com with SMTP id a13so583368ljm.10
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE/iCdYHndFpc/Vd1E/rLvIiYAhS927Axg5oqy6mft8=;
        b=XyWOIv/9cJhWDHogdnraBagGV+6FiaTShU2P+EQDiYk538wtWslWxnTiQo6FX28vRQ
         MRlg5RlE4ug6Jp+m98l1M4R/I88wvNwLAAGgDHYcV8XliPY0//uo5cfTuANGWRavJtoA
         dKa7kmFlTzvsCVG6pG5ywKKysJKbWPOJMGeeXwo2oj7s9reohtwhN2D3YAbr74VFjHdu
         Voym/oSnX5/mOnCpS72tyjpoiLLZYYXCnsSbDi1jg5ktXc+nTu83uXr+iwcdTmXgpx56
         mJWF/yFCbGR3aKMQ8PpkRVZ+XoZAzDivj3xcHLYCxuCBdi20etSWImu7qqZEhc0+sMHA
         y0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE/iCdYHndFpc/Vd1E/rLvIiYAhS927Axg5oqy6mft8=;
        b=FoY2oMPAZUGyS8SHUJuwusB/kSCFSJi7hxyruEECrzLWyGWCzBJ1ptD0alWe/pp4Ch
         7rtDImer4rqCVbWNuqrUz7/jrI1cVOTFcVvZBKfMz37CE8/mWvncYf+/RWxBEWovcBM0
         tlwGEN981jQmPsKABy+x+kC2Rzg+XLQh5K10qwjYhFLOQBHjJBPWMBZWnK43WOkw9d/8
         JdQNyeZjVwgHbA3QGV/oUXJyxKlzbROtI1+5KQ7BtObR/qKTXQh6n6zdzm5dh7r9pyv5
         poRFGscHQ2sqLgOfMdIPVrfORqFt29nt/imqwDAym6g22LXux0h4laifOI3psDF133Yq
         AbUQ==
X-Gm-Message-State: APjAAAXtlfAQu5e4irBbG2MtBWx6Cqk2hIpjuQVBpm+p/PcvKpdBtqGm
        g3VKAD7cVC7g/N6ix/+fea1W0soT+l10GtIakhpBpQ==
X-Google-Smtp-Source: APXvYqzYs76Uwe+UFp5VQj1Em0o54MoZmAIAGfN8OIxLvEYlhfXcFCwZSRJbA50jOUEOA1DKlxAXUuBxKRao9wZ+SJQ=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr17669943ljm.218.1574848982885;
 Wed, 27 Nov 2019 02:03:02 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr>
In-Reply-To: <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 11:02:51 +0100
Message-ID: <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 10:34 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> In the meantime, I have tried changing "gpios" by "cs-gpios" in the
> device tree, and I get the following warning:
(...)
> [    3.156654] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-fsl-spi.c:716
> fsl_spi_cs_control+0x64/0x7c

That should be this one:

if (WARN_ON_ONCE(!pinfo->immr_spi_cs))
   return;

That happens when spi->cs_gpiod is NULL so the
chipselect isn't found and assigned, and the code
goes on to check the native CS and find that this isn't
available either and issues the warning.

That one is a bit puzzling because I know we have this
working with other "cs-gpios" consumer drivers working
just fine. :/

Yours,
Linus Walleij
