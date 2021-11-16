Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B41452F2A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhKPKgf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:36:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41610
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234117AbhKPKgE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 05:36:04 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 26A063F19A
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058787;
        bh=9Le9vThg2zYYZ4FT+Lsh8JZmnjsCqwGI+kiP40c27ZQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=R+54iYerD3XUe0bho3L2AEPDUBTwpTJsRvL6Z6hVfdLPKVFfNNx+nwjDgYZ8qqF51
         C/t2i2mIeYEdtMDPfn8RSPLirEuDuWpMH8NDwLVfy5ruPaWMJkFZCaqEl1ZnDxQEmI
         DFrEt+qf7QxWGzp9Lq8TMgyplU/0q/CJPxU5UxX4Pn1wGow1Wg8ga+HKcogj1g8592
         h3hQET6ea2/zIHQmZFI8ovCP3lMdkkqMNplheIUiEselpNUHUAqOduSkeA4HN6F2oe
         yNefAGATRZgQSG0X8i8JbDmn4DM1lbBKy9d2LqrNGWqoF0jRNk9iGsdBhCRkd+cQ+I
         ulzqdtH+P7FWw==
Received: by mail-lf1-f69.google.com with SMTP id z12-20020a0565120c0c00b004037427efb7so7983927lfu.1
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 02:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Le9vThg2zYYZ4FT+Lsh8JZmnjsCqwGI+kiP40c27ZQ=;
        b=QEBrC+sMWE4nyT84LVYYZDaNrgt9LY3yquA8fMKLa0bql5Qa1HUMHRCwXw6YSLpsV0
         HaW9YfQJBWP9+PFgY4xnsRnUQURxNWPkkj8fw3Wfo0u7pYyPaMCGfyhgnoMn8fPUTP+W
         Ehzr1KNvAaD+t8ic/Tx81NcXn9IwtOsmKLt8c30nkmZZ1IfjpinHkmLJBtaRwrdYs2K7
         7Ilfff9GxLV4JQVQda+Da0tuhv8Mh8CkkKTh7/tkjCZcp9LOIpF8Q4RqNpCm7V2bcg67
         qCwLhgIL6mOZE2A3epPgCF0D6hnF4PIqU6Ra/7tuxf2XhNlxxbxa0EsP9qpBY7oZurPj
         dXHw==
X-Gm-Message-State: AOAM530hCtsvxIfHX2zscmyS9fMTLn2TeG2f1AArfIOqAJNZn8+iS0An
        J/9kamXYB4+fc9LstUNurkIj/fbSIdVt39ybY8SamP5euNv7OOEthAvuYB+8P5sP0CecFmGJdaS
        JoKZmNIB17HOX8PK6iyvnmPgdm7Tv0JuKOycaPg==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr5601485lfq.228.1637058786583;
        Tue, 16 Nov 2021 02:33:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPHWqAmG6+W2LmzevHiirWdaFqHMhmEygAsdCaVQYS7N7sZyD1DqEoJyS2ahO2I8igQ/Bl5w==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr5601460lfq.228.1637058786409;
        Tue, 16 Nov 2021 02:33:06 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p3sm1717385lft.66.2021.11.16.02.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:33:06 -0800 (PST)
Message-ID: <a8b126e6-62e7-7979-01cb-b7a1ce4ae8d1@canonical.com>
Date:   Tue, 16 Nov 2021 11:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 0/7] Add SPI Multi I/O Bus Controller support for
 RZ/G2L
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/10/2021 22:56, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds a couple of fixes for rpc-if driver and
> adds support for RZ/G2L SoC, where the SPI Multi I/O Bus Controller
> is identical to the RPC-IF block found on R-Car Gen3 SoC's.
> 
> Cheers,
> Prabhakar
> 
> Changes for v2:
> * Rebased the patches on linux-next
> * Split patch 5 from v1
> * Included RB tags
> * Fixed review comments pointed by Wolfram
> 
> v1:
> https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Lad Prabhakar (7):
>   dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
>   dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
>   spi: spi-rpc-if: Check return value of rpcif_sw_init()
>   mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
>   memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
>     fails
>   memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
>   memory: renesas-rpc-if: Add support for RZ/G2L
> 

Applied parts 1, 2, 5 and 6. I think 7 is going to have a new version
due to Wolfram's comments?


Best regards,
Krzysztof
