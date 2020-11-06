Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721072A9B4F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFRzu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 12:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgKFRzu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 12:55:50 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC9C0613CF;
        Fri,  6 Nov 2020 09:55:50 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id r8so1344244qtp.13;
        Fri, 06 Nov 2020 09:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tesnr6tHCwXv22LKMrMKDJ13D6GR3yqp1TvXkruwatk=;
        b=fmwQtSRhbUnSDsyjkARa4UgvmDAkCyOTl8SP7WEr1Yvp99ubKu6cysLvYFvTHwDb+i
         iMleoK+yLBncD/Hkpfj9Os7Y/rJElG6JOdL6nW5fHIkJkGd2IIee4ucBdceCjNK4ERc1
         bVTYE3OBsnlW+s9Uqf+oqgC3uoH88B3KievXbhXDJzaBVySOguOrfxhT0m5FEOrugMG4
         5a4vxR/1HC1hf6GxRdNJZdsLQq+oxoir3fXN7+NLgAlWRxRB+vRQxb9wzY/Jq9mHj6wS
         AF36SNHci6m5WcQ1gdLdC2uneD3cFuGV1FyQ4QGAvDsbwhhGbBt633RHZRfLAnr+jmNR
         p07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tesnr6tHCwXv22LKMrMKDJ13D6GR3yqp1TvXkruwatk=;
        b=GTX4KKl6aLp5shyMoetwBUWcGTgNrhVVRx3ddddpvRIDYKLNDFUF/sO6uiK6a7h4wC
         5GtQA1VNNv/hyDGkNib2Vxef7ALS02RLXxi1Gm8tYk4qCzN3HSc2HcxHN9gRFAfQxnVa
         RUuv8fWAwN2gtI9Y+I1moZ912iX6fwOYCbWJ3b5MjSEHxHGihCNHdESed6jbCyvYZC65
         ISXwXP2iFmiA4FjcTTLqqkcchhPrsL8EBJEcHKee2Pt7xzbtp6YO6KHLxVhkVf6XwSPD
         1CBPaxV8YNlMhjkLH29aZV3DDoPXFYjgWQWcPXAuVRi0fZsSOdyijFmcsxXHKb/5oMhf
         DkUg==
X-Gm-Message-State: AOAM5310IVZtCTv0PH3MdSFf5xr1xalST6DEOpNpjl9VG9buFb4g8sF7
        aOm2fA8hd3Oh82OgEdMKnL8=
X-Google-Smtp-Source: ABdhPJzEyYIodKj9msxe0ftebe0gV40PxOWt79WgLwdwXh6s6tMYM+rTDL/UuLerw0UKYGNos2TWkA==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr2519740qtu.309.1604685349389;
        Fri, 06 Nov 2020 09:55:49 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id p127sm1006598qkc.37.2020.11.06.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 09:55:48 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:55:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc2
Message-ID: <20201106175547.GA2959494@ubuntu-m3-large-x86>
References: <20201105164607.AD20021734@mail.kernel.org>
 <20201106101815.GA1403068@ubuntu-m3-large-x86>
 <20201106110053.GA5532@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106110053.GA5532@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 06, 2020 at 11:00:53AM +0000, Mark Brown wrote:
> On Fri, Nov 06, 2020 at 03:18:15AM -0700, Nathan Chancellor wrote:
> > On Thu, Nov 05, 2020 at 04:45:46PM +0000, Mark Brown wrote:
> 
> > > Martin Hundebøll (1):
> > >       spi: bcm2835: fix gpio cs level inversion
> 
> > Why did this go in with two outstanding reports?
> 
> > It looks like there is a fix for it now:
> 
> > https://lore.kernel.org/linux-spi/20201105090615.620315-1-martin@geanix.com/
> 
> > Although I guess it is going to require a resend...
> 
> Erk, sorry - I remembered the issue being fixed but got confused and
> thought that it was an incremental patch on top of something applied
> rather than something that got fixed in a patch revision (got it
> confused with another issue I think).  The incremental fix is queued
> now, I should send it out later today.

No worries, I just wanted to make sure that you were still aware of the
issues with it. Obviously you have a lot on your plate constantly so it
is understandable that something falls through the cracks occasionally
:)

I see you have sent that pull already, thanks for the quick response!

Cheers,
Nathan
