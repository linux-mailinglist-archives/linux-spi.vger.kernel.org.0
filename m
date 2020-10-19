Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA102293076
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgJSV1B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 17:27:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37517 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgJSV1A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 17:27:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id t77so1668559oie.4;
        Mon, 19 Oct 2020 14:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42ogECBDpzk2B5hmCqC8GkPZe7LO6DVjQPS1WqgAupk=;
        b=KdAX1eL76U9nJzL+hI7hBSVrB0uYTNm7p7m99CZCWYByM+8TIVS/EuBoEpGlLLJs7g
         u6+bMWZ0o2noi1Y3nzpWMtDYOrjVNO55BlY0x90nTY0s9jDEyzchcWY3ZwxtJEAhugUT
         WXXaNSTYxjrBG6sTLmF7y061AE6ld9lhOfsT5Fkg6HyGQIET4mr0fbhvEh2oiuTUq6jN
         Y1nlKOFAlWhUuv+BjtS1ieCQ7MCskFc9txT1ZL2geu45Srq8tJo+LqPwvctTjU3Fu+ML
         30QyJjtmdH8U9n8gsVyK7Ul/u82zpVY3wj5gEneL3/FjKbyVkCLufCgMMBOCMcONznP9
         STCQ==
X-Gm-Message-State: AOAM531meRiUkodNn9MpumoMZHgbZv0AKfBa/nlEmNV1SB90FhDV30ZX
        3eSLiapcEpGNCi8yYwKnkg==
X-Google-Smtp-Source: ABdhPJyrNwSPp+oizqlohV+Jk9na5ohcz5ZJi2MZq3Mv+DPJMT15e364TpcafQ8LYV7NQH+/2SdFag==
X-Received: by 2002:aca:dd08:: with SMTP id u8mr1013442oig.85.1603142819915;
        Mon, 19 Oct 2020 14:26:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k51sm236334otc.46.2020.10.19.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:26:59 -0700 (PDT)
Received: (nullmailer pid 3630412 invoked by uid 1000);
        Mon, 19 Oct 2020 21:26:58 -0000
Date:   Mon, 19 Oct 2020 16:26:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     simon.k.r.goldschmidt@gmail.com, richard@nod.at,
        qi-ming.wu@intel.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        cheol.yong.kim@intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] spi: Move cadence-quadspi.txt to
 Documentation/devicetree/bindings/spi
Message-ID: <20201019212658.GA3630377@bogus>
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016093138.28871-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Oct 2020 17:31:33 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Move the Documentation/devicetree/bindings/mtd/cadence-quadspi.txt to
> Documentation/devicetree/bindings/spi/
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>
