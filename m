Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28848413783
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhIUQYo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhIUQYn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 12:24:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75824C061575
        for <linux-spi@vger.kernel.org>; Tue, 21 Sep 2021 09:23:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b15so64979713lfe.7
        for <linux-spi@vger.kernel.org>; Tue, 21 Sep 2021 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGB3KIWuUU5+UMhmxjUiQs+FGymSex7dUZpVcp4T9dw=;
        b=Bm1nRp21JyJReP1yYlxUgMG25ALeM66YI75gB0J79CC1/LkBaEYPn5GboYdTp2+8O6
         l3V+kkTUQ++qJPJx+n418dXu/OyorhyEGaTAIt0J3e7hk+q7gnVz3HA8Dr5OuOjgQWc2
         cx073pHVSY+BSKqpb/ytvZQRPksBCgnpeRRojL8Yq9aA3EroFA9nj966+8FoJo+mcffI
         ZsNKlICnlaA9wwmcBxxzX7+rMmooJoggwzu90+NA+pYEfjxGy0JO2MycIpzqiHm37uht
         CN4bX0alHqojNa+kKMDloU8pPe2HtmuFZRuJbOpjcal88HwJ5+RImVWr5IGteHJNL2wx
         ab9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGB3KIWuUU5+UMhmxjUiQs+FGymSex7dUZpVcp4T9dw=;
        b=zhC6Umnd9YkBr5C3Ripwn7AJLquZWkgWykHtqYiXe5jRfJKobzAQSsapF3Tw67MELG
         uesjWJQ66oVEZxoDeWwULJMvc7inSOYH/FZzTjLwCi1n5FQUDFTBPfnF3OPdTVfrqvTt
         g1w+B3uz6WPkKfY3JJonPyf/DArwLDyTnl06e9cU6/DUWnxqD3zo5SfuXROppww9n4SS
         mJwgdA1efIVvtuZiRwaxOooeqONKg7vm+6o+tkhNEor1QuX6aJlutM45OKHMiEsG+7ij
         245jEWPZRCu4IGOB5E/Q9ViLftIKaaPAhnRYlUxnLYsXUArh4v5KSnOUzt4YmdXT+FRK
         iV0A==
X-Gm-Message-State: AOAM531EUBw+weS1zOM/ER+PlWLroI6hmJXLVeO4NLdgdULC6Ze9KkTs
        i/kHRyKaup2Zo/vmbgEqF/yCW6bBsYuu15WLH/jIxQ==
X-Google-Smtp-Source: ABdhPJzKaepZfzeZo+OmR86T4T1kRGRS8Fl4K7TWvr5VSuyb/bkqERay8zcuxyXKtRA4wwTwhqTm3YxYntrkQhU0Z/4=
X-Received: by 2002:a2e:4c19:: with SMTP id z25mr22499331lja.145.1632241388707;
 Tue, 21 Sep 2021 09:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210920214209.1733768-1-vladimir.oltean@nxp.com> <20210920214209.1733768-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210920214209.1733768-3-vladimir.oltean@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Sep 2021 18:22:57 +0200
Message-ID: <CACRpkdZ085p_qUOXUGiA5jru8fsj-ZqbEFtANGvaO-=FevktDA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: dsa: realtek: register the MDIO bus under devres
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 11:42 PM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:

> Fixes: ac3a68d56651 ("net: phy: don't abuse devres in devm_mdiobus_regist=
er()")
> Reported-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Reported-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
