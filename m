Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A2421683
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhJDScN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 14:32:13 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39922 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbhJDScN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 14:32:13 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so22782575ota.6;
        Mon, 04 Oct 2021 11:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Hga8p58pr2bFvROm6q0SXOaz+V7BKKQwphrn3bK5nQ=;
        b=Rj8Z/qcqD5FVcgQh+wFGmMDZFS0d8OOSjCu9i12RTR2Q1kQygctSzZ49lV8MEujaGX
         yQK8840SUU1iisJSl1ONFwMEABSX0RcOVXfz0aXJJ5wrHOJioRJH9iEC0ujS6MiWKt9a
         CjpbQQWw5tMnaQe2anF6GWdn+9je19iGaEwX7KcFon6s60Ms5zJAyi9UUbUVb9cIUpGu
         Z/ekEGobVhE6Mvj8QJyXsS9wC/TM9SBvr6CsP0DZnpVp4tUEXvq07bMPSsjKIFFgEgnw
         c7N+CDCszWF7as9hVOndWU5ACemU4BonEU4NNTDv+qbCvu184tfrFRzYSGOr28O6JG0+
         zl8w==
X-Gm-Message-State: AOAM532o1O5NP6gC/+hF3NjWhE4mRoegtNmrbwPyduRHxfZ5GZG7AnGp
        uqK3vb1IrHGJQroi7dYDfw==
X-Google-Smtp-Source: ABdhPJwwbNKoiwstW+77MUhfqKv75Q2Zy4WCYXvf8PuP96jj8q/xMG8t7An/cJMI3Fhl9mh1pIsSNg==
X-Received: by 2002:a05:6830:40b0:: with SMTP id x48mr10673721ott.246.1633372223776;
        Mon, 04 Oct 2021 11:30:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 17sm2814736ois.45.2021.10.04.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:30:23 -0700 (PDT)
Received: (nullmailer pid 1615342 invoked by uid 1000);
        Mon, 04 Oct 2021 18:30:22 -0000
Date:   Mon, 4 Oct 2021 13:30:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 1/6] dt-bindings: memory: renesas,rpc-if: Add support for
 the R9A07G044
Message-ID: <YVtIPqHyi/z03yxS@robh.at.kernel.org>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928140721.8805-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 28 Sep 2021 15:07:16 +0100, Lad Prabhakar wrote:
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
> 
> This patch adds a new compatible string to identify the RZ/G2L family
> so that the timing values on RZ/G2L can be adjusted.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../memory-controllers/renesas,rpc-if.yaml    | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
