Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E361E8CA
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOHQG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 03:16:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51341 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfEOHQG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 03:16:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so1437568wmb.1
        for <linux-spi@vger.kernel.org>; Wed, 15 May 2019 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bmyHjZNyHivUvoK23ukxv4Nj9Dp9vXFDiA73FJcaCvw=;
        b=Nx5hfMDZKgnefIIAgQs8SbUtsBCrRfHUUmK1JNJVo0XJCP3elPtIQ6RSayZ/oFUTRo
         7/AtzjH3EswrK4+R7pP5bEiH+g09w0ptv1SJB7g1VvDQhOa5ULSmouhI70Rv4KtRdvF9
         ma4Wp88E+xiD5YYSA6QV8rrqIQORAZN/w9cvwCJND5j6Hnn5V30UaYeGUaKnsSsCVQcb
         j0en7BYL45JLvOLpaBmH7FP1mQY4+PRs+LiIUfVm0HL/65tmJeJ2mjOD8+kmjpJF/adj
         6xFahwnhKyE+Wbd3vI6nS1OTdlZv2CluVIECy2Nmng5uvw1dVQjFGlz5vAuPQWpN2r4o
         kR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bmyHjZNyHivUvoK23ukxv4Nj9Dp9vXFDiA73FJcaCvw=;
        b=TQH5qCkEaAC6f6tDy9J0Ojl6zF4eVYsPwaddtMHWNpv1H6ERyd3+RxOfdxlUIMPiAQ
         qKX0GQHSePIr8DWa+wW7FDZbQsXBMuB7qoTrYWbv0SDvi1WgDdX+MeN+FInlOAscQel6
         kegdeiyZljADT9wdH4Y8DrVpGonhd+EWTmeoQIlf9nyKI8PRcDuYpqIZFiXD36Q6vZm0
         m+qxRfeShFSJ2DT5+j1yqdRSv9lH1UKkunCBxXomNFKPqQSWxZZbXkvM3wjDBsfUwVto
         1VXB0b1rX2lTQoM7+vU5a3taTICI42TROV8H1Yh+L1lO4Eqn+DLNSQYvle9KPc08wHyp
         IfTA==
X-Gm-Message-State: APjAAAWjsngQr9Y1oLHnbMfEuGHdbdCvOHPCVheSnsn+K47pdUUpcaw+
        NblhLyUaZ9LtrBRuhlBSGbHUNA==
X-Google-Smtp-Source: APXvYqz7FxqoIBKKh2LSGlm3FW2p5aY8FKk6NC9YycD5Y1bD0YcUqRnXzXKoCONX8MhljKE5ZywNMg==
X-Received: by 2002:a1c:c5c3:: with SMTP id v186mr17138769wmf.60.1557904564394;
        Wed, 15 May 2019 00:16:04 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id i15sm1290359wre.30.2019.05.15.00.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 00:16:03 -0700 (PDT)
Date:   Wed, 15 May 2019 08:16:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Message-ID: <20190515071601.GQ4319@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-3-git-send-email-masonccyang@mxic.com.tw>
 <20190514065216.GL4319@dell>
 <OF794FCFCD.155B914B-ON482583FB.001EDBB3-482583FB.0020821B@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF794FCFCD.155B914B-ON482583FB.001EDBB3-482583FB.0020821B@mxic.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 May 2019, masonccyang@mxic.com.tw wrote:

> Hi Jones,
> 
> 
> > > +
> > > +struct rpc_spi {
> > > +   struct rpc_mfd *mfd;
> > 
> > The term MFD isn't a real thing.  What you're obtaining below is
> > driver data and is normally articulated as 'ddata' in drivers.
> 
> yes, it's just imply that data is from MFD.
> 
> Should I rename "mfd" ?

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
