Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6C24E763
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHVM1C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:27:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHVM1B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:27:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id d16so4286014wrq.9;
        Sat, 22 Aug 2020 05:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZGKQZE5UXURzH01fkYYDy2bGkaVf9EVp2rSo9uoV0wE=;
        b=r/Tsfp2nJIJ9qtTMzO6aGHwf5iMGkPgywAjGTBmpW6RJsMh/lwXrfqdWs/006BK3AT
         mE7KIHjxt8bB4po/mch4PdoW9fOUqqPNy05UTi7fbvXCbyZwY77JIi7HrVvKFzFFBOWF
         65sYvj3WQP+9m01SLtrtJKh9isdWg/vFuFC9UCGQZ0C8AZNchiKMLez8fHvLXxi4q66X
         QKv4HqZ6HJ4p8/PYRb32CjPupZxCfUa6FAC8U5k3i5nxmp2YJvCMe6oSOAOmmn0pR1tf
         QGzg5O04KtbUYSTXwv8sYURxE8WxtEg+yuN/0BHBwbKpwt4jkcg0ZApLpPhi4QT80OqZ
         ztAw==
X-Gm-Message-State: AOAM531cbC29LYb/W1nvurB3+D6aTLldWaJNS+woyWRRDOWG3v2dZdHU
        yQKDwSH9fb+GeKFWe8y3QR4=
X-Google-Smtp-Source: ABdhPJyBd0nGmaoVqrTgj3M+s2WQBh+tWnxc6i8aNBW22rL2BI87rZcBtBqLNC8VxJaUARBFzs7dCQ==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr6881355wrt.304.1598099219712;
        Sat, 22 Aug 2020 05:26:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id n24sm11141916wmi.36.2020.08.22.05.26.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:26:59 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:26:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 5/9] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Message-ID: <20200822122656.GD20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c@eucas1p1.samsung.com>
 <20200821161401.11307-6-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-6-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:57PM +0200, Łukasz Stelmach wrote:
> Remove descriptions for non-existent fields and fix indentation.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

