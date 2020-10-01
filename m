Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05928078A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgJATML convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 1 Oct 2020 15:12:11 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37338 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJATML (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 15:12:11 -0400
Received: by mail-ej1-f65.google.com with SMTP id nw23so9702795ejb.4;
        Thu, 01 Oct 2020 12:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6v7eOGX7vaObSzK5Xt420tK2IOxcStrJuaNw6Dc3XQU=;
        b=M/Qylx5Uts7qZyl4P3dz+PprvVc9aww7ORoGQV6brsEc0Ocku2hw863l0MqExfxJUu
         T2FkNH96EKkalEodnBxpcZ8wJSJ5dZxBHmyvFqkAPUCgd0hqMB9d03KqBve2NCcVL7h6
         HtwaEsRv1HIhWJYhMWSkRmvNkLVdZOI5j7V/R4pEqn6O+PvXFrMj3llhLZJ8a8Pv63vd
         qewAiik4dJvvwowcEUQflh0mpWpDsJQ+EdwDXfnpb3O508/RnXcw3Ma4uwcLE1VnQbmI
         vT/e258d4wXtmaZbkvf0ekWpOOIAAu8k8i3243fapn7KoW5t4VTNyY7I8NG8nXQvKwTd
         5Ukg==
X-Gm-Message-State: AOAM53082kLrijvrAIKGO17n4GL67EPrhJ5oBgxIueuMjHW+0t9v7pqe
        YR4FJ2F5jQz+q8PQf4lkE4Y=
X-Google-Smtp-Source: ABdhPJxPNlJX1V1ToP7OmScTlJgP9YpQwGnshebQXKQqLpTNBDjedJ9RWr/odhjHthdJRHaOJPff6Q==
X-Received: by 2002:a17:906:f897:: with SMTP id lg23mr10241605ejb.89.1601579528960;
        Thu, 01 Oct 2020 12:12:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id ao17sm985977ejc.18.2020.10.01.12.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 12:12:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:12:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 7/9] spi: spi-s3c64xx: Ensure cur_speed holds
 actual clock value
Message-ID: <20201001191204.GC11048@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <20201001152148.29747-1-l.stelmach@samsung.com>
 <CGME20201001152248eucas1p132a63f588f62d902879322ebadd67173@eucas1p1.samsung.com>
 <20201001152148.29747-8-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201001152148.29747-8-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 01, 2020 at 05:21:46PM +0200, Łukasz Stelmach wrote:
> Make sure the cur_speed value used in s3c64xx_enable_datapath()
> to configure DMA channel and in s3c64xx_wait_for_*() to calculate the
> transfer timeout is set to the actual value of (half) the clock speed.
> 
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
