Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27130115E7F
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2019 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLGU3A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Dec 2019 15:29:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44806 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfLGU3A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Dec 2019 15:29:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so11256818lji.11
        for <linux-spi@vger.kernel.org>; Sat, 07 Dec 2019 12:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l2Bez8LdoluwsORjwCrpP+ORceYmTvmMN1fTDoAmM20=;
        b=YPH9mj0Kpv04KhAttwgYfeRxoLsTRerNnVEWXNEmSiGXVVtmex1Xt6OXiOS3bhbOkL
         px0mSPW7+X1FG4sDoeEfD1M24YYU2d2Gfmc0v55TdiToVI9CaQb8KI+Ycwa9iwo7nSP4
         Oi6aVD4YHbgGxMoyTHM85piOKkbTTUSxrnK/v3WJCNm1+shNe+i0ug68uW8ijb7WFNok
         qmEJGpLp6NI5IQML85sqnEYisDfdHKUWT3JRuvThUVwlD/gRf93GkPmif5fQGyNztp0Y
         zWXgfmYBtSLRQceaVuceJknnC8vVyoAfW+M3DL1ihw/4H6jdL9j4U7ZegWzRi5wYqOqv
         Lraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l2Bez8LdoluwsORjwCrpP+ORceYmTvmMN1fTDoAmM20=;
        b=I2vozrQK7jBgKXacHHlemvPpJL9d5BaH+vJ7yqM4mdupC4tFCsbeQHcSHw7r2AJXz9
         4/yrIKPJCuy7SxQV/k72WYHlKKA6DTzjSSAjU+yYFoLF9nkheuwrYDMdTRkvYLQD2D1o
         8mCXVxbiVbDtDjgvv3aBvxlLDGXF2UbdIVHcSgP5dnoEZIz6x9tO4Nha7b6L5QH7g9xx
         xCNnljq924ORnlo8mjux2qF0MpBpTFQayoxtG1Pyl259D4KAqdTB14CriHX/iBDf6TfP
         jYYfWxPx5bxeiwlCVXtLepuvSsi2Ohxg2EMtHJycGTwkFEsrAZpL93cXO6q3Qp2YLNqv
         1a7w==
X-Gm-Message-State: APjAAAVQSNHMTi4+4sh3E3SI4TIjbK/HXUPAb7w8NPcD43un6fSs2B1X
        DgZ655TSnqP6TDhdsasVdSKznA==
X-Google-Smtp-Source: APXvYqyAYjqX+4BcVE2Sz01P1Gs79GkHwoh28QlbVnZ/sLKD9B7bxtxDLOonL3K55m0asDMMvJU3kQ==
X-Received: by 2002:a2e:9687:: with SMTP id q7mr12472790lji.80.1575750537704;
        Sat, 07 Dec 2019 12:28:57 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4830:260e:ff6:21f7:4d8b:4a84])
        by smtp.gmail.com with ESMTPSA id a9sm8561722lfk.23.2019.12.07.12.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 12:28:57 -0800 (PST)
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     Chris Brandt <chris.brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
Date:   Sat, 7 Dec 2019 23:28:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191206134202.18784-1-chris.brandt@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

  Thank you for having mty on CC:, I might have missed oit otherwise... :-)

On 12/06/2019 04:41 PM, Chris Brandt wrote:

> The Renesas SPI Bus Space Controller (SPIBSC) HW was specifically designed for
> accessing Serial flash devices (QSPI,

   The initial design did only support SPI, hence the SPI in the name.

> HyperFlash, Octa Flash). In the hardware

   Only added in "2nd generation" controllers, like on R-Car gen3, RZ/A2. 

> manuals, it is almost always labeled as the "Renesas SPI Multi I/O Bus Controller".

   Not seeing "Renesas" but the rest looks consistent across the manuals.

> However, the HW IP is usually referred to within Renesas as the "SPI BSC".

   Poor name for the 2nd generation controllers which also support at least HyperFlash.

> Yes, the R-Car team nicknamed it RPC (for "Reduced Pin Count" flash) after HyperFash
> support was added...but I personally think that RPC is not a good name for this
> HW block.

   SPIBSC is also misleading... RPC-IF seems misleading too as it's only spelled out
in the R-Car gen3 and RZ/A2H manuals. 

> This driver has been tested on an RZ/A1H RSK and RZ/A2M EVB.

   In the SPI mode only, I assume?

   What I have now is the core driver (or rather a library) placed under drivers/memory/
and the SPI and HyperFlash front ends in drivers/spi/ and drivers/mtd/hyperbus/ respectfully.
I'm almost ready to post the core driver/bindings, the SPI driver still needs some Mark Brown's
comments addressed, and the HyperFlash driver is also ready but needs the existing HyperBus
infrastructure properly fixed up (having a draft patch now)...

> The testing mostly consisted of formatting an area as JFFS2 and doing copying
> of files and such.

   Did the same (or at least tried to :-) and I must admit that writing doesn't work with
any of the front ends... I still need to get this fixed.

> While the HW changed a little between the RZ/A1 and RZ/A2 generations, the IP
> block in the RZ/A2M was taken from the R-Car H3 design, so in theory this
> driver should work for R-Car Gen3 as well.

   I don't think it's a good idea to use the SPI dedicated driver on R-Car gen3, I would rather
see the RZ/A1 using the RPC-IF driver/library to reduce the code duplication...

> =========================
> Version 2 changes
> =========================
> * I got rid of all the critical clock stuff. The idea is is that if you are
>   planning on using the SPI BSC, even in XIP mode, it should be described in DT.
> 
> * There is no actual 'runtime pm' implmented in the driver at the moment, and
>   so just the standard enable/disable clock API is used.

   My code does have RPM enabled and used.

> * The compatible string "jedec,spi-nor" will be used to determine if a spi controller
>   needs to be regitered or not. At the moment there is no setup needed for
>   running in XIP mode, so we just need to signal that the peripheral clock should
>   be left on and then we're done.

[...]

MBR, Sergei
