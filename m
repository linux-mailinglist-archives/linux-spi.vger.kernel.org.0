Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA3C4279
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 23:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfJAVQi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 17:16:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45182 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfJAVQh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 17:16:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so13285586edh.12;
        Tue, 01 Oct 2019 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/OEKYUmWcpAh+ee4kxhBhTQSHV/hiw7BMd9ell97Mok=;
        b=FDTdi9DJ1U+cIJBw7YfDE4fzF6vK4qeAz/28YIvQXk6KaLHtoV9HTOJwinUuLAxech
         QsRhuJS8kD9Toj16aiMktp9LJx5bex/SqJuVeM5q8kKONkENWRRzo1fpMWQqzHMmI/8K
         geVbn60pMoBRvo8+/tx4kZDCh7fN/4oKiHjaxk3Ei/nKpZjbf7nyUC4FtAiv0spC9iJp
         Kx5Nu4pFmZjkHVoL7n8z3LsL4Mxi1c9LR9ZNxxNlxyvzfbU/wLTsZrLGPWDRKpyvGfi8
         6vVaQM0zLiUb7Q3CdaBNknr/2zHOPRJ/rC2hxp0g6TaeLXa7b5P1Jh2O0pHhZtzXetIs
         eKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/OEKYUmWcpAh+ee4kxhBhTQSHV/hiw7BMd9ell97Mok=;
        b=F0jghGjoIci8h7kp4A5mr542YK83zgu84oIvte0gMYOsf5IbFhTvk3ds3Tayu8jr+G
         hp6PUzjZS8J2UQKfJifLRWs9ASiNv3T8TdFNTmpvbeS4gfG+6pus5zAMoiCAdPJaltNG
         D4/i0+tXG/eLbEfjfrEwlKlYj1/whkNviVFvb21kMLFrL9SsmZKIztY3Z6meB8sSKJ9+
         kZS6qlJsjDf60cXQYGuLCR1uK+s6cyKY6mLGrG+BtFJxsaeWbj+xwaR72Fx3DzG6F3pY
         1EV/mihmgRZ54qgzezUmnn4nm9Sc+SHyoWqlOHzjwfimSWk5dsZVDFoBpuqw8puxyvNW
         qokw==
X-Gm-Message-State: APjAAAWpF3Im5FL/p6mUxCj5n+p7SZ9TmwgCPV9WuH0yD7CHOUMuxYr2
        mIKB+cgZRf1nP13O40UaPBX5qBrEbT4=
X-Google-Smtp-Source: APXvYqwb8yUmjOuhb90A6LbhFYDPlVmUGrUboDMvf82vhDiVF/dIFUzLMSrxkHrY7bYzJGqYTLELFA==
X-Received: by 2002:a05:6402:13c2:: with SMTP id a2mr277615edx.21.1569964594541;
        Tue, 01 Oct 2019 14:16:34 -0700 (PDT)
Received: from [192.168.1.60] (0126800801.0.fullrate.ninja. [2.110.44.75])
        by smtp.gmail.com with ESMTPSA id i30sm3395920ede.32.2019.10.01.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:16:33 -0700 (PDT)
Message-ID: <89dc7df9f1544417dfadea3ead72dcbbc60d5ebd.camel@gmail.com>
Subject: Re: State of spidev from devicetree
From:   claus.stovgaard@gmail.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Date:   Tue, 01 Oct 2019 23:16:32 +0200
In-Reply-To: <CAMuHMdXbRQXarvV=86rssSiRnuKMSFWJLRbU3VH9tcCV_FeOGQ@mail.gmail.com>
References: <CAHirDJ_gtrjL_nq0T2qvn_kv9-UweL+=bc7EBLrTfNfNkVn0QA@mail.gmail.com>
         <20190924175036.GA2036@sirena.org.uk>
         <CAMuHMdXbRQXarvV=86rssSiRnuKMSFWJLRbU3VH9tcCV_FeOGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On tor, 2019-09-26 at 14:21 +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 26, 2019 at 12:50 PM Mark Brown <broonie@kernel.org>
> wrote:
> > On Tue, Sep 24, 2019 at 02:52:59PM +0200, Claus Stovgaard wrote:
> > 
> > > What is yours response to the idea of creating a custom-hardware
> > > binding
> > > for spidev, intended to be used for programmable hardware unknown
> > > at the
> > > devicetree time.
> > 
> > You should use a device tree overlay to describe whatever
> > hardware you've instantiated on your FPGA then load the overlay
> > along with your FPGA image.
> 
> And after that, you can bind spidev to the device in the overlay
> using
> sysfs, cfr. commit 5039563e7c25eccd ("spi: Add driver_override SPI
> device
> attribute").

I know this is a bit old, but will still thank you for the replays.

Regarding overlays and binding via sysfs. I understand your answer and
proposal for solution. Though in our situation with a very basic
embedded system it is just extra overhead and added complexity,
compared to just having a spidev from initial devicetree. Without
giving anything as I see it. So would still have preferred some-kind of
custom string in the .compatible inside spidev.

Thanks
Claus

