Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7724A3D3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHSQOA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 12:14:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35731 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHSQN2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 12:13:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id m20so18582647eds.2;
        Wed, 19 Aug 2020 09:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EkGUFNS7coQmfUryFTJlFWVBsaHRgnCxXeXJMC4zMxQ=;
        b=GD1A2S4pNkGNOPqMkfM2ONnsyzY5JazvMhkRoUyWPpe8bpeZBbo0d90heSIegYjS75
         DF+EHgwOepTOn6aA3nN18AigXBOQFpYzMbcDw350fwaXjPbGm/0NUp20fLl1KY/obrD/
         5Of2airZVDhki5epwX1dti2kMRv//AJaI00npTgI9ILDFBv5Pfbsva8BFu7F2GJkTg9I
         q4XtbD7Adi/f/y0sVy8ndOAoy8fh27VRrkeYRFguSYAR7JQcYK9R8RUDINbak9Zv2Vtm
         ivxc6+H0C6c/VBy2hhA9U/pw5IQYtT3CM2eXL00vC/fa/TdcOZMQEuk67gtD+e838Zgn
         niuQ==
X-Gm-Message-State: AOAM5332Br9aqIBJ3YmXZAK7JZa83Icz/zqNahoziLPXuglkOBIS1l9f
        PtYNazz6wm33YaDxr0NT66M=
X-Google-Smtp-Source: ABdhPJwP5263fuZESXpeNUQpfcMaGgY5rsdcXOy8N4cFBHEIzeOdA1e94sgmB2rLn2bzLYJkXY8bgg==
X-Received: by 2002:aa7:db59:: with SMTP id n25mr24634678edt.276.1597853605726;
        Wed, 19 Aug 2020 09:13:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id x10sm17726281eds.21.2020.08.19.09.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 09:13:25 -0700 (PDT)
Date:   Wed, 19 Aug 2020 18:13:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 6/8] spi: spi-s3c64xx: Check return values
Message-ID: <20200819161323.GA8067@kozik-lap>
References: <20200819124833.GF18122@kozik-lap>
 <CGME20200819154154eucas1p1e88747d2495e6d1074991419504066df@eucas1p1.samsung.com>
 <dleftjwo1uzlqg.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dleftjwo1uzlqg.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 05:41:43PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 śro 14:48>, when Krzysztof Kozlowski wrote:
> > On Wed, Aug 19, 2020 at 02:32:06PM +0200, Łukasz Stelmach wrote:
> >> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >
> > Oh, come on, stop fixing the same local issue without fixing bigger
> > picture... or at least documenting why bigger picture does not have to be
> > fixed and simple 'return' is enough.
> >
> > That's the third, same fix for the same problem.
> >
> > https://lore.kernel.org/lkml/20190314064202.14864-1-kjlu@umn.edu/
> > https://lore.kernel.org/lkml/20170207204520.h2eo3yn5kge56lk7@kozik-lap/
> 
> No wonder. There is a possible NULL dereference below. Now at least we
> know something about conditions that led to this.
> 
> Should I drop the entire patch, or just the dmaengine_prep_slave_sg() part?

The best would be to really go through the call stack and handle the
error properly.

This means returning an error code and propagating it further. It is not
a trivial change...

Best regards,
Krzysztof
