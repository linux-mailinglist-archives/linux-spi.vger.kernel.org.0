Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C212B250C51
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 01:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHXXZF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 19:25:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35437 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXZD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 19:25:03 -0400
Received: by mail-io1-f66.google.com with SMTP id s2so10601658ioo.2;
        Mon, 24 Aug 2020 16:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNaUvZze9QHBkyKu+l3u3r4OB8Z9lM6mxAz5JIOkCOU=;
        b=sBT9oJEwyW+x1isqzKDk8bO45lVxuPPId9kjLBQ934drBCxMoBKfP/aRnf/m5gh7HB
         JPAQGdyU0DE3DxYyKirc1FQwk7ldPzW4QMx5mNxw7Nm2A1Qpafal7JriUoccH0TiNWzl
         BCZcWEjufffniFEuG8knFXy6yHfDa2a1Ig5xfLXE7xrkbRXHK+nTuPKIKDMh1inSn58f
         AOEeTTsh5wwt7vASz7PhLvNk8f4kf4Z0tX06nLgLYYqI5W72Nqyd5BN4zZUgLT206I5B
         O0hDWWzgm1804Y6SK8ePFhjwtfhxRscw4TdXa/Jrz8U2erqjvtlD0RPqIqynW++q8iPh
         GmcA==
X-Gm-Message-State: AOAM531tDpvCQTscEi7WxCD7uw7qOmPnQ8M8bI4yg4aOhf5TvBc0Wmyx
        qxxgdmaI1UCX3V9rfsolGA==
X-Google-Smtp-Source: ABdhPJwrHUF3Pm7/GPTfSTtUf0hU5VDnZuOEWlWSMQlD0pf52vYKSSHVx1FMfP6ytnAY0cx1Nkecbw==
X-Received: by 2002:a6b:f719:: with SMTP id k25mr6886530iog.22.1598311502241;
        Mon, 24 Aug 2020 16:25:02 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m18sm8008022iln.80.2020.08.24.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:25:01 -0700 (PDT)
Received: (nullmailer pid 3531222 invoked by uid 1000);
        Mon, 24 Aug 2020 23:25:00 -0000
Date:   Mon, 24 Aug 2020 17:25:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,rspi: Add r8a7742 to the
 compatible list
Message-ID: <20200824232500.GA3531166@bogus>
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 12 Aug 2020 16:00:47 +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC specific bindings. The R8A7742 qspi module
> is identical to R-Car Gen2 family.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,qspi".
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
