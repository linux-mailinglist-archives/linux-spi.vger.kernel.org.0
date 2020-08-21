Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6898724CE7E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHUHKg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 21 Aug 2020 03:10:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHUHKg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 03:10:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id d16so974961wrq.9;
        Fri, 21 Aug 2020 00:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jz5YmMUMv7fyLq3wiwjcdiqT8QN6h8dN46ufIK0XqjU=;
        b=TdXL19WXJzmGbMno2fWq0ObyowvQMLoy6ue8pWYEE9NobwO0y+K3rnXYXWl3nH2hcE
         uGbGjwcgzeKecfFRIbHqrkFz2VB7t7OQ4wqj74lUte9JJQQ7utM5kWOU9pbI04JhQHZ/
         czkQC5RX8g2pI4TDbOaAHHFWeNHM0JToleeO+AFxDWDGz/EIMwlIYSfVQK7NweGfsxIf
         EClw4b0HntwHCQ+FTIT45a5RGYPP5SYia1WlYKFD0n3iskKhLVlruJwdYLCG7ZA0JzBk
         ZIZkjqupfaIz00vnq4r9x9lwMCFqdlyQ5r05pBfHsp4PoQBpgPg6PRgMdQlTq/RkZZVX
         lPcg==
X-Gm-Message-State: AOAM530xBl/7cm+j4TYeXXru2CAxnsJa4c/eKQJRptTRs/qQb+04MRSj
        X8qUDKHlEfGzga7hjmTSV28=
X-Google-Smtp-Source: ABdhPJwZdIK9j+sztRpjPkTystFIOkQ+5HeSyiTpAe/3quHWZDea6vpzykvVTCUJA8QZl8Gvd3OPmg==
X-Received: by 2002:adf:9501:: with SMTP id 1mr1370184wrs.413.1597993833286;
        Fri, 21 Aug 2020 00:10:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id p15sm2487017wrj.61.2020.08.21.00.10.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 00:10:32 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:10:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 7/8] spi: spi-s3c64xx: Increase transfer timeout
Message-ID: <20200821071030.GA8585@kozik-lap>
References: <20200819124940.GG18122@kozik-lap>
 <CGME20200819133957eucas1p293192baeabb9788ac9148068c1627a57@eucas1p2.samsung.com>
 <dleftjblj621qr.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dleftjblj621qr.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 03:39:56PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 śro 14:49>, when Krzysztof Kozlowski wrote:
> > On Wed, Aug 19, 2020 at 02:32:07PM +0200, Łukasz Stelmach wrote:
> >> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> >
> > Why? Everything works fine and suddenly minimum timeout is 100 ms?
> 
> Actually I am not 100% sure the max() call is required, maybe +30 is
> enough. Definitely some minimum value is required because for small
> tranfers (100s of bytes) ms is 0 after the first assignment.

Sure, just please describe it all in commit msg. All these questions
"why?" came because of lack of explanation in commit msg.

I guess minimum timeout 100 ms for each transfer is quite high, so maybe
just bump the tolerance to 30 which also would be a minimum timeout.

Best regards,
Krzysztof


> 
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 27d77600a820..27db1e0f6f32 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -464,7 +464,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
> >>  
> >>  	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
> >>  	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
> >> -	ms += 10; /* some tolerance */
> >> +	ms = (ms * 10) + 30;    /* some tolerance */
> >> +	ms = max(ms, 100);      /* minimum timeout */
> >>  
> >>  	val = msecs_to_jiffies(ms) + 10;
> >>  	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
> >> -- 
> >> 2.26.2
> >> 
> >
> >
> 
> -- 
> Łukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics


