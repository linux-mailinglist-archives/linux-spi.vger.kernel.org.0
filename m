Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1A2EB103
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbhAERGu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 12:06:50 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51390 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbhAERGt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 12:06:49 -0500
Received: by mail-wm1-f42.google.com with SMTP id v14so215471wml.1;
        Tue, 05 Jan 2021 09:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YAAdpyFMqA6anlcQcter/Q+CJMEzgthAR/tnl6sjtA=;
        b=Af9IoeI60Y03TBjvjRHmLKPALC8N+soWiO6dfZ2fXWazV62NFezarL24/LwoJMMkUt
         9a0neKDEpUOWtVuDR3bP1C9XcoZQA7QbI8mdwjNSPQZDeWiV8kSczo3877Y+1ViGI2Nf
         APHQpwNlVrb7lrosIUWvO+C1dE8imAbaLRFeP6STp4uh0J5fQyCP3v0ZWcyz4ogvbbBL
         bcWqxg7u87fjO++q1cKBf6EiBw5o6UH3e8R8Gi9+kgGMGaEhsEIcitOUGR5hKWaEXPmQ
         f/16U5tbtCkeT3R64rjNU2YAtrZeQPeDXSnS6bqZgJ9t43EjGLh6YUo/15ynhZJG2u6B
         C0Mw==
X-Gm-Message-State: AOAM530YNuclOQheXmEu323yAl06bEYuo9h5AeK4RwUTMs4gdhNCoq/v
        y1peea13Fv2AR+FUuYVHYc4=
X-Google-Smtp-Source: ABdhPJwAzn5n1uY0WAYpYglCpjpQ7wTQ2gVf/5VxObDSAC0+0hOeTHM7OsV/cLPDVW8XqRYVcBYVCQ==
X-Received: by 2002:a1c:9e86:: with SMTP id h128mr81485wme.171.1609866367532;
        Tue, 05 Jan 2021 09:06:07 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l8sm137946wmf.35.2021.01.05.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:06:06 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:06:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        biju.das.jz@bp.renesas.com, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH V2 1/4] dt-bindings: memory: Renesas RPC-IF: Add support
 for RZ/G2 Series
Message-ID: <20210105170604.GA26301@kozik-lap>
References: <20210102115412.3402059-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 02, 2021 at 05:54:09AM -0600, Adam Ford wrote:
> The RZ/G2 Series has the RPC-IF interface.
> Update bindings to support: r8a774a1, r8a774b1, r8a774c0, and r8a774e1
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../bindings/memory-controllers/renesas,rpc-if.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> V2:  Updated renesas,rcar-gen3-rpc-if to include RZ/G2

Thanks, applied.

Best regards,
Krzysztof

