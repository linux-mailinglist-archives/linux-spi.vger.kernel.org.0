Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4C43066D
	for <lists+linux-spi@lfdr.de>; Sun, 17 Oct 2021 06:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbhJQE0B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 17 Oct 2021 00:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhJQE0B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 17 Oct 2021 00:26:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C7C061765;
        Sat, 16 Oct 2021 21:23:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m21so12573195pgu.13;
        Sat, 16 Oct 2021 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ND/C0Cw1igbnIAxbgjJyHzhuGZ4HoMLAKVHeD+CrT8Y=;
        b=DT6/WJd8CM/xsDrxbUL0zoH63WLKlaXMxY/XuZuCPNsBwwxtX6XPXQ+tGxGCi1JAQR
         2wG7sPSv0YxOiKQYvmV8iGHvwnOXSuj3doDUqWE0kwMJe8jLY4aPspdedwDsfy+/nHgm
         DxWTRr50Slm2MoaCNOCygbaDlgZpq2Njd2wLHGLC+IVdTuuLBiOUi2uhM3m6DRVKh+qQ
         0cxEjcVqhwSMLxBtAHB6GYlhRHNf8/k4voLUFs3qWGAG0D8AAlePZ+J3cLI2rKm0gvUG
         pyAS4CbGE+k6PuQO0B2K32qGOE7WeI3T0JcaMWSwpSwRim9m6ef2ru0trdbgNS45D/L+
         Xwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ND/C0Cw1igbnIAxbgjJyHzhuGZ4HoMLAKVHeD+CrT8Y=;
        b=NY+DYffq9DzicaORoWXUqunHjZ+vfd+mE7AqmeKn0FoRZMdqjWcr1+l+HTpiXL9I8V
         iLX3lA50ppuCFbB48CgirXNKikkCH4KAe0uPt0I7JacetqhHwmdDLNzhqHlMpu13YgQC
         CLiUrH4yc5ywH5sV83UX8HEyisGr7U/OyhKkmGGylAQFbP4P/rpqTPvWYQGETnm1j7D4
         30jEfbzuDRT2DYroE+nKC1LufHo+bM91YkGMEvaGdeW7NpP8a/aRITq3vgQaxKAlfFhE
         cYKzGy8JfsyJ/Ta31CFVXgscLHwgbH4DdBYNZp/dQ8ctnd3OYF5yGqDG0ZBKjWM0MaSd
         /HAg==
X-Gm-Message-State: AOAM532gWfytIDnBrw8emZy1eETk0YdnYBB9dBjQjsntgW1uH5bcWM06
        W8bUoWqjp/aFicFJ11qee60=
X-Google-Smtp-Source: ABdhPJwVucY9TRzRmYMqKJKDTt8nnezyWgKMknlx03/WfAC7F1g8Wm2HtQ2OKKqoi5qShBto4bccPg==
X-Received: by 2002:a63:ad49:: with SMTP id y9mr15726225pgo.352.1634444631213;
        Sat, 16 Oct 2021 21:23:51 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e49a:151f:b7d7:af9a])
        by smtp.gmail.com with ESMTPSA id k14sm8823063pgg.92.2021.10.16.21.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 21:23:50 -0700 (PDT)
Date:   Sat, 16 Oct 2021 21:23:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1] Input: ads7846: ads7846_get_value - fix unaligned
 pointer value warning
Message-ID: <YWulU30/yZaDeoAS@google.com>
References: <20210707124115.20028-1-o.rempel@pengutronix.de>
 <YTrnUFI53iwvwxrj@google.com>
 <20210910075154.GF26100@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910075154.GF26100@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 10, 2021 at 09:51:54AM +0200, Oleksij Rempel wrote:
> Hi Dmitry,
> 
> On Thu, Sep 09, 2021 at 10:04:16PM -0700, Dmitry Torokhov wrote:
> > Hi Oleksij,
> > 
> > On Wed, Jul 07, 2021 at 02:41:15PM +0200, Oleksij Rempel wrote:
> > > Fix warning reported by the kernel test robot:
> > > drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
> > > of packed member 'data' of class or structure 'ads7846_buf' may result
> > > in an unaligned pointer value [-Waddress-of-packed-member]
> > > 
> > > Fixes: 6965eece2a89 ("Input: ads7846 - convert to one message")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  drivers/input/touchscreen/ads7846.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> > > index adb4c2230c31..1987dedac94f 100644
> > > --- a/drivers/input/touchscreen/ads7846.c
> > > +++ b/drivers/input/touchscreen/ads7846.c
> > > @@ -702,7 +702,7 @@ static int ads7846_get_value(struct ads7846_buf *buf)
> > >  {
> > >  	int value;
> > >  
> > > -	value = be16_to_cpup(&buf->data);
> > > +	value = get_unaligned_be16(&buf->data);
> > 
> > ds7846_buf is declared as packed so I believe using be16_to_cpu(buf->data)
> > will suffice.
> 
> The pointer to the data is is off by 8 bits, so it is not naturally
> aligned. This is why we need to use function which is dealing with
> unaligned pointers. 

As I mentioned, the structure is packed, so the compiler will take care
of doing unaligned access safely on architectures that can not tolerate
it.

Thanks.

-- 
Dmitry
