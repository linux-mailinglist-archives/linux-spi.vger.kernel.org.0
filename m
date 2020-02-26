Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E316F50C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 02:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgBZBbp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 20:31:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35484 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZBbp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 20:31:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so1484774otd.2;
        Tue, 25 Feb 2020 17:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m69OUPpDCFCPc/oa2eyFJo4I++z0wlZi/kprUKpLj3Y=;
        b=nA2f+OLzY/0xumh5TuXz4ftOJdyLWFEddIBk66xJxkReDm94lliWkpwvPZ4a2z3aL+
         7F+sqVUc1AzH4De2HzKgueukRv45rp0BhL1+N00JyaUl0pf8w2HajjUgeCkoJF7IJOlA
         ggEwGRbikFgBXKyJuSgVOcXhbcpJCTQKeyo/nw/xbjt6rWvnKRe6cB5I1Zh31qnj988D
         ZkrhLAL1NuHixK58f6i/pdi/eHNF5m+KjXIhJbAzoqxI3ZfMK2b0tUyDtQ86XgSM/Yq1
         8gK34CHyXzjHzraPQJFoD50QgHtNUe9dEYNAgyQra9e7EQzFbKF/kURdvfMeW7/ka4B6
         +tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m69OUPpDCFCPc/oa2eyFJo4I++z0wlZi/kprUKpLj3Y=;
        b=KJQ8jt2HgPtLxfqvnaJc7gIHrnRmN+23m4cnYRYAEi7l7rN/hSbJUoYWzYDdL7mKGf
         +abaZzNu89E0+PNEy5D5YqBReo41egOjPV4uW+WTvb6D6VcM5Iys4kqhw86hJr+wsp46
         2G21oQ8DCMRtvXEtJM9ALJwi8f3DJGgQQfM1rT5dtKw1LMczbSdNX+padXHtuOpnIuNG
         xcTHRvb7anJ/OQxJ73ThyO9cbjrxxpCKtcaHlH8bYxK5mksSlFnpWICZKTn0c/RHlQr6
         GVtCWz0bowEa8Hi7hHcgt0XFhP+Wvj5q7OP1r4x8NVVPVgmYWXtlfWe72k4b1WY+oA77
         6VZw==
X-Gm-Message-State: APjAAAXS2Lq5qhEWfyKw2ZxGWQJrJJuWg3VZn6bHKJjqPOnC2+qlM1Dm
        XN52MejeXm3LJuvevzVzfRrk8VZgD8n7CvSAFq8=
X-Google-Smtp-Source: APXvYqx4k8rPNcqHzRcAhaiCXWJ4jVniE5gHoAh/s13hkt4+EPZPVv3r7htQo04hdVYPzVU1U3PK6wlRKTZrD779bTc=
X-Received: by 2002:a9d:6a4f:: with SMTP id h15mr1129292otn.86.1582680704677;
 Tue, 25 Feb 2020 17:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20200215065826.739102-1-gch981213@gmail.com> <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com> <20200225173137.GA31830@bogus>
In-Reply-To: <20200225173137.GA31830@bogus>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 26 Feb 2020 09:31:33 +0800
Message-ID: <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Wed, Feb 26, 2020 at 1:31 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 20, 2020 at 07:58:06AM +0800, Chuanhong Guo wrote:
> > Hi!
> >
> > On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie@kernel.org> wrote:
> > > This is an ABI break so you shouldn't be doing this, if the existing
> > > binding works it should continue to work.
> >
> > The missing spi-max-frequency is the only part preventing old
> > device tree to work with this driver.
> > If the goal is to make existing dt binding work, I could patch dt using
> > of_add_property in v2. I saw similar device tree patching for legacy
> > bindings in pinctrl-single driver.

I just noticed that of_add_property isn't a exported symbol, which means that
device tree patching isn't possible unless driver is builtin.

>
> You should should really only need 'spi-max-frequency' if the max freq
> is less than the minimum of the host and device max freq.

But current spi framework forces that a "spi-max-frequency" property
is present. [0]
Should we patch spi framework then?

[0] https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L1951
-- 
Regards,
Chuanhong Guo
