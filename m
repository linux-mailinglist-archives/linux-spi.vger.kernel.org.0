Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA34421688
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhJDSc0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 14:32:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35490 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbhJDSc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 14:32:26 -0400
Received: by mail-ot1-f45.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so22780936otj.2;
        Mon, 04 Oct 2021 11:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgPusyLa/5AAFYa6yY1gZl5N0nwwIA+sqa/A5TmSbTw=;
        b=3up3cJG1GltDbF4qACuP5BDD8UMYJUh8pIhliR8w5Lpwx9AfdKpcBOyIZmhFE5ihe4
         oSuSwfg0gUs4HTckuET76jsCZPVIWSS2wy/dk8nB/3slH+zJj0Aht1+JI9KayL3r8TR7
         y6CedlZgKff9JS3+Rg2jqj9KiFKH8lAoSMsbHZtLZZDBLlF4eh8qtcncEyasVxd5RgmB
         cRuI8sd0v7n83+gdk0idvlNmXxaMuBia0R568YJdHC5eE20QGmxW46mnLll5f2jobVvb
         FBeX21XbBfN3xz/ZJiQghWzELJ6pjywy8GInz8bg2IQCS2A9VBtiA8SYDG5Ttxce9Ewr
         Gn0Q==
X-Gm-Message-State: AOAM533xFfXj5D/jbsL81lnX+8LAEF6zmGa0cg0HEjIeMXyr80Lsz+rb
        QU1KmvZeaEgGYmloVfVysg==
X-Google-Smtp-Source: ABdhPJylK2zM8ZBzjb/VuvgJd36umt1ITGM8Rr7KONWnz1nplFDn8bbEertxC5/oBScOiB5/auclxw==
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr10340844otp.44.1633372236265;
        Mon, 04 Oct 2021 11:30:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s189sm2284253oif.14.2021.10.04.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:30:35 -0700 (PDT)
Received: (nullmailer pid 1615750 invoked by uid 1000);
        Mon, 04 Oct 2021 18:30:33 -0000
Date:   Mon, 4 Oct 2021 13:30:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/6] dt-bindings: memory: renesas,rpc-if: Add optional
 interrupts property
Message-ID: <YVtISflCYbhKZzdJ@robh.at.kernel.org>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 28 Sep 2021 15:07:17 +0100, Lad Prabhakar wrote:
> For completeness add optional interrupts property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
