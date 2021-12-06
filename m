Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C146AA54
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbhLFVZk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 16:25:40 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43706 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356174AbhLFVZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 16:25:34 -0500
Received: by mail-oi1-f180.google.com with SMTP id o4so23848046oia.10;
        Mon, 06 Dec 2021 13:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtzbU8c0o9gJTrJwZtxJGMONYkckI9EfUgoa5uU3qFA=;
        b=sK4vBJkq+Gav+zP2x36IkYTJcJQ6cFHZi8Gf0Wewbfc89EoEuaTbgCjGS2vU9okYI3
         mrNQs51rzsRO5ejq/EVg+Xei+jucQnpAJKaBXZ2S39oNGrM21SWXIqLtxsDWahs4icZP
         T4DlgQyYFGwqbP4o++9O4Gj+/WwYqvjKUpqCIiC4SLNC7mp1RCPA+cUzxOKxh8AKndsw
         3RTI2jn+EO57KjazJ6gjPq1lM8aNjW8DxpPcKivILJ+Cyx60FtvfIfv7nToUC8bV1ah7
         dJ33Y8KtHdXRUSjyRpEpmMPcHUe18xy47uh8YYXgoXLEK4+gaZUGSlbdDCwzYeD+v50o
         6gNQ==
X-Gm-Message-State: AOAM533DhnaPZMpQ4pOFv9hY4GNQAuEHkSADQ7N0IZglea9C28VwJ72C
        Vmg28ZfLeqaKk4UuUlVcuQ==
X-Google-Smtp-Source: ABdhPJx+6qLHMV08kPKLLwEC00L0H/b5sMt6rFhfrItlQan9KP9JMfFD/XZlvj0GkVxmJHAGdNzU5g==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr1234161oic.53.1638825724466;
        Mon, 06 Dec 2021 13:22:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm2980347oiw.22.2021.12.06.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:22:03 -0800 (PST)
Received: (nullmailer pid 2606265 invoked by uid 1000);
        Mon, 06 Dec 2021 21:22:02 -0000
Date:   Mon, 6 Dec 2021 15:22:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <Ya5++vUkIKXtE1ja@robh.at.kernel.org>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206095921.33302-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 06, 2021 at 10:59:20AM +0100, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
