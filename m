Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56267B2FA3
	for <lists+linux-spi@lfdr.de>; Sun, 15 Sep 2019 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfIOLAp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Sep 2019 07:00:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33544 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfIOLAp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Sep 2019 07:00:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so20703654pfl.0;
        Sun, 15 Sep 2019 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9ULWGyjTvRvcs+e2Yr9L/eBPsXri8OnRsYgrDC1xvs=;
        b=p20pBb4MLemTqg/ZyR8Z/+eIeXKniDpVbE7ullthIp+Qa8BvEWzgsKvto/w8qBIAzL
         O8YYczWHbxeJU2s1FuN2ribAKzxhXNTfDKxT2r+DL8fVPqSsPo9PGz5cBszy+t/qkUXR
         0l3wTsNCXGfhZuAjLolWwc9oGKo/IGP6z6kHTt3Nkty1NESIn/6ekdlgL+DVlLhsW76/
         eZ4lqrclHSnXfPcr1qS63K9TPgvdIMPQVCD6JhElfMc3squMbcaXMSr8BDW8trES2MwQ
         bWinlFSKlhHMSXawG/CEtqhk4igbqnoPo/FamITlpgHidQVoMaVh4q5nawDO4SoYIoqe
         T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9ULWGyjTvRvcs+e2Yr9L/eBPsXri8OnRsYgrDC1xvs=;
        b=cvmiE1dnvRe3roTb1J1bu2R+DEYgQ+s9meq9lMZ5zOkH8tjEEgyUi4C+y2Ai2pRfHi
         TqgwnWcYPwzMNgjF2HcLWuu3lhSTqJC0jfZYvtWfHKnCwbsRZ4qy+zRSu/vc6pPGLbuJ
         E67RRx1v8ku7lEhPYdaDbUxXpFNVGDhpE5CfcE0x2Kfc8dycUnJufHqhttk1h8dAieaX
         0VFXq5Ehq8hxvz2DA8Q0jMnoxHneKGFibTBDXBlyJRz7ozNfWt+YoE15kU7i9LTyyrmX
         LcOLsEsTMFB1XT5lBD3wM74LfbMOOL3Tq579wsLHW0bzBeQ74MkvVGuqfxZi/kBXK15D
         bkUQ==
X-Gm-Message-State: APjAAAUjM6gDpDpPwQE4jPWM4dgKyvJ+aYiXyPK0qzJzd1/sc4hvnIIv
        TSujCwZ+G3vI+7/RhYm1pswBEeA2MzYM9lVBr/k=
X-Google-Smtp-Source: APXvYqzRqqT1Z8Iy+S3yNqh4wOlL8hurOD1p5+F2vaROQJ7IE7fxo9xSAo0aZoLYWfU/dVg5Y//7g8epoVhT/faDPX4=
X-Received: by 2002:aa7:811a:: with SMTP id b26mr9020046pfi.151.1568545244830;
 Sun, 15 Sep 2019 04:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com> <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 15 Sep 2019 14:00:33 +0300
Message-ID: <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 13, 2019 at 3:14 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
>
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> additional registers for software CS control and DMA. This patch does not
> address the changes required for DMA support, it simply adds the compatible
> string. The CS registers are not needed as Linux can use gpios for the CS
> signals.

> +       { .compatible = "renesas,rzn1-spi", },

Can't you simple use in DT something like
  compatible = "renesas,rzn1-spi", "snps,dw-apb-ssi"
?

-- 
With Best Regards,
Andy Shevchenko
