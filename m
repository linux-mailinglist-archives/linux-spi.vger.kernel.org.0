Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2646AA7A
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351991AbhLFVfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 16:35:04 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:46720 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352046AbhLFVfD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 16:35:03 -0500
Received: by mail-oo1-f42.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso4773524ood.13;
        Mon, 06 Dec 2021 13:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGVMocxzrwSJvpkLOikrjLjUvyP1cbBTRtuBKh0+UVo=;
        b=3kCGlmYNBB1MjhMBYVSDw3U5VlNgC19CsZ/GtrPEzMMBmr0OXnUPjLfmXTUCevha2Z
         Z7tqa4CK1xhUi0T0rkOi742ZVjxukstagxL+YPrwE9vRUs2iCEngUrj9IQrUh1+OiYUC
         s4Z7GSEksvbZ8lZAnBP8ANm4OTYYN9fY51MW0quDm/ruuB6FjNU90fj3mdpDgC2s/pZg
         PB0MEtiAO6/52Di3+FpKUt+Cgsftd2jO4YBN4resSUbWrIc5MXW85xyEPnB50b1YJZB2
         aTaPHT1WX7jTdOpT3z7TI2KM2uuLRAsNMV0vOIfSjE/mTZMAzPzJjAgBbTNysItaLJQ+
         3e2Q==
X-Gm-Message-State: AOAM5306yVhNL+BzqQlYoPREfR2xvevaW9w+zDByS5Cnn1fS4CXHpFKR
        Ilob3HAPncG7Jf/fRSQgnthnkc3CgA==
X-Google-Smtp-Source: ABdhPJyKYQSIcGqPHmeo2t8IF2UE+YqzQpYLD8znNuCAHu6fH6Goz2Df3ODuTf5jffRIALOa3oXogQ==
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr23892589ooi.53.1638826294284;
        Mon, 06 Dec 2021 13:31:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm2865342oig.15.2021.12.06.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:31:33 -0800 (PST)
Received: (nullmailer pid 2619328 invoked by uid 1000);
        Mon, 06 Dec 2021 21:31:32 -0000
Date:   Mon, 6 Dec 2021 15:31:32 -0600
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
Subject: Re: [PATCH v3 0/3] Stacked/parallel memories bindings
Message-ID: <Ya6BNGHhflkXOItV@robh.at.kernel.org>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206095921.33302-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 06, 2021 at 10:59:18AM +0100, Miquel Raynal wrote:
> Hello Rob, Mark, Tudor & Pratyush,
> 
> Here is a third versions for these bindings, which applies on top of
> Pratyush's work:
> https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/

Mark, can you either provide a stable branch with this or apply the 
series? Note that there's going to be some other patches needing 
spi-peripheral-props.yaml, so providing a branch might be better if you 
don't want to collect the patches.

Rob
