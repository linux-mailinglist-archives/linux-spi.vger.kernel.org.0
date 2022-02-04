Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3833D4AA308
	for <lists+linux-spi@lfdr.de>; Fri,  4 Feb 2022 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348594AbiBDWUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Feb 2022 17:20:19 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38723 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiBDWUS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Feb 2022 17:20:18 -0500
Received: by mail-ot1-f49.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so6145463otq.5;
        Fri, 04 Feb 2022 14:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxZ5ZOHefV7TGCMx3CC+93djt+kWiLe2HpCoDPruzGA=;
        b=xBj+T2Gn3eDuhd41nvI+bu0j0W9GR/2g7za8e2LpwFs7HFhBGl+jbTQUNUzeqpsK/h
         K2BiRNijxkKmVrVlEwIjW9JhFnnYurRS2pesANU3ShFgiZhxh4S6N6JLNx0OuQQFdWkO
         ICS1R1RqC+TVycEjpgxTqLpMkRXB5gdSIn/MtHl26raJ+ehSGCWBNnv81W5Mln+uFDZl
         bi3/HYQ6pE0a86T30IflOEzmwPQedpZsDgxr+ste8Say+Zcbhe8X8QNViVYcY2gFSS0+
         fUOpggCCtuFVsJbhhofiy3qYL5QJ/UzeSKj5kI0K9jldIrG2BhpFkI87hAEYrUBIOXhr
         i+sw==
X-Gm-Message-State: AOAM530pzkfYO2T6Y0gkfElhWQTYOPgYmGHlugrOg2xucStO0IR0h3Mr
        ZY2mcMZQtu0ejJnSo5zKRysJE0qrNg==
X-Google-Smtp-Source: ABdhPJzmUGS+U+icdKSfT+qh3JXJL3R+DgctsifiOiN2IRDb0ToL/KPxtgMyUZ1Qg1jPdQPwlcqHWQ==
X-Received: by 2002:a9d:69d1:: with SMTP id v17mr407535oto.183.1644013218309;
        Fri, 04 Feb 2022 14:20:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f20sm1270009ooh.10.2022.02.04.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:20:17 -0800 (PST)
Received: (nullmailer pid 3284346 invoked by uid 1000);
        Fri, 04 Feb 2022 22:20:16 -0000
Date:   Fri, 4 Feb 2022 16:20:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, Michael Walle <michael@walle.cc>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v6 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <Yf2moBgtTRSrkmD3@robh.at.kernel.org>
References: <20220126112608.955728-1-miquel.raynal@bootlin.com>
 <20220126112608.955728-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126112608.955728-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Jan 2022 12:26:06 +0100, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
