Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80094ACA13
	for <lists+linux-spi@lfdr.de>; Sun,  8 Sep 2019 01:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIGX61 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Sep 2019 19:58:27 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:33210 "EHLO
        3.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfIGX60 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Sep 2019 19:58:26 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2019 19:58:25 EDT
Received: from player728.ha.ovh.net (unknown [10.109.146.137])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 71088141810
        for <linux-spi@vger.kernel.org>; Sun,  8 Sep 2019 01:39:05 +0200 (CEST)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 4B47C979D591;
        Sat,  7 Sep 2019 23:38:10 +0000 (UTC)
Date:   Sun, 8 Sep 2019 02:38:10 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
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
Subject: Re: [PATCH -next 25/36] spi: s3c24xx: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190907233810.GA15768@jack.zhora.eu>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-26-yuehaibing@huawei.com>
 <CAJKOXPdq4as1Oe3U+9znkvP0RA=sxUoiWVBCSbzf_wq_um2t=w@mail.gmail.com>
 <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3595bac1-e426-b4f9-4e24-01e104fdfe5d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 4582412622624637493
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekvddgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yuehaibing,

> >> Use devm_platform_ioremap_resource() to simplify the code a bit.
> >> This is detected by coccinelle.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > 
> > This tag does not look real... First of all where is the report?
> 
> It is our internal CI robot, which is unavailable to external temporarily.

Hulk Robot is not a person and not accountable for his report.
If it is your internal CI, please write a sentence stating that
the fix has been made using Huawei internal tools.

Credit must be given to tools as well, but not accounts that will
never answer an e-mail.

Otherwise, the patch would look fine.

Andi
