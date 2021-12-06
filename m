Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8E46AA80
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 22:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351768AbhLFVfV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 16:35:21 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36596 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351761AbhLFVfT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 16:35:19 -0500
Received: by mail-oi1-f180.google.com with SMTP id t23so23972854oiw.3;
        Mon, 06 Dec 2021 13:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FCMMUJ0+HiyKmUIwYyAGcz9h/aDXGAPpZdZ0VwD768U=;
        b=hs2Yc95r6/EBvnZTw++Jprob1oimzlX/yfSf/LcMKnUA+N77EKVoXbtmWBiIhC1DEa
         fSNN5+DGfpu0id9lPS6ZQ6Cdm8gGtiOXovYUDRMSSetFrHNN7jYyn5zg1R1zccXWQpHk
         qOTTWIEn9MRbUHfC7UogiRYKwyL0CnyzXOyJPuv+BQQbTrOdUz0361TMur54jEaI3jmc
         1kRbOXHA9JcNQ/TYkWYmEQUWlbeep+WJbVRZgi6QU71TYp9/J5nE+OjJrryHq/g4pM+K
         r7CY70Qx3KzXRcFwKHI+gkVfjsq39X71pEkpA/W0dG/41mf0mFA1urEGcSBIoMPfo/vC
         XKLw==
X-Gm-Message-State: AOAM530qvObWfKXWrl4eM/gJZiQH9q2wgRL6il9fRCw8tZkKVBhyzpo9
        lxJim8b49xmeXVnoF3gCrg==
X-Google-Smtp-Source: ABdhPJwYnhC4hQgC55Mgltgr4tT72tEnDjU8lmBzX2mIzTWoUa3wMrCLM0xJjMjQHnzZUqJ7XRjCIg==
X-Received: by 2002:aca:44c1:: with SMTP id r184mr1245726oia.15.1638826309611;
        Mon, 06 Dec 2021 13:31:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj8sm3135561oib.51.2021.12.06.13.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:31:49 -0800 (PST)
Received: (nullmailer pid 2619775 invoked by uid 1000);
        Mon, 06 Dec 2021 21:31:48 -0000
Date:   Mon, 6 Dec 2021 15:31:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: dt-bindings: Add an example with two stacked
 flashes
Message-ID: <Ya6BRHLcElZghQRb@robh.at.kernel.org>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206095921.33302-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 06 Dec 2021 10:59:21 +0100, Miquel Raynal wrote:
> Provide an example of how to describe two flashes in eg. stacked mode.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
