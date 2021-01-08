Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5805A2EF3EC
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAHOai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Jan 2021 09:30:38 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39893 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbhAHOai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Jan 2021 09:30:38 -0500
Received: by mail-ot1-f54.google.com with SMTP id d8so9796406otq.6;
        Fri, 08 Jan 2021 06:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+8po3MCNGHszVSg7voDdKPux+Z5VkFbpMmCVTH4PIw=;
        b=N2E64KmI3ZVYD9zR/L/dRafhmxt/woeFP1NNDqIxXZziD2nWgXvlGNONlFYuEdB+gP
         uibxq6RlFo7JxVnEbxYBo7TRnfJbpHJarZSjVY/FxxrounKmXfaCbsFMX2Vj6k6dKsp9
         /cfnfPA2X0ry4yk+jvwHnnPaKZHRFZabXkWwvQoWdFjo96i01SgD88Yo7jeVuivh2kqh
         HRJRYUJ5DR5gbSx1Gt3qSzd6kMMu7IVvnQ0UzSGk+cy+6HnMjMWZvNhbkc0coRGTiGkB
         gRbh4WhT1cT7CHYclcSilRsC8Ot1OSpkUpONdRnMEQttn6EG69e+mambVSjueFbwBI+e
         FYiw==
X-Gm-Message-State: AOAM530amwhiQgjiC5Qh7C67Ggm+yUwoZxpi0u1HqsjzFAbePwFeDc8S
        N358Mxkg2tWjhHGONphzvMpsCECv2ivzRnuujwf5PwQS
X-Google-Smtp-Source: ABdhPJwl+BqdH2H2/ssNozGMysossAqp9Zm0Bcs23QBTmbqRiqYazzPRJN3JyfLywvVHhIrmUCdcdtVXFMwgHFhqR+A=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr2731695otr.107.1610116197434;
 Fri, 08 Jan 2021 06:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20210102115412.3402059-1-aford173@gmail.com>
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jan 2021 15:29:45 +0100
Message-ID: <CAMuHMdVdzngBwzh7-HVyCOmqsf8wna3ysGbAzPo1UEDG6RL1kQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: memory: Renesas RPC-IF: Add support
 for RZ/G2 Series
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 2, 2021 at 12:54 PM Adam Ford <aford173@gmail.com> wrote:
> The RZ/G2 Series has the RPC-IF interface.
> Update bindings to support: r8a774a1, r8a774b1, r8a774c0, and r8a774e1
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
