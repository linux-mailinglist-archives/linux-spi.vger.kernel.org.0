Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEADA8949
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 21:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfIDPKA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 11:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbfIDPJ7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 11:09:59 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A5E2342D;
        Wed,  4 Sep 2019 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567609799;
        bh=NqqPlIXhQO92I7kvb7x3or16fY9V13TR0NCZAUTlJWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pv3zIIc/sUvIamdwv4iXpRUltzR4Lt/8nO72lfiLWHJEJD/J84GmVfW9ZUGl4n7xw
         +SCVrmabCw4FJk9IIE26iwahrygp6t0Z9woX00HVqiGqOaKLp3ORKSVFfUDzFM+Q90
         figeioc8KZ6vY17KwwDm3Fw1WY+tfbFHaBV2wi5U=
Received: by mail-lf1-f51.google.com with SMTP id u29so16213613lfk.7;
        Wed, 04 Sep 2019 08:09:58 -0700 (PDT)
X-Gm-Message-State: APjAAAWTeqrx9oN8jMXoFVY1OmyFdVtDLbe2zcYmmBIQFmRyydjEOosw
        S7f3QrEHa1put9aTQf15NnTXAR1jxRq4+G68WDU=
X-Google-Smtp-Source: APXvYqyPSaOFdTAZs9Jlj3fYyUPiQ+i5JR3LIfqaMYnX+qGBlZPtuYUs9/i9kuI0c87VBPXwtFxNFox7lL+fRxUp36w=
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr12719024lfo.60.1567609796654;
 Wed, 04 Sep 2019 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190904135918.25352-1-yuehaibing@huawei.com> <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com> <20190904143928.GB4348@sirena.co.uk>
In-Reply-To: <20190904143928.GB4348@sirena.co.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Sep 2019 17:09:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
Message-ID: <CAJKOXPeRtbAvmR-=8Qa8ukGXt-cCj3ud_7y1Z4LgRpX3YCeumg@mail.gmail.com>
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use devm_platform_ioremap_resource()
 to simplify code
To:     Mark Brown <broonie@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com, eric@anholt.net,
        wahrenst@gmx.net, shc_work@mail.ru, agross@kernel.org,
        khilman@baylibre.com, matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org,
        Andi Shyti <andi@etezian.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 4 Sep 2019 at 16:39, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 04, 2019 at 04:28:29PM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 4 Sep 2019 at 16:00, YueHaibing <yuehaibing@huawei.com> wrote:
>
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
>
> > This tag does not look real... First of all where is the report?
> > Second, it was reported by coccinelle.
> > Reported-by should be use to give real credits.
>
> I think it's reasonable, it's giving credit to the automated system
> they've got running coccinelle (which they do mention in their commit
> logs).  It doesn't really hurt anyone and lets people see their system
> is finding stuff.

Running internally coccinelle is already credited with commit author.
The credits are coming with "From:" field.
Otherwise for commits I send I could use:
  From: krzk
  ...
  Reported-by: www.krzk.eu
  Signed-off-by: krzk
To me it is ridiculous.

Different thing is that Reported-by is for fixing bugs or issues.
There is no bug here. There is no problem solved except making the
code smaller. That's not what is Reported-by for.

Best regards,
Krzysztof
