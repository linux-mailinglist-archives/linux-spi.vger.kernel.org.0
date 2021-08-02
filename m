Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4303DE0D7
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHBUk7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 16:40:59 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:35590 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhHBUk6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 16:40:58 -0400
Received: by mail-io1-f45.google.com with SMTP id y9so21837100iox.2;
        Mon, 02 Aug 2021 13:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uc/rr/5xcuhR+zif0CpvyF7mUh82ehF886KfvVGZcB0=;
        b=J5e6P3zJSrp8swuHuRcpLO/hPF1AdSHOtM8qTj1Zw1PLQyHJD1LeSntMfzK7ti2Ndg
         /zRTBdIoVJ8iJa+B3pR6NxXRuM9T4Jt3uKSG5Jy2r5Y+oah/XvyG63O3J+FQIE1BH5hc
         uFltJtES12Sa8uDk1opwR1r1502UNXrYxbPZjrGuXWFvI69+iH56pPUqGq9Sqw7WscnF
         dD13TvdBoM84o0LmXn6MItAD+8N6t7+FkKH9CCywNsZF0rbkT/Hqj7ht3lUHMKKXNMdu
         pMGuxawmaGR23y90fLVgXtixX2Cv+XCb4LhLmkJhRFyPFlOlGdO1fJ+rkbpIhl+WQQtt
         KaYA==
X-Gm-Message-State: AOAM532+cg755+FusWhgLwVa4RbBTfDrFiGFH6k6ehnjmM4cirzFjYTy
        8Wj2s2C2lxsTHVHr4EK/rlhovulWgg==
X-Google-Smtp-Source: ABdhPJxnLXrZtIwbHJwJS1JysQYhqQudWRsgjCyynZjPxToZnlkja1X5wSw4jWZEi12yEAxyZL0t/Q==
X-Received: by 2002:a05:6638:3824:: with SMTP id i36mr16493740jav.11.1627936847813;
        Mon, 02 Aug 2021 13:40:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f9sm6296535ile.38.2021.08.02.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:40:47 -0700 (PDT)
Received: (nullmailer pid 1570511 invoked by uid 1000);
        Mon, 02 Aug 2021 20:40:45 -0000
Date:   Mon, 2 Aug 2021 14:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: memory: renesas,rpc-if: Miscellaneous
 improvements
Message-ID: <YQhYTXTRBl6HkTL/@robh.at.kernel.org>
References: <d81b59a513c2a5204c8378b4a89cd07f97c46797.1627401508.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81b59a513c2a5204c8378b4a89cd07f97c46797.1627401508.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 27 Jul 2021 18:01:05 +0200, Geert Uytterhoeven wrote:
>   - Fix rejection of legitimate flash subnodes containing multiple
>     compatible values,
>   - Add missing list of required properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop #{address,size}-cells.
> ---
>  .../memory-controllers/renesas,rpc-if.yaml      | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Applied, thanks!
