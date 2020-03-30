Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598211986EB
	for <lists+linux-spi@lfdr.de>; Tue, 31 Mar 2020 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgC3WDS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Mar 2020 18:03:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37544 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730798AbgC3WDR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Mar 2020 18:03:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so19894755ljd.4
        for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2020 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UILNYd+wc5Om9SHaEy7I98AnjGolTLk1pejQ9jaM4to=;
        b=LeIM44GHtM/UuFN4/dDoAV3aDlgJx2PnG5YEVkgJmb/EybPWc/vPEYo4iKZWbh6s9l
         tzm9q6jzXp7LXcyTBI/JzL++naZV53lAsuvAWwsjJS/VDGmT4TtW57UPt9My1GoJFUjo
         ZzGvmq/4diqXEOt4uIZb2kx8MvrrQkYyiZtQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UILNYd+wc5Om9SHaEy7I98AnjGolTLk1pejQ9jaM4to=;
        b=n3P3T3v3l92YTEcqFjIVZEIBt8fDhY5Zv4Sc8JeJm/HoSXB3CcHiMZPcBO7CG3ANgH
         hbZjBnbNzXvj4xVl/cqRvqftop6BjhZUMTyeCpXOUVcvaVy8PkJRicsgsLMbrQAd9jea
         fExxtmzf8vUvUp0C1FAMhzPhzqcDl5Q5e06wGvvRMSBxtakMfI7xXdiKZYjtqQR5QJg0
         /meQ4qR3FG1VqqzOwuLMSLYtnX5PU6y+OFGFoEQ+3W2DpRDUL5cCndzSfSJhb9vq/nMF
         zmjgSGUPmmN67pF3kTUVcIzt0ev0PrlyewJWD4qQWb0h6Td+3jXN2UsIYM7HsjZHTLrH
         rj1Q==
X-Gm-Message-State: AGi0PuYSNuwSGqnD2WC+KroIhMnGHX3RYjfjtvKdqf9Qt1EaHejuJ3bB
        PU6xw+EQ9M3taKeWaSuMd2Cc0mejGXQ=
X-Google-Smtp-Source: APiQypIdxNDMj/e+svUUoQo81YN1HM+qU9djLonpUlR3lA2J5PTw1ILTPIEDLwcxdwIF5YKv4Ivyxg==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr8192501ljg.49.1585605794712;
        Mon, 30 Mar 2020 15:03:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 8sm7234580lfk.64.2020.03.30.15.03.13
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 15:03:13 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t16so14737037lfl.2
        for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2020 15:03:13 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr3516628lfo.125.1585605792996;
 Mon, 30 Mar 2020 15:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200330123732.GH4792@sirena.org.uk>
In-Reply-To: <20200330123732.GH4792@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Mar 2020 15:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7BSueNOs=GZ0Eic-3jfpBHbt9Bm5Rk0BYVFRVLyTEQ@mail.gmail.com>
Message-ID: <CAHk-=wiS7BSueNOs=GZ0Eic-3jfpBHbt9Bm5Rk0BYVFRVLyTEQ@mail.gmail.com>
Subject: Re: [GIT PULL] regulator and spi updates for v5.7
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 30, 2020 at 5:37 AM Mark Brown <broonie@kernel.org> wrote:
>
> At one point in the release cycle I managed to fat finger things and
> apply some SPI fixes onto a regulator branch and merge that into the
> SPI tree, then pull in a change shared with the MTD tree moving the
> Mediatek quadspi driver over to become the Mediatek spi-nor driver in
> the SPI tree.
>
> This has made a mess which I only just noticed while preparing this
> and I can't see a sensible way to unpick things due to other
> subsequent merge commits especially the pull from MTD so it looks like
> the most sensible thing to do is give up and combine the two pull
> requests.
>
> I hope this is OK. Sorry about this, I've changed some bits of
> workflow which should hopefully help me spot such issues earlier in
> future.

No problem - and thanks for the explanation. These things happen,

          Linus
