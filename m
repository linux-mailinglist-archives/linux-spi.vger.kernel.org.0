Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F24607C1
	for <lists+linux-spi@lfdr.de>; Sun, 28 Nov 2021 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358655AbhK1RA3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Nov 2021 12:00:29 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46040 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbhK1Q62 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Nov 2021 11:58:28 -0500
Received: by mail-ot1-f42.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso22052320otf.12;
        Sun, 28 Nov 2021 08:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Kx4mjHYh3JbxTIKV4lb6j/qBNb/1oR0ibaR7m8wF84=;
        b=eG62JzmFIoPSCcFSYDt4U633gGzShET9PK1+GWjUsPUj7nrJk8ANNEAg8hepgiuicj
         SNN8tyLSiR1hQ4VtJTxyiIZwWqb7YGbOPzzrWhwXVxvKFL6oxhsF4CbIeBaNBY1mxZvy
         yXYY1r7xwL3t2MfGI+9VzGr1RBnMFP3KbuQ7VxwS+z8UpWFWwRTEAs/EHDZLUbYA7EkQ
         q46L6jPXHWO+i8TqEA+pXxCL/5Ly3ukgTZ4qiIAofccTzXdADx/r3xlUVL3elM1zvn1m
         +wlw6QcfG7cuqYMKr4fAYssogp9i4mlE8PEoLxO5Ab1IMt73E6Pb6eTgOHWzvT0tvheD
         mtkw==
X-Gm-Message-State: AOAM530BZvFLu9eYoNLvi355PCBuEhy4DcDCvrHOLtXRCGOijj+Z9O46
        23w2SSVQBkChgUKm6QyjJA==
X-Google-Smtp-Source: ABdhPJzH+fMrufpgBICy1lv/D36s6g3VY8c0AiVKM2GIpW7BfPG91KQD8bigrq9CNfmGjd4PMkzL1Q==
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr39803123otg.301.1638118511627;
        Sun, 28 Nov 2021 08:55:11 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:afc8:f6e9:d57a:3e26:ee41])
        by smtp.gmail.com with ESMTPSA id w5sm2159875otk.70.2021.11.28.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:55:10 -0800 (PST)
Received: (nullmailer pid 2710081 invoked by uid 1000);
        Sun, 28 Nov 2021 16:55:06 -0000
Date:   Sun, 28 Nov 2021 10:55:06 -0600
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
Message-ID: <YaO0ahOhM3XwLqND@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-6-miquel.raynal@bootlin.com>
 <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 27, 2021 at 04:13:22PM -0700, Rob Herring wrote:
> On Fri, 26 Nov 2021 17:34:50 +0100, Miquel Raynal wrote:
> > Provide an example of how to describe two flashes in eg. stacked mode.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/spi/spi-controller.example.dts:40.23-45.15: Warning (spi_bus_reg): /example-0/spi@80010000/flash@2,3: SPI bus unit address format error, expected "2"

Unit-addresses are based on the first reg entry.
