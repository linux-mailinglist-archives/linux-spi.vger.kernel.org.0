Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8F449B91
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 19:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhKHSYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 13:24:14 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39692 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbhKHSYO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 13:24:14 -0500
Received: by mail-ot1-f43.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso5558667ots.6;
        Mon, 08 Nov 2021 10:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rCISeuysZKbDMgJjuEiNIJE7YuKQ2TJrqtX7kNAW6+k=;
        b=GrFweR8To4SppYhNoO1nDbVnP9/j5IZsBOuI2vhf3tqKLfv5wnssYjq+P9mo7pFBlr
         XWfXlNc1HYE+cbWkbm4cp3LVRUv20r+Ddk3c+Boycvq069nEIcJZS6deHW15qHBkuMzJ
         inHem2q/34lp1emn5QWrRqttURG4aPP8x6QZWEBmg/COn+tgio7s0oGY7ewAa5KJe60Q
         R/033q6+a+SxDAQG/0JFqWad4K1FsfKf4xriEyZ5nYaHXl8iRWniRC/YkX9KYSdoYHC8
         +/fI36exHI7uwWtFRM6qJjTNG4JbSRAyz7uesV3gtp2aNvFjP1/nhMARC5geg3CazQDW
         IchA==
X-Gm-Message-State: AOAM530mGAa+xmlCpVoAZaA6/ZQKeygDZ+h4gdu8tRMA+S+pdWWT0BH7
        N7lU4i+QLwxbEeABaMm6aA==
X-Google-Smtp-Source: ABdhPJy3zcQSwD3T164usGwB1k3ii5fGInofXXVdg+wtGM5mrZAOChqIQOn0tJZy8lyRAtiuoMCJAA==
X-Received: by 2002:a05:6830:1014:: with SMTP id a20mr836094otp.63.1636395689139;
        Mon, 08 Nov 2021 10:21:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c8sm3671908ooq.43.2021.11.08.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:21:28 -0800 (PST)
Received: (nullmailer pid 3969396 invoked by uid 1000);
        Mon, 08 Nov 2021 18:21:27 -0000
Date:   Mon, 8 Nov 2021 12:21:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: add schema listing
 slave-specific properties
Message-ID: <YYlqp7+vYd4X0Kyi@robh.at.kernel.org>
References: <20211028124518.17370-1-p.yadav@ti.com>
 <20211028124518.17370-2-p.yadav@ti.com>
 <YYlmx3QyI9zxuO9N@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYlmx3QyI9zxuO9N@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 08, 2021 at 12:04:55PM -0600, Rob Herring wrote:
> On Thu, Oct 28, 2021 at 06:15:16PM +0530, Pratyush Yadav wrote:
> > Many SPI controllers need to add properties to slave devices. This could
> 
> Probably should replace 'slave' with 'peripheral' throughout[1]. 

Forgot the link:

https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/
