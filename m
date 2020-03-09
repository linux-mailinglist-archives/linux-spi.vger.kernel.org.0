Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D0B17E67B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCISJ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:09:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42262 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISJ7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:09:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id n18so13087258edw.9;
        Mon, 09 Mar 2020 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ymUyoWzRfb02+hfegg+QB7d5gLRotDje0gN7Rw97jE=;
        b=aZUNB8/m4hdNxkjniWKBlD+2MNKKa8FM0iAAyRr/tFj5vtS0wP6Ib6paQTtK8MAhVL
         mxAsKJ5m9jlp4m2rwl57ZYIzPSaeBMEDy4dFXzgZFZr8aP0wOClYQamk+pPvCstbhL59
         LhKjmZz+19wpA9/1HsXmOMEyvfJFo7OiM5vJxKCXi/fAo+jrhyjr+UCPw6n/z9QXqMho
         1MbhnVKh1XMVgyC+OqWGEN4928e0teCk/kJqTX9/ggkscXhos6nT9OT/9kXjREIoOnLY
         1mW6JoULcOEZr7p+xTvcZoFH6yduxJOZly3f5MZBY/F1xwFmHLX1YSn+FkGrRhnsOOdK
         5+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ymUyoWzRfb02+hfegg+QB7d5gLRotDje0gN7Rw97jE=;
        b=oZCcV1GeZ9bolHcciGXM9AZUPT8ZGjBu2v7xgFMAwpd3CtQWHcqOxWu38WmGzd2daz
         m7lLT+jGWolEioDRf3jxHvRNWrvoD5onHN/P2DlvACMYzUYI1Ky/SC4BB+g78Frgk7hX
         FndEvsrFxGkkwgicibg9f+vla3dQBkCnsghtTDGwQYeZeKi9ip8oB3GNqEQx354kq7SS
         4o7W1JyRXlqkReUwGQzmotQ6djfKdMUWB13oQmZF8fbKUqk91pixBtoH0Now/LARZ/uw
         dUpLA7Lukhv3oaxCcecgm99EQmBpeCKogTr6FK4x3c2FHu87GiAjjWjr4839GNviLK91
         HzZQ==
X-Gm-Message-State: ANhLgQ3lZH36tRFgtWQHxZpN56meiqIAp6v2GE1WAuGkxRzoBN4fKX9q
        HPYmIEvI/Xzk7KYZVU1Jxir5ju4SY91sInCh/5U=
X-Google-Smtp-Source: ADFU+vtiWM2hCTGldMzIEsZsmgDjW6xnZcnOLWNAFcwYZS5ihirWrPk0G2791uJ2wPG1rSuLGjegnUwNdP8AshjEvV4=
X-Received: by 2002:a05:6402:128c:: with SMTP id w12mr18684596edv.368.1583777395945;
 Mon, 09 Mar 2020 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-2-olteanv@gmail.com>
 <c35b3c34123b43b26204a2cf360e7ec1@walle.cc>
In-Reply-To: <c35b3c34123b43b26204a2cf360e7ec1@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:09:44 +0200
Message-ID: <CA+h21hquwbP-qg21EJKW6BpAVRSm0WE6OUWeg-zsorZrCFT=dQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 9 Mar 2020 at 20:05, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > The SPI_MCR_PCSIS macro assumes that the controller has a number of
> > chip
> > select signals equal to 6. That is not always the case, but actually is
> > described through the driver-specific " signals equal to 6. That is not
> > always the case, but actually is described through the driver-specific
> > "spi-num-chipselects" device tree binding.
>
> Repeated sentence? Was this your intention?
>

No, I must have tripped over my vim shortcuts. Sorry.

-Vladimir
