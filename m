Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5F24E782
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVMoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:44:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43895 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHVMog (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:44:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so4306270wrh.10;
        Sat, 22 Aug 2020 05:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FetylycVAb2VdmXFV8OSnaxjVdiLE5dOceTQeBcYszc=;
        b=rp/xoSP7varLCLv2XnQvqFws7MXEJ2d/CHvfL6Z3D6GEk5v57yyFOoiw39m5xn360D
         COO62WLjEYpMVrFzlK2PCcZGdvbFlcIAH+JzROvRgIovKahjFOYlRVHZWMFcI1cG3pD5
         OMtyDdRYfcTgH3KGpZQsHRKTLwx9AOOriuvd5GfgszirJ0ZPn2Rkgc37+u8HiDLaiMpV
         UieAC02hcBGEIFRIddZhlqdk+lMZY6bz7pS+ePYomma/tA550SFywTFocbW1LiJL86q/
         ZspWBi7rTrRcwhrHcuYxagxBfa1y4XkjaVwjqWY0pcQ1sY5xGgwU0jQ1fCLaXk2j5gWQ
         Ndaw==
X-Gm-Message-State: AOAM533PYn6HfgQu12NGvmt8iZQyAGXCXTctkoxqEhFuk3omEAZz8aMQ
        YX2wXSqkrl/bDUFZs6D8UOA=
X-Google-Smtp-Source: ABdhPJxomFoNz2Jn4UGmWCgyq4C/fViPiWfYwBoRb4XshfTNnJSn61Q/pXbf5c6nzHiRoADEShdSmg==
X-Received: by 2002:a5d:6505:: with SMTP id x5mr6812637wru.336.1598100274718;
        Sat, 22 Aug 2020 05:44:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id h5sm8809466wrt.31.2020.08.22.05.44.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:44:34 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:44:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 9/9] spi: spi-s3c64xx: Turn on interrupts upon resume
Message-ID: <20200822124431.GH20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc@eucas1p1.samsung.com>
 <20200821161401.11307-10-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-10-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:14:01PM +0200, Łukasz Stelmach wrote:
> s3c64xx_spi_hwinit() disables interrupts. In s3c64xx_spi_probe() after
> calling s3c64xx_spi_hwinit() they are enabled with the following call.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
