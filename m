Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB94117A62A
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 14:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCENOH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 08:14:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43278 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgCENOG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Mar 2020 08:14:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so6687875edb.10;
        Thu, 05 Mar 2020 05:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkATtzmCc/55ZtDteZe+aqBcT/L3UipcnWyo2K/KElI=;
        b=U20IY018FngDDTtrHwz6S7AFYsJDlOokY3ys2AXG6qWreb2I14L6ivnmCEsdbr9dhS
         3Mxc9vjhfMkMvQszbj3ka5sMDxlmVkw9m59hYWEH90lFtd0V8J/LuANd+mFx2nWlVukT
         qPxjQJ4KV0+IPiFn048o/+RRwUzRF/yZbVVIQRlJ0hvihVx9XBS3012SgP42qr2oVeIO
         avPJV5WYcDxZEJvgq+Auc6q3+nxmnoFnyvhFIJneIjvROFuE0Th9JRK08e66c/465N7M
         KOl46EYg6dDhxfRlW3PQ7iGfTe4SWb9bcci3paW2BLF4gxOaBMpF0XaUnyrLEAkxw8LK
         WKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkATtzmCc/55ZtDteZe+aqBcT/L3UipcnWyo2K/KElI=;
        b=LxpQxZmu7nPxlXCIDsR+LVRkcCzU2mppssL2LUro4mi6u5W+mZtrYqt6sB5zMSqo3c
         yxKNl1pQlbiaz7FYFN0b5vDKS+2dAVGxri9QYnNg5AcyMwNGXaZeDSM/wxeHiTeGcrGJ
         eb+L3K6CywGGxhmHz4w7Xyo5yhsPS88RyvP0Ws9JRvLRAurLcxh7wLmrUt1StZgnPghx
         BfvWJsiOYnph7WdUEfrK+L36oJac+GeWHo1LuvKuNdMpxhuMQ4PatXkc5qjgQhbWU+O5
         PGjBCIN79bmYHrmYJS9Xg2wJoDO1ar1sneOItgZ2xM+XQKXFPiafiZAB+Hf65RV3APWo
         8Ktg==
X-Gm-Message-State: ANhLgQ03SIuwmw7Sy+zczWiK1CuR4v/wVdbTAvC/hdfof0Rt23gZqFdU
        t6DhVa2II8RcuON25LjqGO6NnvJu8AsFIOWezO7Z+g==
X-Google-Smtp-Source: ADFU+vuIxyP9i7lL6OCCspJnFjux+SJUqMkwULBhwgGnG5zFboIo5vlgv/Rf+LiYjgucxB+IdM4UPfuHwriXFyQP2WY=
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr6999237ejj.189.1583414044713;
 Thu, 05 Mar 2020 05:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20200304220044.11193-1-olteanv@gmail.com> <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk> <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
 <20200305130448.GC4046@sirena.org.uk>
In-Reply-To: <20200305130448.GC4046@sirena.org.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Thu, 5 Mar 2020 15:13:53 +0200
Message-ID: <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 5 Mar 2020 at 15:04, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Mar 05, 2020 at 03:00:22PM +0200, Vladimir Oltean wrote:
> > On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie@kernel.org> wrote:
>
> > > This is a fix and so should have been at the start of the series to make
> > > sure there aren't any dependencies.
>
> > My reasoning for not submitting it as a fix is:
> > - The only driver that uses the functionality so far - spi-fsl-dspi -
> > has worked thus far even with the limitation that only byte-by-byte
> > transfers were supported properly.
> > - I removed the limitation before actually changing the operating mode
> > of spi-fsl-dspi. Therefore the limitation is effectively never seen.
> > - New SPI drivers that would want to make use of software timestamping
> > would do so through your SPI for-next branch anyway, where the
> > limitation would be, again, fixed.
>
> That's mostly all true but it's still better to pull fixes like this (or
> the patch limiting the size) forwards and not have to think if it's safe
> to not apply them as a fix, it's less effort all round.

So do you want me to do something about it now?
