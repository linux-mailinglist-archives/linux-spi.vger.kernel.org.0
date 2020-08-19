Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B8249ED5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgHSM6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:58:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44023 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgHSM61 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:58:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id cq28so18020738edb.10;
        Wed, 19 Aug 2020 05:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Xb4tRhzXMgviiFDW9tSyZ3jTP9/igIVkJbqhE4GypA=;
        b=dtshGwXEbpxgMeINCY1LtPjQoXmZ/bZ7FebkSxgrElYIVZ9HROylvctwdqMfVcxjgC
         5blmdu/3GfFtuQXH/qT08O0r7iz/PWpfDKIUpqSTiV+oY+DBi9wqkMXOPj9cE7qhd22q
         m83Jy2g3a+EU+SRYN8Ft6YlsWdusXy8f+u4GTTyZBhHVjO3iDe0+BUXWi/iWn/MDwn5l
         /YAjYLxOslVLrdFedFMGVfNVuHxwtUh5Mqm5NPozPHRaPPZ4ixqbARuMkDWZYRtfQist
         Ir2pBu9kVmGv485DIT8ksk4L2Du5WxhIotxDdKvWd/DDYWTlkLM2MELkou0AXl8v5lWS
         neOQ==
X-Gm-Message-State: AOAM530+QTYBqy5Vd0iEGsMt331lsdgOnzdTF6+WekL3KwRL/rjg/Tdk
        KvK1vJ79X3vKgU4Mv45drEY=
X-Google-Smtp-Source: ABdhPJzxSIaLmSEemtvUBFevKiXnCNyh4UrasOEDD1hKpBzGvzdvLodJ5Gf6MGt4muGYXcLpyurIZA==
X-Received: by 2002:aa7:db44:: with SMTP id n4mr24609587edt.158.1597841905658;
        Wed, 19 Aug 2020 05:58:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id bc10sm17987290edb.5.2020.08.19.05.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:58:24 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:58:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Message-ID: <20200819125822.GA18970@kozik-lap>
References: <20200819123834.GB18122@kozik-lap>
 <CGME20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b@eucas1p1.samsung.com>
 <dleftjtuwy23zk.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dleftjtuwy23zk.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:51:27PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 śro 14:38>, when Krzysztof Kozlowski wrote:
> > On Wed, Aug 19, 2020 at 02:32:01PM +0200, Łukasz Stelmach wrote:
> >> Fix issues with DMA transfers bigger than 512 on Exynos3250.
> >
> > Fix, but how? With proper explanation this should go to CC-stable.
> 
> Honestly, I don't know and I couldn't find out why. It makes stuff
> work. There has been a commit like this before
> 
>     0f5a751ace25 spi/s3c64xx: Enable GPIO /CS prior to starting hardware
> 
> Apparently, it was lost in
> 
>     0732a9d2a155 spi/s3c64xx: Use core message handling

Then describe at least this... maybe Mark knows why he brough back old
code after refactoring?

Best regards,
Krzysztof
