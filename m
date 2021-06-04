Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851C839BBED
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhFDPdW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhFDPdV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 11:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32C4F61402
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622820695;
        bh=y9dsSXNbMIcEq8UnJffs0wbh+86AlXMXqDArzpL1ejg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qvnHZHbpffI4bqhcsPom8cj8ywwplHDIrc9BTtw2VJQW22aAhnSk0tGSEEuLIxgD0
         aecNikxqo9pq4hFXt+43hnxxsZtXY2H3qhmwR3DoCw/uhKHc1MzFXR+gN0gxVqDRAV
         moAPMX959OTsuQ2HGzintUxzs/LEhfZK1rybKZ/+hNQ0ovS82GKQQRIOdwbXTX5/32
         gaQ6EkN2ZXPdsPeAnwg/dX56kRwnNbEu6WbI4MGQDB61mslSNlF4Pm/KddQhkFJOBY
         HPMZPgDBIqa6FWc7QGUI2jh3OLXGN7yiNrkRanbH45s4FORW+khrMAMJ2M2+inKh+2
         LQ+cIAetFn8jQ==
Received: by mail-ed1-f54.google.com with SMTP id o5so11656924edc.5
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:31:35 -0700 (PDT)
X-Gm-Message-State: AOAM530fIoD88tEDpnsm3Ca4N4t7dWGqJUMh8Kd7U2mUVMIG2cCrk6Nu
        ewrEp/+bOqqCCuZQKGNlr7jweutsvbM/a/0MoQ==
X-Google-Smtp-Source: ABdhPJzcNx6WawZZJzBsETgZj/plciRUPlBKfn+5IWd+JFZZlDznsldrTyNutB1G8lqArdulvKaZyERBaxGHdyBjwR4=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr5374606edt.194.1622820693842;
 Fri, 04 Jun 2021 08:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210604151055.28636-1-macroalpha82@gmail.com> <20210604151055.28636-2-macroalpha82@gmail.com>
In-Reply-To: <20210604151055.28636-2-macroalpha82@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Jun 2021 10:31:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJyk95R=t8xWC3r2=PpARsHAYMUeNENqquW9j0LBT8gxw@mail.gmail.com>
Message-ID: <CAL_JsqJyk95R=t8xWC3r2=PpARsHAYMUeNENqquW9j0LBT8gxw@mail.gmail.com>
Subject: Re: [RFC v4 1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip
 serial flash controller
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-spi@vger.kernel.org, jon.lin@rock-chips.com,
        broonie@kernel.org, heiko@sntech.de, jbx6244@gmail.com,
        hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 4, 2021 at 10:11 AM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add bindings for the Rockchip serial flash controller. New device
> specific parameter of rockchip,sfc-no-dma included in documentation.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../devicetree/bindings/spi/rockchip-sfc.yaml | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml

Please resend to the DT list if you want DT patches reviewed.

Rob
