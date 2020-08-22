Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6924E74B
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgHVMDo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 08:03:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgHVMDo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 08:03:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so4294682wrw.1;
        Sat, 22 Aug 2020 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O5Mmh807+dlkwZ+noBd99oZ7U6ajTTxKmW3eWIkcpC8=;
        b=FgtByyRhgKBwo2jm17So3bUotUhty0XbmX4nf8KzQgz6W5oZw7HNkjd2BvScnD8Pg5
         pgdsGou/F9pd719zUEItkTpdI6IN4z99cUR5NiPIforLDhpMR/bIn6Tqbe0kqSxI1YTO
         L5F3fFEd5ecHhffR/VRYIfEsLdeFPsDG2GAKQCUfDjLkCYjwcR5fXQtDxLAIJuOYD0V8
         ElO/b9jVrCCiz8du+Hk5cKQ7BD8f3a+qtFwSAVFn4EHvE6BhUy5VMHLMY8GNM1BKy8Yf
         kqqFvl0M9GOYbvpwJCKyTvr1Dk9ybjk3X2xLtAhfbbs7hGtpjpfCf5lyJvQsI5RY7eyF
         Mabg==
X-Gm-Message-State: AOAM532ze90Dm1mTXFe1Fp5f2+a3YiWu/uVAwZ+1NGLbTjwkmPgWM3XT
        dwMHDWU6i8tmghASR66VfsQ=
X-Google-Smtp-Source: ABdhPJyAzAxWwpFrLyd0fuXR80dw6dBnXHXDLD6m6Dsc7ZhR4bzh8gJwsoJs4njQUlKgSSS0M/OiqQ==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr5753332wrw.132.1598097821916;
        Sat, 22 Aug 2020 05:03:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g3sm11611456wrb.59.2020.08.22.05.03.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:03:41 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:03:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 3/9] spi: spi-s3c64xx: Report more information when
 errors occur
Message-ID: <20200822120339.GC20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7@eucas1p1.samsung.com>
 <20200821161401.11307-4-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-4-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:55PM +0200, Łukasz Stelmach wrote:
> Report amount of pending data when a transfer stops due to errors.
> 
> Report if DMA was used to transfer data and print the status code.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

I already reviewed v1. Include tags you receive on resubmissions.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
