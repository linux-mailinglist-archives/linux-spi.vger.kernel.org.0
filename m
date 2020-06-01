Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD81EA345
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgFAMA4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgFAMAz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 08:00:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A4C03E97C
        for <linux-spi@vger.kernel.org>; Mon,  1 Jun 2020 05:00:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so7779120ljo.5
        for <linux-spi@vger.kernel.org>; Mon, 01 Jun 2020 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sddl049YX4ZGZ5Wy5UDesdVcYAxDam7/pEqJLf4Wu3g=;
        b=BVUQM5RT0MRAtqTXxg43+IkIdgoW6ARsgZvnb5HnqF2mdOgtN6cFNBRj+3oiaFD91F
         lAXtqVhjwqrXPWBbWFL7Q8/SNZid8NQ6T2WJhSFAuL8v8UkFrqx3SzHjP56eY0D3wBp8
         eCf+3OeW7ewCiQ2K3fYOKj9ElVHosqSm7N4Hb0ae1qRYi2c11FKc2V9ktektMhwRa7RQ
         bqmRj5sWfzsFLO6f9FGQY/2mTVw3GXvxL7aSWDBMDCyPoTQ2jfrQg7h7wQfnvQiZnmli
         q1yXQPGWwOFFlQ/dFHPSJRUtU9rPdcfixs7RBuyZrBom4mTpWdJIirq/H0sZqWLrLonR
         K9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sddl049YX4ZGZ5Wy5UDesdVcYAxDam7/pEqJLf4Wu3g=;
        b=FjIJP7A1w6+IRumxNrT9oVaYQ+dwNmNrxOOEuFPsLm8djzsOkaw23pyxJn2tcawB5g
         4Vhytw3Zny9x7f/UIyQmsDvcbyJigjfubDBEL6dR0dwXDsPMW4xJhBvoNCaFXqnJw0WA
         ALpR2niji2DcFAk1cDeU0stEUZn4fTY+KFgrUTXNcEVzceUONSGt1+cdMXJIUve3o4Nk
         qbifZnZwCPpnMzuRI0dNOMuI8He9vnwpQTXuXXS1ksN8hTLISxQI2JMRZwFkheXno8o5
         4M9id5t6kegq0HfkGb+Hhw+oPjhodi3bNQd5d2Wr/wjMCmvG6GyTIMAmHLpC9V+VnIpv
         6IPQ==
X-Gm-Message-State: AOAM530otWKcxcEzxxEINcyW1yMVcYJQUUne39rvhd7+8OG+zfAxdINQ
        072N8YwHQ4WAzqGA3OuX86w=
X-Google-Smtp-Source: ABdhPJzi0BBhiknfODBzcb6oRjRSHafJOEx/XhIA9LoEybL4Ta1ozJwuGSsrxIlyPrLwaSXBgaSiGA==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr9676096ljl.254.1591012852957;
        Mon, 01 Jun 2020 05:00:52 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id y18sm4757593ljj.81.2020.06.01.05.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 05:00:52 -0700 (PDT)
Date:   Mon, 1 Jun 2020 15:00:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200601120050.zyxwsknkmocrfkgy@mobilestation>
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
 <20200529184050.bkn72tash33zgoo4@mobilestation>
 <20200529184955.GY1634618@smile.fi.intel.com>
 <20200529195243.GV4610@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529195243.GV4610@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 08:52:43PM +0100, Mark Brown wrote:
> On Fri, May 29, 2020 at 09:49:55PM +0300, Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:
> 
> > > > -	struct dw_dma_slave slave = {
> > > > -		.src_id = 0,
> > > > -		.dst_id = 0
> > > > -	};
> 
> > > > +	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> > > > +	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
> 
> > > You know my attitude to these changes.) But anyway what's the point in having
> > > the *tx and *rx pointers here? Without any harm to the readability you can use
> > > the structures names directly, don't you?
> 
> > I will wait for Mark to decide.
> 

> Like I said before I don't particularly care either way, I've queued the
> patch to apply but really I'd rather that the people working on the
> driver could come to some sort of agreement here.

Mark, as you can see that's not always possible that easy to come to an
agreement. Sometimes like this time either both solutions are very similar,
or both have some pros and cons, so a better one just can't be chosen. In that
case to save a time I prefer to stop arguing and just ask a maintainer of which
one would be better for him. In any case I don't deny to respond to a review
comment and I normally justify why I think my solution is also acceptable or
why I don't see the proposed modification is better, whoever that comment
provided.

On Fri, May 29, 2020 at 10:21:35PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 10:05 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Fri, May 29, 2020 at 09:49:55PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:
> > > > On Fri, May 29, 2020 at 09:31:49PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > You know my attitude to these changes.) But anyway what's the point in having
> > > > the *tx and *rx pointers here? Without any harm to the readability you can use
> > > > the structures names directly, don't you?
> > >
> > > I will wait for Mark to decide.
> >
> > So no response to a review comment? Shall I do the same when get a review from
> > you?.)
> 
> This patch is result of you insisting on your version of things when I
> tried to explain you that it's not how it should be done. You pushed
> your vision. Mark proposed to submit your changes and consider mine
> which I agreed on. I will wait for him.
> 

Andy, that's not exactly the way the discussion evolved. You proposed a solution,
you thought would be better, justified it as being more readable and maintainable.
I considered your proposition and decided that pros didn't worth the cons,
responded to you why I'd better stick with my patch. Since you insisted on
implementing your solution I asked a higher level arbiter to make a final
decision in order to stop bikeshedding around that part of the patch. Please note,
I didn't refuse to respond, I didn't reject your review, I didn't ignore your
comment. I considered what you said, we had a discussion proposing
justifications for our solutions and only then I asked Mark to give us his
last word. That was my right to do. See the difference between your response
and mine.

In anyway regarding how it "should or shouldn't be done". The patchsets you had
a chance to see and review weren't my first ones. I've sent patches to different
kernel subsystems before and not once and nearly every maintainer/reviewer had a
vision of what should or shouldn't be done sometimes contradicting to each other,
what is right or wrong including the way the patches are formatted,
merged/squashed or split up, moved, inter-mixed and so on. I didn't ignore any
of such comments, and took them into account if they had been justified enough.
But when it came to a situation like this, then "should or shouldn't" aren't
right verbs to say. It's more like personal believe, personal preference rather
than a selection of a right thing to do. The same is applicable to your comment
regarding squashing the patches in the DMA-related series and to the patches
like that. Don't get me wrong I very appreciate reviews you've done and most
likely will do for my patches (since there are going to be two more series
submitted for the DW APB SSI driver). A lot of your comments were very helpful
and indeed implementing some of what you suggested made the patchsets better.
But please don't assume that that valuable comments made everything you think is
the only right thing to do, give a submitter a chance to be right too and
let a bikeshadding go when it really doesn't worth to go on an endless arguing
especially with respect to the situations like we've got here.

-Sergey
