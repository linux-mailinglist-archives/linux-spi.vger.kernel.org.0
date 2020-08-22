Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0024E780
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgHVMoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:44:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56059 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgHVMoB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:44:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id a65so624149wme.5;
        Sat, 22 Aug 2020 05:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b/LQHLcTnWB1iXJZRAUqfkq4diYrkCqNNZRoscuAqx0=;
        b=qA1jEFzfh0rVYRn8nyG/LVeNUuCVYNa68oOnBjlypABfSZPa+nA+PWh8HBOnYVrp6P
         YnqlEpfUEVSYQ0X9/GvZHwygVXqi5PjzcFOS3ymimk05sXNs4DtQ2cKI7yvAAsVHr5FA
         BvekRB5xi5Eg6wfMY/i0QN3crtZxt732Dh5y4/yLXU8lr4O2i1u1V+8za9ApO4DSa5Za
         ipxw0WI2O1KNun6TsjABkAmymzF+PAvElk9MkAMrFD29jGsYD1WaervyBnWZtsTeM8rS
         mSrIjyQxSgFOzOhYCUiVLYmlPwgRaH+xYoTEsdjGJqtpTEY1/shfLpvH172FgWzsE+hY
         GuiQ==
X-Gm-Message-State: AOAM532vGcmWhSItCvKTUDvOV5w1qMoVg5nry/+ar699Y7WfByArFAkB
        WqGMmzwlV1nXZ/aK64Mi9xhMyjkP+U4=
X-Google-Smtp-Source: ABdhPJy9uMwNrknW9trLBA6g1l98xZLjFTYx4+8/VyguZ3FpooZwbQMB+lqi5wV/gjUNLbe+LjNVLQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr7508362wmc.130.1598100239317;
        Sat, 22 Aug 2020 05:43:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id v12sm10482993wri.47.2020.08.22.05.43.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:43:58 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:43:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 8/9] spi: spi-s3c64xx: Increase transfer timeout
Message-ID: <20200822124356.GG20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p23a283ac117d4381e087e9bacec537665@eucas1p2.samsung.com>
 <20200821161401.11307-9-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-9-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:14:00PM +0200, Łukasz Stelmach wrote:
> Increase timeout by 30 ms for some wiggle and set the minimum value to
> 100 ms. This ensures a non-zero value for short transfers which
> may take less than 1 ms. The timeout value does not affect
> performance because it is used with a completion.
> 
> Similar formula is used in other drivers e.g. sun4i, sun6i.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
