Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CED465A14
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 00:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353905AbhLBAAj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 19:00:39 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34801 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbhLBAAj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 19:00:39 -0500
Received: by mail-ot1-f41.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso37615645otj.1;
        Wed, 01 Dec 2021 15:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdYKlP0LT1ahpmU3oI3bcKznEMIHXNXlW8Bp4/Ld1E0=;
        b=Z+ZikqhVkwJFMj7YIsRPz09FA3BCHY7ZeczrlaQcaOxt0+FyKCzwFWkGVCgw7uTTMP
         R4bAMFqLwDflgSfVD5qv6MMAUswcN6iNYFAHQuD1snWu1gzszD581Crc8i57vCkaaXnh
         2YgF7p1pm/MXP6r+8vnrPIWEeO9LPwsE5onpj4t3+em2HNtmvtkhmU13zoqD+ydTm5jP
         7cBqcaxPkYwz9uA6+xBxaN/0iybjzAwi/OSlQGGmtNqj3pBa0NlFZKeurtg2AypBo8yo
         K1BUB/DiKjoDc+8FdLCAQiKhEQWVLBdqG1acekwX2kb//B9y1Mfq+wUYCxW79Y1f2FEE
         gkbQ==
X-Gm-Message-State: AOAM531sbuRHTzEyLqkHptglduteP1NSuiQFurwFPYxqfP3D7n/9jfgP
        X6u6jKxVmlWl3ysMCiI7qQ==
X-Google-Smtp-Source: ABdhPJwhY5Y9vM8+vyvH88bL0iQ5cXqMc9aDFA0LrcfcMs5twctjw4Ko3C1J0hX0jjaI/4xsm859ZA==
X-Received: by 2002:a9d:77ce:: with SMTP id w14mr8835797otl.252.1638403037263;
        Wed, 01 Dec 2021 15:57:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm455435oom.32.2021.12.01.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:57:16 -0800 (PST)
Received: (nullmailer pid 3253597 invoked by uid 1000);
        Wed, 01 Dec 2021 23:57:15 -0000
Date:   Wed, 1 Dec 2021 17:57:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mtd@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 5/5] spi: dt-bindings: Add an example with two stacked
 flashes
Message-ID: <YagL29VKiKZcu7KQ@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-6-miquel.raynal@bootlin.com>
 <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
 <YaO0ahOhM3XwLqND@robh.at.kernel.org>
 <20211129102319.1efe1841@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102319.1efe1841@xps13>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 29, 2021 at 10:23:19AM +0100, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Sun, 28 Nov 2021 10:55:06 -0600:
> 
> > On Sat, Nov 27, 2021 at 04:13:22PM -0700, Rob Herring wrote:
> > > On Fri, 26 Nov 2021 17:34:50 +0100, Miquel Raynal wrote:  
> > > > Provide an example of how to describe two flashes in eg. stacked mode.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >   
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/spi/spi-controller.example.dts:40.23-45.15: Warning (spi_bus_reg): /example-0/spi@80010000/flash@2,3: SPI bus unit address format error, expected "2"  
> > 
> > Unit-addresses are based on the first reg entry.
> 
> Yes, I believe this error is expected since dtc has not been yet
> updated. Below the patch for adapting dtc to this new situation and
> keep the robots happy.
> 
> How should we proceed?

No, I'm saying you have this wrong. A unit-address is composed of 
different fields, not different entries of the same field. For 
example, an external parallel bus has a chip select plus address, so the 
unit-address is '<cs>,<addr>'. If you have 2 SPI chip selects, that's 2 
entries of the same thing. The SPI bus is not 2 address cells, but 1 
cell with 2 entries.

Rob
