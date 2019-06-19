Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45FD4B367
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfFSHy1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 03:54:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37264 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSHy1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 03:54:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so656875wme.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2019 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1iIRBwX7O/jV0okvup0LaLa7MSxzENqsv71JZIteECA=;
        b=vkkpTRYLqsygG8afhbPOZ0pNiBWiLDgcHsdJKbvlWZoTNoBt3qyqKH1oEIknGN87dp
         lWrrlB1LRm9lgDF0Oopyh5jmOb0gb4kJNppf7PYFTpDLqGNkEbf8NeiW0FpZ91qXb2x2
         Txpw9kKdeLk3kk0qdiZCnprjdXEkCPgopj8ymIxdEb+t2mg4qOp17AoSv4Tu9vWn1BIm
         lUXbMxd/8sMituj9+vdqaSddR5ElxHaSI4DyT9Dg/FQmufv9xLWfdBm8PDuAsX1m4T7z
         IL+bjwPkMCJtiX21yXkCScYsi3BP6yzoGoXgBWvLJaHwqTgk4piC23w829X2z2iE0+57
         uRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1iIRBwX7O/jV0okvup0LaLa7MSxzENqsv71JZIteECA=;
        b=E5sG7BpJGWuXSDPU0uyo+fQ9jvrpRP4T9qBlfhn8ix96pabUg+s0t/0zeLMuF/pD+G
         jvCR3kQ6vslQbXu6rRgxkBR6Dv7Yj80tdQy/M1hWrubzcCuDid5uYgDwuhJNz8xlA86J
         cTbGQBOb7WEg22K2nwt/p412QfijyT8Ct+wr1s0F+Vs6OKhN2nAUR4A+pWyfdXXAwdLq
         xKd9W/DQpPRBVzG8RPU23UwmurC+Sema/yf7u9KKQeCJ9f9V7l2W4bUXS4jbhHLqC7ht
         V88eUwNyOFNU8liFON5KWMs+MkRqDgqlXm/m1mXo8fnz3vPbbrwTwZ5Hbl9O/tz+zrsX
         M10g==
X-Gm-Message-State: APjAAAV65hJ+Z9/7iiYJ0NzrC+zuzR33ENMJ0GyE3vn31QhMPNuxaShH
        vCALgFtkV6WONcYejFQxuhKekTqikS8=
X-Google-Smtp-Source: APXvYqxtlRBwzGq5dEKue40aes5iWJK+zPk+04ph/bqqj/eP5649tyAHA7Iexecci0Y/aRJ1GJTkJQ==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr6838838wme.156.1560930864744;
        Wed, 19 Jun 2019 00:54:24 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id c65sm484062wma.44.2019.06.19.00.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 00:54:24 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:54:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190619075422.GJ18371@dell>
References: <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com>
 <20190619061659.GH18371@dell>
 <OFB918AE65.CB02BB75-ON4825841E.0025C688-4825841E.00265891@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFB918AE65.CB02BB75-ON4825841E.0025C688-4825841E.00265891@mxic.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jun 2019, masonccyang@mxic.com.tw wrote:
> > > > Looks like a flash device to me.
> > > 
> > >    More like a multi-protocol flash controller, with the real flash 
> chip connected
> > > to it.
> > 
> > Right, this has been my point from the start.
> > 
> > It's a flash controller.  Sure, you can access it in different ways,
> > but it's still *just* a flash controller and thus not a true MFD.
> > 
> > Surely this whole thing, including the shared portion should live in
> > one of the memory related subsystems?
> > 
> > This is not the first device people have tried to shove in MFD, that
> > is really *just* an <X> device, able to be controlled via different
> > protocols.
> > 
> > MFD is for registering child devices of chips which offer genuine
> > cross-subsystem functionality.  It is not designed for mode selecting,
> > or as a place to shove shared code just because a better location
> > doesn't appear to exist.
> > 
> > Also, ramming it into drivers/platform/<vendor> is not correct either,
> > since this is not a platform controller driver either.
> 
> 
> I will patch RPC-IF back to SPI only and 
> rebase onto previous patches as bellow:

This sounds more like the easy way out, rather than the right thing to
do.  Just because this isn't an MFD, doesn't mean it's not suitable
for inclusion into the kernel.  Take a look at drivers/memory/Kconfig,
and see if any of those devices sound familiar.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
