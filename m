Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C281B2F24
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgDUSbY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUSbY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 14:31:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD925C0610D6
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x8so11249477qtp.13
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBz/0wOnTCCmpPszYn+oabaHyLl3HDHXxMJEJ6NS0jU=;
        b=KGOT3oqQ5JlJ1sZn6S5eaH2oN6QjpS5OkaorHZopxJxonMX76fIxNc63JIKVGjUuWs
         lnm3Ggg8i3ckuAWVuj8uDaR0AKWJW3To97ZwKuePpux5ARXxNktDJDIeAo11yxZgeGRi
         dplYCsh2B8OQ8TH3dQCIjKvoQ3CqDsX7JzfzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBz/0wOnTCCmpPszYn+oabaHyLl3HDHXxMJEJ6NS0jU=;
        b=IW2+z9DNHLKU/MY0Df2KqIckC+V64385EM8tyMYHWs0OJUSwT27zTrtIoMjl9y1q53
         DavdNP82Ev+ZtYl+f6RHRvaE6iE5lURYcL+DQ4TYX69d8eREpaBF7IzIYDCQayzOaYYx
         Jh2mtI2B4VaQg8X+LGLiUOGbgaQhts1zF0rQ5ajGd2qWuMiIZD+Ez+ot81tavTBunDV0
         J9tFj5I5yBE4cySSFLKt2EMbM00gq0G5cBwrPZ4cR/3zU10wQuMU+95uYL8eGp4gOJcR
         HFVzdO8XctvWQwukPPHoPy+BvPMoQxEsiUQBByFFripOWtreBeUfFjGM+9d3vzkJ3Gtg
         70wg==
X-Gm-Message-State: AGi0PuYa17Wne5T4rF4M6H+CApvj48DVoLKlxr5qp4ri5ZsHrm8vb7BM
        H8j6yybxdVqSLeiZR29n6B62qQ==
X-Google-Smtp-Source: APiQypId/nvmXqxnXkiHDNZP5gIEIHkE6obQx5jymRKmOarSYMwD/jhz7GKazPIlCz5G2Q20+/4rUg==
X-Received: by 2002:ac8:bca:: with SMTP id p10mr20913254qti.243.1587493883049;
        Tue, 21 Apr 2020 11:31:23 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id x24sm2308038qth.80.2020.04.21.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 11:31:22 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:31:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200421183120.av3yqoaulhyglppy@chatter.i7.local>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
 <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
 <20200421171558.GE4540@sirena.org.uk>
 <0d91f426-e767-2e69-bcb7-ddc4d7611861@gmail.com>
 <20200421172005.GG4540@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421172005.GG4540@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 21, 2020 at 06:20:05PM +0100, Mark Brown wrote:
> > Could you provide both links with a market at the front, e.g.:
> 
> > Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> > for-5.7
> > CGIT URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7
> 
> Ask Konstantin to implement it (I'm using b4 ty now) and I might!

You can do this already in the template, if your treename is set to the 
https URL.

----
Applied to

Git:   ${treename} ${branch}
Link:  ${treename}/log/?h=${branch}
----

-K
