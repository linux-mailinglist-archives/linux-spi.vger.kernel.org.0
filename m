Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAC3A8C8B
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jun 2021 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhFOXfQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Jun 2021 19:35:16 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:34776 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXfO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Jun 2021 19:35:14 -0400
Received: by mail-il1-f175.google.com with SMTP id w14so710816ilv.1;
        Tue, 15 Jun 2021 16:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Fz3AetKQEA77r3UIPjWBZbJ1RgLcNWRZBS0z/pKRfo=;
        b=KVTk6Bd2xBvzbfXj9OA4kC6kX0U+g8pnEOUP9DtmZw3kqyoIVoCf5q23Bypf6LgoW/
         sTalnO8eAdLn9umTU779ycvggHBnVP2pprJR5D3SEpQKgnDRPSukvZhPXBNYP60uxmqK
         SVKPxg3QPRG48xIOYLrl3GDJOWO24XV5sQuh5Qoc83EhS3SX29uUmJwY32nbvJheRBll
         j++19lDJJiNzNZb2WKJAvBoViCv5ApjnF29FS4m3GyIR+Qm7YbU0n2k2FkJkbgCkQUlZ
         AvK4ijj7l0dsRxhAqvm1Quw/q1yqrRhfrwRO5evarKPqgbHDXzntinIAJOm+9W1ZxXPp
         ehlg==
X-Gm-Message-State: AOAM531jYvuwhN8p3s8DPlzy8JiCkh4ak1V7F4lfoYpC0Qjg5tal/ciU
        /mnR9rQE0Y0cnboTAf7EAA==
X-Google-Smtp-Source: ABdhPJwFYf76OVEZ+HNaaZsult7XHiKTmBkAHWs/gW1dtLaCbWM+Jk97PUvUZRACQLTXkJThIg+EGg==
X-Received: by 2002:a92:5404:: with SMTP id i4mr1340945ilb.226.1623799985851;
        Tue, 15 Jun 2021 16:33:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m5sm251953iov.31.2021.06.15.16.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:33:05 -0700 (PDT)
Received: (nullmailer pid 1624214 invoked by uid 1000);
        Tue, 15 Jun 2021 23:33:03 -0000
Date:   Tue, 15 Jun 2021 17:33:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126
Message-ID: <20210615233303.GA1623889@robh.at.kernel.org>
References: <20210615033213.14241-1-jon.lin@rock-chips.com>
 <20210615033213.14241-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615033213.14241-2-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 15 Jun 2021 11:32:08 +0800, Jon Lin wrote:
> The description below will be used for rv1126.dtsi or compatible one in
> the future
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v8:
> - There is a problem with the version 7 mail format. resend it
> 
> Changes in v7:
> - Fall back "rockchip,rv1126-spi" to "rockchip,rk3066-spi"
> 
> Changes in v6:
> - Consider to compatibility, the "rockchip,rk3568-spi" is removed in
>   Series-changes v5, so the commit massage should also remove the
>   corresponding information
> 
> Changes in v5:
> - Change to leave one compatible id rv1126, and rk3568 is compatible
>   with rv1126
> 
> Changes in v4:
> - Adjust the order patches
> - Simply commit massage like redundancy "application" content
> 
> Changes in v3:
> - Fix compile error which is find by Sascha in [v2,2/8]
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
